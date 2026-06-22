import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';

class DiscoverTopBar extends StatelessWidget {
  const DiscoverTopBar({
    super.key,
    this.onNotificationsTap,
    this.onFiltersTap,
  });

  final VoidCallback? onNotificationsTap;
  final VoidCallback? onFiltersTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Discover',
                style: IntentLoginStyles.onboardingTitle.copyWith(fontSize: 30),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'Meet with intention',
                style: IntentLoginStyles.onboardingCardFieldLabel.copyWith(
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'Profiles are shown through compatibility first. Photos unlock '
                'only through the date flow.',
                style: IntentLoginStyles.onboardingSubtitle.copyWith(
                  fontSize: 13,
                  height: 1.45,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Row(
          children: [
            _TopActionButton(
              icon: Icons.tune,
              onTap: onFiltersTap ?? () {},
            ),
            const SizedBox(width: AppSpacing.sm),
            _TopActionButton(
              icon: Icons.notifications_none,
              showNotificationDot: true,
              onTap: onNotificationsTap ?? () {},
            ),
          ],
        ),
      ],
    );
  }
}

class _TopActionButton extends StatelessWidget {
  const _TopActionButton({
    required this.icon,
    required this.onTap,
    this.showNotificationDot = false,
  });

  final IconData icon;
  final VoidCallback onTap;
  final bool showNotificationDot;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.white.withValues(alpha: 0.9),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.intentInputBorder.withValues(alpha: 0.7),
              ),
              boxShadow: AppShadows.intentInput,
            ),
            child: Icon(
              icon,
              size: 20,
              color: AppColors.intentText,
            ),
          ),
          if (showNotificationDot)
            Positioned(
              top: 6,
              right: 8,
              child: Container(
                width: 7,
                height: 7,
                decoration: const BoxDecoration(
                  color: AppColors.intentNotificationDot,
                  shape: BoxShape.circle,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
