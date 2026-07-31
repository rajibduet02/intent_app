import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intent_app/app/routes/app_router.dart';
import 'package:intent_app/app/routes/app_routes.dart';
import 'package:intent_app/core/utils/auth_snackbar.dart';
import 'package:intent_app/presentation/onboarding/providers/dealbreaker_and_assessments_state.dart';

class DealbreakersState {
  const DealbreakersState({
    this.selectedDealbreaker,
    required this.isLoading,
  });

  final OnboardingDealbreakerType? selectedDealbreaker;
  final bool isLoading;

  factory DealbreakersState.initial() => const DealbreakersState(isLoading: false);

  DealbreakersState copyWith({
    OnboardingDealbreakerType? selectedDealbreaker,
    bool? isLoading,
  }) {
    return DealbreakersState(
      selectedDealbreaker: selectedDealbreaker ?? this.selectedDealbreaker,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

final dealbreakersProvider =
    NotifierProvider<DealbreakersNotifier, DealbreakersState>(
  DealbreakersNotifier.new,
);

class DealbreakersNotifier extends Notifier<DealbreakersState> {
  @override
  DealbreakersState build() => DealbreakersState.initial();

  void selectDealbreaker(OnboardingDealbreakerType type) {
    state = state.copyWith(selectedDealbreaker: type);
  }

  void onBack() {
    appRouter.go(AppRoutes.familyLifestyleValues);
  }

  Future<void> submit() async {
    if (state.selectedDealbreaker == null) {
      AuthSnackbar.error('Please choose a dealbreaker.');
      return;
    }
    state = state.copyWith(isLoading: true);
    try {
      appRouter.go(AppRoutes.profileOverview);
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}
