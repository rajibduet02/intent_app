import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';

class OnboardingStepBanner extends StatelessWidget {
  const OnboardingStepBanner({
    super.key,
    required this.step,
    required this.totalSteps,
  });

  final int step;
  final int totalSteps;

  @override
  Widget build(BuildContext context) {
    final progress = (step / totalSteps).clamp(0.0, 1.0);

    return Column(
      children: [
        Text(
          'STEP $step OF $totalSteps',
          style: IntentLoginStyles.onboardingStepBanner,
        ),
        const SizedBox(height: 10),
        ClipRRect(
          borderRadius: BorderRadius.circular(2),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 3,
            backgroundColor: AppColors.intentProgressInactive,
            color: AppColors.intentGold,
          ),
        ),
      ],
    );
  }
}
