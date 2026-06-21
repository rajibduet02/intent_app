import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';

/// Safety footer: shield icon + verification copy.
class LoginSafetyFooter extends StatelessWidget {
  const LoginSafetyFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: AppColors.intentGold.withValues(alpha: 0.15),
            shape: BoxShape.circle,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Icon(
                Icons.shield_outlined,
                size: 22,
                color: AppColors.intentGold,
              ),
              Positioned(
                bottom: 8,
                child: Icon(
                  Icons.check,
                  size: 10,
                  color: AppColors.intentGold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text('Your safety matters.', style: IntentLoginStyles.safetyTitle),
        const SizedBox(height: 4),
        Text(
          'ID verification required before browsing.',
          textAlign: TextAlign.center,
          style: IntentLoginStyles.safetySubtitle,
        ),
      ],
    );
  }
}
