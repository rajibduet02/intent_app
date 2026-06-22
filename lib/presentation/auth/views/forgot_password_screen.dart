import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intent_app/app/theme/theme.dart';
import 'package:intent_app/core/utils/validators.dart';
import 'package:intent_app/presentation/auth/providers/forgot_password_provider.dart';
import 'package:intent_app/presentation/auth/widgets/forgot_password/forgot_password_header.dart';
import 'package:intent_app/presentation/auth/widgets/forgot_password/forgot_password_info_card.dart';
import 'package:intent_app/presentation/auth/widgets/login/login_brand_header.dart';
import 'package:intent_app/presentation/auth/widgets/login/login_continue_button.dart';
import 'package:intent_app/presentation/auth/widgets/shared/fixed_background_auth_scaffold.dart';
import 'package:intent_app/presentation/auth/widgets/signup/signup_labeled_field.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final FocusNode _emailFocus = FocusNode();

  @override
  void dispose() {
    _emailFocus.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(forgotPasswordProvider.notifier);
    final isLoading = ref.watch(
      forgotPasswordProvider.select((s) => s.isLoading),
    );

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
              const ForgotPasswordHeader(),
              const SizedBox(height: 24),
              SignupLabeledField(
                label: 'Email address',
                hintText: 'name@example.com',
                prefixIcon: Icons.mail_outline,
                controller: _emailController,
                focusNode: _emailFocus,
                keyboardType: TextInputType.emailAddress,
                autofillHints: const [AutofillHints.email],
                validator: (value) =>
                    Validators.requiredField(value, fieldName: 'Email'),
              ),
              const SizedBox(height: 20),
              const ForgotPasswordInfoCard(),
              const SizedBox(height: 24),
              LoginContinueButton(
                label: 'SEND RESET LINK',
                isLoading: isLoading,
                onPressed: () => unawaited(
                  notifier.submit(
                    formKey: _formKey,
                    emailController: _emailController,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(
                    'Remember your password? ',
                    style: IntentLoginStyles.footerPrompt,
                  ),
                  GestureDetector(
                    onTap: notifier.onBack,
                    behavior: HitTestBehavior.opaque,
                    child: Text(
                      'Sign In',
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
