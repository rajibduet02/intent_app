import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intent_app/app/providers/shared_preferences_provider.dart';
import 'package:intent_app/core/services/storage_service.dart';

final storageServiceProvider = Provider<StorageService>((ref) {
  return StorageService(ref.watch(sharedPreferencesProvider));
});
