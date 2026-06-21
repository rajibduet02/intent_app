import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';

class CompatibilityDifferenceCard extends StatelessWidget {
  const CompatibilityDifferenceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: const Color(0xFFF8E8DF),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFE8C9B8).withValues(alpha: 0.65),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: AppColors.white.withValues(alpha: 0.65),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.swap_horiz,
                size: 18,
                color: Color(0xFFB07A62),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'POTENTIAL DIFFERENCE',
                              style: IntentLoginStyles.onboardingAssessmentCategory
                                  .copyWith(
                                fontSize: 8,
                                letterSpacing: 1.1,
                                color: const Color(0xFF9A6A58),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Social energy',
                              style: IntentLoginStyles.onboardingCardFieldLabel
                                  .copyWith(fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8C4B0),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          'GROWTH AREA',
                          style: IntentLoginStyles.onboardingAssessmentCategory
                              .copyWith(
                            fontSize: 7,
                            letterSpacing: 0.8,
                            color: const Color(0xFF7A4F3F),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Julian may enjoy more spontaneous outings, while you may '
                    'prefer slower, planned connection.',
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
      ),
    );
  }
}
