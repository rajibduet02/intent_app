import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';
import 'package:intent_app/presentation/auth/widgets/shared/fixed_background_auth_scaffold.dart';
import 'package:intent_app/presentation/onboarding/models/assessment_question.dart';
import 'package:intent_app/presentation/onboarding/widgets/assessment/assessment_answer_card.dart';
import 'package:intent_app/presentation/onboarding/widgets/mbti/mbti_assessment_header.dart';
import 'package:intent_app/presentation/onboarding/widgets/onboarding_continue_button.dart';

const double assessmentQuestionPinnedFooterHeight = 76;

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
            const SizedBox(height: AppSpacing.xs),
            Text(
              sectionLabel,
              style: IntentLoginStyles.onboardingAssessmentCategory.copyWith(
                color: AppColors.intentGold,
                letterSpacing: 1.4,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 16),
            DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: AppShadows.intentInput,
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      progressLabel.toUpperCase(),
                      style: IntentLoginStyles.mbtiSectionLabel,
                    ),
                    if (question.title.isNotEmpty) ...[
                      const SizedBox(height: 10),
                      Text(
                        question.title,
                        style: IntentLoginStyles.onboardingAssessmentCategory
                            .copyWith(
                          color: AppColors.intentGold,
                          letterSpacing: 1.2,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                    const SizedBox(height: 12),
                    Text(
                      question.prompt.isNotEmpty
                          ? question.prompt
                          : question.title,
                      style: IntentLoginStyles.mbtiQuestion,
                    ),
                    const SizedBox(height: 16),
                    for (var i = 0; i < displayedAnswerIds.length; i++) ...[
                      if (i > 0) const SizedBox(height: 10),
                      AssessmentAnswerCard(
                        text: answersById[displayedAnswerIds[i]]!.text,
                        isSelected: selectedAnswerId == displayedAnswerIds[i],
                        onTap: () => onAnswerSelected(displayedAnswerIds[i]),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
