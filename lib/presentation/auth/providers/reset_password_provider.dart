import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intent_app/app/routes/app_router.dart';
import 'package:intent_app/app/routes/app_routes.dart';
import 'package:intent_app/core/utils/auth_snackbar.dart';
import 'package:intent_app/presentation/auth/providers/reset_password_route_args.dart';
import 'package:intent_app/presentation/auth/providers/reset_password_state.dart';

final resetPasswordProvider =
    NotifierProvider<ResetPasswordNotifier, ResetPasswordState>(
  ResetPasswordNotifier.new,
);

class ResetPasswordNotifier extends Notifier<ResetPasswordState> {
  @override
  ResetPasswordState build() => ResetPasswordState.initial();

  void initialize(ResetPasswordRouteArgs? args) {
    state = state.copyWith(args: args);
  }

  void toggleObscurePassword() {
    state = state.copyWith(obscurePassword: !state.obscurePassword);
  }

  void toggleObscureConfirmPassword() {
    state = state.copyWith(
      obscureConfirmPassword: !state.obscureConfirmPassword,
    );
  }

  void onBack() {
    appRouter.go(AppRoutes.auth);
  }

  void goToForgotPassword() {
    appRouter.push(AppRoutes.forgotPassword);
  }

  Future<void> submit({
    required GlobalKey<FormState> formKey,
    required TextEditingController passwordController,
    required TextEditingController confirmPasswordController,
  }) async {
    if (!(formKey.currentState?.validate() ?? false)) {
      return;
    }

    state = state.copyWith(isLoading: true);
    try {
      // UI-only flow: backend password rules and reset API will be wired
      // during integration.
      await Future<void>.delayed(const Duration(milliseconds: 300));
      AuthSnackbar.success(
        title: 'Reset password successfully',
        message: 'Your password has been updated. You can now sign in.',
      );
      appRouter.go(AppRoutes.auth);
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}
