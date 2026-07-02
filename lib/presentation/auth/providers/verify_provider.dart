import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intent_app/app/providers/auth_repository_provider.dart';
import 'package:intent_app/app/routes/auth_refresh_listenable.dart';
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
      unawaited(submitOtp());
    }
  }

  Future<void> submitOtp() async {
    final otp = state.otp.replaceAll(RegExp(r'\D'), '');
    if (otp.length != 6) {
      AuthSnackbar.info('Enter the full 6-digit code to continue.');
      return;
    }
    await _verifyCode(otp);
  }

  bool _isDemoCode(String code) => code == AppConstants.demoVerificationCode;

  void _markVerificationSucceeded() {
    state = state.copyWith(verificationSucceeded: true, isLoading: false);
  }

  Future<void> _verifyCode(String code) async {
    if (_isVerifying) {
      return;
    }
    _isVerifying = true;
    state = state.copyWith(isLoading: true);
    try {
      if (_isDemoCode(code)) {
        final args = state.args;
        if (args == null) {
          AuthSnackbar.error('Missing signup details. Please start again.');
          return;
        }
        await _authRepository.registerLocalAccount(
          email: args.email,
          password: args.password,
        );
        await authRefreshListenable.notifyLocalSessionChanged();
        AuthSnackbar.success(
          title: 'Verified',
          message: 'Your account has been created.',
        );
        _markVerificationSucceeded();
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
        await _authRepository.persistSignupCredentials(
          email: args.email,
          password: args.password,
        );
        AuthSnackbar.success(
          title: 'Verified',
          message: 'Your account has been created.',
        );
        _markVerificationSucceeded();
      } else if (AuthRepository.isSignupOtpAlreadyUsedResponse(result)) {
        final recovery = await _authRepository.ensureSignedInAfterSignupOtp(
          email: args.email,
          password: args.password,
        );
        if (recovery.success) {
          await _authRepository.persistSignupCredentials(
            email: args.email,
            password: args.password,
          );
          _markVerificationSucceeded();
        } else {
          AuthSnackbar.error(recovery.message ?? 'Verification failed.');
        }
      } else {
        AuthSnackbar.error(result.message ?? 'Invalid verification code.');
      }
    } finally {
      _isVerifying = false;
      if (!state.verificationSucceeded) {
        state = state.copyWith(isLoading: false);
      }
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
