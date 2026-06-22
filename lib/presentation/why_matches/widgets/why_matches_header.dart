import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';
import 'package:intent_app/presentation/auth/widgets/shared/fixed_background_auth_scaffold.dart';

class WhyMatchesHeader extends StatelessWidget {
  const WhyMatchesHeader({
    super.key,
    required this.onBack,
    this.onSparkleTap,
  });

  final VoidCallback onBack;
  final VoidCallback? onSparkleTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: Row(
        children: [
          IntentBackButton(onPressed: onBack),
          Expanded(
            child: Text(
              'Why You Match',
              textAlign: TextAlign.center,
              style: IntentLoginStyles.onboardingTitle.copyWith(fontSize: 22),
            ),
          ),
          _HeaderIconButton(
            icon: Icons.auto_awesome,
            onTap: onSparkleTap,
          ),
        ],
      ),
    );
  }
}

class _HeaderIconButton extends StatelessWidget {
  const _HeaderIconButton({
    required this.icon,
    this.onTap,
  });

  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: AppSpacing.backButtonSize,
        height: AppSpacing.backButtonSize,
        decoration: BoxDecoration(
          color: AppColors.white.withValues(alpha: 0.92),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: AppColors.intentInputBorder.withValues(alpha: 0.65),
          ),
          boxShadow: AppShadows.intentInput,
        ),
        child: Icon(
          icon,
          size: 18,
          color: AppColors.intentForest,
        ),
      ),
    );
  }
}
