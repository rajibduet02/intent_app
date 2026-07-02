import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math' show Random;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart'
    show TargetPlatform, defaultTargetPlatform, kIsWeb;
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:intent_app/core/constants/api_constants.dart';
import 'package:intent_app/core/constants/google_sign_in_constants.dart';
import 'package:intent_app/core/error/exceptions.dart';
import 'package:intent_app/core/firebase/firebase_api_logger.dart';
import 'package:intent_app/core/network/api_client.dart';
import 'package:intent_app/core/services/local_auth_store.dart';
import 'package:intent_app/core/services/storage_service.dart';
import 'package:intent_app/data/models/response_model.dart';
import 'package:intent_app/data/models/user_model.dart';

/// Auth + onboarding persistence (Firebase Auth, Firestore, callable OTP).
class AuthRepository {
  /// Callable / verify flow statuses (aligned with Cloud Functions JSON).
  static const String authStatusSuccess = 'success';
  static const String authStatusAccountExists = 'account_exists';
  static const String authStatusInvalidCode = 'invalid_code';
  static const String authStatusExpiredCode = 'expired_code';
  static const String authStatusTooManyAttempts = 'too_many_attempts';
  static const String authStatusTooManyRequests = 'too_many_requests';
  static const String authStatusWeakPassword = 'weak_password';
  static const String authStatusInternalError = 'internal_error';
  static const String authStatusNewUser = 'new_user';
  static const String authStatusExistingUser = 'existing_user';
  static const String authStatusCancelled = 'cancelled';

  AuthRepository(
    this._api,
    this._storage,
    this._localAuthStore, {
    FirebaseAuth? auth,
    FirebaseFirestore? firestore,
    FirebaseFunctions? functions,
  }) : _authOverride = auth,
       _firestoreOverride = firestore,
       _functionsOverride = functions;

  final ApiClient _api;
  final StorageService _storage;
  final LocalAuthStore _localAuthStore;
  final FirebaseAuth? _authOverride;
  final FirebaseFirestore? _firestoreOverride;
  final FirebaseFunctions? _functionsOverride;

  FirebaseAuth? _authLazy;
  FirebaseFirestore? _firestoreLazy;
  FirebaseFunctions? _functionsLazy;

  FirebaseAuth get _auth {
    final override = _authOverride;
    if (override != null) {
      return override;
    }
    if (Firebase.apps.isEmpty) {
      throw StateError('Firebase is not configured.');
    }
    return _authLazy ??= FirebaseAuth.instance;
  }

  FirebaseFirestore get _firestore {
    final override = _firestoreOverride;
    if (override != null) {
      return override;
    }
    if (Firebase.apps.isEmpty) {
      throw StateError('Firebase is not configured.');
    }
    return _firestoreLazy ??= FirebaseFirestore.instance;
  }

  FirebaseFunctions get _functions {
    final override = _functionsOverride;
    if (override != null) {
      return override;
    }
    if (Firebase.apps.isEmpty) {
      throw StateError('Firebase is not configured.');
    }
    return _functionsLazy ??= FirebaseFunctions.instanceFor(
      region: ApiConstants.firebaseFunctionsRegion,
    );
  }

  String? _memoryOnboardingUid;
  bool? _memoryOnboardingComplete;

  bool get isLoggedIn {
    if (_localAuthStore.hasActiveSession) {
      return true;
    }
    if (Firebase.apps.isEmpty) {
      return false;
    }
    return _auth.currentUser != null;
  }

  bool _shouldFallbackToLocalLogin(String code) {
    return code == 'user-not-found' ||
        code == 'wrong-password' ||
        code == 'invalid-credential';
  }

  String _mapError(Object e) {
    if (e is SocketException) {
      return 'No internet connection. Please check your network and try again.';
    }
    if (e is ServerException) {
      return e.message;
    }
    if (e is CacheException) {
      return e.message;
    }
    return 'Something went wrong. Please try again.';
  }

  String _firebaseAuthMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return 'Invalid email address.';
      case 'user-disabled':
        return 'This account has been disabled.';
      case 'user-not-found':
        return 'No account found for this email.';
      case 'wrong-password':
        return 'Incorrect password.';
      case 'invalid-credential':
        return 'Invalid email or password.';
      case 'email-already-in-use':
        return 'An account already exists for this email.';
      case 'weak-password':
        return 'Password is too weak.';
      case 'invalid-action-code':
      case 'expired-action-code':
        return 'Reset link expired. Please request a new one.';
      case 'network-request-failed':
        return 'Network error. Check your connection.';
      case 'account-exists-with-different-credential':
        return 'This email is already registered with another sign-in method.';
      case 'credential-already-in-use':
        return 'This sign-in account is already linked to another user.';
      default:
        return e.message ?? 'Authentication failed.';
    }
  }

  String _functionsMessage(FirebaseFunctionsException e) {
    return e.message ?? 'Request failed.';
  }

  String _googleSignInPlatformMessage(PlatformException e) {
    final code = e.code.toLowerCase();
    final message = (e.message ?? '').toLowerCase();
    final details = (e.details ?? '').toString().toLowerCase();
    final combined = '$code $message $details';
    if (combined.contains('network') ||
        combined.contains('internet') ||
        combined.contains('connection')) {
      return 'No internet connection. Please check your network and try again.';
    }
    return 'Google sign-in failed. Please try again.';
  }

  /// OAuth sign-in: one `users` read, then batched `users` + `profiles` merge writes.
  ///
  /// [emailForFirestore] / [displayNameForFirestore] override Auth profile fields
  /// when non-null (e.g. Apple full name without [User.reload]).
  Future<bool> _upsertOAuthSignInDocuments(
    User user,
    String oauthProvider, {
    String? emailForFirestore,
    String? displayNameForFirestore,
    required bool emailVerified,
  }) async {
    final uid = user.uid;
    final usersRef = _firestore.collection('users').doc(uid);
    final profilesRef = _firestore.collection('profiles').doc(uid);
    final usersSnap = await FirebaseApiLogger.traceFirestore(
      operation: 'get',
      path: 'users/$uid',
      action: usersRef.get,
    );
    final isNewUser = !usersSnap.exists;
    final userPatch = <String, dynamic>{
      'uid': uid,
      'full_name': displayNameForFirestore ?? user.displayName ?? '',
      'email': emailForFirestore ?? user.email ?? '',
      'photo_url': user.photoURL ?? '',
      'provider': oauthProvider,
      'emailVerified': emailVerified,
      'last_login': FieldValue.serverTimestamp(),
      'lastLoginAt': FieldValue.serverTimestamp(),
      'is_active': true,
    };
    if (isNewUser) {
      userPatch['created_at'] = FieldValue.serverTimestamp();
      userPatch['createdAt'] = FieldValue.serverTimestamp();
    }
    final profilePatch = <String, dynamic>{
      'uid': uid,
      'email': emailForFirestore ?? user.email ?? '',
      'displayName': displayNameForFirestore ?? user.displayName ?? '',
      'updatedAt': FieldValue.serverTimestamp(),
    };
    await FirebaseApiLogger.traceFirestore(
      operation: 'batch.set(merge)',
      path: 'users/$uid, profiles/$uid',
      action: () async {
        final batch = _firestore.batch();
        batch.set(usersRef, userPatch, SetOptions(merge: true));
        batch.set(profilesRef, profilePatch, SetOptions(merge: true));
        await batch.commit();
      },
    );
    return isNewUser;
  }

  Future<void> _syncStorageFromUser(User user) async {
    await _storage.saveUserId(user.uid);
    final token = await user.getIdToken(false);
    await _storage.saveAuthToken(token ?? '');
  }

  /// Clears in-memory and persisted onboarding routing cache (e.g. on sign-out).
  Future<void> clearOnboardingCache() async {
    _memoryOnboardingUid = null;
    _memoryOnboardingComplete = null;
    await _storage.clearOnboardingCache();
  }

  Future<void> _persistOnboardingCache(String uid, bool complete) async {
    _memoryOnboardingUid = uid;
    _memoryOnboardingComplete = complete;
    await _storage.saveOnboardingCompleteCache(uid: uid, complete: complete);
  }

  bool? _readCachedOnboardingComplete(String uid) {
    if (_memoryOnboardingUid == uid && _memoryOnboardingComplete != null) {
      return _memoryOnboardingComplete;
    }
    final prefs = _storage.readOnboardingCompleteForUid(uid);
    if (prefs != null) {
      _memoryOnboardingUid = uid;
      _memoryOnboardingComplete = prefs;
      return prefs;
    }
    return null;
  }

  static bool _profileDataIndicatesOnboardingComplete(
    Map<String, dynamic>? data,
  ) {
    if (data == null) {
      return false;
    }
    if (data['onboardingComplete'] == true) {
      return true;
    }
    final username = (data['username'] as String?)?.trim() ?? '';
    return username.isNotEmpty;
  }

  /// Refreshes persisted token/uid from the current Firebase session (e.g. cold start).
  Future<void> refreshStorageFromCurrentUser() async {
    final user = _auth.currentUser;
    if (user != null) {
      await _syncStorageFromUser(user);
    }
  }

  Future<void> _persistLoginCredentials({
    required String email,
    required String password,
    required bool rememberMe,
    String? existingUserId,
  }) async {
    if (rememberMe) {
      await _localAuthStore.saveRememberedCredentials(
        email: email,
        password: password,
      );
    } else {
      await _localAuthStore.clearRememberedCredentials();
    }
    await _localAuthStore.registerAccount(
      email: email,
      password: password,
      existingUserId: existingUserId,
    );
  }

  Future<({String? email, String? password, bool rememberMe})>
  getRememberedCredentials() {
    return _localAuthStore.readRememberedCredentials();
  }

  Future<void> persistSignupCredentials({
    required String email,
    required String password,
  }) async {
    String? existingUserId;
    if (Firebase.apps.isNotEmpty) {
      existingUserId = _auth.currentUser?.uid;
    } else {
      existingUserId = await _localAuthStore.userIdForEmail(email);
    }
    await _persistLoginCredentials(
      email: email,
      password: password,
      rememberMe: true,
      existingUserId: existingUserId,
    );
  }

  Future<void> registerLocalAccount({
    required String email,
    required String password,
  }) async {
    await _localAuthStore.registerAccount(email: email, password: password);
    await _localAuthStore.signIn(email, password);
    await _localAuthStore.saveRememberedCredentials(
      email: email,
      password: password,
    );
  }

  Future<ResponseModel<UserModel>> login(
    String email,
    String password, {
    bool rememberMe = true,
  }) async {
    final trimmed = email.trim();
    ResponseModel<UserModel>? firebaseFailure;

    if (Firebase.apps.isNotEmpty) {
      try {
        final cred = await FirebaseApiLogger.traceAuth(
          operation: 'signInWithEmailAndPassword',
          context: 'email: $trimmed',
          action: () => _auth.signInWithEmailAndPassword(
            email: trimmed,
            password: password,
          ),
        );
        final user = cred.user;
        if (user == null) {
          return ResponseModel.failure('Sign-in failed.');
        }
        await FirebaseApiLogger.traceFirestore(
          operation: 'set(merge)',
          path: 'users/${user.uid}',
          action: () => _firestore.collection('users').doc(user.uid).set({
            'lastLoginAt': FieldValue.serverTimestamp(),
          }, SetOptions(merge: true)),
        );
        await _syncStorageFromUser(user);
        await _persistLoginCredentials(
          email: trimmed,
          password: password,
          rememberMe: rememberMe,
          existingUserId: user.uid,
        );
        return ResponseModel.success(
          UserModel(
            id: user.uid,
            email: user.email ?? trimmed,
            name: user.displayName,
          ),
        );
      } on FirebaseAuthException catch (e) {
        if (!_shouldFallbackToLocalLogin(e.code)) {
          return ResponseModel.failure(_firebaseAuthMessage(e));
        }
        firebaseFailure = ResponseModel.failure(_firebaseAuthMessage(e));
      } catch (e) {
        return ResponseModel.failure(_mapError(e));
      }
    }

    final signedIn = await _localAuthStore.signIn(trimmed, password);
    if (signedIn) {
      final userId = await _localAuthStore.userIdForEmail(trimmed) ?? '';
      await _persistLoginCredentials(
        email: trimmed,
        password: password,
        rememberMe: rememberMe,
        existingUserId: userId,
      );
      return ResponseModel.success(
        UserModel(id: userId, email: trimmed, name: null),
      );
    }

    return firebaseFailure ??
        ResponseModel.failure('Invalid email or password.');
  }

  /// Signs in with Google (Firebase Auth). Ensures `users` / `profiles` docs exist.
  Future<ResponseModel<UserModel>> signInWithGoogle({
    bool fromSignupFlow = false,
  }) async {
    final GoogleSignIn googleSignIn =
        GoogleSignInConstants.serverClientId.trim().isEmpty
        ? GoogleSignIn(scopes: const <String>['email', 'profile'])
        : GoogleSignIn(
            scopes: const <String>['email', 'profile'],
            serverClientId: GoogleSignInConstants.serverClientId.trim(),
          );
    try {
      final account = await FirebaseApiLogger.traceAuth(
        operation: 'GoogleSignIn.signIn',
        action: () => googleSignIn.signIn(),
      );
      if (account == null) {
        return ResponseModel.failure(
          'Sign-in was cancelled.',
          authStatus: authStatusCancelled,
        );
      }
      final auth = await account.authentication;
      final idToken = auth.idToken;
      final accessToken = auth.accessToken;
      if (idToken == null) {
        return ResponseModel.failure(
          'Google Sign-In did not return an ID token. '
          'In Firebase Console, add the Web client ID to '
          '`lib/core/constants/google_sign_in_constants.dart` as serverClientId, '
          'then rebuild.',
        );
      }
      final credential = GoogleAuthProvider.credential(
        accessToken: accessToken,
        idToken: idToken,
      );
      final cred = await FirebaseApiLogger.traceAuth(
        operation: 'signInWithCredential(Google)',
        context: 'email: ${account.email}',
        action: () => _auth.signInWithCredential(credential),
      );
      final user = cred.user;
      if (user == null) {
        return ResponseModel.failure('Sign-in failed.');
      }
      final isNewUserFromAuth = cred.additionalUserInfo?.isNewUser ?? false;
      final providerIds = user.providerData
          .map((UserInfo info) => info.providerId)
          .toSet();
      final shouldSetEmailVerified =
          fromSignupFlow ||
          user.emailVerified ||
          providerIds.contains('google.com') ||
          providerIds.contains('apple.com');
      final isNewUserByUsersCollection = await _upsertOAuthSignInDocuments(
        user,
        'google',
        emailVerified: shouldSetEmailVerified,
      );
      final isNewUser = isNewUserFromAuth || isNewUserByUsersCollection;
      await _syncStorageFromUser(user);
      return ResponseModel.success(
        UserModel(
          id: user.uid,
          email: user.email ?? account.email,
          name: user.displayName,
        ),
        authStatus: isNewUser ? authStatusNewUser : authStatusExistingUser,
      );
    } on SocketException {
      return ResponseModel.failure(
        'No internet connection. Please check your network and try again.',
      );
    } on PlatformException catch (e) {
      return ResponseModel.failure(_googleSignInPlatformMessage(e));
    } on FirebaseAuthException catch (e) {
      return ResponseModel.failure(_firebaseAuthMessage(e));
    } catch (e) {
      return ResponseModel.failure(_mapError(e));
    }
  }

  static bool get _supportsNativeSignInWithApple {
    if (kIsWeb) return false;
    return defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.macOS;
  }

  /// 32 random bytes, base64url-encoded — used as [rawNonce] for Firebase Apple sign-in.
  String _generateAppleRawNonce() {
    final random = Random.secure();
    final bytes = List<int>.generate(32, (_) => random.nextInt(256));
    return base64UrlEncode(bytes);
  }

  /// SHA-256 of [rawNonce] as lowercase hex (value passed to Apple as `nonce`).
  String _sha256HexNonce(String rawNonce) {
    final digest = sha256.convert(utf8.encode(rawNonce));
    return digest.toString();
  }

  /// Signs in with Apple (Firebase Auth). Same Firestore / routing contract as Google.
  ///
  /// Uses native Apple UI on iOS and macOS. Other platforms should use Google or email.
  Future<ResponseModel<UserModel>> signInWithApple({
    bool fromSignupFlow = false,
  }) async {
    if (!_supportsNativeSignInWithApple) {
      return ResponseModel.failure(
        'Sign in with Apple is only available on iPhone, iPad, and Mac.',
      );
    }
    if (!await SignInWithApple.isAvailable()) {
      return ResponseModel.failure(
        'Sign in with Apple is not available on this device.',
      );
    }
    final String rawNonce = _generateAppleRawNonce();
    final String hashedNonce = _sha256HexNonce(rawNonce);
    try {
      final appleCredential = await FirebaseApiLogger.traceAuth(
        operation: 'SignInWithApple.getAppleIDCredential',
        action: () => SignInWithApple.getAppleIDCredential(
          scopes: <AppleIDAuthorizationScopes>[
            AppleIDAuthorizationScopes.email,
            AppleIDAuthorizationScopes.fullName,
          ],
          nonce: hashedNonce,
        ),
      );
      final String? idToken = appleCredential.identityToken;
      if (idToken == null) {
        return ResponseModel.failure(
          'Apple Sign-In did not return an identity token. '
          'In Firebase Console, enable Authentication → Sign-in method → Apple.',
        );
      }
      // Apple authorization code as accessToken — required for Firebase to
      // validate the Apple OAuth exchange on recent firebase_auth versions.
      final oauthCredential = OAuthProvider('apple.com').credential(
        idToken: idToken,
        rawNonce: rawNonce,
        accessToken: appleCredential.authorizationCode,
      );
      final cred = await FirebaseApiLogger.traceAuth(
        operation: 'signInWithCredential(Apple)',
        context: 'email: ${appleCredential.email ?? '(private relay or none)'}',
        action: () => _auth.signInWithCredential(oauthCredential),
      );
      final user = cred.user;
      if (user == null) {
        return ResponseModel.failure('Sign-in failed.');
      }
      String? appleDisplayName;
      final given = appleCredential.givenName;
      final family = appleCredential.familyName;
      if ((user.displayName == null || user.displayName!.trim().isEmpty) &&
          ((given != null && given.isNotEmpty) ||
              (family != null && family.isNotEmpty))) {
        final buffer = StringBuffer();
        if (given != null && given.isNotEmpty) {
          buffer.write(given);
        }
        if (family != null && family.isNotEmpty) {
          if (buffer.isNotEmpty) buffer.write(' ');
          buffer.write(family);
        }
        appleDisplayName = buffer.toString().trim();
        if (appleDisplayName.isNotEmpty) {
          unawaited(
            FirebaseApiLogger.traceAuth(
              operation: 'User.updateDisplayName(Apple)',
              action: () => user.updateDisplayName(appleDisplayName!),
            ),
          );
        } else {
          appleDisplayName = null;
        }
      }
      final isNewUserFromAuth = cred.additionalUserInfo?.isNewUser ?? false;
      final providerIds = user.providerData
          .map((UserInfo info) => info.providerId)
          .toSet();
      final shouldSetEmailVerified =
          fromSignupFlow ||
          user.emailVerified ||
          providerIds.contains('google.com') ||
          providerIds.contains('apple.com');
      final resolvedEmail = user.email ?? appleCredential.email?.trim() ?? '';
      final isNewUserByUsersCollection = await _upsertOAuthSignInDocuments(
        user,
        'apple',
        emailForFirestore: resolvedEmail,
        displayNameForFirestore: appleDisplayName ?? user.displayName,
        emailVerified: shouldSetEmailVerified,
      );
      final isNewUser = isNewUserFromAuth || isNewUserByUsersCollection;
      await _syncStorageFromUser(user);
      return ResponseModel.success(
        UserModel(
          id: user.uid,
          email: resolvedEmail,
          name: appleDisplayName ?? user.displayName,
        ),
        authStatus: isNewUser ? authStatusNewUser : authStatusExistingUser,
      );
    } on SignInWithAppleAuthorizationException catch (e) {
      if (e.code == AuthorizationErrorCode.canceled) {
        return ResponseModel.failure(
          'Sign-in was cancelled.',
          authStatus: authStatusCancelled,
        );
      }
      return ResponseModel.failure(
        e.message.isNotEmpty ? e.message : 'Apple sign-in failed.',
      );
    } on SignInWithAppleNotSupportedException {
      return ResponseModel.failure(
        'Sign in with Apple is not supported on this OS version.',
      );
    } on SocketException {
      return ResponseModel.failure(
        'No internet connection. Please check your network and try again.',
      );
    } on FirebaseAuthException catch (e) {
      return ResponseModel.failure(_firebaseAuthMessage(e));
    } catch (e) {
      return ResponseModel.failure(_mapError(e));
    }
  }

  /// Sends signup OTP via Cloud Function (hashed server-side). No Auth user yet.
  Future<ResponseModel<UserModel>> sendSignupOtp({
    required String email,
  }) async {
    final trimmed = email.trim();
    try {
      final result = await FirebaseApiLogger.invokeHttpsCallable(
        callable: _functions.httpsCallable('sendSignupOtp'),
        functionName: 'sendSignupOtp',
        parameters: <String, dynamic>{'email': trimmed},
        functionsRegion: ApiConstants.firebaseFunctionsRegion,
      );
      final data = Map<String, dynamic>.from(result.data as Map);
      final status = data['status'] as String? ?? authStatusInternalError;
      switch (status) {
        case authStatusSuccess:
          return ResponseModel.success(
            UserModel(id: '', email: trimmed, name: null),
          );
        case authStatusAccountExists:
          return ResponseModel.failure(
            'Account already exists. Please login.',
            authStatus: authStatusAccountExists,
          );
        case authStatusTooManyRequests:
          return ResponseModel.failure(
            (data['message'] as String?)?.trim().isNotEmpty == true
                ? data['message'] as String
                : 'Too many requests. Try again later.',
            authStatus: authStatusTooManyRequests,
          );
        default:
          return ResponseModel.failure(
            (data['message'] as String?)?.trim().isNotEmpty == true
                ? data['message'] as String
                : 'Something went wrong. Please try again.',
            authStatus: status,
          );
      }
    } on FirebaseFunctionsException catch (e) {
      return ResponseModel.failure(
        _functionsMessage(e),
        authStatus: authStatusInternalError,
      );
    } catch (e) {
      return ResponseModel.failure(
        _mapError(e),
        authStatus: authStatusInternalError,
      );
    }
  }

  /// True when verify callable rejected the OTP because it was already consumed
  /// (e.g. double tap after a successful verify).
  static bool isSignupOtpAlreadyUsedResponse(ResponseModel<UserModel> r) {
    if (r.success) return false;
    if (r.authStatus != authStatusInvalidCode) return false;
    final m = r.message?.toLowerCase() ?? '';
    return m.contains('already') && m.contains('used');
  }

  Future<void> _mergeUserLastLoginAndSync(User user) async {
    await FirebaseApiLogger.traceFirestore(
      operation: 'set(merge)',
      path: 'users/${user.uid}',
      action: () => _firestore.collection('users').doc(user.uid).set({
        'lastLoginAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true)),
    );
    await _syncStorageFromUser(user);
  }

  /// After the server has created the Auth user, sign in and sync local session.
  Future<ResponseModel<UserModel>> _signInAfterOtpServerSuccess(
    String trimmedEmail,
    String password,
  ) async {
    try {
      final cred = await FirebaseApiLogger.traceAuth(
        operation: 'signInWithEmailAndPassword',
        context: 'email: $trimmedEmail',
        action: () => _auth.signInWithEmailAndPassword(
          email: trimmedEmail,
          password: password,
        ),
      );
      final user = cred.user;
      if (user == null) {
        return ResponseModel.failure(
          'Sign-in failed. Please try again.',
          authStatus: authStatusInternalError,
        );
      }
      await _mergeUserLastLoginAndSync(user);
      return ResponseModel.success(
        UserModel(
          id: user.uid,
          email: user.email ?? trimmedEmail,
          name: user.displayName,
        ),
      );
    } on FirebaseAuthException catch (e) {
      return ResponseModel.failure(
        _firebaseAuthMessage(e),
        authStatus: authStatusInternalError,
      );
    }
  }

  /// Completes signup when the OTP doc is already verified (duplicate verify tap)
  /// or this device already signed in from the first attempt.
  Future<ResponseModel<UserModel>> ensureSignedInAfterSignupOtp({
    required String email,
    required String password,
  }) async {
    final trimmedEmail = email.trim();
    final current = _auth.currentUser;
    final emailMatch =
        current?.email?.toLowerCase() == trimmedEmail.toLowerCase();
    if (current != null && emailMatch) {
      await _mergeUserLastLoginAndSync(current);
      return ResponseModel.success(
        UserModel(
          id: current.uid,
          email: current.email ?? trimmedEmail,
          name: current.displayName,
        ),
      );
    }
    return _signInAfterOtpServerSuccess(trimmedEmail, password);
  }

  /// Verifies OTP on server, creates Auth user + Firestore docs, returns custom token.
  Future<ResponseModel<UserModel>> verifySignupOtpAndCreateUser({
    required String email,
    required String password,
    required String code,
  }) async {
    final trimmedEmail = email.trim();
    try {
      final result = await FirebaseApiLogger.invokeHttpsCallable(
        callable: _functions.httpsCallable('verifySignupOtpAndCreateUser'),
        functionName: 'verifySignupOtpAndCreateUser',
        parameters: <String, dynamic>{
          'email': trimmedEmail,
          'password': password,
          'code': code.trim(),
        },
        functionsRegion: ApiConstants.firebaseFunctionsRegion,
      );
      final data = Map<String, dynamic>.from(result.data as Map);
      final status = data['status'] as String? ?? authStatusInternalError;
      if (status == authStatusSuccess) {
        return _signInAfterOtpServerSuccess(trimmedEmail, password);
      }
      final message = (data['message'] as String?)?.trim();
      return ResponseModel.failure(
        message != null && message.isNotEmpty
            ? message
            : _defaultMessageForVerifyStatus(status),
        authStatus: status,
      );
    } on FirebaseFunctionsException catch (e) {
      return ResponseModel.failure(
        _functionsMessage(e),
        authStatus: authStatusInternalError,
      );
    } on FirebaseAuthException catch (e) {
      return ResponseModel.failure(
        _firebaseAuthMessage(e),
        authStatus: authStatusInternalError,
      );
    } catch (e) {
      return ResponseModel.failure(
        _mapError(e),
        authStatus: authStatusInternalError,
      );
    }
  }

  String _defaultMessageForVerifyStatus(String status) {
    switch (status) {
      case authStatusInvalidCode:
        return 'Invalid verification code.';
      case authStatusExpiredCode:
        return 'Code has expired. Request a new code.';
      case authStatusTooManyAttempts:
        return 'Too many attempts. Try again later.';
      case authStatusAccountExists:
        return 'Account already exists. Please sign in.';
      case authStatusWeakPassword:
        return 'Password is too weak.';
      default:
        return 'Something went wrong. Please try again.';
    }
  }

  /// Whether the signed-in user should land on Home (vs onboarding entry).
  ///
  /// True when [profiles.onboardingComplete] is true or a username was saved
  /// (identity step done); handles profiles created before the flag was written.
  Future<bool> isProfileOnboardingComplete({bool forceRefresh = false}) async {
    if (Firebase.apps.isNotEmpty) {
      final uid = _auth.currentUser?.uid;
      if (uid != null) {
        if (!forceRefresh) {
          final cached = _readCachedOnboardingComplete(uid);
          if (cached != null) {
            return cached;
          }
        }
        try {
          final snap = await _firestore.collection('profiles').doc(uid).get();
          final done = _profileDataIndicatesOnboardingComplete(snap.data());
          await _persistOnboardingCache(uid, done);
          return done;
        } catch (_) {
          return false;
        }
      }
    }

    final localEmail = _localAuthStore.activeEmail;
    if (localEmail == null) {
      return false;
    }
    final localUid = await _localAuthStore.userIdForEmail(localEmail);
    if (localUid == null) {
      return false;
    }
    if (!forceRefresh) {
      final cached = _readCachedOnboardingComplete(localUid);
      if (cached != null) {
        return cached;
      }
    }
    final done = await _localAuthStore.isOnboardingComplete(localEmail);
    await _persistOnboardingCache(localUid, done);
    return done;
  }

  Future<void> markOnboardingComplete() async {
    if (Firebase.apps.isNotEmpty) {
      final uid = _auth.currentUser?.uid;
      if (uid != null) {
        await mergeProfileOnboardingFields(
          uid: uid,
          onboardingComplete: true,
        );
      }
    }

    final localEmail = _localAuthStore.activeEmail;
    if (localEmail != null) {
      await _localAuthStore.setOnboardingComplete(localEmail, true);
      final localUid = await _localAuthStore.userIdForEmail(localEmail);
      if (localUid != null) {
        await _persistOnboardingCache(localUid, true);
      }
    }
  }

  /// Sends branded reset email via Cloud Function ([requestPasswordReset]).
  /// Server always succeeds from the client’s perspective (no enumeration).
  Future<ResponseModel<bool>> forgotPassword(String email) async {
    final normalized = email.trim().toLowerCase();
    if (normalized.isEmpty) {
      return ResponseModel.failure('Email is required');
    }
    try {
      await FirebaseApiLogger.invokeHttpsCallable(
        callable: _functions.httpsCallable('requestPasswordReset'),
        functionName: 'requestPasswordReset',
        parameters: <String, dynamic>{'email': normalized},
        functionsRegion: ApiConstants.firebaseFunctionsRegion,
      );
      return ResponseModel.success(true);
    } on FirebaseFunctionsException catch (e) {
      return ResponseModel.failure(_functionsMessage(e));
    } catch (e) {
      return ResponseModel.failure(_mapError(e));
    }
  }

  /// @nodoc Kept for call sites; delegates to [forgotPassword].
  Future<ResponseModel<bool>> requestPasswordReset(String email) {
    return forgotPassword(email);
  }

  /// Completes reset using OOB [code] from the email link ([confirmPasswordReset]).
  Future<ResponseModel<bool>> resetPassword({
    required String code,
    required String newPassword,
  }) async {
    final trimmed = code.trim();
    if (trimmed.isEmpty) {
      return ResponseModel.failure(
        'Open the reset link from your email to finish changing your password, '
        'or request a new reset email from the login screen.',
      );
    }
    try {
      await FirebaseApiLogger.traceAuth(
        operation: 'confirmPasswordReset',
        context: 'oob code and new password omitted from logs',
        action: () =>
            _auth.confirmPasswordReset(code: trimmed, newPassword: newPassword),
      );
      return ResponseModel.success(true);
    } on FirebaseAuthException catch (e) {
      return ResponseModel.failure(_firebaseAuthMessage(e));
    } catch (e) {
      return ResponseModel.failure(_mapError(e));
    }
  }

  Future<void> logout() async {
    try {
      await GoogleSignIn().signOut();
    } catch (_) {}
    await _localAuthStore.clearActiveSession();
    await clearOnboardingCache();
    await _storage.clearSession();
    if (Firebase.apps.isNotEmpty) {
      await FirebaseApiLogger.traceAuth(
        operation: 'signOut',
        action: () => _auth.signOut(),
      );
    }
  }

  Future<String?> _resolveCurrentAccountEmail() async {
    if (Firebase.apps.isNotEmpty) {
      final email = _auth.currentUser?.email?.trim();
      if (email != null && email.isNotEmpty) {
        return email;
      }
    }
    return _localAuthStore.activeEmail ?? _localAuthStore.rememberedEmail;
  }

  Future<void> _deleteFirestoreUserData(String uid) async {
    if (Firebase.apps.isEmpty) {
      return;
    }
    final profileRef = _firestore.collection('profiles').doc(uid);
    final profileSnap = await profileRef.get();
    final username = (profileSnap.data()?['username'] as String?)?.trim() ?? '';
    final batch = _firestore.batch();
    batch.delete(profileRef);
    batch.delete(_firestore.collection('users').doc(uid));
    if (username.isNotEmpty) {
      batch.delete(
        _firestore.collection('usernames').doc(username.toLowerCase()),
      );
    }
    await batch.commit();
  }

  /// Permanently deletes the signed-in account (Firebase + local device data).
  Future<ResponseModel<bool>> deleteAccount() async {
    try {
      final email = await _resolveCurrentAccountEmail();

      if (Firebase.apps.isNotEmpty) {
        final user = _auth.currentUser;
        if (user != null) {
          final uid = user.uid;
          try {
            await _deleteFirestoreUserData(uid);
            await FirebaseApiLogger.traceAuth(
              operation: 'User.delete',
              context: 'uid: $uid',
              action: () => user.delete(),
            );
          } on FirebaseAuthException catch (e) {
            if (e.code == 'requires-recent-login') {
              return ResponseModel.failure(
                'For your security, please sign in again before deleting '
                'your account.',
              );
            }
            return ResponseModel.failure(_firebaseAuthMessage(e));
          }
        }
      }

      if (email != null && email.isNotEmpty) {
        await _localAuthStore.deleteAccount(email);
      }
      await _localAuthStore.clearRememberedCredentials();
      await _localAuthStore.clearActiveSession();
      await clearOnboardingCache();
      await _storage.clearSession();

      if (Firebase.apps.isNotEmpty) {
        try {
          await FirebaseApiLogger.traceAuth(
            operation: 'signOut',
            action: () => _auth.signOut(),
          );
        } catch (_) {}
      }

      return ResponseModel.success(true);
    } on FirebaseException catch (e) {
      return ResponseModel.failure(e.message ?? 'Failed to delete account');
    } catch (e) {
      return ResponseModel.failure(_mapError(e));
    }
  }

  String _genderLabel(int index) {
    switch (index) {
      case 0:
        return 'male';
      case 1:
        return 'female';
      default:
        return 'other';
    }
  }

  /// Claims `usernames/{canonical}` and merges identity fields into `profiles/{uid}`.
  Future<ResponseModel<bool>> saveIdentityAndClaimUsername({
    required String uid,
    required String firstName,
    required String lastName,
    required String username,
    required DateTime dateOfBirth,
    required int genderIndex,
  }) async {
    final canonical = username.trim().toLowerCase();
    if (canonical.isEmpty) {
      return ResponseModel.failure('Username is required');
    }
    try {
      await FirebaseApiLogger.traceFirestore(
        operation: 'runTransaction',
        path: 'usernames/$canonical, profiles/$uid',
        action: () => _firestore.runTransaction((transaction) async {
          final profileRef = _firestore.collection('profiles').doc(uid);
          final profileSnap = await transaction.get(profileRef);
          final existingUsername =
              (profileSnap.data()?['username'] as String?)?.trim() ?? '';
          final existingCanonical = existingUsername.toLowerCase();

          final usernameRef = _firestore.collection('usernames').doc(canonical);
          final usernameSnap = await transaction.get(usernameRef);
          if (usernameSnap.exists) {
            final claimedUid = (usernameSnap.data()?['uid'] as String?)?.trim();
            if (claimedUid != uid) {
              throw ServerException(
                'Username is already taken',
                statusCode: 409,
              );
            }
          }

          // If this user previously claimed a different username, release it.
          if (existingCanonical.isNotEmpty && existingCanonical != canonical) {
            final oldUsernameRef = _firestore
                .collection('usernames')
                .doc(existingCanonical);
            final oldUsernameSnap = await transaction.get(oldUsernameRef);
            final oldClaimedUid = (oldUsernameSnap.data()?['uid'] as String?)
                ?.trim();
            if (oldUsernameSnap.exists && oldClaimedUid == uid) {
              transaction.delete(oldUsernameRef);
            }
          }

          transaction.set(usernameRef, {
            'uid': uid,
            'createdAt': FieldValue.serverTimestamp(),
            'updatedAt': FieldValue.serverTimestamp(),
          }, SetOptions(merge: true));
          transaction.set(profileRef, {
            'firstName': firstName.trim(),
            'lastName': lastName.trim(),
            'displayName': '${firstName.trim()} ${lastName.trim()}'.trim(),
            'username': username.trim(),
            'dob': Timestamp.fromDate(dateOfBirth),
            'gender': _genderLabel(genderIndex),
            'updatedAt': FieldValue.serverTimestamp(),
          }, SetOptions(merge: true));
        }),
      );
      await _persistOnboardingCache(uid, true);
      return ResponseModel.success(true);
    } on ServerException catch (e) {
      return ResponseModel.failure(e.message, statusCode: e.statusCode);
    } on FirebaseException catch (e) {
      return ResponseModel.failure(e.message ?? 'Failed to save profile');
    } catch (e) {
      return ResponseModel.failure(_mapError(e));
    }
  }

  /// Merges only non-null fields so earlier onboarding steps are not wiped.
  Future<ResponseModel<bool>> mergeProfileOnboardingFields({
    required String uid,
    String? bio,
    String? avatarUrl,
    String? coverUrl,
    String? country,
    String? city,
    String? gender,
    DateTime? dob,
    List<String>? languages,
    List<String>? interests,
    Map<String, dynamic>? socialLinks,
    bool? onboardingComplete,
  }) async {
    final patch = <String, dynamic>{'updatedAt': FieldValue.serverTimestamp()};
    if (bio != null) {
      patch['bio'] = bio;
    }
    if (avatarUrl != null) {
      patch['avatarUrl'] = avatarUrl;
    }
    if (coverUrl != null) {
      patch['coverUrl'] = coverUrl;
    }
    if (country != null) {
      patch['country'] = country;
    }
    if (city != null) {
      patch['city'] = city;
    }
    if (gender != null) {
      patch['gender'] = gender;
    }
    if (dob != null) {
      patch['dob'] = Timestamp.fromDate(dob);
    }
    if (languages != null) {
      patch['languages'] = languages;
    }
    if (interests != null) {
      patch['interests'] = interests;
    }
    if (socialLinks != null) {
      patch['socialLinks'] = socialLinks;
    }
    if (onboardingComplete != null) {
      patch['onboardingComplete'] = onboardingComplete;
    }
    try {
      await FirebaseApiLogger.traceFirestore(
        operation: 'set(merge)',
        path: 'profiles/$uid',
        action: () => _firestore
            .collection('profiles')
            .doc(uid)
            .set(patch, SetOptions(merge: true)),
      );
      if (onboardingComplete == true) {
        await _persistOnboardingCache(uid, true);
      } else {
        await clearOnboardingCache();
      }
      return ResponseModel.success(true);
    } on FirebaseException catch (e) {
      return ResponseModel.failure(e.message ?? 'Failed to save profile');
    } catch (e) {
      return ResponseModel.failure(_mapError(e));
    }
  }

  static String _imageContentTypeForPath(String path) {
    final lower = path.toLowerCase();
    if (lower.endsWith('.png')) {
      return 'image/png';
    }
    if (lower.endsWith('.webp')) {
      return 'image/webp';
    }
    return 'image/jpeg';
  }

  /// Uploads to Storage `avatar/{uid}/avatar.jpg` (matches console folder `avatar/`).
  Future<ResponseModel<String>> uploadProfileAvatar(File file) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) {
      return ResponseModel.failure('Not signed in');
    }
    try {
      final ref = FirebaseStorage.instance.ref('avatar/$uid/avatar.jpg');
      await ref.putFile(
        file,
        SettableMetadata(contentType: _imageContentTypeForPath(file.path)),
      );
      final url = await ref.getDownloadURL();
      return ResponseModel.success(url);
    } on FirebaseException catch (e) {
      return ResponseModel.failure(e.message ?? 'Upload failed');
    } catch (e) {
      return ResponseModel.failure(_mapError(e));
    }
  }

  /// Uploads to Storage `userCoverImage/{uid}/cover.jpg`.
  Future<ResponseModel<String>> uploadProfileCover(File file) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) {
      return ResponseModel.failure('Not signed in');
    }
    try {
      final ref = FirebaseStorage.instance.ref('userCoverImage/$uid/cover.jpg');
      await ref.putFile(
        file,
        SettableMetadata(contentType: _imageContentTypeForPath(file.path)),
      );
      final url = await ref.getDownloadURL();
      return ResponseModel.success(url);
    } on FirebaseException catch (e) {
      return ResponseModel.failure(e.message ?? 'Upload failed');
    } catch (e) {
      return ResponseModel.failure(_mapError(e));
    }
  }

  Future<ResponseModel<Map<String, dynamic>>> fetchProfileRaw() async {
    try {
      final res = await _api.get(ApiConstants.profilePath);
      if (res.statusCode >= 200 && res.statusCode < 300) {
        final map = jsonDecode(res.body) as Map<String, dynamic>;
        return ResponseModel.success(map, statusCode: res.statusCode);
      }
      throw ServerException('Request failed', statusCode: res.statusCode);
    } on ServerException catch (e) {
      return ResponseModel.failure(e.message, statusCode: e.statusCode);
    } catch (e) {
      return ResponseModel.failure(_mapError(e));
    }
  }
}
