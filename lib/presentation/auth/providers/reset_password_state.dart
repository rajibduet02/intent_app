import 'package:intent_app/presentation/auth/providers/reset_password_route_args.dart';

class ResetPasswordState {
  const ResetPasswordState({
    required this.isLoading,
    required this.obscurePassword,
    required this.obscureConfirmPassword,
    this.args,
  });

  final bool isLoading;
  final bool obscurePassword;
  final bool obscureConfirmPassword;
  final ResetPasswordRouteArgs? args;

  factory ResetPasswordState.initial() => const ResetPasswordState(
        isLoading: false,
        obscurePassword: true,
        obscureConfirmPassword: true,
      );

  ResetPasswordState copyWith({
    bool? isLoading,
    bool? obscurePassword,
    bool? obscureConfirmPassword,
    ResetPasswordRouteArgs? args,
  }) {
    return ResetPasswordState(
      isLoading: isLoading ?? this.isLoading,
      obscurePassword: obscurePassword ?? this.obscurePassword,
      obscureConfirmPassword:
          obscureConfirmPassword ?? this.obscureConfirmPassword,
      args: args ?? this.args,
    );
  }
}
