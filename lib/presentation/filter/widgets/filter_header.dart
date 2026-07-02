import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';
import 'package:intent_app/presentation/auth/widgets/shared/fixed_background_auth_scaffold.dart';

class FilterHeader extends StatelessWidget {
  const FilterHeader({
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
              'Filters',
              textAlign: TextAlign.center,
              style: IntentLoginStyles.onboardingTitle.copyWith(fontSize: 22),
            ),
          ),
          _CircleHeaderButton(
            child: Icon(
              Icons.tune,
              size: 18,
              color: AppColors.intentForest,
            ),
          ),
        ],
      ),
    );
  }
}

class _CircleHeaderButton extends StatelessWidget {
  const _CircleHeaderButton({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
