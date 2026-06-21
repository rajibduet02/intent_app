import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';

class CompatibilityProfilesSection extends StatelessWidget {
  const CompatibilityProfilesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const _ProfileAvatar(
              initial: 'J',
              backgroundColor: AppColors.intentForest,
              foregroundColor: AppColors.white,
            ),
            const SizedBox(width: 12),
            Icon(
              Icons.favorite,
              size: 18,
              color: AppColors.intentGold.withValues(alpha: 0.9),
            ),
            const SizedBox(width: 12),
            const _ProfileAvatar(
              initial: 'Y',
              backgroundColor: Color(0xFFE8DCC8),
              foregroundColor: AppColors.intentTextSoft,
            ),
          ],
        ),
        const SizedBox(height: 14),
        Text(
          'Julian & You',
          style: IntentLoginStyles.onboardingTitle.copyWith(fontSize: 26),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.lock_outline,
              size: 13,
              color: AppColors.intentTextSoft,
            ),
            const SizedBox(width: 5),
            Text(
              'Photos stay private until the date flow',
              style: IntentLoginStyles.onboardingSubtitle.copyWith(
                fontSize: 11,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ProfileAvatar extends StatelessWidget {
  const _ProfileAvatar({
    required this.initial,
    required this.backgroundColor,
    required this.foregroundColor,
  });

  final String initial;
  final Color backgroundColor;
  final Color foregroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 72,
      height: 72,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.intentInputBorder.withValues(alpha: 0.45),
        ),
        boxShadow: AppShadows.intentInput,
      ),
      alignment: Alignment.center,
      child: Text(
        initial,
        style: IntentLoginStyles.onboardingTitle.copyWith(
          fontSize: 28,
          color: foregroundColor,
        ),
      ),
    );
  }
}
