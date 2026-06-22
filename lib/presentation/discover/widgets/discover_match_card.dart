import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';
import 'package:intent_app/presentation/discover/widgets/discover_action_button.dart';
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
    this.onTap,
    this.onViewCompatibility,
    this.onConnectWithIntention,
    this.onPassRespectfully,
  });

  final String name;
  final int age;
  final int matchPercent;
  final List<DiscoverMatchHighlight> highlights;
  final VoidCallback? onTap;
  final VoidCallback? onViewCompatibility;
  final VoidCallback? onConnectWithIntention;
  final VoidCallback? onPassRespectfully;

  static const List<DiscoverMatchCard> sampleCards = [
    DiscoverMatchCard(
      name: 'Julian',
      age: 31,
      matchPercent: 94,
      highlights: [
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
    ),
    DiscoverMatchCard(
      name: 'Maya',
      age: 29,
      matchPercent: 89,
      highlights: [
        DiscoverMatchHighlight(
          icon: Icons.self_improvement_outlined,
          label: 'Both value personal growth',
        ),
        DiscoverMatchHighlight(
          icon: Icons.nightlife_outlined,
          label: 'Balanced social energy',
        ),
        DiscoverMatchHighlight(
          icon: Icons.volunteer_activism_outlined,
          label: 'Shared community mindset',
        ),
      ],
    ),
    DiscoverMatchCard(
      name: 'Elena',
      age: 33,
      matchPercent: 86,
      highlights: [
        DiscoverMatchHighlight(
          icon: Icons.favorite_border,
          label: 'Serious relationship intent',
        ),
        DiscoverMatchHighlight(
          icon: Icons.menu_book_outlined,
          label: 'Shared curiosity and depth',
        ),
        DiscoverMatchHighlight(
          icon: Icons.schedule_outlined,
          label: 'Compatible pace of connection',
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.intentDiscoverMatch,
      elevation: 0,
      shadowColor: Colors.transparent,
      borderRadius: BorderRadius.circular(22),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          boxShadow: AppShadows.intentInput,
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 18, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              InkWell(
                onTap: onTap,
                borderRadius: BorderRadius.circular(14),
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
                                style: IntentLoginStyles.onboardingContinue
                                    .copyWith(
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
                                    style: IntentLoginStyles
                                        .onboardingCardFieldLabel
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
                              const _MetaRow(
                                icon: Icons.location_on_outlined,
                                label: 'Nearby',
                              ),
                              const SizedBox(height: 4),
                              const _MetaRow(
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
                      style: IntentLoginStyles.onboardingAssessmentCategory
                          .copyWith(
                        fontSize: 9,
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.w700,
                        color: AppColors.white.withValues(alpha: 0.9),
                      ),
                    ),
                    const SizedBox(height: 10),
                    for (final highlight in highlights) ...[
                      _HighlightRow(highlight: highlight),
                      if (highlight != highlights.last)
                        const SizedBox(height: 8),
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
              const SizedBox(height: AppSpacing.md),
              DiscoverActionButton(
                label: 'View Compatibility',
                icon: Icons.visibility_outlined,
                onPressed: onViewCompatibility,
              ),
              const SizedBox(height: AppSpacing.md),
              DiscoverActionButton(
                label: 'Connect with Intention',
                icon: Icons.favorite_border,
                style: DiscoverActionStyle.outlined,
                onPressed: onConnectWithIntention,
              ),
              const SizedBox(height: AppSpacing.md),
              DiscoverActionButton(
                label: 'Pass respectfully',
                icon: Icons.cancel_outlined,
                style: DiscoverActionStyle.muted,
                showChevron: false,
                onPressed: onPassRespectfully,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
/// Vertical stack of discover match profile cards.
class DiscoverMatchCardList extends StatelessWidget {
  const DiscoverMatchCardList({
    super.key,
    this.cards = DiscoverMatchCard.sampleCards,
    this.spacing = 14,
    this.onCardTap,
    this.onViewCompatibility,
    this.onConnectWithIntention,
    this.onPassRespectfully,
  });

  final List<DiscoverMatchCard> cards;
  final double spacing;
  final VoidCallback? onCardTap;
  final VoidCallback? onViewCompatibility;
  final VoidCallback? onConnectWithIntention;
  final VoidCallback? onPassRespectfully;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (var i = 0; i < cards.length; i++) ...[
          if (i > 0) SizedBox(height: spacing),
          DiscoverMatchCard(
            name: cards[i].name,
            age: cards[i].age,
            matchPercent: cards[i].matchPercent,
            highlights: cards[i].highlights,
            onTap: onCardTap,
            onViewCompatibility: onViewCompatibility,
            onConnectWithIntention: onConnectWithIntention,
            onPassRespectfully: onPassRespectfully,
          ),
        ],
      ],
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
