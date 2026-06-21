import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';

class OnboardingValueChip extends StatelessWidget {
  const OnboardingValueChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.intentGold : AppColors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? AppColors.intentGold
                : AppColors.intentInputBorder,
          ),
        ),
        child: Text(
          label,
          style: IntentLoginStyles.onboardingValueChip.copyWith(
            color: AppColors.intentText,
          ),
        ),
      ),
    );
  }
}

class OnboardingLifestyleChip extends StatelessWidget {
  const OnboardingLifestyleChip({
    super.key,
    required this.label,
    required this.onRemove,
  });

  final String label;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 12, right: 4, top: 6, bottom: 6),
      decoration: BoxDecoration(
        color: AppColors.intentSegmentFill,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.intentInputBorder),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label, style: IntentLoginStyles.onboardingLifestyleChip),
          InkWell(
            onTap: onRemove,
            borderRadius: BorderRadius.circular(12),
            child: const Padding(
              padding: EdgeInsets.all(4),
              child: Icon(
                Icons.close,
                size: 16,
                color: AppColors.intentTextSoft,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
