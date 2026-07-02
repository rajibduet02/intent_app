import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intent_app/app/routes/app_router.dart';
import 'package:intent_app/app/routes/app_routes.dart';
import 'package:intent_app/core/utils/auth_snackbar.dart';
import 'package:intent_app/presentation/onboarding/providers/upload_id_state.dart';

final uploadIdProvider =
    NotifierProvider<UploadIdNotifier, UploadIdState>(UploadIdNotifier.new);

class UploadIdNotifier extends Notifier<UploadIdState> {
  @override
  UploadIdState build() => UploadIdState.initial();

  void setDocument({
    required String path,
    required String name,
    required bool isPdf,
  }) {
    state = state.copyWith(
      documentPath: path,
      documentName: name,
      isPdf: isPdf,
    );
  }

  void clearDocument() {
    state = state.copyWith(clearDocument: true);
  }

  void onBack() {
    appRouter.go(AppRoutes.choosePreviewPhotos);
  }

  Future<void> submit() async {
    if (!state.canSubmit) {
      AuthSnackbar.info(
        'Please upload your ID document before submitting.',
      );
      return;
    }
    state = state.copyWith(isLoading: true);
    try {
      appRouter.go(AppRoutes.safetyStarts);
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}
