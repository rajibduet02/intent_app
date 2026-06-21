import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';

class OnboardingSelectField extends StatelessWidget {
  const OnboardingSelectField({
    super.key,
    required this.label,
    required this.placeholder,
    required this.onTap,
    this.value,
  });

  final String label;
  final String placeholder;
  final String? value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final hasValue = value != null && value!.isNotEmpty;
    final borderRadius = BorderRadius.circular(12);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: IntentLoginStyles.onboardingCardFieldLabel,
        ),
        const SizedBox(height: 8),
        Material(
          color: AppColors.white,
          borderRadius: borderRadius,
          child: InkWell(
            onTap: onTap,
            borderRadius: borderRadius,
            child: Container(
              width: double.infinity,
              height: AppSpacing.inputFieldHeight,
              padding: AppSpacing.inputFieldContentPadding,
              decoration: BoxDecoration(
                borderRadius: borderRadius,
                border: Border.all(color: AppColors.intentInputBorder),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      hasValue ? value! : placeholder,
                      style: hasValue
                          ? IntentLoginStyles.fieldHint.copyWith(
                              color: AppColors.intentText,
                            )
                          : IntentLoginStyles.fieldHint,
                    ),
                  ),
                  const Icon(
                    Icons.keyboard_arrow_down,
                    color: AppColors.intentTextSoft,
                    size: 22,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
