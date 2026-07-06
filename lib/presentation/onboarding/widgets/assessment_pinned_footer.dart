import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';

/// Scroll inset for [AssessmentPinnedFooter] content (excludes outer bottom padding).
const double assessmentPinnedFooterHeight = 48;

class AssessmentPinnedFooter extends StatelessWidget {
  const AssessmentPinnedFooter({
    super.key,
    required this.submitLabel,
    required this.isLoading,
    required this.onSubmit,
    this.submitLabelStyle,
  });

  final String submitLabel;
  final bool isLoading;
  final VoidCallback onSubmit;
  final TextStyle? submitLabelStyle;

  @override
  Widget build(BuildContext context) {
    final labelStyle = submitLabelStyle ?? IntentLoginStyles.mbtiSubmit;

    return SizedBox(
      width: double.infinity,
      height: AppSpacing.primaryButtonHeight,
      child: ElevatedButton(
        onPressed: isLoading ? null : onSubmit,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.intentForest,
          disabledBackgroundColor:
              AppColors.intentForest.withValues(alpha: 0.6),
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(AppSpacing.primaryButtonBorderRadius),
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
            : FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  submitLabel,
                  style: labelStyle,
                  textAlign: TextAlign.center,
                ),
              ),
      ),
    );
  }
}
