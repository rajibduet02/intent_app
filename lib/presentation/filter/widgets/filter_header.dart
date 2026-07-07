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
          const SizedBox(
            width: AppSpacing.backButtonSize,
            height: AppSpacing.backButtonSize,
          ),
        ],
      ),
    );
  }
}
