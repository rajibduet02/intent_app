import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';
import 'package:intent_app/presentation/auth/widgets/shared/fixed_background_auth_scaffold.dart';

class CompatibilityPreviewHeader extends StatelessWidget {
  const CompatibilityPreviewHeader({
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
              'Compatibility Overview',
              textAlign: TextAlign.center,
              style: IntentLoginStyles.onboardingCardFieldLabel.copyWith(
                fontSize: 17,
              ),
            ),
          ),
          Stack(
            clipBehavior: Clip.none,
            children: [
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
                  Icons.person_outline,
                  size: 20,
                  color: AppColors.intentForest,
                ),
              ),
              Positioned(
                top: 2,
                right: 2,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: AppColors.success,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.white, width: 1.5),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
