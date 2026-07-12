import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intent_app/app/routes/app_router.dart';
import 'package:intent_app/app/routes/app_routes.dart';
import 'package:intent_app/presentation/onboarding/data/intent_reflections_questions.dart';
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

  void _ensureAllQuestionsShuffled() {
    if (state.shuffledAnswerOrder.length >=
        IntentReflectionsQuestions.totalQuestions) {
      return;
    }

    final shuffled = Map<String, List<String>>.from(state.shuffledAnswerOrder);
    for (final question in IntentReflectionsQuestions.questions) {
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
    appRouter.go(AppRoutes.onboarding4);
  }

  void onBackFromQuestion() {
    if (state.currentIndex == 0) {
      appRouter.go(AppRoutes.intentReflectionsIntro);
      return;
    }
    state = state.copyWith(currentIndex: state.currentIndex - 1);
  }

  void continueFromIntro() {
    _ensureAllQuestionsShuffled();
    state = state.copyWith(currentIndex: 0);
    appRouter.go(AppRoutes.intentReflectionsAssessment);
  }

  void continueFromQuestion() {
    final question =
        IntentReflectionsQuestions.questions[state.currentIndex];
    if (!state.selectedAnswers.containsKey(question.id)) {
      return;
    }

    if (state.currentIndex >= IntentReflectionsQuestions.totalQuestions - 1) {
      ref.read(onboarding4Provider.notifier).markIntentReflectionsCompleted();
      appRouter.go(AppRoutes.onboarding4);
      return;
    }

    state = state.copyWith(currentIndex: state.currentIndex + 1);
  }

  void goToLastQuestion() {
    state = state.copyWith(
      currentIndex: IntentReflectionsQuestions.totalQuestions - 1,
    );
  }
}
