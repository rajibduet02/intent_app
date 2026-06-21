import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';
import 'package:intent_app/presentation/discover/widgets/discover_action_button.dart';

class CompatibilityAiInsightsCard extends StatelessWidget {
  const CompatibilityAiInsightsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: const Color(0xFFF3E8D4),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppColors.intentGoldMuted.withValues(alpha: 0.55),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: const BoxDecoration(
                    color: AppColors.intentGold,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.auto_awesome,
                    size: 22,
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Unlock AI-powered 'Why You Match' insights.",
                        style: IntentLoginStyles.onboardingCardFieldLabel
                            .copyWith(fontSize: 14),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'See deeper compatibility patterns, conversation '
                        'starters, and growth areas tailored to both of you.',
                        style: IntentLoginStyles.onboardingSubtitle.copyWith(
                          fontSize: 11,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(14, 12, 14, 52),
                  decoration: BoxDecoration(
                    color: AppColors.white.withValues(alpha: 0.88),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: AppColors.intentInputBorder.withValues(alpha: 0.45),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.lock_outline,
                            size: 13,
                            color: AppColors.intentTextSoft,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'PREMIUM INSIGHT PREVIEW',
                            style: IntentLoginStyles.onboardingAssessmentCategory
                                .copyWith(
                              fontSize: 8,
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      _PlaceholderLine(width: double.infinity),
                      const SizedBox(height: 6),
                      _PlaceholderLine(width: 180),
                      const SizedBox(height: 6),
                      _PlaceholderLine(width: 140),
                    ],
                  ),
                ),
                Positioned(
                  left: 14,
                  right: 14,
                  bottom: 10,
                  child: DiscoverActionButton(
                    label: 'View Premium Insights',
                    icon: Icons.arrow_forward,
                    showChevron: false,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PlaceholderLine extends StatelessWidget {
  const _PlaceholderLine({required this.width});

  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 6,
      decoration: BoxDecoration(
        color: AppColors.intentSegmentFill,
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
