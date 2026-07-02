import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';

/// Verify affordance. Verification runs automatically when the OTP is
/// complete; this control also submits when tapped.
class VerifySubmitButton extends StatelessWidget {
  const VerifySubmitButton({
    super.key,
    this.onPressed,
    this.enabled = false,
    this.isLoading = false,
  });

  final VoidCallback? onPressed;
  final bool enabled;
  final bool isLoading;

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
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: enabled && !isLoading ? onPressed : null,
              customBorder: const CircleBorder(),
              child: Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: enabled
                      ? AppColors.intentForest
                      : AppColors.intentForest.withValues(alpha: 0.45),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: isLoading
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.intentGold,
                        ),
                      )
                    : const Icon(
                        Icons.check,
                        color: AppColors.intentGold,
                        size: 28,
                      ),
              ),
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
