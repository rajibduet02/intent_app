import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';

class ProfileHeroCard extends StatelessWidget {
  const ProfileHeroCard({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: AppShadows.intentInput,
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 18, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: 72,
                      height: 72,
                      decoration: const BoxDecoration(
                        color: AppColors.intentForest,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'J',
                        style: IntentLoginStyles.onboardingContinue.copyWith(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Positioned(
                      top: -2,
                      right: -2,
                      child: Container(
                        width: 22,
                        height: 22,
                        decoration: BoxDecoration(
                          color: AppColors.intentGold,
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.white, width: 2),
                        ),
                        child: const Icon(
                          Icons.star,
                          size: 12,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Julian, 31',
                        style: IntentLoginStyles.onboardingSectionTitle
                            .copyWith(fontSize: 22),
                      ),
                      const SizedBox(height: 6),
                      _MetaChip(
                        icon: Icons.location_on_outlined,
                        label: 'Nearby',
                      ),
                      const SizedBox(height: 4),
                      _MetaChip(
                        icon: Icons.work_outline,
                        label: 'Product Designer',
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.intentForest.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color:
                                AppColors.intentForest.withValues(alpha: 0.18),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 6,
                              height: 6,
                              decoration: const BoxDecoration(
                                color: AppColors.intentForest,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'Verified',
                              style: IntentLoginStyles.onboardingSubtitle
                                  .copyWith(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: AppColors.intentForest,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Divider(
              height: 1,
              color: AppColors.intentInputBorder.withValues(alpha: 0.55),
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Icon(
                  Icons.lock_outline,
                  size: 14,
                  color: AppColors.intentTextSoft,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    'Photos unlock only through the intentional date flow.',
                    style: IntentLoginStyles.onboardingSubtitle.copyWith(
                      fontSize: 11,
                      height: 1.35,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: 0.80,
                      minHeight: 4,
                      backgroundColor: AppColors.intentProgressInactive,
                      color: AppColors.intentText,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  '80% Match',
                  style: IntentLoginStyles.onboardingCardFieldLabel.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _MetaChip extends StatelessWidget {
  const _MetaChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 13, color: AppColors.intentTextSoft),
        const SizedBox(width: 4),
        Text(
          label,
          style: IntentLoginStyles.onboardingSubtitle.copyWith(fontSize: 12),
        ),
      ],
    );
  }
}
