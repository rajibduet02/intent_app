import 'package:intent_app/presentation/onboarding/models/relationship_style.dart';

class RelationshipStyleAssessmentState {
  const RelationshipStyleAssessmentState({
    required this.currentIndex,
    required this.selectedAnswers,
    required this.shuffledAnswerOrder,
    this.result,
  });

  factory RelationshipStyleAssessmentState.initial() =>
      const RelationshipStyleAssessmentState(
        currentIndex: 0,
        selectedAnswers: {},
        shuffledAnswerOrder: {},
      );

  final int currentIndex;
  final Map<String, String> selectedAnswers;
  final Map<String, List<String>> shuffledAnswerOrder;
  final RelationshipStyleResult? result;

  bool get isComplete => selectedAnswers.length >= totalQuestions;

  static const totalQuestions = 16;

  RelationshipStyleAssessmentState copyWith({
    int? currentIndex,
    Map<String, String>? selectedAnswers,
    Map<String, List<String>>? shuffledAnswerOrder,
    RelationshipStyleResult? result,
  }) {
    return RelationshipStyleAssessmentState(
      currentIndex: currentIndex ?? this.currentIndex,
      selectedAnswers: selectedAnswers ?? this.selectedAnswers,
      shuffledAnswerOrder: shuffledAnswerOrder ?? this.shuffledAnswerOrder,
      result: result ?? this.result,
    );
  }
}
