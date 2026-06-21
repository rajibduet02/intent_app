import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';

enum DiscoverActionStyle {
  primary,
  outlined,
  muted,
}

class DiscoverActionButton extends StatelessWidget {
  const DiscoverActionButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
    this.style = DiscoverActionStyle.primary,
    this.showChevron = true,
  });

  final String label;
  final IconData icon;
  final VoidCallback? onPressed;
  final DiscoverActionStyle style;
  final bool showChevron;

  @override
  Widget build(BuildContext context) {
    final isPrimary = style == DiscoverActionStyle.primary;
    final isOutlined = style == DiscoverActionStyle.outlined;

    final backgroundColor = switch (style) {
      DiscoverActionStyle.primary => AppColors.intentForest,
      DiscoverActionStyle.outlined => AppColors.white,
      DiscoverActionStyle.muted => AppColors.intentCreamDeep.withValues(alpha: 0.75),
    };

    final foregroundColor = switch (style) {
      DiscoverActionStyle.primary => AppColors.white,
      DiscoverActionStyle.outlined => AppColors.intentText,
      DiscoverActionStyle.muted => AppColors.intentTextSoft,
    };

    return SizedBox(
      width: double.infinity,
      height: AppSpacing.primaryButtonHeight,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          disabledBackgroundColor: backgroundColor.withValues(alpha: 0.6),
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              AppSpacing.primaryButtonBorderRadius,
            ),
            side: isOutlined
                ? BorderSide(
                    color: AppColors.intentInputBorder.withValues(alpha: 0.85),
                  )
                : BorderSide.none,
          ),
        ),
        child: Row(
          mainAxisAlignment:
              showChevron ? MainAxisAlignment.start : MainAxisAlignment.center,
          children: [
            Icon(icon, size: 20, color: foregroundColor),
            const SizedBox(width: AppSpacing.xs),
            if (showChevron)
              Expanded(
                child: Text(
                  label,
                  style: IntentLoginStyles.onboardingContinue.copyWith(
                    color: foregroundColor,
                    letterSpacing: isPrimary ? 1.0 : 0.2,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            else
              Text(
                label,
                style: IntentLoginStyles.onboardingContinue.copyWith(
                  color: foregroundColor,
                  letterSpacing: isPrimary ? 1.0 : 0.2,
                  fontWeight: FontWeight.w600,
                ),
              ),
            if (showChevron)
              Icon(
                Icons.chevron_right,
                size: 22,
                color: isPrimary
                    ? AppColors.white
                    : AppColors.intentTextSoft,
              ),
          ],
        ),
      ),
    );
  }
}
