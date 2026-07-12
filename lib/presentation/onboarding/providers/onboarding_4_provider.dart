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
      title: 'Core Personality Assessment',
      category: 'PERSONALITY',
      icon: Icons.psychology_outlined,
      iconBackground: Color(0xFFF5E8D0),
      iconColor: AppColors.intentGold,
    ),
    OnboardingAssessmentItem(
      title: 'Intent Reflections',
      category: 'REFLECTION',
      icon: Icons.edit_note_outlined,
      iconBackground: Color(0xFFE8EEF5),
      iconColor: Color(0xFF5A7A9A),
    ),
    OnboardingAssessmentItem(
      title: 'Relationship Style',
      category: 'HEART',
      icon: Icons.favorite_outline,
      iconBackground: Color(0xFFF8E8E8),
      iconColor: Color(0xFFB85C5C),
    ),
    OnboardingAssessmentItem(
      title: 'Love Language Selection',
      category: 'INSIGHT',
      icon: Icons.visibility_outlined,
      iconBackground: Color(0xFFE3EFF3),
      iconColor: Color(0xFF4A8A9A),
    ),
    OnboardingAssessmentItem(
      title: 'Vibe Sliders',
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

  void onAssessmentTap(int index) {
    switch (index) {
      case 0:
        appRouter.go(AppRoutes.mbtiAssessment);
      case 1:
        appRouter.go(AppRoutes.intentReflectionsIntro);
      case 2:
        appRouter.go(AppRoutes.relationshipStyleIntro);
      case 3:
        appRouter.go(AppRoutes.loveLanguage);
      case 4:
        appRouter.go(AppRoutes.relationshipVibe);
      default:
        break;
    }
  }

  void markCorePersonalityCompleted() {
    state = state.copyWith(corePersonalityCompleted: true);
  }

  void markIntentReflectionsCompleted() {
    state = state.copyWith(intentReflectionsCompleted: true);
  }

  void markRelationshipStyleCompleted() {
    state = state.copyWith(relationshipStyleCompleted: true);
  }

  void markLoveLanguageCompleted() {
    state = state.copyWith(loveLanguageCompleted: true);
  }

  void markVibeSlidersCompleted() {
    state = state.copyWith(vibeSlidersCompleted: true);
  }

  Future<void> submit() async {
    if (state.selectedDealbreaker == null) {
      AuthSnackbar.error('Please choose a dealbreaker.');
      return;
    }
    if (!state.allAssessmentsCompleted) {
      AuthSnackbar.info(
        'Please complete all required compatibility assessment sections before continuing.',
      );
      return;
    }
    state = state.copyWith(isLoading: true);
    try {
      appRouter.go(AppRoutes.profileOverview);
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}
