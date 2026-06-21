import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intent_app/app/routes/app_router.dart';
import 'package:intent_app/app/routes/app_routes.dart';
import 'package:intent_app/presentation/onboarding/providers/face_verification_state.dart';

final faceVerificationProvider =
    NotifierProvider<FaceVerificationNotifier, FaceVerificationState>(
  FaceVerificationNotifier.new,
);

class FaceVerificationNotifier extends Notifier<FaceVerificationState> {
  @override
  FaceVerificationState build() => FaceVerificationState.initial();

  void setPhase(FaceScanPhase phase, {String? statusLabel}) {
    state = state.copyWith(
      phase: phase,
      statusLabel: statusLabel,
    );
  }

  void setProgress(double progress) {
    state = state.copyWith(scanProgress: progress.clamp(0, 1));
  }

  void completeScan({String? selfiePath}) {
    state = state.copyWith(
      phase: FaceScanPhase.completed,
      selfiePath: selfiePath,
      scanProgress: 1,
      statusLabel: 'Face Verification Successful',
    );
  }

  void resetScan() {
    state = state.copyWith(
      resetScan: true,
      clearSelfie: true,
      phase: FaceScanPhase.idle,
      statusLabel: 'ALIGN FACE',
    );
  }

  void setLoading(bool isLoading) {
    state = state.copyWith(isLoading: isLoading);
  }

  void onBack() {
    appRouter.go(AppRoutes.safetyStarts);
  }

  Future<void> submit() async {
    if (!state.canContinue) {
      return;
    }
    state = state.copyWith(isLoading: true);
    try {
      appRouter.go(AppRoutes.communityCommitment);
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}
