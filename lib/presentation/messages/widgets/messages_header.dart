import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';

class MessagesHeader extends StatelessWidget {
  const MessagesHeader({
    super.key,
    this.onSearchTap,
  });

  final VoidCallback? onSearchTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Messages',
                    style: IntentLoginStyles.onboardingTitle.copyWith(
                      fontSize: 30,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Your conversations, all in one place.',
                    style: IntentLoginStyles.onboardingSubtitle.copyWith(
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            _HeaderActionButton(
              icon: Icons.search,
              onTap: onSearchTap,
            ),
          ],
        ),
      ],
    );
  }
}

class _HeaderActionButton extends StatelessWidget {
  const _HeaderActionButton({
    required this.icon,
    this.onTap,
  });

  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () {},
      borderRadius: BorderRadius.circular(12),
      child: Container(
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
    );
  }
}
