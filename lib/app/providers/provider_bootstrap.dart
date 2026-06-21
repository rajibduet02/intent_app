import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intent_app/app/bootstrap/auth_state_bootstrap.dart';

/// Shared [ProviderContainer] for app-wide Riverpod services.
late final ProviderContainer appProviderContainer;

void initAppProviderContainer({List<Override> overrides = const []}) {
  appProviderContainer = ProviderContainer(overrides: overrides);
}

void disposeAppProviderContainer() {
  AuthStateBootstrap.dispose();
  appProviderContainer.dispose();
}
