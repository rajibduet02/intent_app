import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intent_app/app/routes/app_router.dart';
import 'package:intent_app/app/routes/app_routes.dart';
import 'package:intent_app/presentation/onboarding/data/enneagram_questions.dart';
import 'package:intent_app/presentation/onboarding/providers/enneagram_assessment_state.dart';

final enneagramAssessmentProvider =
    NotifierProvider<EnneagramAssessmentNotifier, EnneagramAssessmentState>(
  EnneagramAssessmentNotifier.new,
);

class EnneagramAssessmentNotifier extends Notifier<EnneagramAssessmentState> {
  @override
  EnneagramAssessmentState build() => EnneagramAssessmentState.initial();

  void selectAnswer(int questionIndex, int optionIndex) {
    final updated = Map<int, int>.from(state.answers)
      ..[questionIndex] = optionIndex;
    state = state.copyWith(answers: updated);
  }

  void onBack() {
    appRouter.go(AppRoutes.mbtiAssessPreview);
  }

  Future<void> submit() async {
    if (state.answeredCount < EnneagramQuestions.totalQuestions) {
      return;
    }
    state = state.copyWith(isLoading: true);
    try {
      appRouter.go(AppRoutes.enneagramAssessPreview);
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}
