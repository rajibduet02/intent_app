import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intent_app/app/routes/app_router.dart';
import 'package:intent_app/app/routes/app_routes.dart';
import 'package:intent_app/core/utils/auth_snackbar.dart';
import 'package:intent_app/presentation/onboarding/providers/onboarding_2_state.dart';

final onboarding2Provider =
    NotifierProvider<Onboarding2Notifier, Onboarding2State>(
  Onboarding2Notifier.new,
);

class Onboarding2Notifier extends Notifier<Onboarding2State> {
  static const relationshipIntentions = [
    'Long-term relationship',
    'Marriage',
    'Casual dating',
    'Friendship first',
    'Still figuring it out',
    'Other',
  ];

  static const religionBeliefs = [
    'Christianity',
    'Islam',
    'Judaism',
    'Hinduism',
    'Buddhism',
    'Spiritual but not religious',
    'Agnostic',
    'Atheist',
    'Other',
    'Prefer not to say',
  ];

  static const importanceLevels = [
    'Very important',
    'Somewhat important',
    'Not very important',
    "Doesn't matter",
  ];

  @override
  Onboarding2State build() => Onboarding2State.initial();

  void setRelationshipIntention(String? value) {
    state = state.copyWith(relationshipIntention: value);
  }

  void setReligionBeliefs(String? value) {
    state = state.copyWith(religionBeliefs: value);
  }

  void setImportanceLevel(String? value) {
    state = state.copyWith(importanceLevel: value);
  }

  void onBack() {
    appRouter.go(AppRoutes.onboarding1);
  }

  Future<void> submit() async {
    if (state.relationshipIntention == null ||
        state.relationshipIntention!.isEmpty) {
      AuthSnackbar.error('Please select your relationship intention.');
      return;
    }
    if (state.religionBeliefs == null || state.religionBeliefs!.isEmpty) {
      AuthSnackbar.error('Please select your belief or religion.');
      return;
    }
    if (state.importanceLevel == null || state.importanceLevel!.isEmpty) {
      AuthSnackbar.error('Please select how important this is to you.');
      return;
    }
    state = state.copyWith(isLoading: true);
    try {
      appRouter.go(AppRoutes.onboarding3);
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}
