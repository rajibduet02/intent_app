import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intent_app/app/routes/app_router.dart';
import 'package:intent_app/app/routes/app_routes.dart';
import 'package:intent_app/core/utils/auth_snackbar.dart';
import 'package:intent_app/presentation/onboarding/data/attachment_style_questions.dart';
import 'package:intent_app/presentation/onboarding/providers/attachment_style_state.dart';

final attachmentStyleProvider =
    NotifierProvider<AttachmentStyleNotifier, AttachmentStyleState>(
  AttachmentStyleNotifier.new,
);

class AttachmentStyleNotifier extends Notifier<AttachmentStyleState> {
  @override
  AttachmentStyleState build() => AttachmentStyleState.initial();

  void selectAnswer(int questionIndex, int optionIndex) {
    final updated = Map<int, int>.from(state.answers)
      ..[questionIndex] = optionIndex;
    state = state.copyWith(answers: updated);
  }

  void onBack() {
    appRouter.go(AppRoutes.enneagramAssessPreview);
  }

  Future<void> submit() async {
    if (state.answeredCount < AttachmentStyleQuestions.totalQuestions) {
      if (state.answeredCount == 0) {
        AuthSnackbar.info(
          'Please answer the attachment style questions before viewing your result.',
        );
      } else {
        final remaining =
            AttachmentStyleQuestions.totalQuestions - state.answeredCount;
        AuthSnackbar.info(
          'Please answer all questions before viewing your result. '
          '$remaining remaining.',
        );
      }
      return;
    }
    state = state.copyWith(isLoading: true);
    try {
      appRouter.go(AppRoutes.attachmentStylePreview);
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}
