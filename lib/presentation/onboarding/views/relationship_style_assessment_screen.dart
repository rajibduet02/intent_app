import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:intent_app/presentation/onboarding/data/relationship_style_questions.dart';
import 'package:intent_app/presentation/onboarding/providers/relationship_style_assessment_provider.dart';
import 'package:intent_app/presentation/onboarding/widgets/assessment/assessment_question_screen.dart';

class RelationshipStyleAssessmentScreen extends ConsumerWidget {
  const RelationshipStyleAssessmentScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(relationshipStyleAssessmentProvider.notifier);
    final state = ref.watch(relationshipStyleAssessmentProvider);
    final question =
        RelationshipStyleQuestions.questions[state.currentIndex];
    final displayedAnswerIds = notifier.displayedAnswerIdsFor(question.id);
    final isLastQuestion = state.currentIndex >=
        RelationshipStyleQuestions.totalQuestions - 1;

    return AssessmentQuestionScreen(
      onBack: notifier.onBackFromQuestion,
      progressLabel:
          'Question ${state.currentIndex + 1} of ${RelationshipStyleQuestions.totalQuestions}',
      sectionLabel: question.sectionLabel,
      question: question,
      displayedAnswerIds: displayedAnswerIds,
      selectedAnswerId: state.selectedAnswers[question.id],
      onAnswerSelected: (answerId) =>
          notifier.selectAnswer(question.id, answerId),
      onContinue: notifier.continueFromQuestion,
      // continueLabel: isLastQuestion ? 'SEE RESULTS' : 'NEXT',
      continueLabel: isLastQuestion ? 'CONTINUE' : 'NEXT',
      assessmentIndex: 3,
    );
  }
}
