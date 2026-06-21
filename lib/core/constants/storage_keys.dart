/// Keys used with [StorageService].
abstract final class StorageKeys {
  StorageKeys._();

  static const String authToken = 'auth_token';
  static const String userId = 'user_id';

  /// Cached [AuthRepository.isProfileOnboardingComplete] for cold start (per uid).
  static const String onboardingCacheUid = 'onboarding_cache_uid';
  static const String onboardingCacheComplete = 'onboarding_cache_complete';

  /// Home / search — persisted list of query strings (order: newest first).
  static const String recentSearches = 'recent_searches';
}
