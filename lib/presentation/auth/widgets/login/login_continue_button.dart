import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';

/// Full-width forest-green Continue button.
class LoginContinueButton extends StatelessWidget {
  const LoginContinueButton({
    super.key,
    required this.onPressed,
    this.isLoading = false,
    this.label = 'CONTINUE',
  });

  final VoidCallback? onPressed;
  final bool isLoading;
  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: AppSpacing.primaryButtonHeight,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.intentForest,
          disabledBackgroundColor: AppColors.intentForest.withValues(alpha: 0.6),
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.primaryButtonBorderRadius),
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
