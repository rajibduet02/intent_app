import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intent_app/app/providers/auth_repository_provider.dart';
import 'package:intent_app/app/routes/app_router.dart';
import 'package:intent_app/app/routes/app_routes.dart';
import 'package:intent_app/core/utils/auth_snackbar.dart';
import 'package:intent_app/data/repositories/auth_repository.dart';
import 'package:intent_app/presentation/auth/providers/signup_state.dart';
import 'package:intent_app/presentation/auth/providers/verify_route_args.dart';

final signupProvider = NotifierProvider<SignupNotifier, SignupState>(
  SignupNotifier.new,
);

class SignupNotifier extends Notifier<SignupState> {
  @override
  SignupState build() => SignupState.initial();

  AuthRepository get _authRepository => ref.read(authRepositoryProvider);

  void toggleObscurePassword() {
    state = state.copyWith(obscurePassword: !state.obscurePassword);
  }

  void setTermsAccepted(bool value) {
    state = state.copyWith(termsAccepted: value);
  }

  void goToLogin() {
    appRouter.go(AppRoutes.auth);
  }

  void onBack() {
    goToLogin();
  }

  Future<void> submit({
    required GlobalKey<FormState> formKey,
    required TextEditingController emailController,
    required TextEditingController phoneController,
    required TextEditingController passwordController,
  }) async {
    if (!state.termsAccepted) {
      AuthSnackbar.error(
        'Please accept the Terms of Service and Privacy Policy.',
      );
      return;
    }
    if (!(formKey.currentState?.validate() ?? false)) {
      return;
    }
    state = state.copyWith(isLoading: true);
    try {
      final email = emailController.text.trim();
      final phone = phoneController.text.trim();
      final password = passwordController.text;

      appRouter.push(
        AppRoutes.verify,
        extra: VerifyRouteArgs(
          email: email,
          password: password,
          phone: phone.isEmpty ? null : phone,
        ),
      );

      if (Firebase.apps.isNotEmpty) {
        unawaited(_sendSignupOtp(email));
      }
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> _sendSignupOtp(String email) async {
    try {
      final result = await _authRepository.sendSignupOtp(email: email);
      if (!result.success && result.message != null) {
        AuthSnackbar.error(result.message!);
      }
    } catch (_) {
      // OTP is unavailable until Firebase is configured for this project.
    }
  }
}
