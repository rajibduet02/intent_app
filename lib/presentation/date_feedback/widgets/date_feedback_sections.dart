import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';

enum DateFeedbackFeeling {
  greatConnection,
  goodConversation,
  notSureYet,
  notAFit,
}

const _selectedFeelingBg = Color(0xFFEEF6F0);
const _harmonyBadgeBg = Color(0xFFF8E9B8);

class DateFeedbackIntroSection extends StatelessWidget {
  const DateFeedbackIntroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'How did it feel?',
          textAlign: TextAlign.center,
          style: IntentLoginStyles.onboardingTitle.copyWith(fontSize: 28),
        ),
        const SizedBox(height: 10),
        Text(
          'Your feedback helps Intent understand the quality of the '
          'connection while keeping the experience respectful and private.',
          textAlign: TextAlign.center,
          style: IntentLoginStyles.onboardingSubtitle.copyWith(
            fontSize: 16,
            height: 1.45,
          ),
        ),
        const SizedBox(height: 14),
        Center(child: DateFeedbackCompletedPill()),
      ],
    );
  }
}

class DateFeedbackCompletedPill extends StatelessWidget {
  const DateFeedbackCompletedPill({
    super.key,
    this.matchName = 'Julian',
  });

  final String matchName;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.intentInputBorder.withValues(alpha: 0.5),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.person_outline,
            size: 14,
            color: AppColors.intentTextSoft,
          ),
          const SizedBox(width: 6),
          Text(
            '$matchName · Date completed',
            style: IntentLoginStyles.onboardingSubtitle.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.intentText,
            ),
          ),
        ],
      ),
    );
  }
}

class DateFeedbackSummaryCard extends StatelessWidget {
  const DateFeedbackSummaryCard({
    super.key,
    this.name = 'Julian',
    this.harmonyPercent = 94,
  });

  final String name;
  final int harmonyPercent;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.intentInputBorder.withValues(alpha: 0.35),
        ),
        boxShadow: AppShadows.intentInput,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Date with $name',
                  style: IntentLoginStyles.onboardingSectionTitle.copyWith(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 14),
                const _SummaryDetailRow(
                  icon: Icons.calendar_today_outlined,
                  label: 'Date',
                  value: 'Friday, June 21',
                ),
                const SizedBox(height: 10),
                const _SummaryDetailRow(
                  icon: Icons.location_on_outlined,
                  label: 'Location',
                  value: 'Bloom Café, Downtown',
                ),
                const SizedBox(height: 10),
                const _SummaryDetailRow(
                  icon: Icons.check_circle_outline,
                  label: 'Status',
                  value: 'Date completed',
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(28),
                child: Image.asset(
                  AppAssets.demoPreviewPhoto,
                  width: 56,
                  height: 56,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _harmonyBadgeBg,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppColors.intentInputBorder.withValues(alpha: 0.35),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.auto_awesome,
                      size: 10,
                      color: AppColors.intentGold.withValues(alpha: 0.95),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '$harmonyPercent% Harmony',
                      style: IntentLoginStyles.onboardingSubtitle.copyWith(
                        fontSize: 9,
                        fontWeight: FontWeight.w600,
                        color: AppColors.intentText,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SummaryDetailRow extends StatelessWidget {
  const _SummaryDetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: AppColors.intentTextSoft),
        const SizedBox(width: 8),
        Text(
          label,
          style: IntentLoginStyles.onboardingSubtitle.copyWith(
            fontSize: 13,
            color: AppColors.intentTextSoft,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: IntentLoginStyles.onboardingCardFieldLabel.copyWith(
              fontSize: 13,
            ),
          ),
        ),
      ],
    );
  }
}

class DateFeedbackFeelingSection extends StatelessWidget {
  const DateFeedbackFeelingSection({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  final DateFeedbackFeeling? selected;
  final ValueChanged<DateFeedbackFeeling> onSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Choose the closest feeling',
          style: IntentLoginStyles.onboardingSectionTitle.copyWith(
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 14),
        _FeelingTile(
          icon: Icons.favorite,
          iconBg: AppColors.intentForest,
          iconColor: AppColors.white,
          title: 'Great connection',
          subtitle: 'The date felt warm, natural, and promising.',
          isSelected: selected == DateFeedbackFeeling.greatConnection,
          onTap: () => onSelected(DateFeedbackFeeling.greatConnection),
        ),
        const SizedBox(height: 10),
        _FeelingTile(
          icon: Icons.chat_bubble_outline,
          iconBg: const Color(0xFFFFF0E0),
          iconColor: const Color(0xFFB8860B),
          title: 'Good conversation',
          subtitle: 'We talked well, but the spark is still forming.',
          isSelected: selected == DateFeedbackFeeling.goodConversation,
          onTap: () => onSelected(DateFeedbackFeeling.goodConversation),
        ),
        const SizedBox(height: 10),
        _FeelingTile(
          icon: Icons.help_outline,
          iconBg: const Color(0xFFE8EEF2),
          iconColor: AppColors.intentTextSoft,
          title: 'Not sure yet',
          subtitle: 'I need more time to understand how I feel.',
          isSelected: selected == DateFeedbackFeeling.notSureYet,
          onTap: () => onSelected(DateFeedbackFeeling.notSureYet),
        ),
        const SizedBox(height: 10),
        _FeelingTile(
          icon: Icons.close,
          iconBg: const Color(0xFFF9E8E8),
          iconColor: const Color(0xFFB85C5C),
          title: 'Not a fit',
          subtitle: 'The connection did not feel right for me.',
          isSelected: selected == DateFeedbackFeeling.notAFit,
          onTap: () => onSelected(DateFeedbackFeeling.notAFit),
        ),
      ],
    );
  }
}

class _FeelingTile extends StatelessWidget {
  const _FeelingTile({
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
  });

  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String title;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isSelected ? _selectedFeelingBg : AppColors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected
                  ? AppColors.intentForest
                  : AppColors.intentInputBorder.withValues(alpha: 0.55),
              width: isSelected ? 1.5 : 1,
            ),
            boxShadow: isSelected ? null : AppShadows.intentInput,
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: iconBg,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 18, color: iconColor),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: IntentLoginStyles.onboardingCardFieldLabel
                          .copyWith(fontSize: 15),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      subtitle,
                      style: IntentLoginStyles.onboardingSubtitle.copyWith(
                        fontSize: 13,
                        height: 1.35,
                        color: AppColors.intentTextSoft,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              if (isSelected)
                Container(
                  width: 24,
                  height: 24,
                  decoration: const BoxDecoration(
                    color: AppColors.intentForest,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check,
                    size: 14,
                    color: AppColors.white,
                  ),
                )
              else
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.intentInputBorder.withValues(alpha: 0.8),
                      width: 1.5,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class DateFeedbackQualitiesSection extends StatelessWidget {
  const DateFeedbackQualitiesSection({
    super.key,
    required this.selectedQualities,
    required this.onToggle,
  });

  final Set<String> selectedQualities;
  final ValueChanged<String> onToggle;

  static const qualities = [
    _QualityOption('Thoughtful', Icons.favorite_border),
    _QualityOption('Kind', Icons.check_circle_outline),
    _QualityOption('Emotionally mature', Icons.public_outlined),
    _QualityOption('Respectful', Icons.people_outline),
    _QualityOption('Good listener', Icons.mic_none_outlined),
    _QualityOption('Intentional', Icons.assignment_outlined),
    _QualityOption('Funny', null, emoji: '😊'),
    _QualityOption('Ambitious', Icons.star_outline),
    _QualityOption('Warm', Icons.wb_sunny_outlined),
    _QualityOption('Honest', Icons.verified_user_outlined),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'What stood out?',
          style: IntentLoginStyles.onboardingSectionTitle.copyWith(
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Select any qualities you noticed.',
          style: IntentLoginStyles.onboardingSubtitle.copyWith(
            fontSize: 14,
            color: AppColors.intentTextSoft,
          ),
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final quality in qualities)
              _QualityChip(
                option: quality,
                isSelected: selectedQualities.contains(quality.label),
                onTap: () => onToggle(quality.label),
              ),
          ],
        ),
      ],
    );
  }
}

class _QualityOption {
  const _QualityOption(this.label, this.icon, {this.emoji});

  final String label;
  final IconData? icon;
  final String? emoji;
}

class _QualityChip extends StatelessWidget {
  const _QualityChip({
    required this.option,
    required this.isSelected,
    required this.onTap,
  });

  final _QualityOption option;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final contentColor =
        isSelected ? AppColors.white : AppColors.intentText;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.intentForest : AppColors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelected
                  ? AppColors.intentForest
                  : AppColors.intentInputBorder.withValues(alpha: 0.55),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (option.emoji != null)
                Text(
                  option.emoji!,
                  style: const TextStyle(fontSize: 14, height: 1),
                )
              else
                Icon(
                  option.icon,
                  size: 15,
                  color: contentColor,
                ),
              const SizedBox(width: 6),
              Text(
                option.label,
                style: IntentLoginStyles.onboardingSubtitle.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: contentColor,
                ),
              ),
              if (isSelected) ...[
                const SizedBox(width: 8),
                const Icon(
                  Icons.check,
                  size: 14,
                  color: AppColors.white,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class DateFeedbackPrivacyNote extends StatelessWidget {
  const DateFeedbackPrivacyNote({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFFDF8F2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.intentGoldMuted.withValues(alpha: 0.35),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.lock_outline,
            size: 18,
            color: AppColors.intentTextSoft,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Your feedback stays private and is not shown on your profile. '
              'It helps Intent improve matching and safety.',
              style: IntentLoginStyles.onboardingSubtitle.copyWith(
                fontSize: 14,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DateFeedbackSafetyCard extends StatelessWidget {
  const DateFeedbackSafetyCard({super.key, this.onSafetyTap});

  final VoidCallback? onSafetyTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onSafetyTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppColors.intentInputBorder.withValues(alpha: 0.45),
            ),
            boxShadow: AppShadows.intentInput,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F0D8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.verified_user_outlined,
                  size: 18,
                  color: AppColors.intentGold.withValues(alpha: 0.95),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Need support?',
                      style: IntentLoginStyles.onboardingCardFieldLabel
                          .copyWith(fontSize: 15),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'If anything felt uncomfortable or unsafe, you can '
                      'open safety tools.',
                      style: IntentLoginStyles.onboardingSubtitle.copyWith(
                        fontSize: 13,
                        height: 1.4,
                        color: AppColors.intentTextSoft,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Open Safety Center',
                    style: IntentLoginStyles.onboardingSubtitle.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.intentText,
                    ),
                  ),
                  Icon(
                    Icons.chevron_right,
                    size: 18,
                    color: AppColors.intentTextSoft.withValues(alpha: 0.75),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DateFeedbackSubmitButton extends StatelessWidget {
  const DateFeedbackSubmitButton({super.key, this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          AppSpacing.primaryButtonBorderRadius,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.intentForest.withValues(alpha: 0.22),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: SizedBox(
        width: double.infinity,
        height: AppSpacing.primaryButtonHeight,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.intentForest,
            elevation: 0,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                AppSpacing.primaryButtonBorderRadius,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.verified_user_outlined,
                size: 18,
                color: AppColors.white,
              ),
              const SizedBox(width: 4),
              Text(
                'Submit Feedback',
                style: IntentLoginStyles.onboardingContinue.copyWith(
                  letterSpacing: 0.6,
                ),
              ),
              const SizedBox(width: 4),
              const Icon(
                Icons.chevron_right,
                color: AppColors.white,
                size: 22,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DateFeedbackSkipLink extends StatelessWidget {
  const DateFeedbackSkipLink({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: Text(
          'Skip for now',
          style: IntentLoginStyles.onboardingSectionTitle.copyWith(
            fontSize: 16,
            decoration: TextDecoration.underline,
            decorationColor: AppColors.intentText,
            height: 1.3,
          ),
        ),
      ),
    );
  }
}
