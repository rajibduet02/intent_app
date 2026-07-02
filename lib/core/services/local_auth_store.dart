import 'dart:convert';
import 'dart:math' show Random;

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intent_app/core/constants/storage_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Device-local email accounts for demo signup and remembered sign-in.
class LocalAuthStore {
  LocalAuthStore(this._prefs, {FlutterSecureStorage? secureStorage})
    : _secureStorage =
          secureStorage ??
          const FlutterSecureStorage(
            aOptions: AndroidOptions(),
          );

  final SharedPreferences _prefs;
  final FlutterSecureStorage _secureStorage;

  static const String _accountsKey = 'local_auth_accounts';
  static const String _rememberedPasswordKey = 'remembered_password';

  String _normalizeEmail(String email) => email.trim().toLowerCase();

  String? get activeEmail => _prefs.getString(StorageKeys.localSessionEmail);

  bool get hasActiveSession {
    final email = activeEmail;
    return email != null && email.isNotEmpty;
  }

  Future<Map<String, dynamic>> _readAccounts() async {
    final raw = await _secureStorage.read(key: _accountsKey);
    if (raw == null || raw.isEmpty) {
      return <String, dynamic>{};
    }
    try {
      final decoded = jsonDecode(raw);
      if (decoded is Map<String, dynamic>) {
        return decoded;
      }
      if (decoded is Map) {
        return Map<String, dynamic>.from(decoded);
      }
    } catch (_) {}
    return <String, dynamic>{};
  }

  Future<void> _writeAccounts(Map<String, dynamic> accounts) async {
    await _secureStorage.write(key: _accountsKey, value: jsonEncode(accounts));
  }

  String _generateLocalUserId() {
    final random = Random.secure();
    return 'local_${DateTime.now().millisecondsSinceEpoch}_${random.nextInt(999999)}';
  }

  Future<void> registerAccount({
    required String email,
    required String password,
    String? existingUserId,
  }) async {
    final key = _normalizeEmail(email);
    final accounts = await _readAccounts();
    final existing = accounts[key];
    final userId = existing is Map
        ? (existing['id'] as String?) ?? existingUserId ?? _generateLocalUserId()
        : existingUserId ?? _generateLocalUserId();
    final onboardingComplete = existing is Map
        ? existing['onboardingComplete'] == true
        : false;
    accounts[key] = <String, dynamic>{
      'id': userId,
      'password': password,
      'onboardingComplete': onboardingComplete,
    };
    await _writeAccounts(accounts);
  }

  Future<bool> verifyCredentials(String email, String password) async {
    final key = _normalizeEmail(email);
    final accounts = await _readAccounts();
    final entry = accounts[key];
    if (entry is! Map) {
      return false;
    }
    return entry['password'] == password;
  }

  Future<String?> userIdForEmail(String email) async {
    final key = _normalizeEmail(email);
    final accounts = await _readAccounts();
    final entry = accounts[key];
    if (entry is! Map) {
      return null;
    }
    return entry['id'] as String?;
  }

  Future<bool> isOnboardingComplete(String email) async {
    final key = _normalizeEmail(email);
    final accounts = await _readAccounts();
    final entry = accounts[key];
    if (entry is! Map) {
      return false;
    }
    return entry['onboardingComplete'] == true;
  }

  Future<void> setOnboardingComplete(String email, bool complete) async {
    final key = _normalizeEmail(email);
    final accounts = await _readAccounts();
    final entry = accounts[key];
    if (entry is! Map) {
      return;
    }
    accounts[key] = <String, dynamic>{
      ...Map<String, dynamic>.from(entry),
      'onboardingComplete': complete,
    };
    await _writeAccounts(accounts);
  }

  Future<bool> activateSession({
    required String email,
    required String userId,
  }) async {
    await _prefs.setString(StorageKeys.localSessionEmail, _normalizeEmail(email));
    await _prefs.setString(StorageKeys.userId, userId);
    await _prefs.setString(StorageKeys.authToken, 'local_session_$userId');
    return true;
  }

  Future<void> clearActiveSession() async {
    await _prefs.remove(StorageKeys.localSessionEmail);
    await _prefs.remove(StorageKeys.authToken);
    await _prefs.remove(StorageKeys.userId);
  }

  Future<bool> signIn(String email, String password) async {
    if (!await verifyCredentials(email, password)) {
      return false;
    }
    final userId = await userIdForEmail(email);
    if (userId == null || userId.isEmpty) {
      return false;
    }
    await activateSession(email: email, userId: userId);
    return true;
  }

  Future<void> deleteAccount(String email) async {
    final key = _normalizeEmail(email);
    final accounts = await _readAccounts();
    accounts.remove(key);
    await _writeAccounts(accounts);
    if (activeEmail == key) {
      await clearActiveSession();
    }
  }

  Future<void> saveRememberedCredentials({
    required String email,
    required String password,
  }) async {
    await _prefs.setString(
      StorageKeys.rememberedEmail,
      _normalizeEmail(email),
    );
    await _prefs.setBool(StorageKeys.rememberMeEnabled, true);
    await _secureStorage.write(key: _rememberedPasswordKey, value: password);
  }

  Future<void> clearRememberedCredentials() async {
    await _prefs.remove(StorageKeys.rememberedEmail);
    await _prefs.remove(StorageKeys.rememberMeEnabled);
    await _secureStorage.delete(key: _rememberedPasswordKey);
  }

  bool get rememberMeEnabled =>
      _prefs.getBool(StorageKeys.rememberMeEnabled) ?? false;

  String? get rememberedEmail => _prefs.getString(StorageKeys.rememberedEmail);

  Future<String?> readRememberedPassword() =>
      _secureStorage.read(key: _rememberedPasswordKey);

  Future<({String? email, String? password, bool rememberMe})>
  readRememberedCredentials() async {
    final rememberMe = rememberMeEnabled;
    if (!rememberMe) {
      return (email: null, password: null, rememberMe: false);
    }
    final email = rememberedEmail;
    if (email == null || email.isEmpty) {
      return (email: null, password: null, rememberMe: false);
    }
    final password = await readRememberedPassword();
    return (email: email, password: password, rememberMe: true);
  }
}
