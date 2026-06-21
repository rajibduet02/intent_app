import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';

class ProfileSummaryCard extends StatelessWidget {
  const ProfileSummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF5C4A3A),
            Color(0xFF2F4A3F),
            AppColors.intentForest,
          ],
        ),
        boxShadow: AppShadows.intentInput,
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 18, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: const BoxDecoration(
                    color: AppColors.intentForestDark,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'J',
                    style: IntentLoginStyles.onboardingContinue.copyWith(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Julian, 31',
                            style: IntentLoginStyles.onboardingCardFieldLabel
                                .copyWith(
                              fontSize: 18,
                              color: AppColors.white,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Container(
                            width: 16,
                            height: 16,
                            decoration: const BoxDecoration(
                              color: AppColors.intentGold,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.check,
                              size: 11,
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      _MetaRow(
                        icon: Icons.work_outline,
                        label: 'Product Designer',
                      ),
                      const SizedBox(height: 4),
                      _MetaRow(
                        icon: Icons.location_on_outlined,
                        label: 'Nearby',
                      ),
                    ],
                  ),
                ),
                _MatchPercentBadge(percent: 94),
              ],
            ),
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.22),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.lock_outline,
                    size: 13,
                    color: AppColors.white.withValues(alpha: 0.9),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Photos hidden until date flow',
                    style: IntentLoginStyles.onboardingSubtitle.copyWith(
                      fontSize: 11,
                      color: AppColors.white.withValues(alpha: 0.92),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Icon(
                  Icons.lock_outline,
                  size: 14,
                  color: AppColors.white.withValues(alpha: 0.85),
                ),
                const SizedBox(width: 6),
                Text(
                  'Full gallery hidden',
                  style: IntentLoginStyles.onboardingSubtitle.copyWith(
                    fontSize: 12,
                    color: AppColors.white.withValues(alpha: 0.9),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                for (var i = 0; i < 3; i++) ...[
                  if (i > 0) const SizedBox(width: 8),
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.18),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppColors.white.withValues(alpha: 0.12),
                          ),
                        ),
                        child: Icon(
                          Icons.lock_outline,
                          size: 18,
                          color: AppColors.white.withValues(alpha: 0.7),
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _MetaRow extends StatelessWidget {
  const _MetaRow({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 13,
          color: AppColors.white.withValues(alpha: 0.9),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: IntentLoginStyles.onboardingSubtitle.copyWith(
            fontSize: 12,
            color: AppColors.white.withValues(alpha: 0.92),
          ),
        ),
      ],
    );
  }
}

class _MatchPercentBadge extends StatelessWidget {
  const _MatchPercentBadge({required this.percent});

  final int percent;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 58,
      height: 58,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black.withValues(alpha: 0.28),
        border: Border.all(
          color: AppColors.intentGold.withValues(alpha: 0.85),
          width: 1.5,
        ),
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$percent%',
            style: IntentLoginStyles.onboardingTitle.copyWith(
              fontSize: 16,
              color: AppColors.white,
              height: 1,
            ),
          ),
          Text(
            'MATCH',
            style: IntentLoginStyles.onboardingAssessmentCategory.copyWith(
              fontSize: 7,
              letterSpacing: 0.8,
              color: AppColors.white.withValues(alpha: 0.9),
            ),
          ),
        ],
      ),
    );
  }
}
