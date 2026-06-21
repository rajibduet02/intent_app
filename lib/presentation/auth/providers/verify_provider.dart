import 'dart:async';

import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intent_app/app/providers/auth_repository_provider.dart';
import 'package:intent_app/app/routes/app_router.dart';
import 'package:intent_app/app/routes/app_routes.dart';
import 'package:intent_app/core/constants/app_constants.dart';
import 'package:intent_app/core/utils/auth_snackbar.dart';
import 'package:intent_app/data/repositories/auth_repository.dart';
import 'package:intent_app/presentation/auth/providers/verify_route_args.dart';
import 'package:intent_app/presentation/auth/providers/verify_state.dart';

final verifyProvider = NotifierProvider<VerifyNotifier, VerifyState>(
  VerifyNotifier.new,
);

class VerifyNotifier extends Notifier<VerifyState> {
  Timer? _countdownTimer;
  bool _initialized = false;
  bool _isVerifying = false;

  @override
  VerifyState build() {
    ref.onDispose(() => _countdownTimer?.cancel());
    return VerifyState.initial();
  }

  AuthRepository get _authRepository => ref.read(authRepositoryProvider);

  void initialize(VerifyRouteArgs args) {
    final isNewSession = state.args?.email != args.email;
    state = state.copyWith(
      args: args,
      otp: isNewSession ? '' : state.otp,
    );
    if (_initialized) {
      return;
    }
    _initialized = true;
    _startCountdown();
  }

  void _startCountdown() {
    _countdownTimer?.cancel();
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.secondsRemaining <= 1) {
        timer.cancel();
        state = state.copyWith(secondsRemaining: 0, canResend: true);
        return;
      }
      state = state.copyWith(secondsRemaining: state.secondsRemaining - 1);
    });
  }

  void updateOtp(String value) {
    final otp = value.replaceAll(RegExp(r'\D'), '');
    state = state.copyWith(otp: otp);
  }

  void onOtpCompleted(String value) {
    final otp = value.replaceAll(RegExp(r'\D'), '');
    state = state.copyWith(otp: otp);
    if (otp.length == 6) {
      unawaited(_verifyCode(otp));
    }
  }

  bool _isDemoCode(String code) => code == AppConstants.demoVerificationCode;

  void _goToOnboarding() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      appRouter.go(AppRoutes.onboarding1);
    });
  }

  Future<void> _verifyCode(String code) async {
    if (_isVerifying) {
      return;
    }
    _isVerifying = true;
    try {
      if (_isDemoCode(code)) {
        _goToOnboarding();
        return;
      }
      final args = state.args;
      if (args == null) {
        return;
      }
      final result = await _authRepository.verifySignupOtpAndCreateUser(
        email: args.email,
        password: args.password,
        code: code,
      );
      if (result.success && result.data != null) {
        AuthSnackbar.success(
          title: 'Verified',
          message: 'Your account has been created.',
        );
        appRouter.go(AppRoutes.onboarding1);
      } else if (AuthRepository.isSignupOtpAlreadyUsedResponse(result)) {
        final recovery = await _authRepository.ensureSignedInAfterSignupOtp(
          email: args.email,
          password: args.password,
        );
        if (recovery.success) {
          appRouter.go(AppRoutes.onboarding1);
        } else {
          AuthSnackbar.error(recovery.message ?? 'Verification failed.');
        }
      } else {
        AuthSnackbar.error(result.message ?? 'Invalid verification code.');
      }
    } finally {
      _isVerifying = false;
    }
  }

  void onBack() {
    appRouter.go(AppRoutes.signup);
  }

  void onEditDestination() {
    appRouter.go(AppRoutes.signup);
  }

  Future<void> resendCode() async {
    final args = state.args;
    if (args == null || !state.canResend || state.isResending) {
      return;
    }
    state = state.copyWith(isResending: true);
    try {
      final result = await _authRepository.sendSignupOtp(email: args.email);
      if (result.success) {
        AuthSnackbar.success(
          title: 'Code sent',
          message: 'A new verification code has been sent.',
        );
        state = state.copyWith(
          secondsRemaining: VerifyState.codeExpirySeconds,
          canResend: false,
          otp: '',
        );
        _startCountdown();
      } else {
        AuthSnackbar.error(result.message ?? 'Could not resend code.');
      }
    } finally {
      state = state.copyWith(isResending: false);
    }
  }
}
