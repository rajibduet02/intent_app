import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intent_app/app/routes/app_router.dart';
import 'package:intent_app/app/routes/app_routes.dart';
import 'package:intent_app/presentation/onboarding/providers/community_commitment_state.dart';

final communityCommitmentProvider =
    NotifierProvider<CommunityCommitmentNotifier, CommunityCommitmentState>(
  CommunityCommitmentNotifier.new,
);

class CommunityCommitmentNotifier extends Notifier<CommunityCommitmentState> {
  @override
  CommunityCommitmentState build() => CommunityCommitmentState.initial();

  void toggleAgreement(int index) {
    final updated = List<bool>.from(state.agreements);
    updated[index] = !updated[index];
    state = state.copyWith(agreements: updated);
  }

  void onBack() {
    appRouter.go(AppRoutes.faceVerification);
  }

  Future<void> submit() async {
    if (!state.canAgree) {
      return;
    }
    state = state.copyWith(isLoading: true);
    try {
      appRouter.go(AppRoutes.intentionSuccess);
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}
