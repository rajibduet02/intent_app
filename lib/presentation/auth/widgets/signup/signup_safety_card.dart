import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';

class SignupSafetyCard extends StatelessWidget {
  const SignupSafetyCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.intentCreamDeep.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.intentInputBorder.withValues(alpha: 0.8),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 56,
            height: 56,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: AppColors.intentGold.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Icon(
                        Icons.shield_outlined,
                        size: 30,
                        color: AppColors.intentGold,
                      ),
                      Icon(
                        Icons.person_outline,
                        size: 14,
                        color: AppColors.intentGold.withValues(alpha: 0.85),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: -2,
                  right: -2,
                  child: Container(
                    width: 18,
                    height: 18,
                    decoration: const BoxDecoration(
                      color: AppColors.intentForest,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check,
                      size: 11,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your safety is our priority.',
                  style: IntentLoginStyles.safetyCardTitle,
                ),
                const SizedBox(height: 6),
                Text(
                  'ID verification is required before you can start exploring and connecting.',
                  style: IntentLoginStyles.safetyCardBody,
                ),
                const SizedBox(height: 8),
                Text(
                  'Verified profiles. Real connections.',
                  style: IntentLoginStyles.safetyCardFooter,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
