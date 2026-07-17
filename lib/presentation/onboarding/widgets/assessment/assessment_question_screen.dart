import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';
import 'package:intent_app/presentation/auth/widgets/shared/fixed_background_auth_scaffold.dart';
import 'package:intent_app/presentation/onboarding/models/assessment_question.dart';
import 'package:intent_app/presentation/onboarding/widgets/assessment/assessment_answer_card.dart';
import 'package:intent_app/presentation/onboarding/widgets/mbti/mbti_assessment_header.dart';
import 'package:intent_app/presentation/onboarding/widgets/onboarding_continue_button.dart';

const double assessmentQuestionPinnedFooterHeight = 76;

/// One question per screen with full-width answer cards.
class AssessmentQuestionScreen extends StatelessWidget {
  const AssessmentQuestionScreen({
    super.key,
    required this.onBack,
    required this.progressLabel,
    required this.sectionLabel,
    required this.question,
    required this.displayedAnswerIds,
    required this.selectedAnswerId,
    required this.onAnswerSelected,
    required this.onContinue,
    this.continueLabel = 'CONTINUE',
  });

  final VoidCallback onBack;
  final String progressLabel;
  final String sectionLabel;
  final AssessmentQuestion question;
  final List<String> displayedAnswerIds;
  final String? selectedAnswerId;
  final ValueChanged<String> onAnswerSelected;
  final VoidCallback onContinue;
  final String continueLabel;

  @override
  Widget build(BuildContext context) {
    final answersById = {
      for (final answer in question.answers) answer.id: answer,
    };
    final prompt = question.prompt.isNotEmpty ? question.prompt : question.title;

    return FixedBackgroundAuthScaffold(
      pinnedFooter: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
        child: OnboardingContinueButton(
          label: continueLabel,
          onPressed: selectedAnswerId != null ? onContinue : null,
        ),
      ),
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24).copyWith(
          bottom: 24 + assessmentQuestionPinnedFooterHeight,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MbtiAssessmentHeader(onBack: onBack),
            const SizedBox(height: AppSpacing.sm),
            Text(
              progressLabel,
              style: IntentLoginStyles.mbtiSectionLabel.copyWith(
                fontWeight: FontWeight.w600,
                letterSpacing: 0.4,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              sectionLabel,
              style: IntentLoginStyles.onboardingAssessmentCategory.copyWith(
                color: AppColors.intentGold,
                letterSpacing: 1.4,
                fontWeight: FontWeight.w700,
              ),
            ),
            if (question.title.isNotEmpty) ...[
              const SizedBox(height: 20),
              Text(
                question.title,
                style: IntentLoginStyles.onboardingTitle.copyWith(
                  fontSize: 22,
                  height: 1.25,
                ),
              ),
            ],
            const SizedBox(height: 12),
            Text(
              prompt,
              style: IntentLoginStyles.mbtiQuestion.copyWith(
                fontSize: 16,
                height: 1.45,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 24),
            for (var i = 0; i < displayedAnswerIds.length; i++) ...[
              if (i > 0) const SizedBox(height: 14),
              AssessmentAnswerCard(
                text: answersById[displayedAnswerIds[i]]!.text,
                isSelected: selectedAnswerId == displayedAnswerIds[i],
                onTap: () => onAnswerSelected(displayedAnswerIds[i]),
              ),
            ],
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
