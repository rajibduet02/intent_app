import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intent_app/app/providers/auth_repository_provider.dart';
import 'package:intent_app/app/routes/app_router.dart';
import 'package:intent_app/app/routes/app_routes.dart';
import 'package:intent_app/core/utils/auth_snackbar.dart';
import 'package:intent_app/data/repositories/auth_repository.dart';
import 'package:intent_app/presentation/auth/providers/auth_state.dart';

final authProvider = NotifierProvider<AuthNotifier, AuthState>(
  AuthNotifier.new,
);

class AuthNotifier extends Notifier<AuthState> {
  Timer? _passwordPeekTimer;

  static const Duration _obscurePeekDuration = Duration(milliseconds: 300);

  @override
  AuthState build() {
    ref.onDispose(() {
      _passwordPeekTimer?.cancel();
    });
    return AuthState.initial();
  }

  AuthRepository get _authRepository => ref.read(authRepositoryProvider);

  void toggleObscurePassword() {
    state = state.copyWith(obscurePassword: !state.obscurePassword);
  }

  void peekPassword() {
    if (!state.obscurePassword) {
      return;
    }
    _passwordPeekTimer?.cancel();
    state = state.copyWith(obscurePassword: false);
    _passwordPeekTimer = Timer(_obscurePeekDuration, () {
      state = state.copyWith(obscurePassword: true);
    });
  }

  void goToSignup() {
    appRouter.go(AppRoutes.signup);
  }

  void goToForgotPassword() {
    appRouter.push(AppRoutes.forgotPassword);
  }

  Future<void> submit({
    required GlobalKey<FormState> formKey,
    required TextEditingController emailController,
    required TextEditingController passwordController,
  }) async {
    if (!(formKey.currentState?.validate() ?? false)) {
      return;
    }
    state = state.copyWith(isLoading: true);
    try {
      final result = await _authRepository.login(
        emailController.text.trim(),
        passwordController.text,
      );
      if (result.success && result.data != null) {
        AuthSnackbar.success(title: 'Success', message: 'Login Successfully');
      } else {
        AuthSnackbar.error(result.message ?? 'Something went wrong');
      }
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> signInWithGoogle() async {
    if (state.isGoogleLoading || state.isAppleLoading || state.isLoading) {
      return;
    }
    state = state.copyWith(isGoogleLoading: true);
    try {
      final result = await _authRepository.signInWithGoogle();
      if (result.success && result.data != null) {
        AuthSnackbar.success(
          title: 'Success',
          message: 'Signed in with Google',
        );
      } else if (result.authStatus == AuthRepository.authStatusCancelled) {
        return;
      } else {
        AuthSnackbar.error(result.message ?? 'Google sign-in failed');
      }
    } finally {
      state = state.copyWith(isGoogleLoading: false);
    }
  }

  Future<void> signInWithApple() async {
    if (state.isAppleLoading || state.isGoogleLoading || state.isLoading) {
      return;
    }
    state = state.copyWith(isAppleLoading: true);
    try {
      final result = await _authRepository.signInWithApple();
      if (result.success && result.data != null) {
        AuthSnackbar.success(title: 'Success', message: 'Signed in with Apple');
      } else if (result.authStatus == AuthRepository.authStatusCancelled) {
        return;
      } else {
        AuthSnackbar.error(result.message ?? 'Apple sign-in failed');
      }
    } finally {
      state = state.copyWith(isAppleLoading: false);
    }
  }
}
