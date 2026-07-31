import 'package:intent_app/presentation/onboarding/models/onboarding_phase.dart';

class OnboardingProgressState {
  const OnboardingProgressState({
    required this.phase,
    required this.questionIndex,
    this.questionTotalOverride,
  });

  final OnboardingPhase phase;

  /// 1-based index within the current phase.
  final int questionIndex;

  /// Optional override when a sub-flow uses a different total (e.g. MBTI 16).
  final int? questionTotalOverride;

  int get questionTotal => questionTotalOverride ?? phase.totalQuestions;

  double get progress {
    if (questionTotal <= 0) return 0;
    return (questionIndex / questionTotal).clamp(0.0, 1.0);
  }

  String get phaseLabel => 'Phase ${phase.number} of ${OnboardingPhase.totalPhases}';

  String get questionLabel =>
      '${phase.progressUnit} $questionIndex of $questionTotal';

  factory OnboardingProgressState.initial() => const OnboardingProgressState(
        phase: OnboardingPhase.aboutYou,
        questionIndex: 1,
      );

  OnboardingProgressState copyWith({
    OnboardingPhase? phase,
    int? questionIndex,
    int? questionTotalOverride,
    bool clearQuestionTotalOverride = false,
  }) {
    return OnboardingProgressState(
      phase: phase ?? this.phase,
      questionIndex: questionIndex ?? this.questionIndex,
      questionTotalOverride: clearQuestionTotalOverride
          ? null
          : (questionTotalOverride ?? this.questionTotalOverride),
    );
  }
}
