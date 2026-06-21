import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';
import 'package:intent_app/presentation/onboarding/data/love_language_options.dart';

class LoveLanguageOptionCard extends StatelessWidget {
  const LoveLanguageOptionCard({
    super.key,
    required this.option,
    required this.rank,
    required this.onTap,
  });

  final LoveLanguageOption option;
  final int? rank;
  final VoidCallback onTap;

  bool get isSelected => rank != null;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isSelected ? AppColors.intentCreamDeep : AppColors.white,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isSelected
                  ? AppColors.intentGold
                  : AppColors.intentInputBorder.withValues(alpha: 0.7),
              width: isSelected ? 1.5 : 1,
            ),
            boxShadow: isSelected ? null : AppShadows.intentInput,
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected
                      ? AppColors.intentGoldMuted.withValues(alpha: 0.35)
                      : AppColors.intentCreamDeep,
                ),
                child: Icon(
                  option.icon,
                  size: 20,
                  color: isSelected
                      ? AppColors.intentGold
                      : AppColors.intentTextSoft,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  option.label,
                  style: IntentLoginStyles.onboardingAssessmentTitle.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              if (isSelected)
                Container(
                  width: 28,
                  height: 28,
                  decoration: const BoxDecoration(
                    color: AppColors.intentGold,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '$rank',
                    style: IntentLoginStyles.onboardingAssessmentTitle.copyWith(
                      color: AppColors.intentForest,
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
