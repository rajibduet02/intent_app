import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';
import 'package:intent_app/presentation/auth/widgets/login/login_brand_header.dart';

class ResetPasswordHeader extends StatelessWidget {
  const ResetPasswordHeader({super.key, this.email});

  final String? email;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const IntentLogo(),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'Create new password',
          textAlign: TextAlign.center,
          style: IntentLoginStyles.signupTitle,
        ),
        const SizedBox(height: AppSpacing.sm),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            email != null && email!.isNotEmpty
                ? 'Choose a strong new password for $email.'
                : 'Choose a strong new password for your account.',
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
