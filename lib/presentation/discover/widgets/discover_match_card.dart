import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';

class DiscoverMatchHighlight {
  const DiscoverMatchHighlight({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;
}

class DiscoverMatchCard extends StatelessWidget {
  const DiscoverMatchCard({
    super.key,
    this.name = 'Julian',
    this.age = 31,
    this.matchPercent = 94,
    this.highlights = const [
      DiscoverMatchHighlight(
        icon: Icons.diamond_outlined,
        label: 'Both marriage-minded',
      ),
      DiscoverMatchHighlight(
        icon: Icons.home_outlined,
        label: 'Shared value: family',
      ),
      DiscoverMatchHighlight(
        icon: Icons.chat_bubble_outline,
        label: 'Similar communication rhythm',
      ),
      DiscoverMatchHighlight(
        icon: Icons.favorite,
        label: 'Aligned faith importance',
      ),
    ],
  });

  final String name;
  final int age;
  final int matchPercent;
  final List<DiscoverMatchHighlight> highlights;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.intentDiscoverMatch,
        borderRadius: BorderRadius.circular(22),
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
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: 52,
                      height: 52,
                      decoration: const BoxDecoration(
                        color: AppColors.intentForest,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        name.isNotEmpty ? name[0].toUpperCase() : '?',
                        style: IntentLoginStyles.onboardingContinue.copyWith(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -2,
                      right: -2,
                      child: Container(
                        width: 18,
                        height: 18,
                        decoration: BoxDecoration(
                          color: AppColors.intentForest,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.intentDiscoverMatch,
                            width: 2,
                          ),
                        ),
                        child: const Icon(
                          Icons.check,
                          size: 11,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            '$name, $age',
                            style: IntentLoginStyles.onboardingCardFieldLabel
                                .copyWith(
                              fontSize: 16,
                              color: AppColors.white,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Container(
                            width: 16,
                            height: 16,
                            decoration: const BoxDecoration(
                              color: AppColors.white,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.check,
                              size: 11,
                              color: AppColors.intentForest,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      _MetaRow(
                        icon: Icons.location_on_outlined,
                        label: 'Nearby',
                      ),
                      const SizedBox(height: 4),
                      _MetaRow(
                        icon: Icons.lock_outline,
                        label: 'Photos hidden',
                      ),
                    ],
                  ),
                ),
                _MatchPercentBadge(percent: matchPercent),
              ],
            ),
            const SizedBox(height: 18),
            Text(
              'WHY THIS MATCH STANDS OUT',
              style: IntentLoginStyles.onboardingAssessmentCategory.copyWith(
                fontSize: 9,
                letterSpacing: 1.2,
                fontWeight: FontWeight.w700,
                color: AppColors.white.withValues(alpha: 0.9),
              ),
            ),
            const SizedBox(height: 10),
            for (final highlight in highlights) ...[
              _HighlightRow(highlight: highlight),
              if (highlight != highlights.last) const SizedBox(height: 8),
            ],
            const SizedBox(height: 14),
            Row(
              children: [
                Icon(
                  Icons.lock_outline,
                  size: 14,
                  color: AppColors.white.withValues(alpha: 0.85),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    'Photo preview can unlock after a date is proposed.',
                    style: IntentLoginStyles.onboardingSubtitle.copyWith(
                      fontSize: 11,
                      color: AppColors.white.withValues(alpha: 0.88),
                      height: 1.35,
                    ),
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
        border: Border.all(
          color: AppColors.white.withValues(alpha: 0.55),
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

class _HighlightRow extends StatelessWidget {
  const _HighlightRow({required this.highlight});

  final DiscoverMatchHighlight highlight;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.white.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: AppColors.white.withValues(alpha: 0.22),
              shape: BoxShape.circle,
            ),
            child: Icon(
              highlight.icon,
              size: 15,
              color: AppColors.white,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              highlight.label,
              style: IntentLoginStyles.onboardingSubtitle.copyWith(
                fontSize: 12,
                color: AppColors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
