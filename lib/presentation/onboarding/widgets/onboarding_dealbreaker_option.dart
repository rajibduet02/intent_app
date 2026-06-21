import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';

class OnboardingDealbreakerOption extends StatelessWidget {
  const OnboardingDealbreakerOption({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.showDivider = true,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      label,
                      style: IntentLoginStyles.onboardingDealbreaker,
                    ),
                  ),
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isSelected
                          ? AppColors.intentForest
                          : AppColors.white,
                      border: Border.all(
                        color: isSelected
                            ? AppColors.intentForest
                            : AppColors.intentInputBorder,
                      ),
                    ),
                    child: isSelected
                        ? const Icon(
                            Icons.check,
                            size: 14,
                            color: AppColors.white,
                          )
                        : null,
                  ),
                ],
              ),
            ),
          ),
        ),
        if (showDivider)
          const Divider(
            height: 1,
            thickness: 1,
            color: AppColors.intentInputBorder,
            indent: 16,
            endIndent: 16,
          ),
      ],
    );
  }
}

class OnboardingPlusNote extends StatelessWidget {
  const OnboardingPlusNote({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.lock_outline,
          size: 14,
          color: AppColors.intentGold.withValues(alpha: 0.9),
        ),
        const SizedBox(width: 6),
        Flexible(
          child: Text(
            'Connection Plus users can add more dealbreakers',
            textAlign: TextAlign.center,
            style: IntentLoginStyles.onboardingPlusNote,
          ),
        ),
      ],
    );
  }
}
