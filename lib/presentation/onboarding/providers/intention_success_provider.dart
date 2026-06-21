import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intent_app/app/routes/app_router.dart';
import 'package:intent_app/app/routes/app_routes.dart';
import 'package:intent_app/presentation/onboarding/providers/intention_success_state.dart';

final intentionSuccessProvider =
    NotifierProvider<IntentionSuccessNotifier, IntentionSuccessState>(
  IntentionSuccessNotifier.new,
);

class IntentionSuccessNotifier extends Notifier<IntentionSuccessState> {
  @override
  IntentionSuccessState build() => const IntentionSuccessState();

  void onBack() {
    appRouter.go(AppRoutes.communityCommitment);
  }

  Future<void> startDiscovering() async {
    state = state.copyWith(isLoading: true);
    try {
      appRouter.go(AppRoutes.discover);
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}
