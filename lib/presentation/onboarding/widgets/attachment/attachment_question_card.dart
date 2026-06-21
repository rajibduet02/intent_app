import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';
import 'package:intent_app/presentation/onboarding/data/attachment_style_questions.dart';

class AttachmentQuestionCard extends StatelessWidget {
  const AttachmentQuestionCard({
    super.key,
    required this.questionIndex,
    required this.question,
    required this.selectedOptionIndex,
    required this.onOptionSelected,
  });

  final int questionIndex;
  final AttachmentStyleQuestion question;
  final int? selectedOptionIndex;
  final ValueChanged<int> onOptionSelected;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
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
              'QUESTION ${questionIndex + 1} OF ${AttachmentStyleQuestions.totalQuestions}',
              style: IntentLoginStyles.mbtiSectionLabel,
            ),
            const SizedBox(height: 12),
            Text(
              question.question,
              style: IntentLoginStyles.mbtiQuestion,
            ),
            const SizedBox(height: 16),
            for (var i = 0; i < question.options.length; i++) ...[
              if (i > 0) const SizedBox(height: 10),
              _AttachmentOptionButton(
                label: question.options[i],
                isSelected: selectedOptionIndex == i,
                onTap: () => onOptionSelected(i),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _AttachmentOptionButton extends StatelessWidget {
  const _AttachmentOptionButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isSelected
                  ? AppColors.intentGoldMuted.withValues(alpha: 0.6)
                  : AppColors.intentInputBorder.withValues(alpha: 0.5),
            ),
            color: isSelected ? AppColors.intentCreamDeep : AppColors.white,
          ),
          child: Text(label, style: IntentLoginStyles.mbtiOption),
        ),
      ),
    );
  }
}
