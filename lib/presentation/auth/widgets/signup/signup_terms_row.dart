import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';

class SignupTermsRow extends StatelessWidget {
  const SignupTermsRow({
    super.key,
    required this.accepted,
    required this.onChanged,
    this.onTermsTap,
    this.onPrivacyTap,
  });

  final bool accepted;
  final ValueChanged<bool> onChanged;
  final VoidCallback? onTermsTap;
  final VoidCallback? onPrivacyTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: Checkbox(
            value: accepted,
            onChanged: (v) => onChanged(v ?? false),
            activeColor: AppColors.intentForest,
            checkColor: AppColors.white,
            side: const BorderSide(color: AppColors.intentForest, width: 1.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: VisualDensity.compact,
          ),
        ),
        const SizedBox(width: AppSpacing.xs),
        Expanded(
          child: GestureDetector(
            onTap: () => onChanged(!accepted),
            behavior: HitTestBehavior.opaque,
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text('I agree to the ', style: IntentLoginStyles.termsBody),
                GestureDetector(
                  onTap: onTermsTap,
                  child: Text(
                    'Terms of Service',
                    style: IntentLoginStyles.termsLink,
                  ),
                ),
                Text(' and ', style: IntentLoginStyles.termsBody),
                GestureDetector(
                  onTap: onPrivacyTap,
                  child: Text(
                    'Privacy Policy',
                    style: IntentLoginStyles.termsLink,
                  ),
                ),
                Text('.', style: IntentLoginStyles.termsBody),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
