import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intent_app/app/theme/theme.dart';
import 'package:intent_app/presentation/auth/widgets/shared/fixed_background_auth_scaffold.dart';
import 'package:intent_app/presentation/onboarding/data/attachment_style_questions.dart';
import 'package:intent_app/presentation/onboarding/providers/attachment_style_provider.dart';
import 'package:intent_app/presentation/onboarding/widgets/attachment/attachment_question_card.dart';
import 'package:intent_app/presentation/onboarding/widgets/assessment_pinned_footer.dart';
import 'package:intent_app/presentation/onboarding/widgets/assessment_progress_indicator.dart';
import 'package:intent_app/presentation/onboarding/widgets/attachment/attachment_style_header.dart';

class AttachmentStyleScreen extends ConsumerWidget {
  const AttachmentStyleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(attachmentStyleProvider.notifier);
    final state = ref.watch(attachmentStyleProvider);
    final questions = AttachmentStyleQuestions.questions;
    final total = AttachmentStyleQuestions.totalQuestions;

    return FixedBackgroundAuthScaffold(
      pinnedFooter: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
        child: AssessmentPinnedFooter(
          submitLabel: 'View Attachment Result',
          isLoading: state.isLoading,
          onSubmit: () => unawaited(notifier.submit()),
          submitLabelStyle: IntentLoginStyles.mbtiSubmit.copyWith(
            letterSpacing: 0.4,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24).copyWith(
          bottom: 24 + assessmentPinnedFooterHeight,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AttachmentStyleHeader(onBack: notifier.onBack),
            const SizedBox(height: AppSpacing.xs),
            const _Intro(),
            const SizedBox(height: 16),
            AssessmentProgressIndicator(
              answeredCount: state.answeredCount,
              total: total,
            ),
            const SizedBox(height: 16),
            for (var i = 0; i < questions.length; i++) ...[
              if (i > 0) const SizedBox(height: 16),
              AttachmentQuestionCard(
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
              '03 CONNECTION STYLE',
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
          'Attachment Style',
          textAlign: TextAlign.center,
          style: IntentLoginStyles.onboardingTitle,
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          '“Understand how you connect, communicate, and feel supported in relationships.”',
          textAlign: TextAlign.center,
          style: IntentLoginStyles.onboardingSubtitle.copyWith(
            fontStyle: FontStyle.italic,
            height: 1.5,
          ),
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
                Icons.lightbulb_outline,
                color: AppColors.intentGold.withValues(alpha: 0.9),
                size: 20,
              ),
              const SizedBox(width: AppSpacing.xs),
              Expanded(
                child: Text(
                  'Choose the answer that feels most like you. There are no right or wrong answers.',
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


