import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intent_app/app/theme/theme.dart';
import 'package:intent_app/core/utils/validators.dart';
import 'package:intent_app/presentation/auth/providers/signup_provider.dart';
import 'package:intent_app/presentation/auth/widgets/login/login_continue_button.dart';
import 'package:intent_app/presentation/auth/widgets/shared/fixed_background_auth_scaffold.dart';
import 'package:intent_app/presentation/auth/widgets/shared/auth_form_input.dart';
import 'package:intent_app/presentation/auth/widgets/signup/signup_footer.dart';
import 'package:intent_app/presentation/auth/widgets/signup/signup_header.dart';
import 'package:intent_app/presentation/auth/widgets/signup/signup_labeled_field.dart';
import 'package:intent_app/presentation/auth/widgets/signup/signup_safety_card.dart';
import 'package:intent_app/presentation/auth/widgets/signup/signup_terms_row.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  @override
  void dispose() {
    _emailFocus.dispose();
    _phoneFocus.dispose();
    _passwordFocus.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final signupNotifier = ref.read(signupProvider.notifier);
    final termsAccepted = ref.watch(
      signupProvider.select((s) => s.termsAccepted),
    );

    return FixedBackgroundAuthScaffold(
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IntentBackButton(onPressed: signupNotifier.onBack),
              ),
              const SizedBox(height: 4),
              const SignupHeader(),
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
              SignupLabeledField(
                label: 'Phone number (optional)',
                hintText: '+1 (555) 123-4567',
                prefixIcon: Icons.phone_outlined,
                controller: _phoneController,
                focusNode: _phoneFocus,
                keyboardType: TextInputType.phone,
                autofillHints: const [AutofillHints.telephoneNumber],
                validator: Validators.optionalPhone,
              ),
              const SizedBox(height: 16),
              _SignupPasswordField(
                passwordController: _passwordController,
                passwordFocus: _passwordFocus,
                signupNotifier: signupNotifier,
              ),
              const SizedBox(height: AppSpacing.sm),
              SignupTermsRow(
                accepted: termsAccepted,
                onChanged: signupNotifier.setTermsAccepted,
              ),
              const SizedBox(height: 24),
                          _SignupCreateButton(
                            formKey: _formKey,
                            emailController: _emailController,
                            phoneController: _phoneController,
                            passwordController: _passwordController,
                            signupNotifier: signupNotifier,
                          ),
              const SizedBox(height: 24),
              const SignupSafetyCard(),
              const SizedBox(height: 24),
              SignupFooter(onSignInTap: signupNotifier.goToLogin),
            ],
          ),
        ),
      ),
    );
  }
}

class _SignupPasswordField extends ConsumerWidget {
  const _SignupPasswordField({
    required this.passwordController,
    required this.passwordFocus,
    required this.signupNotifier,
  });

  final TextEditingController passwordController;
  final FocusNode passwordFocus;
  final SignupNotifier signupNotifier;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final obscurePassword = ref.watch(
      signupProvider.select((s) => s.obscurePassword),
    );

    return SignupLabeledField(
      label: 'Password',
      hintText: '••••••••••••',
      prefixIcon: Icons.lock_outline,
      controller: passwordController,
      focusNode: passwordFocus,
      obscureText: obscurePassword,
      validator: Validators.password,
      autofillHints: const [AutofillHints.newPassword],
      suffixIcon: AuthFormInputSuffixAction(
        icon: obscurePassword
            ? Icons.visibility_outlined
            : Icons.visibility_off_outlined,
        onPressed: signupNotifier.toggleObscurePassword,
      ),
    );
  }
}

class _SignupCreateButton extends ConsumerWidget {
  const _SignupCreateButton({
    required this.formKey,
    required this.emailController,
    required this.phoneController,
    required this.passwordController,
    required this.signupNotifier,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController passwordController;
  final SignupNotifier signupNotifier;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(signupProvider.select((s) => s.isLoading));
    return LoginContinueButton(
      isLoading: isLoading,
      label: 'Create Account',
      onPressed: () => unawaited(
        signupNotifier.submit(
          formKey: formKey,
          emailController: emailController,
          phoneController: phoneController,
          passwordController: passwordController,
        ),
      ),
    );
  }
}
