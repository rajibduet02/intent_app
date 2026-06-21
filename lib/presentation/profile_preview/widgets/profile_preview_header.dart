import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';
import 'package:intent_app/presentation/auth/widgets/shared/fixed_background_auth_scaffold.dart';

class ProfilePreviewHeader extends StatelessWidget {
  const ProfilePreviewHeader({
    super.key,
    required this.onBack,
  });

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: Row(
        children: [
          IntentBackButton(onPressed: onBack),
          Expanded(
            child: Text(
              'Profile Preview',
              textAlign: TextAlign.center,
              style: IntentLoginStyles.onboardingCardFieldLabel.copyWith(
                fontSize: 17,
              ),
            ),
          ),
          Container(
            width: AppSpacing.backButtonSize,
            height: AppSpacing.backButtonSize,
            decoration: BoxDecoration(
              color: AppColors.white.withValues(alpha: 0.92),
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.intentInputBorder.withValues(alpha: 0.65),
              ),
              boxShadow: AppShadows.intentInput,
            ),
            child: const Icon(
              Icons.check_circle_outline,
              size: 20,
              color: AppColors.intentForest,
            ),
          ),
        ],
      ),
    );
  }
}
