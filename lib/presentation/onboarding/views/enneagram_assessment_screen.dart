import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intent_app/app/theme/theme.dart';
import 'package:intent_app/presentation/auth/widgets/shared/fixed_background_auth_scaffold.dart';
import 'package:intent_app/presentation/onboarding/data/enneagram_questions.dart';
import 'package:intent_app/presentation/onboarding/providers/enneagram_assessment_provider.dart';
import 'package:intent_app/presentation/onboarding/widgets/enneagram/enneagram_assessment_header.dart';
import 'package:intent_app/presentation/onboarding/widgets/enneagram/enneagram_question_card.dart';
import 'package:intent_app/presentation/onboarding/widgets/enneagram/enneagram_result_button.dart';

class EnneagramAssessmentScreen extends ConsumerWidget {
  const EnneagramAssessmentScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(enneagramAssessmentProvider.notifier);
    final state = ref.watch(enneagramAssessmentProvider);
    final questions = EnneagramQuestions.questions;
    final total = EnneagramQuestions.totalQuestions;
    final progress = total == 0 ? 0.0 : state.answeredCount / total;
    final isComplete = state.answeredCount >= total;

    return FixedBackgroundAuthScaffold(
      pinnedFooter: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
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
            EnneagramResultButton(
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
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24).copyWith(
          bottom: 24 + _enneagramPinnedFooterHeight,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            EnneagramAssessmentHeader(
              onBack: notifier.onBack,
            ),
            const SizedBox(height: 24),
            _Intro(),
            const SizedBox(height: 18),
            for (var i = 0; i < questions.length; i++) ...[
              if (i > 0) const SizedBox(height: 16),
              EnneagramQuestionCard(
                questionIndex: i,
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
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            decoration: BoxDecoration(
              color: AppColors.intentGoldMuted.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Text(
              '02 PERSONALITY',
              style: IntentLoginStyles.onboardingAssessmentCategory.copyWith(
                color: AppColors.intentGold,
                letterSpacing: 1.6,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        const SizedBox(height: 14),
        Text(
          'Enneagram Assessment',
          textAlign: TextAlign.center,
          style: IntentLoginStyles.onboardingTitle,
        ),
        const SizedBox(height: 10),
        Text(
          'Discover what drives you in relationships, work, and everyday decisions.',
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
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Choose the answer that feels most like you. There are no right or wrong answers. Your responses help Intent personalize your experience.',
                  style: IntentLoginStyles.onboardingSubtitle.copyWith(
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

const double _enneagramPinnedFooterHeight = 100;

