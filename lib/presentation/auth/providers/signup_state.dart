class SignupState {
  const SignupState({
    required this.isLoading,
    required this.obscurePassword,
    required this.obscureConfirmPassword,
    required this.termsAccepted,
  });

  final bool isLoading;
  final bool obscurePassword;
  final bool obscureConfirmPassword;
  final bool termsAccepted;

  factory SignupState.initial() => const SignupState(
        isLoading: false,
        obscurePassword: true,
        obscureConfirmPassword: true,
        termsAccepted: false,
      );

  SignupState copyWith({
    bool? isLoading,
    bool? obscurePassword,
    bool? obscureConfirmPassword,
    bool? termsAccepted,
  }) {
    return SignupState(
      isLoading: isLoading ?? this.isLoading,
      obscurePassword: obscurePassword ?? this.obscurePassword,
      obscureConfirmPassword:
          obscureConfirmPassword ?? this.obscureConfirmPassword,
      termsAccepted: termsAccepted ?? this.termsAccepted,
    );
  }
}
