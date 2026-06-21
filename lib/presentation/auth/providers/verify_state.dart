import 'package:intent_app/presentation/auth/providers/verify_route_args.dart';

class VerifyState {
  static const int codeExpirySeconds = 90;

  const VerifyState({
    this.args,
    required this.otp,
    required this.secondsRemaining,
    required this.isLoading,
    required this.isResending,
    required this.canResend,
  });

  final VerifyRouteArgs? args;
  final String otp;
  final int secondsRemaining;
  final bool isLoading;
  final bool isResending;
  final bool canResend;

  factory VerifyState.initial() => const VerifyState(
        otp: '',
        secondsRemaining: codeExpirySeconds,
        isLoading: false,
        isResending: false,
        canResend: false,
      );

  VerifyState copyWith({
    VerifyRouteArgs? args,
    String? otp,
    int? secondsRemaining,
    bool? isLoading,
    bool? isResending,
    bool? canResend,
  }) {
    return VerifyState(
      args: args ?? this.args,
      otp: otp ?? this.otp,
      secondsRemaining: secondsRemaining ?? this.secondsRemaining,
      isLoading: isLoading ?? this.isLoading,
      isResending: isResending ?? this.isResending,
      canResend: canResend ?? this.canResend,
    );
  }

  String get formattedTimer {
    final minutes = (secondsRemaining ~/ 60).toString().padLeft(2, '0');
    final seconds = (secondsRemaining % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}
