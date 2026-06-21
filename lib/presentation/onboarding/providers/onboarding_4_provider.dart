import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intent_app/app/routes/app_router.dart';
import 'package:intent_app/app/routes/app_routes.dart';
import 'package:intent_app/app/theme/app_colors.dart';
import 'package:intent_app/core/utils/auth_snackbar.dart';
import 'package:intent_app/presentation/onboarding/providers/onboarding_4_state.dart';

final onboarding4Provider =
    NotifierProvider<Onboarding4Notifier, Onboarding4State>(
  Onboarding4Notifier.new,
);

class OnboardingAssessmentItem {
  const OnboardingAssessmentItem({
    required this.title,
    required this.category,
    required this.icon,
    required this.iconBackground,
    required this.iconColor,
  });

  final String title;
  final String category;
  final IconData icon;
  final Color iconBackground;
  final Color iconColor;
}

class Onboarding4Notifier extends Notifier<Onboarding4State> {
  static const assessments = [
    OnboardingAssessmentItem(
      title: 'MBTI short assessment',
      category: 'PERSONALITY',
      icon: Icons.psychology_outlined,
      iconBackground: Color(0xFFF5E8D0),
      iconColor: AppColors.intentGold,
    ),
    OnboardingAssessmentItem(
      title: 'Enneagram short assessment',
      category: 'CONNECTION',
      icon: Icons.hub_outlined,
      iconBackground: Color(0xFFE3EFE6),
      iconColor: AppColors.intentForest,
    ),
    OnboardingAssessmentItem(
      title: 'Attachment style assessment',
      category: 'HEART',
      icon: Icons.favorite_outline,
      iconBackground: Color(0xFFF8E8E8),
      iconColor: Color(0xFFB85C5C),
    ),
    OnboardingAssessmentItem(
      title: 'Love language selection',
      category: 'INSIGHT',
      icon: Icons.visibility_outlined,
      iconBackground: Color(0xFFE3EFF3),
      iconColor: Color(0xFF4A8A9A),
    ),
    OnboardingAssessmentItem(
      title: 'Vibe sliders',
      category: 'SPARKLE',
      icon: Icons.auto_awesome_outlined,
      iconBackground: Color(0xFFF8F0D8),
      iconColor: AppColors.intentGold,
    ),
  ];

  @override
  Onboarding4State build() => Onboarding4State.initial();

  void selectDealbreaker(OnboardingDealbreakerType type) {
    state = state.copyWith(selectedDealbreaker: type);
  }

  void onBack() {
    appRouter.go(AppRoutes.onboarding3);
  }

  Future<void> submit() async {
    if (state.selectedDealbreaker == null) {
      AuthSnackbar.error('Please choose a dealbreaker.');
      return;
    }
    state = state.copyWith(isLoading: true);
    try {
      appRouter.go(AppRoutes.mbtiAssessment);
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}
