import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';
import 'package:intent_app/presentation/auth/widgets/shared/fixed_background_auth_scaffold.dart';

class ChatHeader extends StatelessWidget {
  const ChatHeader({
    super.key,
    required this.onBack,
    this.name = 'Julian',
    this.initial = 'J',
    this.harmonyPercent = 94,
    this.daysLeftToPropose = 23,
  });

  final VoidCallback onBack;
  final String name;
  final String initial;
  final int harmonyPercent;
  final int daysLeftToPropose;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 4, 8, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IntentBackButton(onPressed: onBack),
          const SizedBox(width: 4),
          Container(
            width: 44,
            height: 44,
            decoration: const BoxDecoration(
              color: AppColors.intentForest,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              initial,
              style: IntentLoginStyles.onboardingContinue.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: IntentLoginStyles.onboardingTitle.copyWith(
                    fontSize: 22,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.intentCreamDeep.withValues(alpha: 0.9),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.intentInputBorder.withValues(alpha: 0.55),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.star,
                        size: 12,
                        color: AppColors.intentGold,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '$harmonyPercent% Harmony',
                        style: IntentLoginStyles.onboardingSubtitle.copyWith(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: AppColors.intentText,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today_outlined,
                      size: 12,
                      color: AppColors.intentGoldMuted,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        '$daysLeftToPropose days left to propose a date',
                        style: IntentLoginStyles.onboardingSubtitle.copyWith(
                          fontSize: 11,
                          color: AppColors.intentTextSoft,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 6),
          const _ChatHeaderAction(icon: Icons.favorite_border),
          const SizedBox(width: 6),
          const _ChatHeaderAction(icon: Icons.verified_user_outlined),
          const SizedBox(width: 6),
          const _ChatHeaderAction(icon: Icons.more_horiz),
        ],
      ),
    );
  }
}

class _ChatHeaderAction extends StatelessWidget {
  const _ChatHeaderAction({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: AppColors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppColors.intentInputBorder.withValues(alpha: 0.7),
        ),
        boxShadow: AppShadows.intentInput,
      ),
      child: Icon(
        icon,
        size: 18,
        color: AppColors.intentText,
      ),
    );
  }
}
