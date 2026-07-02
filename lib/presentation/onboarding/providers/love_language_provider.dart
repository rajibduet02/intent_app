import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intent_app/app/routes/app_router.dart';
import 'package:intent_app/app/routes/app_routes.dart';
import 'package:intent_app/core/utils/auth_snackbar.dart';
import 'package:intent_app/presentation/onboarding/data/love_language_options.dart';
import 'package:intent_app/presentation/onboarding/providers/love_language_state.dart';

final loveLanguageProvider =
    NotifierProvider<LoveLanguageNotifier, LoveLanguageState>(
  LoveLanguageNotifier.new,
);

class LoveLanguageNotifier extends Notifier<LoveLanguageState> {
  @override
  LoveLanguageState build() => LoveLanguageState.initial();

  void toggleLanguage(LoveLanguageType type) {
    final current = List<LoveLanguageType>.from(state.selectedLanguages);
    final existingIndex = current.indexOf(type);

    if (existingIndex != -1) {
      current.removeAt(existingIndex);
    } else if (current.length < 2) {
      current.add(type);
    } else {
      current[1] = type;
    }

    state = state.copyWith(selectedLanguages: current);
  }

  void setVibeValue(String axisId, double value) {
    final updated = Map<String, double>.from(state.vibeValues)..[axisId] = value;
    state = state.copyWith(vibeValues: updated);
  }

  void onBack() {
    appRouter.go(AppRoutes.attachmentStylePreview);
  }

  Future<void> submit() async {
    if (!state.canContinue) {
      if (state.selectedLanguages.isEmpty) {
        AuthSnackbar.info(
          'Please select your top 2 love languages before continuing.',
        );
      } else {
        AuthSnackbar.info(
          'Please select one more love language. You need 2 total.',
        );
      }
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
