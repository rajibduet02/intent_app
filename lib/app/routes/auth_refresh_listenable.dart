import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:intent_app/app/theme/app_animations.dart';
import 'package:intent_app/core/services/storage_service.dart';
import 'package:intent_app/data/repositories/auth_repository.dart';

/// Drives [GoRouter] refresh + cached auth/onboarding state for redirects.
final AuthRefreshListenable authRefreshListenable = AuthRefreshListenable();

class AuthRefreshListenable extends ChangeNotifier {
  AuthRefreshListenable({FirebaseAuth? auth}) : _authOverride = auth;

  final FirebaseAuth? _authOverride;
  StreamSubscription<User?>? _subscription;
  Timer? _authDebounceTimer;

  AuthRepository Function()? _authRepository;
  StorageService Function()? _storageService;

  User? _user;
  bool? _onboardingComplete;
  bool _splashResolving = false;
  bool _isHandlingAuthEvent = false;

  User? get user => _user;

  bool? get onboardingComplete => _onboardingComplete;

  bool get isSignedIn => _user != null;

  bool get splashResolving => _splashResolving;

  void attach({
    required AuthRepository Function() authRepository,
    required StorageService Function() storageService,
  }) {
    final auth = _resolveAuth();
    if (auth == null) {
      return;
    }

    _authRepository = authRepository;
    _storageService = storageService;
    _user = auth.currentUser;
    _subscription?.cancel();
    _subscription = auth.authStateChanges().listen(_scheduleAuthHandling);
    if (_user != null) {
      unawaited(refreshOnboardingStatus());
    }
  }

  FirebaseAuth? _resolveAuth() {
    if (_authOverride != null) {
      return _authOverride;
    }
    if (Firebase.apps.isEmpty) {
      return null;
    }
    return FirebaseAuth.instance;
  }

  void setSplashResolving(bool value) {
    if (_splashResolving == value) {
      return;
    }
    _splashResolving = value;
    notifyListeners();
  }

  /// Call after repository updates onboarding cache (identity, profile merge, etc.).
  Future<void> refreshOnboardingStatus({bool forceRefresh = false}) async {
    final repo = _authRepository?.call();
    if (repo == null || _user == null) {
      return;
    }
    _onboardingComplete = await repo.isProfileOnboardingComplete(
      forceRefresh: forceRefresh,
    );
    notifyListeners();
  }

  void _scheduleAuthHandling(User? user) {
    _authDebounceTimer?.cancel();
    _authDebounceTimer = Timer(AppAnimations.authDebounce, () {
      unawaited(_handleAuthChanged(user));
    });
  }

  Future<void> _handleAuthChanged(User? user) async {
    if (_isHandlingAuthEvent) {
      return;
    }
    _isHandlingAuthEvent = true;
    try {
      _user = user;
      if (user == null) {
        _onboardingComplete = null;
        final repo = _authRepository?.call();
        final storage = _storageService?.call();
        await repo?.clearOnboardingCache();
        await storage?.clearSession();
        notifyListeners();
        return;
      }

      final repo = _authRepository?.call();
      if (repo != null) {
        await repo.refreshStorageFromCurrentUser();
        _onboardingComplete = await repo.isProfileOnboardingComplete();
      }
      notifyListeners();
    } finally {
      _isHandlingAuthEvent = false;
    }
  }

  @override
  void dispose() {
    _authDebounceTimer?.cancel();
    _authDebounceTimer = null;
    _subscription?.cancel();
    _subscription = null;
    _authRepository = null;
    _storageService = null;
    super.dispose();
  }
}
