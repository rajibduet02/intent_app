import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:intent_app/app/theme/theme.dart';

/// Full-width white social sign-in button (Apple / Google).
class LoginSocialButton extends StatelessWidget {
  const LoginSocialButton({
    super.key,
    required this.label,
    required this.iconAsset,
    required this.onPressed,
    this.isLoading = false,
  });

  final String label;
  final String iconAsset;
  final VoidCallback? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: Material(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        elevation: 0,
        shadowColor: Colors.transparent,
        child: InkWell(
          onTap: isLoading ? null : onPressed,
          borderRadius: BorderRadius.circular(14),
          child: Ink(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.intentInputBorder),
              boxShadow: AppShadows.intentSocialButton,
            ),
            child: Center(
              child: isLoading
                  ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.intentForest,
                      ),
                    )
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          iconAsset,
                          width: 20,
                          height: 20,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(width: 12),
                        Text(label, style: IntentLoginStyles.socialButton),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

/// "Or continue with" divider with gold lines.
class LoginOrContinueDivider extends StatelessWidget {
  const LoginOrContinueDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 1,
            color: AppColors.intentDividerGold.withValues(alpha: 0.45),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Or continue with',
            style: IntentLoginStyles.orContinueWith,
          ),
        ),
        Expanded(
          child: Container(
            height: 1,
            color: AppColors.intentDividerGold.withValues(alpha: 0.45),
          ),
        ),
      ],
    );
  }
}
