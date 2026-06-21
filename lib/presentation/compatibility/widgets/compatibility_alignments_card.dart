import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';

class CompatibilityAlignmentItem {
  const CompatibilityAlignmentItem({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;
}

class CompatibilityAlignmentsCard extends StatelessWidget {
  const CompatibilityAlignmentsCard({
    super.key,
    required this.items,
  });

  final List<CompatibilityAlignmentItem> items;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: AppShadows.intentInput,
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: const BoxDecoration(
                    color: AppColors.intentForest,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.star_outline,
                    size: 16,
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  'Top Alignments',
                  style: IntentLoginStyles.onboardingCardFieldLabel.copyWith(
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            for (var i = 0; i < items.length; i++) ...[
              if (i > 0)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Divider(
                    height: 1,
                    color: AppColors.intentInputBorder.withValues(alpha: 0.55),
                  ),
                ),
              _AlignmentRow(item: items[i]),
            ],
          ],
        ),
      ),
    );
  }
}

class _AlignmentRow extends StatelessWidget {
  const _AlignmentRow({required this.item});

  final CompatibilityAlignmentItem item;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: AppColors.intentForest.withValues(alpha: 0.08),
            shape: BoxShape.circle,
          ),
          child: Icon(
            item.icon,
            size: 16,
            color: AppColors.intentForest,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.title,
                style: IntentLoginStyles.onboardingCardFieldLabel.copyWith(
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                item.subtitle,
                style: IntentLoginStyles.onboardingSubtitle.copyWith(
                  fontSize: 11,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        const Icon(
          Icons.check_circle,
          size: 18,
          color: AppColors.intentForest,
        ),
      ],
    );
  }
}
