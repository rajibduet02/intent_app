import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';

class ChatSafetyCard extends StatelessWidget {
  const ChatSafetyCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.intentCreamDeep.withValues(alpha: 0.75),
              borderRadius: BorderRadius.circular(16),
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
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.intentInputBorder.withValues(alpha: 0.55),
                    ),
                  ),
                  child: const Icon(
                    Icons.verified_user_outlined,
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
                        'Your safety and comfort matter.',
                        style: IntentLoginStyles.onboardingCardFieldLabel
                            .copyWith(fontSize: 13),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Keep early conversations on Intent. You can report '
                        'unsafe behavior anytime.',
                        style: IntentLoginStyles.onboardingSubtitle.copyWith(
                          fontSize: 11,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Intent protects comfort, boundaries, and respectful '
                        'communication.',
                        style: IntentLoginStyles.onboardingSubtitle.copyWith(
                          fontSize: 10,
                          color: AppColors.intentTextSoft,
                          height: 1.35,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  size: 20,
                  color: AppColors.intentTextSoft,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
