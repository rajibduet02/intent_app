import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';

class ProfilePhotoPrivacyBanner extends StatelessWidget {
  const ProfilePhotoPrivacyBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.intentCreamDeep.withValues(alpha: 0.75),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppColors.intentInputBorder.withValues(alpha: 0.5),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.white.withValues(alpha: 0.9),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: AppColors.intentInputBorder.withValues(alpha: 0.55),
              ),
            ),
            child: const Icon(
              Icons.lock_outline,
              size: 18,
              color: AppColors.intentForest,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Photos stay hidden until you unlock the date flow.',
                  style: IntentLoginStyles.onboardingCardFieldLabel.copyWith(
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Intent prioritizes compatibility first so connections '
                  'begin with intention, not appearance alone.',
                  style: IntentLoginStyles.onboardingSubtitle.copyWith(
                    fontSize: 12,
                    height: 1.4,
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
