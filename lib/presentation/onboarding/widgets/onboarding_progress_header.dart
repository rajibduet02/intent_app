import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intent_app/app/theme/theme.dart';
import 'package:intent_app/presentation/auth/widgets/shared/fixed_background_auth_scaffold.dart';
import 'package:intent_app/presentation/onboarding/providers/onboarding_progress_provider.dart';

/// Reusable macro progress: phase label, animated bar, phase title, question.
class OnboardingProgressHeader extends ConsumerWidget {
  const OnboardingProgressHeader({
    super.key,
    required this.onBack,
    this.showQuestionLabel = true,
    this.phaseTitleOverride,
    this.questionLabelOverride,
  });

  final VoidCallback onBack;
  final bool showQuestionLabel;
  final String? phaseTitleOverride;
  final String? questionLabelOverride;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progress = ref.watch(onboardingProgressProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: 48,
          child: Row(
            children: [
              IntentBackButton(onPressed: onBack),
              const Spacer(),
              Text(
                progress.phaseLabel,
                style: IntentLoginStyles.onboardingStepBanner,
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        ClipRRect(
          borderRadius: BorderRadius.circular(2),
          child: TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0, end: progress.progress),
            duration: AppAnimations.medium,
            curve: AppAnimations.enter,
            builder: (context, value, _) {
              return LinearProgressIndicator(
                value: value,
                minHeight: 3,
                backgroundColor: AppColors.intentProgressInactive,
                color: AppColors.intentGold,
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        Text(
          phaseTitleOverride ?? progress.phase.title,
          textAlign: TextAlign.center,
          style: IntentLoginStyles.onboardingAssessmentCategory.copyWith(
            letterSpacing: 1.2,
            fontWeight: FontWeight.w600,
            color: AppColors.intentGold,
          ),
        ),
        if (showQuestionLabel) ...[
          const SizedBox(height: 6),
          Text(
            questionLabelOverride ?? progress.questionLabel,
            textAlign: TextAlign.center,
            style: IntentLoginStyles.onboardingSubtitle.copyWith(
              fontSize: 12,
            ),
          ),
        ],
      ],
    );
  }
}
