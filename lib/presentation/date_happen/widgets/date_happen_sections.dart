import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';

enum DateHappenedChoice {
  yesMet,
  didNotMeet,
  rescheduled,
}

const _statusGold = Color(0xFFB8860B);
const _selectedBg = Color(0xFFEEF6F0);

class DateHappenIntroSection extends StatelessWidget {
  const DateHappenIntroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Icon(
                Icons.auto_awesome,
                size: 14,
                color: AppColors.intentGold.withValues(alpha: 0.85),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'Did the date happen?',
                textAlign: TextAlign.center,
                style: IntentLoginStyles.onboardingTitle.copyWith(fontSize: 28),
              ),
            ),
            const SizedBox(width: 8),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Icon(
                Icons.auto_awesome,
                size: 14,
                color: AppColors.intentGold.withValues(alpha: 0.85),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          'Let us know how the date went so Intent can guide the next '
          'step with care.',
          textAlign: TextAlign.center,
          style: IntentLoginStyles.onboardingSubtitle.copyWith(
            fontSize: 16,
            height: 1.45,
          ),
        ),
        const SizedBox(height: 14),
        const Center(child: DateHappenInfoPill()),
      ],
    );
  }
}

class DateHappenInfoPill extends StatelessWidget {
  const DateHappenInfoPill({
    super.key,
    this.matchName = 'Julian',
    this.dateLabel = 'Friday, June 21',
    this.timeLabel = '6:30 PM',
  });

  final String matchName;
  final String dateLabel;
  final String timeLabel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F4EC),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: AppColors.intentInputBorder.withValues(alpha: 0.45),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _PillItem(icon: Icons.person_outline, label: matchName),
          _PillDot(),
          _PillItem(icon: Icons.calendar_today_outlined, label: dateLabel),
          _PillDot(),
          _PillItem(icon: Icons.schedule_outlined, label: timeLabel),
        ],
      ),
    );
  }
}

class _PillItem extends StatelessWidget {
  const _PillItem({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 13,
          color: AppColors.intentTextSoft,
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: IntentLoginStyles.onboardingSubtitle.copyWith(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: AppColors.intentText,
          ),
        ),
      ],
    );
  }
}

class _PillDot extends StatelessWidget {
  const _PillDot();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Text(
        '·',
        style: IntentLoginStyles.onboardingSubtitle.copyWith(
          fontSize: 14,
          color: AppColors.intentTextSoft,
        ),
      ),
    );
  }
}

class DateHappenSummaryCard extends StatelessWidget {
  const DateHappenSummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.intentInputBorder.withValues(alpha: 0.35),
        ),
        boxShadow: AppShadows.intentInput,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Date summary',
            style: IntentLoginStyles.onboardingCardFieldLabel.copyWith(
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 14),
          const _SummaryRow(
            icon: Icons.person_outline,
            label: 'Match',
            value: 'Julian',
          ),
          const SizedBox(height: 12),
          const _SummaryRow(
            icon: Icons.location_on_outlined,
            label: 'Location',
            value: 'Bloom Café, Downtown',
          ),
          const SizedBox(height: 12),
          const _SummaryRow(
            icon: Icons.people_outline,
            label: 'Date type',
            value: 'In person',
          ),
          const SizedBox(height: 12),
          const _SummaryRow(
            icon: Icons.verified_user_outlined,
            label: 'Status',
            value: 'Awaiting confirmation',
            valueColor: _statusGold,
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.icon,
    required this.label,
    required this.value,
    this.valueColor,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 18,
          color: AppColors.intentTextSoft,
        ),
        const SizedBox(width: 10),
        Text(
          label,
          style: IntentLoginStyles.onboardingSubtitle.copyWith(
            fontSize: 15,
            color: AppColors.intentTextSoft,
          ),
        ),
        const Spacer(),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: IntentLoginStyles.onboardingCardFieldLabel.copyWith(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: valueColor ?? AppColors.intentText,
            ),
          ),
        ),
      ],
    );
  }
}

class DateHappenChoiceCard extends StatelessWidget {
  const DateHappenChoiceCard({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  final DateHappenedChoice selected;
  final ValueChanged<DateHappenedChoice> onSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.intentInputBorder.withValues(alpha: 0.35),
        ),
        boxShadow: AppShadows.intentInput,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Choose one',
            style: IntentLoginStyles.onboardingCardFieldLabel.copyWith(
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 14),
          _ChoiceTile(
            icon: Icons.photo_outlined,
            title: 'Yes, we met',
            subtitle: 'The date happened as planned.',
            isSelected: selected == DateHappenedChoice.yesMet,
            onTap: () => onSelected(DateHappenedChoice.yesMet),
          ),
          const SizedBox(height: 10),
          _ChoiceTile(
            icon: Icons.event_busy_outlined,
            title: 'No, we did not meet',
            subtitle: 'The date did not happen.',
            isSelected: selected == DateHappenedChoice.didNotMeet,
            onTap: () => onSelected(DateHappenedChoice.didNotMeet),
          ),
          const SizedBox(height: 10),
          _ChoiceTile(
            icon: Icons.event_repeat_outlined,
            title: 'We rescheduled',
            subtitle: 'You agreed to meet at another time.',
            isSelected: selected == DateHappenedChoice.rescheduled,
            onTap: () => onSelected(DateHappenedChoice.rescheduled),
          ),
        ],
      ),
    );
  }
}

class _ChoiceTile extends StatelessWidget {
  const _ChoiceTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
  });

  final IconData icon;
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
            color: isSelected ? _selectedBg : AppColors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected
                  ? AppColors.intentForest
                  : AppColors.intentInputBorder.withValues(alpha: 0.55),
              width: isSelected ? 1.5 : 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.intentInputBorder.withValues(alpha: 0.45),
                  ),
                ),
                child: Icon(
                  icon,
                  size: 20,
                  color: AppColors.intentTextSoft,
                ),
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

class DateHappenSafetyNote extends StatelessWidget {
  const DateHappenSafetyNote({super.key});

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
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: AppColors.intentInputBorder.withValues(alpha: 0.4),
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(
                  Icons.shield_outlined,
                  size: 18,
                  color: AppColors.intentGold.withValues(alpha: 0.95),
                ),
                Positioned(
                  bottom: 6,
                  child: Icon(
                    Icons.favorite,
                    size: 8,
                    color: AppColors.intentGold.withValues(alpha: 0.95),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Your response helps Intent keep the experience accurate, '
              'safe, and intentional. If something felt unsafe, you can '
              'access safety tools from the next step.',
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

class DateHappenContinueButton extends StatelessWidget {
  const DateHappenContinueButton({super.key, this.onPressed});

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
              Text(
                'Continue',
                style: IntentLoginStyles.onboardingContinue.copyWith(
                  letterSpacing: 0.6,
                ),
              ),
              const SizedBox(width: 8),
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

class DateHappenSafetyCenterLink extends StatelessWidget {
  const DateHappenSafetyCenterLink({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: Text(
          'Need help? Open Safety Center',
          textAlign: TextAlign.center,
          style: IntentLoginStyles.onboardingSectionTitle.copyWith(
            fontSize: 15,
            decoration: TextDecoration.underline,
            decorationColor: AppColors.intentText,
            height: 1.3,
          ),
        ),
      ),
    );
  }
}
