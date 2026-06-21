class SignupState {
  const SignupState({
    required this.isLoading,
    required this.obscurePassword,
    required this.termsAccepted,
  });

  final bool isLoading;
  final bool obscurePassword;
  final bool termsAccepted;

  factory SignupState.initial() => const SignupState(
        isLoading: false,
        obscurePassword: true,
        termsAccepted: false,
      );

  SignupState copyWith({
    bool? isLoading,
    bool? obscurePassword,
    bool? termsAccepted,
  }) {
    return SignupState(
      isLoading: isLoading ?? this.isLoading,
      obscurePassword: obscurePassword ?? this.obscurePassword,
      termsAccepted: termsAccepted ?? this.termsAccepted,
    );
  }
}
