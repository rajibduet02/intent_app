import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';

TextStyle get _bodyStyle => IntentLoginStyles.onboardingSubtitle.copyWith(
      fontSize: 12,
      height: 1.45,
    );

TextStyle get _footerNoteStyle => IntentLoginStyles.onboardingFooterNote.copyWith(
      fontSize: 12,
      height: 1.45,
    );

class WhyMatchesCard extends StatelessWidget {
  const WhyMatchesCard({
    super.key,
    required this.child,
    this.backgroundColor = AppColors.white,
    this.padding = const EdgeInsets.fromLTRB(16, 16, 16, 14),
  });

  final Widget child;
  final Color backgroundColor;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.intentInputBorder.withValues(alpha: 0.45),
        ),
        boxShadow: AppShadows.intentInput,
      ),
      child: child,
    );
  }
}

class WhyMatchesSectionTitle extends StatelessWidget {
  const WhyMatchesSectionTitle({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: IntentLoginStyles.onboardingSectionTitle.copyWith(fontSize: 18),
    );
  }
}

class WhyMatchesInsightCard extends StatelessWidget {
  const WhyMatchesInsightCard({super.key});

  @override
  Widget build(BuildContext context) {
    return WhyMatchesCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const WhyMatchesSectionTitle(title: 'A personalized connection insight'),
          const SizedBox(height: 10),
          Text(
            'This connection appears emotionally grounded and intention-led. '
            'You both seem to value sincerity, depth, and building something '
            'meaningful rather than rushing into surface-level attraction.',
            style: IntentLoginStyles.onboardingSubtitle.copyWith(
              fontSize: 12,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}

class WhyMatchesStrongAlignmentCard extends StatelessWidget {
  const WhyMatchesStrongAlignmentCard({super.key});

  static const _items = [
    _AlignmentEntry(
      icon: Icons.flag_outlined,
      label: 'Relationship intentions',
      description:
          "You're both looking for something serious and long-term.",
    ),
    _AlignmentEntry(
      icon: Icons.home_outlined,
      label: 'Family values',
      description:
          'You both place high importance on building a stable foundation.',
    ),
    _AlignmentEntry(
      icon: Icons.shield_outlined,
      label: 'Emotional depth',
      description:
          'You each value sincerity, honesty, and open hearts.',
    ),
    _AlignmentEntry(
      icon: Icons.calendar_today_outlined,
      label: 'Long-term outlook',
      description: 'Your goals appear aligned around building something real.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return WhyMatchesCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const WhyMatchesSectionTitle(title: 'Strong Alignment'),
          const SizedBox(height: 14),
          for (var i = 0; i < _items.length; i++) ...[
            if (i > 0) const SizedBox(height: 12),
            _AlignmentRow(entry: _items[i]),
          ],
        ],
      ),
    );
  }
}

class _AlignmentEntry {
  const _AlignmentEntry({
    required this.icon,
    required this.label,
    required this.description,
  });

  final IconData icon;
  final String label;
  final String description;
}

class _AlignmentRow extends StatelessWidget {
  const _AlignmentRow({required this.entry});

  final _AlignmentEntry entry;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: AppColors.intentForest.withValues(alpha: 0.08),
            shape: BoxShape.circle,
          ),
          child: Icon(
            entry.icon,
            size: 15,
            color: AppColors.intentForest,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: _bodyStyle.copyWith(color: AppColors.intentTextSoft),
              children: [
                TextSpan(
                  text: '${entry.label}: ',
                  style: _bodyStyle.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.intentTextSoft,
                  ),
                ),
                TextSpan(text: entry.description),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class WhyMatchesCommunicationCard extends StatelessWidget {
  const WhyMatchesCommunicationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return WhyMatchesCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const WhyMatchesSectionTitle(title: 'Communication Style'),
          const SizedBox(height: 14),
          const Row(
            children: [
              Expanded(
                child: _CommunicationBox(
                  label: 'YOU',
                  value: 'Direct, thoughtful',
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: _CommunicationBox(
                  label: 'JULIAN',
                  value: 'Warm, empathetic',
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            "You're likely to communicate well because both of you value "
            'meaningful discussion over superficial chat.',
            style: _footerNoteStyle,
          ),
        ],
      ),
    );
  }
}

class _CommunicationBox extends StatelessWidget {
  const _CommunicationBox({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.intentCreamDeep.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.intentInputBorder.withValues(alpha: 0.45),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: IntentLoginStyles.onboardingSubtitle.copyWith(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: IntentLoginStyles.onboardingCardFieldLabel.copyWith(
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}

class WhyMatchesSharedValuesCard extends StatelessWidget {
  const WhyMatchesSharedValuesCard({super.key});

  static const _values = [
    'Family',
    'Honesty',
    'Faith importance',
    'Emotional maturity',
  ];

  @override
  Widget build(BuildContext context) {
    return WhyMatchesCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const WhyMatchesSectionTitle(title: 'Shared Values'),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final value in _values)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.intentSegmentFill,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: AppColors.intentInputBorder.withValues(alpha: 0.5),
                    ),
                  ),
                  child: Text(
                    value,
                    style: IntentLoginStyles.onboardingSubtitle.copyWith(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: AppColors.intentText,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'The strongest part of this match may be how naturally your core '
            'values support each other.',
            style: _bodyStyle,
          ),
        ],
      ),
    );
  }
}

class WhyMatchesLifestyleCard extends StatelessWidget {
  const WhyMatchesLifestyleCard({super.key});

  static const _points = [
    'Balanced routine',
    'Meaningful quality time',
    'Home-centered lifestyle',
    'Similar pace of connection',
  ];

  @override
  Widget build(BuildContext context) {
    return WhyMatchesCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const WhyMatchesSectionTitle(title: 'Lifestyle Compatibility'),
          const SizedBox(height: 12),
          for (final point in _points) ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 6, right: 8),
                  child: Container(
                    width: 5,
                    height: 5,
                    decoration: const BoxDecoration(
                      color: AppColors.intentForest,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(point, style: _bodyStyle),
                ),
              ],
            ),
            const SizedBox(height: 4),
          ],
          const SizedBox(height: 8),
          Text(
            'Your lifestyles seem compatible in a grounded, sustainable way.',
            style: _footerNoteStyle,
          ),
        ],
      ),
    );
  }
}

class WhyMatchesGrowthAreasCard extends StatelessWidget {
  const WhyMatchesGrowthAreasCard({super.key});

  static const _areas = [
    _GrowthArea(
      title: 'Social energy',
      description: 'Managing different levels of social engagement.',
    ),
    _GrowthArea(
      title: 'Decision pace',
      description: 'How you both approach making big life choices.',
    ),
    _GrowthArea(
      title: 'Conflict reassurance',
      description:
          'Ways you both prefer to receive comfort after tension.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return WhyMatchesCard(
      backgroundColor: AppColors.intentCreamDeep.withValues(alpha: 0.55),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const WhyMatchesSectionTitle(title: 'Potential Growth Areas'),
          const SizedBox(height: 12),
          for (var i = 0; i < _areas.length; i++) ...[
            if (i > 0) const SizedBox(height: 10),
            _GrowthAreaRow(area: _areas[i]),
          ],
          const SizedBox(height: 12),
          Text(
            "There may be small differences... they're the kind of differences "
            'that can become strengths with open communication.',
            style: _footerNoteStyle,
          ),
        ],
      ),
    );
  }
}

class _GrowthArea {
  const _GrowthArea({
    required this.title,
    required this.description,
  });

  final String title;
  final String description;
}

class _GrowthAreaRow extends StatelessWidget {
  const _GrowthAreaRow({required this.area});

  final _GrowthArea area;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: _bodyStyle.copyWith(color: AppColors.intentTextSoft),
        children: [
          TextSpan(
            text: '${area.title}: ',
            style: _bodyStyle.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.intentTextSoft,
            ),
          ),
          TextSpan(text: area.description),
        ],
      ),
    );
  }
}

class WhyMatchesConversationStartersCard extends StatelessWidget {
  const WhyMatchesConversationStartersCard({super.key});

  static const _questions = [
    'What does a meaningful relationship look like to you?',
    'How do you usually show care to the people in your life?',
    'What values did you grow up with that you still hold dear today?',
    "What's one thing that always makes you feel truly at home?",
  ];

  @override
  Widget build(BuildContext context) {
    return WhyMatchesCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const WhyMatchesSectionTitle(title: 'Date Conversation Starters'),
          const SizedBox(height: 12),
          for (var i = 0; i < _questions.length; i++) ...[
            if (i > 0) const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.intentInputBorder.withValues(alpha: 0.65),
                ),
              ),
              child: Text(
                '"${_questions[i]}"',
                style: IntentLoginStyles.onboardingSubtitle.copyWith(
                  fontSize: 12,
                  height: 1.45,
                  color: AppColors.intentText,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
