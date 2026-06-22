import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';

class MatchesHeader extends StatelessWidget {
  const MatchesHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'Your Matches',
              style: IntentLoginStyles.onboardingTitle.copyWith(fontSize: 30),
            ),
            const SizedBox(width: AppSpacing.xs),
            Icon(
              Icons.favorite_border,
              size: 22,
              color: AppColors.intentForest.withValues(alpha: 0.85),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          'Real people. Real connections. Real intention.',
          style: IntentLoginStyles.onboardingSubtitle.copyWith(
            fontSize: 13,
            height: 1.4,
          ),
        ),
      ],
    );
  }
}
