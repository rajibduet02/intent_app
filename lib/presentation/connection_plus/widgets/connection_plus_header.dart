import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';
import 'package:intent_app/presentation/auth/widgets/shared/fixed_background_auth_scaffold.dart';

class ConnectionPlusHeader extends StatelessWidget {
  const ConnectionPlusHeader({
    super.key,
    required this.onBack,
    this.onStarTap,
  });

  final VoidCallback onBack;
  final VoidCallback? onStarTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: Row(
        children: [
          IntentBackButton(onPressed: onBack),
          Expanded(
            child: Text(
              'Connection Plus',
              textAlign: TextAlign.center,
              style: IntentLoginStyles.onboardingTitle.copyWith(fontSize: 22),
            ),
          ),
          _CircleHeaderButton(
            onTap: onStarTap,
            child: Icon(
              Icons.auto_awesome,
              size: 18,
              color: AppColors.intentGold.withValues(alpha: 0.95),
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
          color: const Color(0xFFF4E8BF),
          shape: BoxShape.circle,
          border: Border.all(
            color: AppColors.intentGoldMuted.withValues(alpha: 0.55),
          ),
          boxShadow: AppShadows.intentInput,
        ),
        alignment: Alignment.center,
        child: child,
      ),
    );
  }
}
