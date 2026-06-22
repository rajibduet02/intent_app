import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';
import 'package:intent_app/core/constants/app_constants.dart';

class ResetPasswordRequirements extends StatelessWidget {
  const ResetPasswordRequirements({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.info_outline,
          size: 16,
          color: AppColors.intentGold.withValues(alpha: 0.95),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            'Use at least ${AppConstants.minPasswordLengthReset} characters '
            'with a mix of letters and numbers for a stronger password.',
            style: IntentLoginStyles.signupSubtitle.copyWith(
              fontSize: 13,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}
