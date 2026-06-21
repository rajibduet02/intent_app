import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';

class ChatProposeDateCard extends StatelessWidget {
  const ChatProposeDateCard({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(18),
          child: Ink(
            decoration: BoxDecoration(
              color: AppColors.intentForest,
              borderRadius: BorderRadius.circular(18),
              boxShadow: AppShadows.intentInput,
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.white.withValues(alpha: 0.45),
                        width: 1.5,
                      ),
                    ),
                    child: const Icon(
                      Icons.calendar_month_outlined,
                      size: 22,
                      color: AppColors.white,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Propose a Date',
                          style: IntentLoginStyles.onboardingTitle.copyWith(
                            fontSize: 20,
                            color: AppColors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "When the timing feels right, suggest a date through "
                          "Intent's guided date flow.",
                          style: IntentLoginStyles.onboardingSubtitle.copyWith(
                            fontSize: 11,
                            height: 1.4,
                            color: AppColors.white.withValues(alpha: 0.88),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.chevron_right,
                    size: 22,
                    color: AppColors.white.withValues(alpha: 0.9),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
