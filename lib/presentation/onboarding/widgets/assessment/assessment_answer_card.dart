import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';

class AssessmentAnswerCard extends StatelessWidget {
  const AssessmentAnswerCard({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  final String text;
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
          child: Text(text, style: IntentLoginStyles.mbtiOption),
        ),
      ),
    );
  }
}
