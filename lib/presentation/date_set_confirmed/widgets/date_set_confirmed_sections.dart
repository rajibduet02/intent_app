import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';

class DateSetConfirmedIntroText extends StatelessWidget {
  const DateSetConfirmedIntroText({
    super.key,
    this.matchName = 'Julian',
  });

  final String matchName;

  @override
  Widget build(BuildContext context) {
    return Text(
      'Your plan with $matchName is confirmed. Keep the conversation '
      'going and review safety tools before you meet.',
      textAlign: TextAlign.center,
      style: IntentLoginStyles.onboardingSubtitle.copyWith(
        fontSize: 16,
        height: 1.45,
      ),
    );
  }
}

class DateSetConfirmedBadge extends StatelessWidget {
  const DateSetConfirmedBadge({super.key});

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
            Icons.check_circle_outline,
            size: 14,
            color: AppColors.intentForest.withValues(alpha: 0.9),
          ),
          const SizedBox(width: 6),
          Text(
            'Confirmed',
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

class DateSetConfirmedProfileCard extends StatelessWidget {
  const DateSetConfirmedProfileCard({
    super.key,
    this.name = 'Julian',
    this.harmonyPercent = 84,
  });

  final String name;
  final int harmonyPercent;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.intentInputBorder.withValues(alpha: 0.55),
        ),
        boxShadow: AppShadows.intentInput,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.asset(
              AppAssets.demoPreviewPhoto,
              width: 72,
              height: 72,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        name,
                        style: IntentLoginStyles.onboardingSectionTitle
                            .copyWith(fontSize: 20),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8E9B8),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '+ $harmonyPercent% Harmony',
                        style: IntentLoginStyles.onboardingSubtitle.copyWith(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: AppColors.intentText,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.lock_outline,
                      size: 14,
                      color: AppColors.intentTextSoft,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        'Preview photo released. Full gallery remains private '
                        'until after the date flow progresses.',
                        style: IntentLoginStyles.onboardingSubtitle.copyWith(
                          fontSize: 12,
                          height: 1.4,
                          color: AppColors.intentTextSoft,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

const _planCardBg = Color(0xFFFDFBFA);
const _planIconBg = Color(0xFFF4F7FB);

class DateSetConfirmedPlanCard extends StatelessWidget {
  const DateSetConfirmedPlanCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 18),
      decoration: BoxDecoration(
        color: _planCardBg,
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
            'Confirmed plan',
            style: IntentLoginStyles.onboardingSectionTitle.copyWith(
              fontSize: 20,
              color: AppColors.intentText,
            ),
          ),
          const SizedBox(height: 18),
          const _ConfirmedPlanRow(
            icon: Icons.calendar_today_outlined,
            label: 'Date',
            value: 'Friday, June 21',
          ),
          _ConfirmedPlanDivider(),
          _ConfirmedPlanRow(
            icon: Icons.schedule_outlined,
            label: 'Time',
            value: '6:30 PM',
          ),
          _ConfirmedPlanDivider(),
          _ConfirmedPlanRow(
            icon: Icons.location_on_outlined,
            label: 'Location',
            value: 'Bloom Café, Downtown',
            subValue: 'Public place',
          ),
          _ConfirmedPlanDivider(),
          _ConfirmedPlanRow(
            icon: Icons.people_outline,
            label: 'Date type',
            value: 'In person',
          ),
          _ConfirmedPlanDivider(),
          _ConfirmedPlanRow(
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

class _ConfirmedPlanDivider extends StatelessWidget {
  const _ConfirmedPlanDivider();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Divider(
        height: 1,
        thickness: 1,
        color: AppColors.intentInputBorder.withValues(alpha: 0.4),
      ),
    );
  }
}

class _ConfirmedPlanRow extends StatelessWidget {
  const _ConfirmedPlanRow({
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
                    fontSize: 13,
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

class DateSetConfirmedReminderSection extends StatelessWidget {
  const DateSetConfirmedReminderSection({super.key});

  static const _cardBg = Color(0xFFFDF8F2);
  static const _accentCircle = Color(0xFFF9EFE5);
  static const _accentBell = Color(0xFFA68A78);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 18),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: AppColors.intentInputBorder.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Date reminder',
                      style: IntentLoginStyles.onboardingSectionTitle.copyWith(
                        fontSize: 20,
                        color: AppColors.intentText,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'We’ll remind you before the date so you can review the '
                      'plan and safety tools.',
                      style: IntentLoginStyles.onboardingSubtitle.copyWith(
                        fontSize: 14,
                        height: 1.45,
                        color: AppColors.intentTextSoft,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Container(
                width: 44,
                height: 44,
                decoration: const BoxDecoration(
                  color: _accentCircle,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.notifications,
                  size: 22,
                  color: _accentBell,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(24),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.notifications_none_outlined,
                      size: 20,
                      color: AppColors.intentTextSoft,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Reminder set',
                      style: IntentLoginStyles.onboardingCardFieldLabel
                          .copyWith(fontSize: 16),
                    ),
                    const Spacer(),
                    Text(
                      '1 hour before',
                      style: IntentLoginStyles.onboardingSubtitle.copyWith(
                        fontSize: 14,
                        color: AppColors.intentTextSoft,
                      ),
                    ),
                    const SizedBox(width: 4),
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
        ],
      ),
    );
  }
}

class DateSetConfirmedSafetyToolsSection extends StatelessWidget {
  const DateSetConfirmedSafetyToolsSection({super.key});

  static const _iconCircleBg = Color(0xFFF5EDE3);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Safety tools',
          style: IntentLoginStyles.onboardingSectionTitle.copyWith(
            fontSize: 20,
            color: AppColors.intentText,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: AppColors.intentInputBorder.withValues(alpha: 0.4),
            ),
            boxShadow: AppShadows.intentInput,
          ),
          child: Column(
            children: [
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: const [
                    Expanded(
                      child: _SafetyToolTile(
                        icon: Icons.flag_outlined,
                        title: 'Report',
                        subtitle: 'Tell us about unsafe behavior',
                        iconBackground: _iconCircleBg,
                      ),
                    ),
                    Expanded(
                      child: _SafetyToolTile(
                        icon: Icons.groups_outlined,
                        title: 'Block',
                        subtitle: 'Stop contact from this match',
                        iconBackground: _iconCircleBg,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 1,
                thickness: 1,
                color: AppColors.intentInputBorder.withValues(alpha: 0.35),
              ),
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: const [
                    Expanded(
                      child: _SafetyToolTile(
                        icon: Icons.verified_user_outlined,
                        title: 'Safety Center',
                        subtitle: 'Review safe dating guidance',
                        iconBackground: _iconCircleBg,
                      ),
                    ),
                    Expanded(
                      child: _SafetyToolTile(
                        icon: Icons.notifications_none_outlined,
                        title: 'Date Reminder',
                        subtitle: 'Manage reminders and plan updates',
                        iconBackground: _iconCircleBg,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SafetyToolTile extends StatelessWidget {
  const _SafetyToolTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.iconBackground,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Color iconBackground;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 16, 10, 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: iconBackground,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 18,
                  color: AppColors.intentText,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: IntentLoginStyles.onboardingCardFieldLabel
                          .copyWith(fontSize: 14),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      subtitle,
                      style: IntentLoginStyles.onboardingSubtitle.copyWith(
                        fontSize: 11,
                        height: 1.35,
                        color: AppColors.intentTextSoft,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                size: 18,
                color: AppColors.intentTextSoft.withValues(alpha: 0.75),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DateSetConfirmedSafetyTip extends StatelessWidget {
  const DateSetConfirmedSafetyTip({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F0D8),
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
            child: Icon(
              Icons.favorite_border,
              size: 18,
              color: AppColors.intentGold.withValues(alpha: 0.95),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'For first dates, meet in a public place, keep plans inside '
              'Intent, and let someone you trust know where you’ll be. You '
              'can report, block, or update plans anytime.',
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

class DateSetConfirmedBackToChatButton extends StatelessWidget {
  const DateSetConfirmedBackToChatButton({super.key, this.onPressed});

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
          child: Text(
            'Continue',
            style: IntentLoginStyles.onboardingContinue.copyWith(
              letterSpacing: 0.6,
            ),
          ),
        ),
      ),
    );
  }
}

class DateSetConfirmedViewDetailsLink extends StatelessWidget {
  const DateSetConfirmedViewDetailsLink({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: Text(
          'View date details',
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
