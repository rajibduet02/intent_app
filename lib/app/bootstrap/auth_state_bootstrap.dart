import 'package:intent_app/app/providers/auth_repository_provider.dart';
import 'package:intent_app/app/providers/provider_bootstrap.dart';
import 'package:intent_app/app/providers/storage_service_provider.dart';
import 'package:intent_app/app/routes/auth_refresh_listenable.dart';

/// Attaches Firebase auth listening for session sync and router refresh.
abstract final class AuthStateBootstrap {
  AuthStateBootstrap._();

  static bool _attached = false;

  static void start() {
    if (_attached) {
      return;
    }
    _attached = true;
    authRefreshListenable.attach(
      authRepository: () => appProviderContainer.read(authRepositoryProvider),
      storageService: () => appProviderContainer.read(storageServiceProvider),
    );
  }

  static void dispose() {
    authRefreshListenable.dispose();
    _attached = false;
  }
}
