import 'package:intent_app/core/constants/api_constants.dart';

/// Environment-level configuration (URLs, feature flags).
abstract final class Env {
  Env._();

  static String get apiBaseUrl => ApiConstants.baseUrl;
}
