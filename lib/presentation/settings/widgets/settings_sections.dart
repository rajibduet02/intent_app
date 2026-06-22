import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';

class SettingsSectionCard extends StatelessWidget {
  const SettingsSectionCard({
    super.key,
    required this.title,
    required this.children,
  });

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: AppShadows.intentInput,
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              style: IntentLoginStyles.onboardingSectionTitle.copyWith(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            ...children,
          ],
        ),
      ),
    );
  }
}

class SettingsNavRow extends StatelessWidget {
  const SettingsNavRow({
    super.key,
    required this.icon,
    required this.label,
    this.subtitle,
    this.onTap,
    this.showDivider = true,
  });

  final IconData icon;
  final String label;
  final String? subtitle;
  final VoidCallback? onTap;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              children: [
                Icon(icon, size: 18, color: AppColors.intentTextSoft),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        label,
                        style: IntentLoginStyles.onboardingCardFieldLabel
                            .copyWith(fontSize: 14),
                      ),
                      if (subtitle != null) ...[
                        const SizedBox(height: 2),
                        Text(
                          subtitle!,
                          style: IntentLoginStyles.onboardingSubtitle.copyWith(
                            fontSize: 12,
                            height: 1.35,
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
        if (showDivider)
          Divider(
            height: 1,
            color: AppColors.intentInputBorder.withValues(alpha: 0.55),
          ),
      ],
    );
  }
}

class SettingsToggleRow extends StatelessWidget {
  const SettingsToggleRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.onChanged,
    this.showDivider = true,
  });

  final IconData icon;
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              Icon(icon, size: 18, color: AppColors.intentTextSoft),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  label,
                  style: IntentLoginStyles.onboardingCardFieldLabel.copyWith(
                    fontSize: 14,
                  ),
                ),
              ),
              Switch.adaptive(
                value: value,
                onChanged: onChanged,
                activeTrackColor:
                    AppColors.intentForest.withValues(alpha: 0.35),
                activeThumbColor: AppColors.intentForest,
              ),
            ],
          ),
        ),
        if (showDivider)
          Divider(
            height: 1,
            color: AppColors.intentInputBorder.withValues(alpha: 0.55),
          ),
      ],
    );
  }
}

class SettingsInfoBanner extends StatelessWidget {
  const SettingsInfoBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFFBF6E8),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.intentGoldMuted.withValues(alpha: 0.4),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.shield_outlined,
            size: 18,
            color: AppColors.intentGold.withValues(alpha: 0.95),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'Intent is built for intentional connection. Manage how your '
              'profile, photos, and notifications work for you.',
              style: IntentLoginStyles.onboardingSubtitle.copyWith(
                fontSize: 12,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SettingsActionButton extends StatelessWidget {
  const SettingsActionButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.style = SettingsActionStyle.primary,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final SettingsActionStyle style;

  @override
  Widget build(BuildContext context) {
    final isDanger = style == SettingsActionStyle.danger;

    if (isDanger) {
      return SizedBox(
        width: double.infinity,
        height: AppSpacing.primaryButtonHeight,
        child: OutlinedButton(
          onPressed: isLoading ? null : onPressed,
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.danger,
            side: BorderSide(color: AppColors.danger.withValues(alpha: 0.65)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                AppSpacing.primaryButtonBorderRadius,
              ),
            ),
          ),
          child: isLoading
              ? const SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text(
                  label,
                  style: IntentLoginStyles.onboardingCardFieldLabel.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.danger,
                  ),
                ),
        ),
      );
    }

    return SizedBox(
      width: double.infinity,
      height: AppSpacing.primaryButtonHeight,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.intentForest,
          disabledBackgroundColor:
              AppColors.intentForest.withValues(alpha: 0.6),
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              AppSpacing.primaryButtonBorderRadius,
            ),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppColors.white,
                ),
              )
            : Text(label, style: IntentLoginStyles.onboardingContinue),
      ),
    );
  }
}

enum SettingsActionStyle { primary, danger }
