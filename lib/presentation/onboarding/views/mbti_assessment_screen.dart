import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intent_app/app/theme/theme.dart';
import 'package:intent_app/presentation/auth/widgets/shared/fixed_background_auth_scaffold.dart';
import 'package:intent_app/presentation/onboarding/data/mbti_questions.dart';
import 'package:intent_app/presentation/onboarding/providers/mbti_assessment_provider.dart';
import 'package:intent_app/presentation/onboarding/widgets/mbti/mbti_assessment_header.dart';
import 'package:intent_app/presentation/onboarding/widgets/mbti/mbti_question_card.dart';
import 'package:intent_app/presentation/onboarding/widgets/mbti/mbti_submit_button.dart';

class MbtiAssessmentScreen extends ConsumerWidget {
  const MbtiAssessmentScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(mbtiAssessmentProvider.notifier);
    final state = ref.watch(mbtiAssessmentProvider);
    final questions = MbtiQuestions.sections;
    final total = MbtiQuestions.totalSections;
    final progress = total == 0 ? 0.0 : state.answeredCount / total;
    final isComplete = state.answeredCount >= total;

    return FixedBackgroundAuthScaffold(
      pinnedFooter: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '${state.answeredCount} of $total answered',
                style: IntentLoginStyles.mbtiProgress,
              ),
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(2),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 3,
                backgroundColor: AppColors.intentProgressInactive,
                color: AppColors.intentText,
              ),
            ),
            const SizedBox(height: 12),
            MbtiSubmitButton(
              isLoading: state.isLoading,
              onPressed:
                  isComplete ? () => unawaited(notifier.submit()) : null,
            ),
          ],
        ),
      ),
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24).copyWith(
          bottom: 24 + _mbtiPinnedFooterHeight,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MbtiAssessmentHeader(
              onBack: notifier.onBack,
            ),
            const SizedBox(height: AppSpacing.xs),
            const _Intro(),
            const SizedBox(height: 16),
            for (var i = 0; i < questions.length; i++) ...[
              if (i > 0) const SizedBox(height: 16),
              MbtiQuestionCard(
                sectionIndex: i,
                question: questions[i],
                selectedOptionIndex: state.answers[i],
                onOptionSelected: (optionIndex) =>
                    notifier.selectAnswer(i, optionIndex),
              ),
            ],
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _Intro extends StatelessWidget {
  const _Intro();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Align(
          alignment: Alignment.center,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            decoration: BoxDecoration(
              color: AppColors.intentGoldMuted.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Text(
              '01 PERSONALITY',
              style: IntentLoginStyles.onboardingAssessmentCategory.copyWith(
                color: AppColors.intentGold,
                letterSpacing: 1.6,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'MBTI Assessment',
          textAlign: TextAlign.center,
          style: IntentLoginStyles.onboardingTitle,
        ),
        const SizedBox(height: 10),
        Text(
          'One thoughtful assessment to understand your personality style.',
          textAlign: TextAlign.center,
          style: IntentLoginStyles.onboardingSubtitle,
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.intentInputBorder),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.info_outline,
                color: AppColors.intentGold.withValues(alpha: 0.9),
                size: 20,
              ),
              const SizedBox(width: AppSpacing.xs),
              Expanded(
                child: Text(
                  'Choose the answer that feels most like you. There are no right or wrong answers. Your responses help Intent personalize your experience.',
                  style: IntentLoginStyles.onboardingSubtitle.copyWith(
                    fontSize: 14,
                    height: 1.45,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

const double _mbtiPinnedFooterHeight = 100;
