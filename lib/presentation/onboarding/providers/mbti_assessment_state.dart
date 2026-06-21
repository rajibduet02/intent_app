class MbtiAssessmentState {
  const MbtiAssessmentState({
    required this.answers,
    required this.isLoading,
  });

  final Map<int, int> answers;
  final bool isLoading;

  factory MbtiAssessmentState.initial() => const MbtiAssessmentState(
        answers: {},
        isLoading: false,
      );

  int get answeredCount => answers.length;

  MbtiAssessmentState copyWith({
    Map<int, int>? answers,
    bool? isLoading,
  }) {
    return MbtiAssessmentState(
      answers: answers ?? this.answers,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
