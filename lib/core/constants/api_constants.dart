/// Remote API configuration. Replace with your backend URLs.
abstract final class ApiConstants {
  ApiConstants._();

  /// Region for signup OTP callables (`sendSignupOtp`, `verifySignupOtpAndCreateUser`).
  static const String firebaseFunctionsRegion = 'us-central1';

  // static const String baseUrl = 'https://api.example.com';
  static const String baseUrl = 'https://api.example.com';
  static const String loginPath = '/auth/login';
  static const String registerPath = '/auth/register';
  static const String forgotPasswordPath = '/auth/forgot-password';
  static const String resetPasswordPath = '/auth/reset-password';
  static const String profilePath = '/user/profile';
}
