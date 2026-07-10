import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:intent_app/presentation/onboarding/data/intent_reflections_questions.dart';
import 'package:intent_app/presentation/onboarding/providers/intent_reflections_provider.dart';
import 'package:intent_app/presentation/onboarding/widgets/assessment/assessment_question_screen.dart';

class IntentReflectionsAssessmentScreen extends ConsumerWidget {
  const IntentReflectionsAssessmentScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(intentReflectionsProvider.notifier);
    final state = ref.watch(intentReflectionsProvider);
    final question =
        IntentReflectionsQuestions.questions[state.currentIndex];
    final displayedAnswerIds = state.shuffledAnswerOrder[question.id] ??
        question.answers.map((answer) => answer.id).toList();

    return AssessmentQuestionScreen(
      onBack: notifier.onBackFromQuestion,
      progressLabel:
          // 'Reflection ${state.currentIndex + 1} of ${IntentReflectionsQuestions.totalQuestions} — ${question.title}',
          'Reflection ${state.currentIndex + 1} of ${IntentReflectionsQuestions.totalQuestions}',
      sectionLabel: question.sectionLabel,
      question: question,
      displayedAnswerIds: displayedAnswerIds,
      selectedAnswerId: state.selectedAnswers[question.id],
      onAnswerSelected: (answerId) =>
          notifier.selectAnswer(question.id, answerId),
      onContinue: notifier.continueFromQuestion,
    );
  }
}
