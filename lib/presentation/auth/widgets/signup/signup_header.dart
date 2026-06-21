import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';
import 'package:intent_app/presentation/auth/widgets/login/login_brand_header.dart';

class SignupHeader extends StatelessWidget {
  const SignupHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const IntentLogo(),
        // const SizedBox(height: 16),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'Create your account',
          textAlign: TextAlign.center,
          style: IntentLoginStyles.signupTitle,
        ),
        const SizedBox(height: AppSpacing.sm),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            'Join Intent and start your journey towards meaningful connections.',
            textAlign: TextAlign.center,
            style: IntentLoginStyles.signupSubtitle,
          ),
        ),
      ],
    );
  }
}
