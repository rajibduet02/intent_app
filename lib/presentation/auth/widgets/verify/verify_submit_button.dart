import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';

/// Decorative verify affordance. Verification is triggered automatically when
/// the OTP is complete; this control is not interactive.
class VerifySubmitButton extends StatelessWidget {
  const VerifySubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.intentForest.withValues(alpha: 0.04),
            ),
          ),
          Container(
            width: 96,
            height: 96,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.intentForest.withValues(alpha: 0.06),
            ),
          ),
          Container(
            width: 76,
            height: 76,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.intentForest.withValues(alpha: 0.08),
            ),
          ),
          Container(
            width: 64,
            height: 64,
            decoration: const BoxDecoration(
              color: AppColors.intentForest,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: const Icon(
              Icons.check,
              color: AppColors.intentGold,
              size: 28,
            ),
          ),
        ],
      ),
    );
  }
}

class VerifyFooterMessage extends StatelessWidget {
  const VerifyFooterMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Almost there!', style: IntentLoginStyles.verifyAlmostThere),
        const SizedBox(height: 6),
        Text(
          'One step closer to meaningful connections.',
          textAlign: TextAlign.center,
          style: IntentLoginStyles.verifyBody,
        ),
      ],
    );
  }
}
