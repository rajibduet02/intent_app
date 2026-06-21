import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';

class DiscoverTopBar extends StatelessWidget {
  const DiscoverTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Intent',
              style: IntentLoginStyles.brandTitle.copyWith(fontSize: 22),
            ),
            const SizedBox(width: 6),
            Icon(
              Icons.favorite_border,
              size: 18,
              color: AppColors.intentText.withValues(alpha: 0.85),
            ),
          ],
        ),
        const Spacer(),
        _TopActionButton(
          icon: Icons.tune,
          onTap: () {},
        ),
        const SizedBox(width: 10),
        _TopActionButton(
          icon: Icons.notifications_none,
          showNotificationDot: true,
          onTap: () {},
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
