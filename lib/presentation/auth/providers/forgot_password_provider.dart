import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intent_app/app/routes/app_router.dart';
import 'package:intent_app/app/routes/app_routes.dart';
import 'package:intent_app/presentation/auth/providers/forgot_password_state.dart';
import 'package:intent_app/presentation/auth/providers/reset_password_route_args.dart';

final forgotPasswordProvider =
    NotifierProvider<ForgotPasswordNotifier, ForgotPasswordState>(
  ForgotPasswordNotifier.new,
);

class ForgotPasswordNotifier extends Notifier<ForgotPasswordState> {
  @override
  ForgotPasswordState build() => ForgotPasswordState.initial();

  void onBack() {
    appRouter.go(AppRoutes.auth);
  }

  Future<void> submit({
    required GlobalKey<FormState> formKey,
    required TextEditingController emailController,
  }) async {
    if (!(formKey.currentState?.validate() ?? false)) {
      return;
    }

    final email = emailController.text.trim();
    state = state.copyWith(isLoading: true);
    try {
      // UI-only flow: backend email validation and reset link delivery
      // will be wired during integration.
      await Future<void>.delayed(const Duration(milliseconds: 300));
      state = state.copyWith(emailSent: true);
      appRouter.push(
        AppRoutes.resetPassword,
        extra: ResetPasswordRouteArgs(email: email),
      );
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}
