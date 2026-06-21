import 'package:intent_app/presentation/onboarding/data/attachment_style_questions.dart';

class AttachmentStyleState {
  const AttachmentStyleState({
    required this.answers,
    required this.isLoading,
  });

  final Map<int, int> answers;
  final bool isLoading;

  factory AttachmentStyleState.initial() => const AttachmentStyleState(
        answers: {},
        isLoading: false,
      );

  int get answeredCount => answers.length;

  bool get isComplete =>
      answeredCount >= AttachmentStyleQuestions.totalQuestions;

  AttachmentStyleState copyWith({
    Map<int, int>? answers,
    bool? isLoading,
  }) {
    return AttachmentStyleState(
      answers: answers ?? this.answers,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
