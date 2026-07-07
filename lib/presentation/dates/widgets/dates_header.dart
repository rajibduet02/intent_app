import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';

class DatesHeader extends StatelessWidget {
  const DatesHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'Your Dates',
              style: IntentLoginStyles.onboardingTitle.copyWith(fontSize: 30),
            ),
            const SizedBox(width: AppSpacing.xs),
            Icon(
              Icons.event_available_outlined,
              size: 22,
              color: AppColors.intentForest.withValues(alpha: 0.85),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'Track proposals, confirmed plans, and what needs your attention.',
          style: IntentLoginStyles.onboardingSubtitle.copyWith(
            fontSize: 13,
            height: 1.4,
          ),
        ),
      ],
    );
  }
}
