import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';
import 'package:intent_app/presentation/auth/widgets/login/login_brand_header.dart';
import 'package:intent_app/presentation/auth/widgets/shared/fixed_background_auth_scaffold.dart';

class OnboardingHeader extends StatelessWidget {
  const OnboardingHeader({
    super.key,
    required this.currentStep,
    required this.totalSteps,
    required this.onBack,
    this.logoSize = 36,
    this.showLogo = true,
    this.showProgressDots = true,
  });

  final int currentStep;
  final int totalSteps;
  final VoidCallback onBack;
  final double logoSize;
  final bool showLogo;
  final bool showProgressDots;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: IntentBackButton(onPressed: onBack),
          ),
          if (showLogo) IntentLogo(size: logoSize),
          if (showProgressDots)
            Align(
              alignment: Alignment.centerRight,
              child: _OnboardingProgressDots(
                currentStep: currentStep,
                totalSteps: totalSteps,
              ),
            ),
        ],
      ),
    );
  }
}

class _OnboardingProgressDots extends StatelessWidget {
  const _OnboardingProgressDots({
    required this.currentStep,
    required this.totalSteps,
  });

  final int currentStep;
  final int totalSteps;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < totalSteps; i++) ...[
          if (i > 0) const SizedBox(width: 6),
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: i == currentStep
                  ? AppColors.intentForest
                  : AppColors.intentProgressInactive,
            ),
          ),
        ],
      ],
    );
  }
}
