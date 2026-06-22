import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';
import 'package:intent_app/presentation/auth/widgets/login/login_brand_header.dart';

class ForgotPasswordHeader extends StatelessWidget {
  const ForgotPasswordHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const IntentLogo(),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'Forgot password?',
          textAlign: TextAlign.center,
          style: IntentLoginStyles.signupTitle,
        ),
        const SizedBox(height: AppSpacing.sm),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            'Enter the email linked to your account and we’ll send you '
            'secure instructions to reset your password.',
            textAlign: TextAlign.center,
            style: IntentLoginStyles.signupSubtitle,
          ),
        ),
        const SizedBox(height: 12),
        const IntentStarDivider(),
      ],
    );
  }
}
