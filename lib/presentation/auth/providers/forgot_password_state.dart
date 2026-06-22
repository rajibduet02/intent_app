class ForgotPasswordState {
  const ForgotPasswordState({
    required this.isLoading,
    required this.emailSent,
  });

  final bool isLoading;
  final bool emailSent;

  factory ForgotPasswordState.initial() => const ForgotPasswordState(
        isLoading: false,
        emailSent: false,
      );

  ForgotPasswordState copyWith({
    bool? isLoading,
    bool? emailSent,
  }) {
    return ForgotPasswordState(
      isLoading: isLoading ?? this.isLoading,
      emailSent: emailSent ?? this.emailSent,
    );
  }
}
