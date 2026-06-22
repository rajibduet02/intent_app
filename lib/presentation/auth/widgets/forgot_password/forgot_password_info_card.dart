import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';

class ForgotPasswordInfoCard extends StatelessWidget {
  const ForgotPasswordInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFBF6E8),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.intentGoldMuted.withValues(alpha: 0.45),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.white,
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.intentInputBorder.withValues(alpha: 0.55),
              ),
            ),
            child: Icon(
              Icons.lock_reset_outlined,
              size: 22,
              color: AppColors.intentGold.withValues(alpha: 0.95),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Secure reset link',
                  style: IntentLoginStyles.safetyCardTitle.copyWith(
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'For your privacy, reset links expire after a short time. '
                  'Check your spam folder if you don’t see the email.',
                  style: IntentLoginStyles.safetyCardBody.copyWith(
                    fontSize: 13,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
