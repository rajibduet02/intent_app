import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';
import 'package:intent_app/presentation/matches/models/match_profile.dart';

class MatchProfileCard extends StatelessWidget {
  const MatchProfileCard({
    super.key,
    required this.match,
    this.onTap,
    this.onMessageTap,
  });

  final MatchProfile match;
  final VoidCallback? onTap;
  final VoidCallback? onMessageTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
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
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: AppColors.intentSegmentFill,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.intentInputBorder.withValues(alpha: 0.5),
                  ),
                ),
                child: Icon(
                  Icons.person_outline,
                  size: 26,
                  color: AppColors.intentTextSoft.withValues(alpha: 0.7),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${match.name}, ${match.age}',
                      style: IntentLoginStyles.onboardingCardFieldLabel
                          .copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      match.location,
                      style: IntentLoginStyles.onboardingSubtitle.copyWith(
                        fontSize: 11,
                        color: AppColors.intentTextSoft,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE8F0E4),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '${match.compatibilityPercent}% COMPATIBLE',
                            style: IntentLoginStyles.onboardingSubtitle
                                .copyWith(
                              fontSize: 9,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.3,
                              color: AppColors.intentForest,
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '+ ${match.sharedValuesCount} shared values',
                          style: IntentLoginStyles.onboardingSubtitle.copyWith(
                            fontSize: 10,
                            color: AppColors.intentTextSoft,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              InkWell(
                onTap: onMessageTap,
                borderRadius: BorderRadius.circular(22),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.intentInputBorder.withValues(alpha: 0.8),
                    ),
                  ),
                  child: Icon(
                    Icons.chat_bubble_outline,
                    size: 18,
                    color: AppColors.intentTextSoft.withValues(alpha: 0.85),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
