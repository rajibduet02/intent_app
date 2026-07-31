import 'package:flutter/material.dart';
import 'package:intent_app/presentation/onboarding/widgets/onboarding_progress_header.dart';

class LoveLanguageHeader extends StatelessWidget {
  const LoveLanguageHeader({
    super.key,
    required this.onBack,
    this.questionLabelOverride,
  });

  final VoidCallback onBack;
  final String? questionLabelOverride;

  @override
  Widget build(BuildContext context) {
    return OnboardingProgressHeader(
      onBack: onBack,
      questionLabelOverride: questionLabelOverride,
    );
  }
}
