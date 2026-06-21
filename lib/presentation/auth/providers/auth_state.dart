class AuthState {
  const AuthState({
    required this.isLoading,
    required this.isGoogleLoading,
    required this.isAppleLoading,
    required this.obscurePassword,
  });

  final bool isLoading;
  final bool isGoogleLoading;
  final bool isAppleLoading;
  final bool obscurePassword;

  factory AuthState.initial() => const AuthState(
    isLoading: false,
    isGoogleLoading: false,
    isAppleLoading: false,
    obscurePassword: true,
  );

  AuthState copyWith({
    bool? isLoading,
    bool? isGoogleLoading,
    bool? isAppleLoading,
    bool? obscurePassword,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      isGoogleLoading: isGoogleLoading ?? this.isGoogleLoading,
      isAppleLoading: isAppleLoading ?? this.isAppleLoading,
      obscurePassword: obscurePassword ?? this.obscurePassword,
    );
  }
}
