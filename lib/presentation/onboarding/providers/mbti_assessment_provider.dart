import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intent_app/app/routes/app_router.dart';
import 'package:intent_app/app/routes/app_routes.dart';
import 'package:intent_app/core/utils/auth_snackbar.dart';
import 'package:intent_app/presentation/onboarding/data/mbti_questions.dart';
import 'package:intent_app/presentation/onboarding/providers/mbti_assessment_state.dart';

final mbtiAssessmentProvider =
    NotifierProvider<MbtiAssessmentNotifier, MbtiAssessmentState>(
  MbtiAssessmentNotifier.new,
);

class MbtiAssessmentNotifier extends Notifier<MbtiAssessmentState> {
  @override
  MbtiAssessmentState build() => MbtiAssessmentState.initial();

  void selectAnswer(int sectionIndex, int optionIndex) {
    final updated = Map<int, int>.from(state.answers)
      ..[sectionIndex] = optionIndex;
    state = state.copyWith(answers: updated);
  }

  void onBack() {
    appRouter.go(AppRoutes.dealbreakerAndAssessments);
  }

  Future<void> submit() async {
    if (state.answeredCount < MbtiQuestions.totalSections) {
      if (state.answeredCount == 0) {
        AuthSnackbar.info(
          'Please answer the MBTI questions before viewing your result.',
        );
      } else {
        final remaining = MbtiQuestions.totalSections - state.answeredCount;
        AuthSnackbar.info(
          'Please answer all sections before viewing your result. '
          '$remaining remaining.',
        );
      }
      return;
    }
    state = state.copyWith(isLoading: true);
    try {
      appRouter.go(AppRoutes.mbtiAssessPreview);
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}
