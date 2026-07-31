import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intent_app/presentation/onboarding/models/onboarding_phase.dart';
import 'package:intent_app/presentation/onboarding/providers/onboarding_progress_state.dart';

final onboardingProgressProvider =
    NotifierProvider<OnboardingProgressNotifier, OnboardingProgressState>(
  OnboardingProgressNotifier.new,
);

class OnboardingProgressNotifier extends Notifier<OnboardingProgressState> {
  @override
  OnboardingProgressState build() => OnboardingProgressState.initial();

  void setPhase(OnboardingPhase phase, {int questionIndex = 1}) {
    state = OnboardingProgressState(
      phase: phase,
      questionIndex: questionIndex,
    );
  }

  void setQuestion({
    required int index,
    int? totalOverride,
  }) {
    state = state.copyWith(
      questionIndex: index,
      questionTotalOverride: totalOverride,
      clearQuestionTotalOverride: totalOverride == null,
    );
  }

  void sync({
    required OnboardingPhase phase,
    required int questionIndex,
    int? questionTotalOverride,
  }) {
    state = OnboardingProgressState(
      phase: phase,
      questionIndex: questionIndex,
      questionTotalOverride: questionTotalOverride,
    );
  }
}
