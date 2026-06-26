import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';

class OnboardingContinueButton extends StatelessWidget {
  const OnboardingContinueButton({
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

class OnboardingPrivacyNote extends StatelessWidget {
  const OnboardingPrivacyNote({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 2),
          child: Row(
            children: [
              Icon(
                Icons.auto_awesome,
                size: 12,
                color: AppColors.intentGold.withValues(alpha: 0.9),
              ),
              Icon(
                Icons.auto_awesome,
                size: 10,
                color: AppColors.intentGold.withValues(alpha: 0.7),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            'Your information is safe and handled with premium privacy.',
            style: IntentLoginStyles.onboardingPrivacy,
          ),
        ),
      ],
    );
  }
}
