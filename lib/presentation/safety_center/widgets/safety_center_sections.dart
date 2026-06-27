import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';

const _iconBoxBg = Color(0xFFF4F7FB);
const _warningAccent = Color(0xFFB85C3A);
const _supportBadgeBg = Color(0xFFFCEAEA);
const _supportBadgeText = Color(0xFF9E4B4B);

class SafetyCenterIntroSection extends StatelessWidget {
  const SafetyCenterIntroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
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
                'Access tools and guidance designed to help keep your '
                'Intent experience respectful, private, and safe.',
                textAlign: TextAlign.center,
                style: IntentLoginStyles.onboardingSubtitle.copyWith(
                  fontSize: 15,
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
        Center(child: SafetyCenterSupportBadge()),
      ],
    );
  }
}

class SafetyCenterSupportBadge extends StatelessWidget {
  const SafetyCenterSupportBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: _supportBadgeBg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: _supportBadgeText.withValues(alpha: 0.25),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.verified_user_outlined,
            size: 14,
            color: _supportBadgeText,
          ),
          const SizedBox(width: 6),
          Text(
            'Support is always available',
            style: IntentLoginStyles.onboardingSubtitle.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: _supportBadgeText,
            ),
          ),
        ],
      ),
    );
  }
}

class SafetyCenterToolsSection extends StatelessWidget {
  const SafetyCenterToolsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Safety tools',
          style: IntentLoginStyles.onboardingSectionTitle.copyWith(
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppColors.intentInputBorder.withValues(alpha: 0.35),
            ),
            boxShadow: AppShadows.intentInput,
          ),
          child: Column(
            children: const [
              _SafetyListTile(
                icon: Icons.flag_outlined,
                title: 'Report a user',
                subtitle:
                    'Tell us about unsafe, disrespectful, or suspicious behavior.',
              ),
              Divider(height: 1, thickness: 1, color: Color(0x59E0D8CC)),
              _SafetyListTile(
                icon: Icons.person_off_outlined,
                title: 'Block a user',
                subtitle: 'Stop a match from contacting you.',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class SafetyCenterDatingTipsSection extends StatelessWidget {
  const SafetyCenterDatingTipsSection({super.key});

  static const _tips = [
    _TipItem(Icons.people_outline, 'Meet in public places'),
    _TipItem(Icons.lock_outline, 'Keep early plans inside Intent'),
    _TipItem(Icons.verified_user_outlined, 'Tell someone you trust where you\'ll be'),
    _TipItem(Icons.favorite_border, 'Trust your comfort and boundaries'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Dating safety tips',
          style: IntentLoginStyles.onboardingSectionTitle.copyWith(
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppColors.intentInputBorder.withValues(alpha: 0.35),
            ),
            boxShadow: AppShadows.intentInput,
          ),
          child: Column(
            children: [
              for (var i = 0; i < _tips.length; i++) ...[
                if (i > 0)
                  Divider(
                    height: 1,
                    thickness: 1,
                    color: AppColors.intentInputBorder.withValues(alpha: 0.35),
                  ),
                _SafetyListTile(
                  icon: _tips[i].icon,
                  title: _tips[i].title,
                ),
              ],
              Divider(
                height: 1,
                thickness: 1,
                color: AppColors.intentInputBorder.withValues(alpha: 0.35),
              ),
              const _SafetyListTile(
                title: 'View all safety tips',
                showIcon: false,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TipItem {
  const _TipItem(this.icon, this.title);

  final IconData icon;
  final String title;
}

class SafetyCenterOffPlatformWarningCard extends StatelessWidget {
  const SafetyCenterOffPlatformWarningCard({super.key});

  static const _cardRadius = 24.0;
  static const _accentWidth = 7.0;
  static const _iconSize = 44.0;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(_cardRadius),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(_cardRadius),
            boxShadow: AppShadows.intentInput,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(_cardRadius),
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    width: _accentWidth,
                    color: _warningAccent,
                  ),
                  Expanded(
                    child: Container(
                      color: AppColors.white,
                      padding: const EdgeInsets.fromLTRB(18, 20, 14, 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: _iconSize,
                                  height: _iconSize,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFFF3EB),
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  child: Icon(
                                    Icons.warning_amber_outlined,
                                    size: 24,
                                    color: _warningAccent,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Off-platform message warning',
                                        style: IntentLoginStyles
                                            .onboardingSectionTitle
                                            .copyWith(
                                          fontSize: 17,
                                          height: 1.25,
                                          fontWeight: FontWeight.w700,
                                          color: _warningAccent,
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      Text(
                                        'Be careful if someone pressures you '
                                        'to move conversations away from '
                                        'Intent too quickly.',
                                        style: IntentLoginStyles
                                            .onboardingCardFieldLabel
                                            .copyWith(
                                          fontSize: 14,
                                          height: 1.45,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.intentText,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        'Keeping early communication on Intent '
                                        'helps protect comfort, boundaries, '
                                        'and reporting access.',
                                        style: IntentLoginStyles
                                            .onboardingSubtitle
                                            .copyWith(
                                          fontSize: 13,
                                          height: 1.45,
                                          color: AppColors.intentTextSoft,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          Padding(
                            padding: const EdgeInsets.only(top: 2),
                            child: Icon(
                              Icons.chevron_right,
                              size: 22,
                              color: AppColors.intentTextSoft
                                  .withValues(alpha: 0.65),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SafetyCenterRestrictedPolicySection extends StatelessWidget {
  const SafetyCenterRestrictedPolicySection({super.key});

  static const _policies = [
    _PolicyItem(Icons.close, 'Fake or misleading profiles'),
    _PolicyItem(Icons.report_gmailerrorred_outlined, 'Harassment or pressure'),
    _PolicyItem(Icons.shield_outlined, 'Unsafe or repeated reported behavior'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Text(
              'Restricted account policy',
              style: IntentLoginStyles.onboardingSectionTitle.copyWith(
                fontSize: 20,
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              Icons.verified_user_outlined,
              size: 18,
              color: _supportBadgeText.withValues(alpha: 0.85),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppColors.intentInputBorder.withValues(alpha: 0.35),
            ),
            boxShadow: AppShadows.intentInput,
          ),
          child: Column(
            children: [
              for (var i = 0; i < _policies.length; i++) ...[
                if (i > 0)
                  Divider(
                    height: 1,
                    thickness: 1,
                    color: AppColors.intentInputBorder.withValues(alpha: 0.35),
                  ),
                _SafetyListTile(
                  icon: _policies[i].icon,
                  title: _policies[i].title,
                  iconBackground: const Color(0xFFFFF0E0),
                  iconColor: _warningAccent,
                ),
              ],
              Divider(
                height: 1,
                thickness: 1,
                color: AppColors.intentInputBorder.withValues(alpha: 0.35),
              ),
              const _SafetyListTile(
                title: 'Learn about account restrictions',
                showIcon: false,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PolicyItem {
  const _PolicyItem(this.icon, this.title);

  final IconData icon;
  final String title;
}

class SafetyCenterPrivacyNoteCard extends StatelessWidget {
  const SafetyCenterPrivacyNoteCard({super.key});

  @override
  Widget build(BuildContext context) {
    return _SafetyInfoCard(
      icon: Icons.lock_outline,
      body:
          'Your reports stay private. Reporting or blocking someone does not '
          'publicly appear on your profile. Intent reviews safety concerns '
          'privately.',
    );
  }
}

class SafetyCenterEmergencyNoteCard extends StatelessWidget {
  const SafetyCenterEmergencyNoteCard({super.key});

  @override
  Widget build(BuildContext context) {
    return _SafetyInfoCard(
      icon: Icons.health_and_safety_outlined,
      body:
          'If you feel in immediate danger, contact local emergency services '
          'first.',
    );
  }
}

class _SafetyInfoCard extends StatelessWidget {
  const _SafetyInfoCard({
    required this.icon,
    required this.body,
  });

  final IconData icon;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.intentInputBorder.withValues(alpha: 0.4),
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
              color: _iconBoxBg,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              size: 18,
              color: AppColors.intentTextSoft,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              body,
              style: IntentLoginStyles.onboardingSubtitle.copyWith(
                fontSize: 13,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SafetyListTile extends StatelessWidget {
  const _SafetyListTile({
    this.icon,
    required this.title,
    this.subtitle,
    this.showIcon = true,
    this.iconBackground = _iconBoxBg,
    this.iconColor,
  });

  final IconData? icon;
  final String title;
  final String? subtitle;
  final bool showIcon;
  final Color iconBackground;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 14, 12, 14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (showIcon && icon != null) ...[
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: iconBackground,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon,
                    size: 20,
                    color: iconColor ?? AppColors.intentTextSoft,
                  ),
                ),
                const SizedBox(width: 12),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: IntentLoginStyles.onboardingCardFieldLabel
                          .copyWith(fontSize: 15),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        subtitle!,
                        style: IntentLoginStyles.onboardingSubtitle.copyWith(
                          fontSize: 13,
                          height: 1.4,
                          color: AppColors.intentTextSoft,
                        ),
                      ),
                    ],
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
        ),
      ),
    );
  }
}

class SafetyCenterBackButton extends StatelessWidget {
  const SafetyCenterBackButton({super.key, this.onPressed});

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
              // const Icon(
              //   Icons.chevron_left,
              //   color: AppColors.white,
              //   size: 22,
              // ),
              Text(
                'CONTINUE',
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
