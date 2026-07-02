import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:intent_app/app/theme/app_animations.dart';
import 'package:intent_app/core/services/local_auth_store.dart';
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
  LocalAuthStore Function()? _localAuthStore;

  User? _user;
  bool? _onboardingComplete;
  bool _hasLocalSession = false;
  bool _splashResolving = false;
  bool _isHandlingAuthEvent = false;

  User? get user => _user;

  bool? get onboardingComplete => _onboardingComplete;

  bool get isSignedIn => _user != null || _hasLocalSession;

  bool get splashResolving => _splashResolving;

  void attach({
    required AuthRepository Function() authRepository,
    required StorageService Function() storageService,
    required LocalAuthStore Function() localAuthStore,
  }) {
    final auth = _resolveAuth();

    _authRepository = authRepository;
    _storageService = storageService;
    _localAuthStore = localAuthStore;
    _hasLocalSession = localAuthStore().hasActiveSession;

    if (auth == null) {
      if (_hasLocalSession) {
        unawaited(refreshOnboardingStatus());
      }
      return;
    }

    _user = auth.currentUser;
    _subscription?.cancel();
    _subscription = auth.authStateChanges().listen(_scheduleAuthHandling);
    if (_user != null || _hasLocalSession) {
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
    if (repo == null) {
      return;
    }
    if (_user == null && !_hasLocalSession) {
      return;
    }
    _onboardingComplete = await repo.isProfileOnboardingComplete(
      forceRefresh: forceRefresh,
    );
    notifyListeners();
  }

  /// Notifies listeners after a local-only session sign-in (no Firebase user).
  Future<void> notifyLocalSessionChanged() async {
    _hasLocalSession = _localAuthStore?.call().hasActiveSession ?? false;
    if (_hasLocalSession) {
      await refreshOnboardingStatus();
    } else {
      notifyListeners();
    }
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
      _hasLocalSession = _localAuthStore?.call().hasActiveSession ?? false;
      if (user == null) {
        _onboardingComplete = null;
        final repo = _authRepository?.call();
        final storage = _storageService?.call();
        if (!_hasLocalSession) {
          await repo?.clearOnboardingCache();
          await storage?.clearSession();
        }
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
    _localAuthStore = null;
    super.dispose();
  }
}
