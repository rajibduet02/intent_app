import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';

class CompatibilityDealbreakerItem {
  const CompatibilityDealbreakerItem({
    required this.icon,
    required this.label,
    required this.status,
  });

  final IconData icon;
  final String label;
  final String status;
}

class CompatibilityDealbreakerCard extends StatelessWidget {
  const CompatibilityDealbreakerCard({
    super.key,
    required this.items,
  });

  final List<CompatibilityDealbreakerItem> items;

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
                    Icons.fact_check_outlined,
                    size: 16,
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  'Dealbreaker Status',
                  style: IntentLoginStyles.onboardingCardFieldLabel.copyWith(
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: items.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1.35,
              ),
              itemBuilder: (context, index) {
                return _DealbreakerTile(item: items[index]);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _DealbreakerTile extends StatelessWidget {
  const _DealbreakerTile({required this.item});

  final CompatibilityDealbreakerItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.intentCream.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppColors.intentInputBorder.withValues(alpha: 0.45),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            item.icon,
            size: 16,
            color: AppColors.intentForest,
          ),
          const SizedBox(height: 8),
          Text(
            item.label,
            textAlign: TextAlign.center,
            style: IntentLoginStyles.onboardingAssessmentCategory.copyWith(
              fontSize: 7,
              letterSpacing: 0.8,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: AppColors.intentInputBorder.withValues(alpha: 0.55),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.check_circle,
                  size: 12,
                  color: AppColors.accentBlue,
                ),
                const SizedBox(width: 4),
                Text(
                  item.status,
                  style: IntentLoginStyles.onboardingSubtitle.copyWith(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
