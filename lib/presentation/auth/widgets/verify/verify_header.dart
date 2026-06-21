import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';
import 'package:intent_app/presentation/auth/widgets/login/login_brand_header.dart';

class VerifyHeader extends StatelessWidget {
  const VerifyHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const IntentLogo(),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'Enter verification code',
          textAlign: TextAlign.center,
          style: IntentLoginStyles.verifyTitle,
        ),
        const SizedBox(height: 12),
        const IntentStarDivider(),
      ],
    );
  }
}
