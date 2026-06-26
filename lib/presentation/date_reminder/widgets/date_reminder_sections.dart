import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';

const _cardCream = Color(0xFFFDF8F2);
const _planIconBg = Color(0xFFF4F7FB);
const _confirmedDateBadgeBg = Color(0xFFFFF0E0);
const _confirmedDateText = Color(0xFFB8860B);
const _harmonyBadgeBg = Color(0xFFE8F0EA);

class DateReminderIntroSection extends StatelessWidget {
  const DateReminderIntroSection({
    super.key,
    this.matchName = 'Julian',
  });

  final String matchName;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Your date is coming up',
          textAlign: TextAlign.center,
          style: IntentLoginStyles.onboardingTitle.copyWith(fontSize: 28),
        ),
        const SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Icon(
                Icons.auto_awesome,
                size: 14,
                color: AppColors.intentGold.withValues(alpha: 0.85),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'Your plan with $matchName is coming up soon. Review the '
                'details, check safety tips, and keep the conversation going.',
                textAlign: TextAlign.center,
                style: IntentLoginStyles.onboardingSubtitle.copyWith(
                  fontSize: 16,
                  height: 1.45,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Icon(
                Icons.auto_awesome,
                size: 14,
                color: AppColors.intentGold.withValues(alpha: 0.85),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Center(child: DateReminderSetBadge()),
        const SizedBox(height: 10),
        Text(
          'TODAY AT 6:30 PM',
          textAlign: TextAlign.center,
          style: IntentLoginStyles.onboardingSubtitle.copyWith(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.1,
            color: AppColors.intentTextSoft,
          ),
        ),
      ],
    );
  }
}

class DateReminderSetBadge extends StatelessWidget {
  const DateReminderSetBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFF8E9B8),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.intentGoldMuted.withValues(alpha: 0.4),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.notifications_none_outlined,
            size: 14,
            color: AppColors.intentGold.withValues(alpha: 0.95),
          ),
          const SizedBox(width: 6),
          Text(
            'Reminder set',
            style: IntentLoginStyles.onboardingSubtitle.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.intentText,
            ),
          ),
        ],
      ),
    );
  }
}

class DateReminderDetailsCard extends StatelessWidget {
  const DateReminderDetailsCard({
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
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 18),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: AppColors.intentInputBorder.withValues(alpha: 0.35),
        ),
        boxShadow: AppShadows.intentInput,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Date details',
            style: IntentLoginStyles.onboardingSectionTitle.copyWith(
              fontSize: 20,
              color: AppColors.intentText,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 8,
                      runSpacing: 6,
                      children: [
                        Text(
                          name,
                          style: IntentLoginStyles.onboardingSectionTitle
                              .copyWith(fontSize: 20),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: _confirmedDateBadgeBg,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: AppColors.intentGoldMuted
                                  .withValues(alpha: 0.35),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.check_circle_outline,
                                size: 11,
                                color: _confirmedDateText,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'CONFIRMED DATE',
                                style: IntentLoginStyles.onboardingSubtitle
                                    .copyWith(
                                  fontSize: 9,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.4,
                                  color: _confirmedDateText,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _harmonyBadgeBg,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.auto_awesome,
                            size: 11,
                            color: AppColors.intentForest.withValues(alpha: 0.85),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '$harmonyPercent% Harmony',
                            style: IntentLoginStyles.onboardingSubtitle
                                .copyWith(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: AppColors.intentForest,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          const _DateDetailRow(
            icon: Icons.calendar_today_outlined,
            label: 'Date',
            value: 'Friday, June 21',
          ),
          _DateDetailDivider(),
          const _DateDetailRow(
            icon: Icons.schedule_outlined,
            label: 'Time',
            value: '6:30 PM',
          ),
          _DateDetailDivider(),
          const _DateDetailRow(
            icon: Icons.location_on_outlined,
            label: 'Location',
            value: 'Bloom Café, Downtown',
            subValue: 'PUBLIC PLACE',
          ),
          _DateDetailDivider(),
          const _DateDetailRow(
            icon: Icons.people_outline,
            label: 'Date type',
            value: 'In person',
          ),
          _DateDetailDivider(),
          const _DateDetailRow(
            icon: Icons.chat_bubble_outline,
            label: 'Plan note',
            value: 'Coffee feels simple, public, and easy to talk.',
            multilineValue: true,
          ),
        ],
      ),
    );
  }
}

class _DateDetailDivider extends StatelessWidget {
  const _DateDetailDivider();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Divider(
        height: 1,
        thickness: 1,
        color: AppColors.intentInputBorder.withValues(alpha: 0.35),
      ),
    );
  }
}

class _DateDetailRow extends StatelessWidget {
  const _DateDetailRow({
    required this.icon,
    required this.label,
    required this.value,
    this.subValue,
    this.multilineValue = false,
  });

  final IconData icon;
  final String label;
  final String value;
  final String? subValue;
  final bool multilineValue;

  @override
  Widget build(BuildContext context) {
    final alignTop = subValue != null || multilineValue;

    return Row(
      crossAxisAlignment:
          alignTop ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: _planIconBg,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            size: 20,
            color: AppColors.intentTextSoft,
          ),
        ),
        const SizedBox(width: 14),
        Text(
          label,
          style: IntentLoginStyles.onboardingSubtitle.copyWith(
            fontSize: 16,
            color: AppColors.intentTextSoft,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                textAlign: TextAlign.right,
                softWrap: multilineValue,
                style: IntentLoginStyles.onboardingCardFieldLabel.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.intentText,
                  height: multilineValue ? 1.45 : 1.2,
                ),
              ),
              if (subValue != null) ...[
                const SizedBox(height: 2),
                Text(
                  subValue!,
                  textAlign: TextAlign.right,
                  style: IntentLoginStyles.onboardingSubtitle.copyWith(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                    color: AppColors.intentTextSoft,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class DateReminderActiveCard extends StatelessWidget {
  const DateReminderActiveCard({super.key});

  @override
  Widget build(BuildContext context) {
    return _DateReminderInfoCard(
      icon: Icons.notifications_none_outlined,
      title: 'Reminder active',
      description:
          'We\'ll remind you before the date so you can review the plan '
          'and safety tools.',
      footer: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(24),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.notifications_none_outlined,
                  size: 18,
                  color: AppColors.intentTextSoft,
                ),
                const SizedBox(width: 10),
                Text(
                  '1 hour before',
                  style: IntentLoginStyles.onboardingCardFieldLabel.copyWith(
                    fontSize: 15,
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.chevron_right,
                  size: 20,
                  color: AppColors.intentTextSoft,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DateReminderSafetyCard extends StatelessWidget {
  const DateReminderSafetyCard({super.key});

  @override
  Widget build(BuildContext context) {
    return _DateReminderInfoCard(
      icon: Icons.verified_user_outlined,
      title: 'Safety reminder',
      description:
          'For first dates, meet in a public place, keep plans inside '
          'Intent, and let someone you trust know where you\'ll be.',
      footer: Text(
        'YOU CAN ACCESS REPORT, BLOCK, AND SAFETY GUIDANCE ANYTIME.',
        style: IntentLoginStyles.onboardingSubtitle.copyWith(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.4,
          height: 1.4,
          color: AppColors.intentTextSoft,
        ),
      ),
    );
  }
}

class DateReminderRefreshCard extends StatelessWidget {
  const DateReminderRefreshCard({super.key});

  @override
  Widget build(BuildContext context) {
    return _DateReminderInfoCard(
      icon: Icons.assignment_outlined,
      title: 'Need a quick refresh?',
      description: 'Review safety tips before heading out.',
    );
  }
}

class _DateReminderInfoCard extends StatelessWidget {
  const _DateReminderInfoCard({
    required this.icon,
    required this.title,
    required this.description,
    this.footer,
  });

  final IconData icon;
  final String title;
  final String description;
  final Widget? footer;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: _cardCream,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppColors.intentInputBorder.withValues(alpha: 0.35),
            ),
            boxShadow: AppShadows.intentInput,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppColors.intentInputBorder.withValues(alpha: 0.4),
                      ),
                    ),
                    child: Icon(
                      icon,
                      size: 20,
                      color: AppColors.intentGold.withValues(alpha: 0.95),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: IntentLoginStyles.onboardingSectionTitle
                              .copyWith(fontSize: 18),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          description,
                          style: IntentLoginStyles.onboardingSubtitle.copyWith(
                            fontSize: 14,
                            height: 1.45,
                            color: AppColors.intentTextSoft,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.chevron_right,
                    size: 20,
                    color: AppColors.intentTextSoft.withValues(alpha: 0.75),
                  ),
                ],
              ),
              if (footer != null) ...[
                const SizedBox(height: 14),
                footer!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class DateReminderOpenChatButton extends StatelessWidget {
  const DateReminderOpenChatButton({super.key, this.onPressed});

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
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: AppColors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.chat_bubble_outline,
                  size: 16,
                  color: AppColors.white,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                'Open Chat',
                style: IntentLoginStyles.onboardingContinue.copyWith(
                  letterSpacing: 0.6,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DateReminderViewSafetyTipsButton extends StatelessWidget {
  const DateReminderViewSafetyTipsButton({super.key, this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: AppSpacing.primaryButtonHeight,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.white,
          foregroundColor: AppColors.intentText,
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              AppSpacing.primaryButtonBorderRadius,
            ),
            side: BorderSide(
              color: AppColors.intentText.withValues(alpha: 0.85),
            ),
          ),
        ),
        child: Text(
          'View Safety Tips',
          style: IntentLoginStyles.onboardingSectionTitle.copyWith(
            fontSize: 16,
            color: AppColors.intentText,
            height: 1.2,
          ),
        ),
      ),
    );
  }
}
