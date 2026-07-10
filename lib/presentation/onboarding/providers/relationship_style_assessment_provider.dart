import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intent_app/app/routes/app_router.dart';
import 'package:intent_app/app/routes/app_routes.dart';
import 'package:intent_app/presentation/onboarding/data/relationship_style_questions.dart';
import 'package:intent_app/presentation/onboarding/providers/intent_reflections_provider.dart';
import 'package:intent_app/presentation/onboarding/providers/relationship_style_assessment_state.dart';

final relationshipStyleAssessmentProvider = NotifierProvider<
    RelationshipStyleAssessmentNotifier, RelationshipStyleAssessmentState>(
  RelationshipStyleAssessmentNotifier.new,
);

class RelationshipStyleAssessmentNotifier
    extends Notifier<RelationshipStyleAssessmentState> {
  final _random = Random();

  @override
  RelationshipStyleAssessmentState build() =>
      RelationshipStyleAssessmentState.initial();

  void _ensureAllQuestionsShuffled() {
    if (state.shuffledAnswerOrder.length >=
        RelationshipStyleQuestions.totalQuestions) {
      return;
    }

    final shuffled = Map<String, List<String>>.from(state.shuffledAnswerOrder);
    for (final question in RelationshipStyleQuestions.questions) {
      shuffled.putIfAbsent(question.id, () {
        final ids = question.answers.map((answer) => answer.id).toList()
          ..shuffle(_random);
        return ids;
      });
    }
    state = state.copyWith(shuffledAnswerOrder: shuffled);
  }

  List<String> displayedAnswerIdsFor(String questionId) {
    _ensureAllQuestionsShuffled();
    return state.shuffledAnswerOrder[questionId] ?? [];
  }

  void selectAnswer(String questionId, String answerId) {
    state = state.copyWith(
      selectedAnswers: {
        ...state.selectedAnswers,
        questionId: answerId,
      },
    );
  }

  void onBackFromIntro() {
    ref.read(intentReflectionsProvider.notifier).goToLastQuestion();
    appRouter.go(AppRoutes.intentReflectionsAssessment);
  }

  void onBackFromQuestion() {
    if (state.currentIndex == 0) {
      appRouter.go(AppRoutes.relationshipStyleIntro);
      return;
    }
    state = state.copyWith(currentIndex: state.currentIndex - 1);
  }

  void continueFromIntro() {
    _ensureAllQuestionsShuffled();
    state = state.copyWith(currentIndex: 0);
    appRouter.go(AppRoutes.relationshipStyleAssessment);
  }

  void continueFromQuestion() {
    final question =
        RelationshipStyleQuestions.questions[state.currentIndex];
    if (!state.selectedAnswers.containsKey(question.id)) {
      return;
    }

    if (state.currentIndex >= RelationshipStyleQuestions.totalQuestions - 1) {
      final result = RelationshipStyleQuestions.calculateResult(
        state.selectedAnswers,
      );
      state = state.copyWith(result: result);
      appRouter.go(AppRoutes.loveLanguage);
      return;
    }

    state = state.copyWith(currentIndex: state.currentIndex + 1);
  }

  void goToLastQuestion() {
    state = state.copyWith(
      currentIndex: RelationshipStyleQuestions.totalQuestions - 1,
    );
  }
}
