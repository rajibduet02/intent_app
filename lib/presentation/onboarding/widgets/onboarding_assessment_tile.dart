import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';
import 'package:intent_app/presentation/onboarding/providers/onboarding_4_provider.dart';

class OnboardingAssessmentTile extends StatelessWidget {
  const OnboardingAssessmentTile({
    super.key,
    required this.item,
    required this.onTap,
    this.showDivider = true,
    this.isCompleted = false,
  });

  final OnboardingAssessmentItem item;
  final VoidCallback onTap;
  final bool showDivider;
  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: item.iconBackground,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      item.icon,
                      color: item.iconColor,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.title,
                          style: IntentLoginStyles.onboardingAssessmentTitle,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          item.category,
                          style: IntentLoginStyles.onboardingAssessmentCategory,
                        ),
                      ],
                    ),
                  ),
                  if (isCompleted)
                    const Icon(
                      Icons.check_circle,
                      color: AppColors.intentForest,
                      size: 22,
                    )
                  else
                    const Icon(
                      Icons.chevron_right,
                      color: AppColors.intentTextSoft,
                      size: 22,
                    ),
                ],
              ),
            ),
          ),
        ),
        if (showDivider)
          const Divider(
            height: 1,
            thickness: 1,
            color: AppColors.intentInputBorder,
            indent: 16,
            endIndent: 16,
          ),
      ],
    );
  }
}
