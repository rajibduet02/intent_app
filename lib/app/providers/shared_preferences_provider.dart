import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Must be overridden in [main] after [SharedPreferences.getInstance].
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnsupportedError(
    'sharedPreferencesProvider: override with SharedPreferences.getInstance() in main().',
  );
});
