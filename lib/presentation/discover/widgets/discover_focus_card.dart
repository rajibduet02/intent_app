import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';

class DiscoverFocusCard extends StatelessWidget {
  const DiscoverFocusCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(14),
        child: Container(
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
                  color: AppColors.white.withValues(alpha: 0.85),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: AppColors.intentInputBorder.withValues(alpha: 0.55),
                  ),
                ),
                child: Icon(
                  Icons.adjust,
                  size: 18,
                  color: AppColors.intentForest,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Today's discovery focus",
                      style: IntentLoginStyles.onboardingCardFieldLabel.copyWith(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Intent is prioritizing matches with aligned goals, '
                      'family values, and communication style.',
                      style: IntentLoginStyles.onboardingSubtitle.copyWith(
                        fontSize: 14,
                        height: 1.2,
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
    );
  }
}
