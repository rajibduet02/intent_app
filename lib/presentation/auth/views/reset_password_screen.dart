import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intent_app/app/theme/theme.dart';
import 'package:intent_app/core/utils/validators.dart';
import 'package:intent_app/presentation/auth/providers/reset_password_provider.dart';
import 'package:intent_app/presentation/auth/providers/reset_password_route_args.dart';
import 'package:intent_app/presentation/auth/widgets/login/login_brand_header.dart';
import 'package:intent_app/presentation/auth/widgets/login/login_continue_button.dart';
import 'package:intent_app/presentation/auth/widgets/reset_password/reset_password_header.dart';
import 'package:intent_app/presentation/auth/widgets/reset_password/reset_password_requirements.dart';
import 'package:intent_app/presentation/auth/widgets/shared/auth_form_input.dart';
import 'package:intent_app/presentation/auth/widgets/shared/fixed_background_auth_scaffold.dart';
import 'package:intent_app/presentation/auth/widgets/signup/signup_labeled_field.dart';

class ResetPasswordScreen extends ConsumerStatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  ConsumerState<ResetPasswordScreen> createState() =>
      _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends ConsumerState<ResetPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();

  @override
  void dispose() {
    _passwordFocus.dispose();
    _confirmPasswordFocus.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ResetPasswordRouteArgs.parse(GoRouterState.of(context).extra);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }
      ref.read(resetPasswordProvider.notifier).initialize(args);
    });
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(resetPasswordProvider.notifier);
    final state = ref.watch(resetPasswordProvider);
    final args = state.args;

    return FixedBackgroundAuthScaffold(
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IntentBackButton(onPressed: notifier.onBack),
              ),
              const SizedBox(height: 4),
              ResetPasswordHeader(email: args?.email),
              const SizedBox(height: 24),
              _ResetPasswordField(
                passwordController: _passwordController,
                passwordFocus: _passwordFocus,
                obscurePassword: state.obscurePassword,
                onToggleObscure: notifier.toggleObscurePassword,
              ),
              const SizedBox(height: 16),
              _ResetConfirmPasswordField(
                confirmPasswordController: _confirmPasswordController,
                confirmPasswordFocus: _confirmPasswordFocus,
                passwordController: _passwordController,
                obscureConfirmPassword: state.obscureConfirmPassword,
                onToggleObscure: notifier.toggleObscureConfirmPassword,
              ),
              const SizedBox(height: 16),
              const ResetPasswordRequirements(),
              const SizedBox(height: 24),
              LoginContinueButton(
                label: 'RESET PASSWORD',
                isLoading: state.isLoading,
                onPressed: () => unawaited(
                  notifier.submit(
                    formKey: _formKey,
                    passwordController: _passwordController,
                    confirmPasswordController: _confirmPasswordController,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(
                    "Didn't receive the reset link? ",
                    style: IntentLoginStyles.footerPrompt,
                  ),
                  GestureDetector(
                    onTap: notifier.goToForgotPassword,
                    behavior: HitTestBehavior.opaque,
                    child: Text(
                      'Resend link',
                      style: IntentLoginStyles.footerLink,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Center(child: IntentFourPointStar(size: 8)),
            ],
          ),
        ),
      ),
    );
  }
}

class _ResetPasswordField extends StatelessWidget {
  const _ResetPasswordField({
    required this.passwordController,
    required this.passwordFocus,
    required this.obscurePassword,
    required this.onToggleObscure,
  });

  final TextEditingController passwordController;
  final FocusNode passwordFocus;
  final bool obscurePassword;
  final VoidCallback onToggleObscure;

  @override
  Widget build(BuildContext context) {
    return SignupLabeledField(
      label: 'New password',
      hintText: '••••••••••••',
      prefixIcon: Icons.lock_outline,
      controller: passwordController,
      focusNode: passwordFocus,
      obscureText: obscurePassword,
      validator: (value) =>
          Validators.requiredField(value, fieldName: 'New password'),
      autofillHints: const [AutofillHints.newPassword],
      suffixIcon: AuthFormInputSuffixAction(
        icon: obscurePassword
            ? Icons.visibility_outlined
            : Icons.visibility_off_outlined,
        onPressed: onToggleObscure,
      ),
    );
  }
}

class _ResetConfirmPasswordField extends StatelessWidget {
  const _ResetConfirmPasswordField({
    required this.confirmPasswordController,
    required this.confirmPasswordFocus,
    required this.passwordController,
    required this.obscureConfirmPassword,
    required this.onToggleObscure,
  });

  final TextEditingController confirmPasswordController;
  final FocusNode confirmPasswordFocus;
  final TextEditingController passwordController;
  final bool obscureConfirmPassword;
  final VoidCallback onToggleObscure;

  @override
  Widget build(BuildContext context) {
    return SignupLabeledField(
      label: 'Confirm new password',
      hintText: '••••••••••••',
      prefixIcon: Icons.lock_outline,
      controller: confirmPasswordController,
      focusNode: confirmPasswordFocus,
      obscureText: obscureConfirmPassword,
      validator: (value) {
        final requiredError = Validators.requiredField(
          value,
          fieldName: 'Confirm new password',
        );
        if (requiredError != null) {
          return requiredError;
        }
        if (value != passwordController.text) {
          return 'Passwords do not match';
        }
        return null;
      },
      autofillHints: const [AutofillHints.newPassword],
      suffixIcon: AuthFormInputSuffixAction(
        icon: obscureConfirmPassword
            ? Icons.visibility_outlined
            : Icons.visibility_off_outlined,
        onPressed: onToggleObscure,
      ),
    );
  }
}
