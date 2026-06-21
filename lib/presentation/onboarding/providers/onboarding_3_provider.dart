import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intent_app/app/routes/app_router.dart';
import 'package:intent_app/app/routes/app_routes.dart';
import 'package:intent_app/core/utils/auth_snackbar.dart';
import 'package:intent_app/presentation/onboarding/providers/onboarding_3_state.dart';

final onboarding3Provider =
    NotifierProvider<Onboarding3Notifier, Onboarding3State>(
  Onboarding3Notifier.new,
);

class Onboarding3Notifier extends Notifier<Onboarding3State> {
  static const familyGoals = [
    'Want children someday',
    "Don't want children",
    'Open to children',
    'Already have children',
    'Not sure yet',
    'Prefer not to say',
  ];

  static const lifestyleOptions = [
    'Fitness',
    'Pets',
    'Balanced routine',
    'Travel',
    'Night owl',
    'Early bird',
    'Homebody',
    'Foodie',
    'Outdoors',
    'Creative hobbies',
    'Mindfulness',
  ];

  static const values = [
    'Honesty',
    'Faith',
    'Family',
    'Emotional Maturity',
    'Ambition',
    'Stability',
    'Communication',
    'Loyalty',
    'Growth',
    'Kindness',
    'Humor',
    'Financial Responsibility',
    'Adventure',
    'Peace',
    'Service',
  ];

  static const int minValues = 5;
  static const int maxValues = 8;

  @override
  Onboarding3State build() => Onboarding3State.initial();

  void setFamilyGoal(String? value) {
    state = state.copyWith(familyGoal: value);
  }

  void setIsDealbreaker(bool value) {
    state = state.copyWith(isDealbreaker: value);
  }

  void setLifestylePreferences(Set<String> values) {
    state = state.copyWith(lifestylePreferences: values);
  }

  void removeLifestyle(String value) {
    final updated = Set<String>.from(state.lifestylePreferences)..remove(value);
    state = state.copyWith(lifestylePreferences: updated);
  }

  void toggleValue(String value) {
    final updated = Set<String>.from(state.selectedValues);
    if (updated.contains(value)) {
      updated.remove(value);
    } else {
      updated.add(value);
    }
    state = state.copyWith(selectedValues: updated);
  }

  void onBack() {
    appRouter.go(AppRoutes.onboarding2);
  }

  Future<void> submit() async {
    if (state.familyGoal == null || state.familyGoal!.isEmpty) {
      AuthSnackbar.error('Please select your family goal.');
      return;
    }
    if (state.lifestylePreferences.isEmpty) {
      AuthSnackbar.error('Please choose at least one lifestyle preference.');
      return;
    }
    final valueCount = state.selectedValues.length;
    if (valueCount < minValues || valueCount > maxValues) {
      AuthSnackbar.error('Please select $minValues-$maxValues values.');
      return;
    }
    state = state.copyWith(isLoading: true);
    try {
      appRouter.go(AppRoutes.onboarding4);
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}
