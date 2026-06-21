/// App-wide non-API constants (durations, limits, UI copy keys, etc.).
abstract final class AppConstants {
  AppConstants._();

  static const String appName = 'Intent';
  static const Duration splashDelay = Duration(seconds: 2);
  static const int minPasswordLength = 6;

  /// Minimum length for new password on reset-password screen (stricter).
  static const int minPasswordLengthReset = 8;

  /// Demo OTP for verify screen (auto-advances without backend).
  static const String demoVerificationCode = '123456';
}
