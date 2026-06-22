import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';
import 'package:intent_app/presentation/auth/widgets/login/login_continue_button.dart';

class MatchesTipsCard extends StatelessWidget {
  const MatchesTipsCard({
    super.key,
    this.onViewTips,
  });

  final VoidCallback? onViewTips;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
      decoration: BoxDecoration(
        color: AppColors.intentCreamDeep.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.intentInputBorder.withValues(alpha: 0.45),
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.white.withValues(alpha: 0.9),
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.intentInputBorder.withValues(alpha: 0.55),
              ),
            ),
            child: Icon(
              Icons.lightbulb_outline,
              size: 22,
              color: AppColors.intentGold.withValues(alpha: 0.95),
            ),
          ),
          const SizedBox(height: 14),
          Text(
            'Keep the conversation going',
            textAlign: TextAlign.center,
            style: IntentLoginStyles.onboardingCardFieldLabel.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Ask intentional questions and build real connection.',
            textAlign: TextAlign.center,
            style: IntentLoginStyles.onboardingSubtitle.copyWith(
              fontSize: 12,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 18),
          LoginContinueButton(
            label: 'VIEW TIPS',
            onPressed: onViewTips,
          ),
        ],
      ),
    );
  }
}
