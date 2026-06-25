import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';
import 'package:intent_app/presentation/auth/widgets/shared/fixed_background_auth_scaffold.dart';

class DateHappenHeader extends StatelessWidget {
  const DateHappenHeader({
    super.key,
    required this.onBack,
    this.onShieldTap,
  });

  final VoidCallback onBack;
  final VoidCallback? onShieldTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: Row(
        children: [
          IntentBackButton(onPressed: onBack),
          const Spacer(),
          _CircleHeaderButton(
            onTap: onShieldTap,
            child: const Icon(
              Icons.verified_user_outlined,
              size: 20,
              color: AppColors.intentGold,
            ),
          ),
        ],
      ),
    );
  }
}

class _CircleHeaderButton extends StatelessWidget {
  const _CircleHeaderButton({
    required this.child,
    this.onTap,
  });

  final Widget child;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: AppSpacing.backButtonSize,
        height: AppSpacing.backButtonSize,
        decoration: BoxDecoration(
          color: AppColors.white.withValues(alpha: 0.95),
          shape: BoxShape.circle,
          border: Border.all(
            color: AppColors.intentInputBorder.withValues(alpha: 0.65),
          ),
          boxShadow: AppShadows.intentInput,
        ),
        alignment: Alignment.center,
        child: child,
      ),
    );
  }
}
