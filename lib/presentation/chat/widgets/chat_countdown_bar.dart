import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';

class ChatCountdownBar extends StatelessWidget {
  const ChatCountdownBar({
    super.key,
    this.currentDay = 7,
    this.totalDays = 30,
  });

  final int currentDay;
  final int totalDays;

  @override
  Widget build(BuildContext context) {
    final progress = currentDay / totalDays;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  '$totalDays-day date proposal countdown',
                  style: IntentLoginStyles.onboardingSubtitle.copyWith(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Text(
                'Day $currentDay of $totalDays',
                style: IntentLoginStyles.onboardingSubtitle.copyWith(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 5,
              backgroundColor: AppColors.intentCreamDeep.withValues(alpha: 0.85),
              valueColor: const AlwaysStoppedAnimation<Color>(
                Color(0xFFB8956F),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
