import 'package:intent_app/presentation/onboarding/data/intent_reflections_questions.dart';
import 'package:intent_app/presentation/onboarding/models/intent_reflection_result.dart';

class IntentReflectionsState {
  const IntentReflectionsState({
    required this.currentIndex,
    required this.selectedAnswers,
    required this.shuffledAnswerOrder,
    this.result,
  });

  factory IntentReflectionsState.initial() => const IntentReflectionsState(
        currentIndex: 0,
        selectedAnswers: {},
        shuffledAnswerOrder: {},
      );

  final int currentIndex;
  final Map<String, String> selectedAnswers;
  final Map<String, List<String>> shuffledAnswerOrder;
  final IntentReflectionsResult? result;

  bool get isComplete =>
      selectedAnswers.length >= IntentReflectionsQuestions.totalQuestions;

  static const totalQuestions = 10;

  String? selectedAnswerForCurrent(String questionId) =>
      selectedAnswers[questionId];

  IntentReflectionsState copyWith({
    int? currentIndex,
    Map<String, String>? selectedAnswers,
    Map<String, List<String>>? shuffledAnswerOrder,
    IntentReflectionsResult? result,
  }) {
    return IntentReflectionsState(
      currentIndex: currentIndex ?? this.currentIndex,
      selectedAnswers: selectedAnswers ?? this.selectedAnswers,
      shuffledAnswerOrder: shuffledAnswerOrder ?? this.shuffledAnswerOrder,
      result: result ?? this.result,
    );
  }
}
