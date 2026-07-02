import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intent_app/app/providers/shared_preferences_provider.dart';
import 'package:intent_app/core/services/local_auth_store.dart';

final localAuthStoreProvider = Provider<LocalAuthStore>((ref) {
  return LocalAuthStore(ref.watch(sharedPreferencesProvider));
});
