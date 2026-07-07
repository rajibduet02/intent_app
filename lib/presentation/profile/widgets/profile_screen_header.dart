import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';
import 'package:intent_app/presentation/auth/widgets/shared/fixed_background_auth_scaffold.dart';

class ProfileScreenHeader extends StatelessWidget {
  const ProfileScreenHeader({
    super.key,
    this.onBack,
    this.title = 'Profile',
    this.onSettings,
    this.trailingIcon = Icons.settings_outlined,
  });

  final VoidCallback? onBack;
  final String title;
  final VoidCallback? onSettings;
  final IconData trailingIcon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: Row(
        children: [
          if (onBack != null)
            IntentBackButton(onPressed: onBack!)
          else
            const SizedBox(
              width: AppSpacing.backButtonSize,
              height: AppSpacing.backButtonSize,
            ),
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: IntentLoginStyles.onboardingTitle.copyWith(fontSize: 22),
            ),
          ),
          if (onSettings != null)
            IconButton(
              onPressed: onSettings,
              padding: EdgeInsets.zero,
              style: IconButton.styleFrom(
                fixedSize: const Size(
                  AppSpacing.backButtonSize,
                  AppSpacing.backButtonSize,
                ),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              icon: Icon(
                trailingIcon,
                size: 22,
                color: AppColors.intentForest,
              ),
            )
          else
            const SizedBox(
              width: AppSpacing.backButtonSize,
              height: AppSpacing.backButtonSize,
            ),
        ],
      ),
    );
  }
}
