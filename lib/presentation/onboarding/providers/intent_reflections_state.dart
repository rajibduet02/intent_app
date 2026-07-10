import 'package:intent_app/presentation/onboarding/data/intent_reflections_questions.dart';

class IntentReflectionsState {
  const IntentReflectionsState({
    required this.currentIndex,
    required this.selectedAnswers,
    required this.shuffledAnswerOrder,
  });

  factory IntentReflectionsState.initial() => const IntentReflectionsState(
        currentIndex: 0,
        selectedAnswers: {},
        shuffledAnswerOrder: {},
      );

  final int currentIndex;
  final Map<String, String> selectedAnswers;
  final Map<String, List<String>> shuffledAnswerOrder;

  bool get isComplete =>
      selectedAnswers.length >= IntentReflectionsQuestions.totalQuestions;

  static const totalQuestions = 10;

  String? selectedAnswerForCurrent(String questionId) =>
      selectedAnswers[questionId];

  IntentReflectionsState copyWith({
    int? currentIndex,
    Map<String, String>? selectedAnswers,
    Map<String, List<String>>? shuffledAnswerOrder,
  }) {
    return IntentReflectionsState(
      currentIndex: currentIndex ?? this.currentIndex,
      selectedAnswers: selectedAnswers ?? this.selectedAnswers,
      shuffledAnswerOrder: shuffledAnswerOrder ?? this.shuffledAnswerOrder,
    );
  }
}
