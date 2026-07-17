import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intent_app/app/routes/app_router.dart';
import 'package:intent_app/app/routes/app_routes.dart';
import 'package:intent_app/presentation/onboarding/data/intent_reflections_questions.dart';
import 'package:intent_app/presentation/onboarding/data/intent_reflections_scoring.dart';
import 'package:intent_app/presentation/onboarding/providers/intent_reflections_state.dart';
import 'package:intent_app/presentation/onboarding/providers/onboarding_4_provider.dart';

final intentReflectionsProvider =
    NotifierProvider<IntentReflectionsNotifier, IntentReflectionsState>(
  IntentReflectionsNotifier.new,
);

class IntentReflectionsNotifier extends Notifier<IntentReflectionsState> {
  final _random = Random();

  @override
  IntentReflectionsState build() => IntentReflectionsState.initial();

  /// Shuffles display order for [questionId] without changing answer IDs.
  void _reshuffleDisplayedOrder(String questionId) {
    final question = IntentReflectionsQuestions.questions.firstWhere(
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
    final question = IntentReflectionsQuestions.questions.firstWhere(
      (q) => q.id == questionId,
    );
    return question.answers.map((answer) => answer.id).toList();
  }

  void selectAnswer(String questionId, String answerId) {
    // Store original answer ID — never remap based on display position.
    state = state.copyWith(
      selectedAnswers: {
        ...state.selectedAnswers,
        questionId: answerId,
      },
    );
  }

  void onBackFromIntro() {
    appRouter.go(AppRoutes.onboarding4);
  }

  void onBackFromQuestion() {
    if (state.currentIndex == 0) {
      appRouter.go(AppRoutes.intentReflectionsIntro);
      return;
    }
    final previousIndex = state.currentIndex - 1;
    final previousQuestion =
        IntentReflectionsQuestions.questions[previousIndex];
    state = state.copyWith(currentIndex: previousIndex);
    _reshuffleDisplayedOrder(previousQuestion.id);
  }

  void onBackFromResults() {
    goToLastQuestion();
    appRouter.go(AppRoutes.intentReflectionsAssessment);
  }

  void continueFromIntro() {
    if (state.isComplete) {
      if (state.result == null) {
        final result =
            IntentReflectionsScoring.calculate(state.selectedAnswers);
        state = state.copyWith(result: result);
      }
      appRouter.go(AppRoutes.intentReflectionsResults);
      return;
    }

    final resumeIndex = _resumeQuestionIndex();
    final question = IntentReflectionsQuestions.questions[resumeIndex];
    state = state.copyWith(currentIndex: resumeIndex);
    _reshuffleDisplayedOrder(question.id);
    appRouter.go(AppRoutes.intentReflectionsAssessment);
  }

  int _resumeQuestionIndex() {
    for (var i = 0; i < IntentReflectionsQuestions.questions.length; i++) {
      final id = IntentReflectionsQuestions.questions[i].id;
      if (!state.selectedAnswers.containsKey(id)) {
        return i;
      }
    }
    return state.currentIndex.clamp(
      0,
      IntentReflectionsQuestions.totalQuestions - 1,
    );
  }

  void continueFromQuestion() {
    final question =
        IntentReflectionsQuestions.questions[state.currentIndex];
    if (!state.selectedAnswers.containsKey(question.id)) {
      return;
    }

    if (state.currentIndex >= IntentReflectionsQuestions.totalQuestions - 1) {
      final result = IntentReflectionsScoring.calculate(state.selectedAnswers);
      state = state.copyWith(result: result);
      appRouter.go(AppRoutes.intentReflectionsResults);
      return;
    }

    final nextIndex = state.currentIndex + 1;
    final nextQuestion = IntentReflectionsQuestions.questions[nextIndex];
    state = state.copyWith(currentIndex: nextIndex);
    _reshuffleDisplayedOrder(nextQuestion.id);
  }

  void continueFromResults() {
    ref.read(onboarding4Provider.notifier).markIntentReflectionsCompleted();
    appRouter.go(AppRoutes.onboarding4);
  }

  void goToLastQuestion() {
    final lastIndex = IntentReflectionsQuestions.totalQuestions - 1;
    final lastQuestion = IntentReflectionsQuestions.questions[lastIndex];
    state = state.copyWith(currentIndex: lastIndex);
    _reshuffleDisplayedOrder(lastQuestion.id);
  }
}
