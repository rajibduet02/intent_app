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
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Ink(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isSelected
                  ? AppColors.intentGoldMuted.withValues(alpha: 0.75)
                  : AppColors.intentInputBorder.withValues(alpha: 0.55),
              width: isSelected ? 1.5 : 1,
            ),
            color: isSelected ? AppColors.intentCreamDeep : AppColors.white,
            boxShadow: AppShadows.intentInput,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
            child: Text(
              text,
              style: IntentLoginStyles.mbtiOption.copyWith(
                fontSize: 15,
                height: 1.4,
                fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
