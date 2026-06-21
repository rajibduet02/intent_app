import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';
import 'package:intent_app/presentation/auth/widgets/login/login_brand_header.dart';

class SignupFooter extends StatelessWidget {
  const SignupFooter({super.key, required this.onSignInTap});

  final VoidCallback onSignInTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(
              'Already have an account? ',
              style: IntentLoginStyles.footerPrompt,
            ),
            GestureDetector(
              onTap: onSignInTap,
              behavior: HitTestBehavior.opaque,
              child: Text('Sign In', style: IntentLoginStyles.footerLink),
            ),
          ],
        ),
        const SizedBox(height: 20),
        const IntentFourPointStar(size: 8),
      ],
    );
  }
}
