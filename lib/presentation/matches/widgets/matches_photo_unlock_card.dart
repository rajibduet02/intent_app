import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';

class MatchesPhotoUnlockCard extends StatelessWidget {
  const MatchesPhotoUnlockCard({
    super.key,
    this.onLearnMore,
  });

  final VoidCallback? onLearnMore;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.intentInputBorder.withValues(alpha: 0.55),
        ),
        boxShadow: AppShadows.intentInput,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.intentForest,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.lock_outline,
              size: 18,
              color: AppColors.white,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Photos unlock on your first date. We believe real '
                  'connection starts before photos.',
                  style: IntentLoginStyles.onboardingSubtitle.copyWith(
                    fontSize: 12,
                    height: 1.45,
                    color: AppColors.intentText,
                  ),
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: _LearnMoreLink(onTap: onLearnMore),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LearnMoreLink extends StatelessWidget {
  const _LearnMoreLink({this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final content = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'LEARN MORE',
          style: IntentLoginStyles.onboardingSubtitle.copyWith(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.4,
            color: AppColors.intentForest,
          ),
        ),
        const SizedBox(width: 2),
        Icon(
          Icons.chevron_right,
          size: 16,
          color: AppColors.intentForest.withValues(alpha: 0.9),
        ),
      ],
    );

    if (onTap == null) {
      return content;
    }

    return GestureDetector(onTap: onTap, child: content);
  }
}
