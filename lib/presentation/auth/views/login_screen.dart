import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intent_app/app/theme/theme.dart';
import 'package:intent_app/core/utils/validators.dart';
import 'package:intent_app/presentation/auth/providers/auth_provider.dart';
import 'package:intent_app/presentation/auth/widgets/login/login_brand_header.dart';
import 'package:intent_app/presentation/auth/widgets/login/login_continue_button.dart';
import 'package:intent_app/presentation/auth/widgets/login/login_safety_footer.dart';
import 'package:intent_app/presentation/auth/widgets/login/login_social_button.dart';
import 'package:intent_app/presentation/auth/widgets/shared/fixed_background_auth_scaffold.dart';
import 'package:intent_app/presentation/auth/widgets/shared/auth_form_input.dart';
import 'package:intent_app/presentation/auth/widgets/signup/signup_labeled_field.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  bool _rememberMe = true;

  @override
  void dispose() {
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authNotifier = ref.read(authProvider.notifier);

    return FixedBackgroundAuthScaffold(
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Center(child: LoginBrandHeader()),
              const SizedBox(height: 24),
              SignupLabeledField(
                label: 'Email address',
                hintText: 'name@example.com',
                prefixIcon: Icons.mail_outline,
                controller: _emailController,
                focusNode: _emailFocus,
                keyboardType: TextInputType.emailAddress,
                autofillHints: const [AutofillHints.email],
                validator: Validators.email,
              ),
              const SizedBox(height: 16),
              _LoginPasswordField(
                passwordController: _passwordController,
                passwordFocus: _passwordFocus,
                authNotifier: authNotifier,
              ),
              const SizedBox(height: AppSpacing.sm),
              _RememberMeRow(
                rememberMe: _rememberMe,
                onRememberChanged: (v) => setState(() => _rememberMe = v),
                authNotifier: authNotifier,
              ),
              const SizedBox(height: 24),
              _LoginContinueButton(
                formKey: _formKey,
                emailController: _emailController,
                passwordController: _passwordController,
                authNotifier: authNotifier,
              ),
              const SizedBox(height: 24),
              const LoginOrContinueDivider(),
              const SizedBox(height: 16),
              _LoginSocialSection(authNotifier: authNotifier),
              const SizedBox(height: 24),
              const LoginSafetyFooter(),
              const SizedBox(height: 16),
              Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: IntentLoginStyles.footerPrompt,
                  ),
                  GestureDetector(
                    onTap: authNotifier.goToSignup,
                    behavior: HitTestBehavior.opaque,
                    child: Text(
                      'Sign Up',
                      style: IntentLoginStyles.footerLink,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RememberMeRow extends StatelessWidget {
  const _RememberMeRow({
    required this.rememberMe,
    required this.onRememberChanged,
    required this.authNotifier,
  });

  final bool rememberMe;
  final ValueChanged<bool> onRememberChanged;
  final AuthNotifier authNotifier;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: Checkbox(
            value: rememberMe,
            onChanged: (v) => onRememberChanged(v ?? false),
            activeColor: AppColors.intentForest,
            checkColor: AppColors.white,
            side: const BorderSide(color: AppColors.intentForest, width: 1.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: VisualDensity.compact,
          ),
        ),
        const SizedBox(width: AppSpacing.xs),
        GestureDetector(
          onTap: () => onRememberChanged(!rememberMe),
          behavior: HitTestBehavior.opaque,
          child: Text('Remember me', style: IntentLoginStyles.rememberMe),
        ),
        const Spacer(),
        GestureDetector(
          onTap: authNotifier.goToForgotPassword,
          behavior: HitTestBehavior.opaque,
          child: Text('Forgot password?', style: IntentLoginStyles.forgotPassword),
        ),
      ],
    );
  }
}

class _LoginPasswordField extends ConsumerWidget {
  const _LoginPasswordField({
    required this.passwordController,
    required this.passwordFocus,
    required this.authNotifier,
  });

  final TextEditingController passwordController;
  final FocusNode passwordFocus;
  final AuthNotifier authNotifier;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final obscurePassword = ref.watch(
      authProvider.select((s) => s.obscurePassword),
    );

    return SignupLabeledField(
      label: 'Password',
      hintText: '••••••••••••',
      prefixIcon: Icons.lock_outline,
      controller: passwordController,
      focusNode: passwordFocus,
      obscureText: obscurePassword,
      validator: Validators.password,
      autofillHints: const [AutofillHints.password],
      suffixIcon: AuthFormInputSuffixAction(
        icon: obscurePassword
            ? Icons.visibility_outlined
            : Icons.visibility_off_outlined,
        onPressed: authNotifier.toggleObscurePassword,
      ),
    );
  }
}

class _LoginContinueButton extends ConsumerWidget {
  const _LoginContinueButton({
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.authNotifier,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final AuthNotifier authNotifier;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(authProvider.select((s) => s.isLoading));
    return LoginContinueButton(
      isLoading: isLoading,
      onPressed: () => unawaited(
        authNotifier.submit(
          formKey: formKey,
          emailController: emailController,
          passwordController: passwordController,
        ),
      ),
    );
  }
}

class _LoginSocialSection extends ConsumerWidget {
  const _LoginSocialSection({required this.authNotifier});

  final AuthNotifier authNotifier;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gLoading = ref.watch(authProvider.select((s) => s.isGoogleLoading));
    final aLoading = ref.watch(authProvider.select((s) => s.isAppleLoading));
    final emailLoading = ref.watch(authProvider.select((s) => s.isLoading));
    final busy = gLoading || aLoading || emailLoading;

    return Column(
      children: [
        LoginSocialButton(
          label: 'Continue with Apple',
          iconAsset: 'assets/icons/new_apple.svg',
          isLoading: aLoading,
          onPressed:
              busy ? null : () => unawaited(authNotifier.signInWithApple()),
        ),
        const SizedBox(height: 16),
        LoginSocialButton(
          label: 'Continue with Google',
          iconAsset: 'assets/icons/new_google.svg',
          isLoading: gLoading,
          onPressed:
              busy ? null : () => unawaited(authNotifier.signInWithGoogle()),
        ),
      ],
    );
  }
}
