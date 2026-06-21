import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intent_app/app/providers/api_client_provider.dart';
import 'package:intent_app/app/providers/storage_service_provider.dart';
import 'package:intent_app/data/repositories/auth_repository.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(
    ref.watch(apiClientProvider),
    ref.watch(storageServiceProvider),
  );
});
