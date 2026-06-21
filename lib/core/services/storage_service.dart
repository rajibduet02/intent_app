import 'package:intent_app/core/constants/storage_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Typed local persistence via [SharedPreferences].
class StorageService {
  StorageService(this._prefs);

  final SharedPreferences _prefs;

  String? get authToken => _prefs.getString(StorageKeys.authToken);

  Future<void> saveAuthToken(String token) =>
      _prefs.setString(StorageKeys.authToken, token);

  Future<void> saveUserId(String id) =>
      _prefs.setString(StorageKeys.userId, id);

  String? get userId => _prefs.getString(StorageKeys.userId);

  Future<void> clearSession() async {
    await _prefs.remove(StorageKeys.authToken);
    await _prefs.remove(StorageKeys.userId);
    await clearOnboardingCache();
  }

  /// Last known onboarding-complete flag for [uid], or `null` if none / uid mismatch.
  bool? readOnboardingCompleteForUid(String uid) {
    final cachedUid = _prefs.getString(StorageKeys.onboardingCacheUid);
    if (cachedUid != uid) {
      return null;
    }
    if (!_prefs.containsKey(StorageKeys.onboardingCacheComplete)) {
      return null;
    }
    return _prefs.getBool(StorageKeys.onboardingCacheComplete);
  }

  Future<void> saveOnboardingCompleteCache({
    required String uid,
    required bool complete,
  }) async {
    await _prefs.setString(StorageKeys.onboardingCacheUid, uid);
    await _prefs.setBool(StorageKeys.onboardingCacheComplete, complete);
  }

  Future<void> clearOnboardingCache() async {
    await _prefs.remove(StorageKeys.onboardingCacheUid);
    await _prefs.remove(StorageKeys.onboardingCacheComplete);
  }

  bool get hasValidSession {
    final t = authToken;
    return t != null && t.isNotEmpty;
  }

  /// `null` if never stored.
  List<String>? readRecentSearchesRaw() {
    final list = _prefs.getStringList(StorageKeys.recentSearches);
    if (list == null) return null;
    return list.where((s) => s.isNotEmpty).toList();
  }

  Future<void> saveRecentSearches(List<String> queries) =>
      _prefs.setStringList(StorageKeys.recentSearches, queries);
}
