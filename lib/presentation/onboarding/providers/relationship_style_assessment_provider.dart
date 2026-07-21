import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intent_app/app/routes/app_router.dart';
import 'package:intent_app/app/routes/app_routes.dart';
import 'package:intent_app/presentation/onboarding/data/relationship_style_questions.dart';
import 'package:intent_app/presentation/onboarding/providers/dealbreaker_and_assessments_provider.dart';
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

  void _reshuffleDisplayedOrder(String questionId) {
    final question = RelationshipStyleQuestions.questions.firstWhere(
      (q) => q.id == questionId,
    );
    final ids = question.answers.map((answer) => answer.id).toList()
      ..shuffle(_random);
    state = state.copyWith(
      shuffledAnswerOrder: {
        ...state.shuffledAnswerOrder,
        questionId: ids,
      },
    );
  }

  /// Read-only display order. Shuffle happens on navigation, never during build.
  List<String> displayedAnswerIdsFor(String questionId) {
    final existing = state.shuffledAnswerOrder[questionId];
    if (existing != null) {
      return existing;
    }
    final question = RelationshipStyleQuestions.questions.firstWhere(
      (q) => q.id == questionId,
    );
    return question.answers.map((answer) => answer.id).toList();
  }

  void selectAnswer(String questionId, String answerId) {
    // Store original answer ID — style mapping stays on the answer object.
    state = state.copyWith(
      selectedAnswers: {
        ...state.selectedAnswers,
        questionId: answerId,
      },
    );
  }

  void onBackFromIntro() {
    appRouter.go(AppRoutes.dealbreakerAndAssessments);
  }

  void onBackFromQuestion() {
    if (state.currentIndex == 0) {
      appRouter.go(AppRoutes.relationshipStyleIntro);
      return;
    }
    final previousIndex = state.currentIndex - 1;
    final previousQuestion =
        RelationshipStyleQuestions.questions[previousIndex];
    state = state.copyWith(currentIndex: previousIndex);
    _reshuffleDisplayedOrder(previousQuestion.id);
  }

  void onBackFromResults() {
    goToLastQuestion();
    appRouter.go(AppRoutes.relationshipStyleAssessment);
  }

  void continueFromIntro() {
    if (state.isComplete) {
      if (state.result == null) {
        final result = RelationshipStyleQuestions.calculateResult(
          state.selectedAnswers,
        );
        state = state.copyWith(result: result);
      }
      appRouter.go(AppRoutes.relationshipStyleResults);
      return;
    }

    final resumeIndex = _resumeQuestionIndex();
    final question = RelationshipStyleQuestions.questions[resumeIndex];
    state = state.copyWith(currentIndex: resumeIndex);
    _reshuffleDisplayedOrder(question.id);
    appRouter.go(AppRoutes.relationshipStyleAssessment);
  }

  int _resumeQuestionIndex() {
    for (var i = 0; i < RelationshipStyleQuestions.questions.length; i++) {
      final id = RelationshipStyleQuestions.questions[i].id;
      if (!state.selectedAnswers.containsKey(id)) {
        return i;
      }
    }
    return state.currentIndex.clamp(
      0,
      RelationshipStyleQuestions.totalQuestions - 1,
    );
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
      appRouter.go(AppRoutes.relationshipStyleResults);
      return;
    }

    final nextIndex = state.currentIndex + 1;
    final nextQuestion = RelationshipStyleQuestions.questions[nextIndex];
    state = state.copyWith(currentIndex: nextIndex);
    _reshuffleDisplayedOrder(nextQuestion.id);
  }

  void continueFromResults() {
    ref.read(dealbreakerAndAssessmentsProvider.notifier).markRelationshipStyleCompleted();
    appRouter.go(AppRoutes.dealbreakerAndAssessments);
  }

  void goToLastQuestion() {
    final lastIndex = RelationshipStyleQuestions.totalQuestions - 1;
    final lastQuestion = RelationshipStyleQuestions.questions[lastIndex];
    state = state.copyWith(currentIndex: lastIndex);
    _reshuffleDisplayedOrder(lastQuestion.id);
  }
}
