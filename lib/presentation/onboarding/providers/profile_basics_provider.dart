import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intent_app/app/routes/app_router.dart';
import 'package:intent_app/app/routes/app_routes.dart';
import 'package:intent_app/core/utils/auth_snackbar.dart';
import 'package:intent_app/presentation/onboarding/providers/profile_basics_state.dart';

final profileBasicsProvider =
    NotifierProvider<ProfileBasicsNotifier, ProfileBasicsState>(
  ProfileBasicsNotifier.new,
);

class ProfileBasicsNotifier extends Notifier<ProfileBasicsState> {
  static const occupations = [
    'Student',
    'Healthcare',
    'Technology',
    'Education',
    'Finance',
    'Creative / Arts',
    'Entrepreneur',
    'Other',
  ];

  @override
  ProfileBasicsState build() => ProfileBasicsState.initial();

  void setGender(OnboardingGender gender) {
    state = state.copyWith(gender: gender);
  }

  void setOccupation(String? occupation) {
    state = state.copyWith(occupation: occupation);
  }

  void setDateOfBirth(DateTime dob) {
    final now = DateTime.now();
    var age = now.year - dob.year;
    if (now.month < dob.month ||
        (now.month == dob.month && now.day < dob.day)) {
      age--;
    }
    state = state.copyWith(dateOfBirth: dob, age: age);
  }

  void onBack() {
    appRouter.go(AppRoutes.phaseAboutYou);
  }

  Future<void> submit({
    required GlobalKey<FormState> formKey,
    required TextEditingController firstNameController,
    required TextEditingController lastNameController,
  }) async {
    if (!(formKey.currentState?.validate() ?? false)) {
      return;
    }
    if (state.dateOfBirth == null) {
      AuthSnackbar.error('Please select your date of birth.');
      return;
    }
    if (state.gender == null) {
      AuthSnackbar.error('Please select how you identify.');
      return;
    }
    if (state.occupation == null || state.occupation!.isEmpty) {
      AuthSnackbar.error('Please select your occupation.');
      return;
    }
    state = state.copyWith(
      isLoading: true,
      firstName: firstNameController.text.trim(),
      lastName: lastNameController.text.trim(),
    );
    try {
      appRouter.go(AppRoutes.relationshipIntention);
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}
