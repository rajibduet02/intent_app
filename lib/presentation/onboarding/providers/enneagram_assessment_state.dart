class EnneagramAssessmentState {
  const EnneagramAssessmentState({
    required this.answers,
    required this.isLoading,
  });

  final Map<int, int> answers;
  final bool isLoading;

  factory EnneagramAssessmentState.initial() => const EnneagramAssessmentState(
        answers: {},
        isLoading: false,
      );

  int get answeredCount => answers.length;

  bool get isComplete => answeredCount >= EnneagramAssessmentState.totalQuestions;

  static const int totalQuestions = 16;

  EnneagramAssessmentState copyWith({
    Map<int, int>? answers,
    bool? isLoading,
  }) {
    return EnneagramAssessmentState(
      answers: answers ?? this.answers,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
