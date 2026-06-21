enum OnboardingDealbreakerType {
  religionBeliefs('Religion / beliefs'),
  childrenFamilyGoals('Children / family goals'),
  relationshipIntention('Relationship intention'),
  lifestyle('Lifestyle'),
  coreValues('Values');

  const OnboardingDealbreakerType(this.label);

  final String label;
}

class Onboarding4State {
  const Onboarding4State({
    required this.selectedDealbreaker,
    required this.isLoading,
  });

  final OnboardingDealbreakerType selectedDealbreaker;
  final bool isLoading;

  factory Onboarding4State.initial() => const Onboarding4State(
        selectedDealbreaker: OnboardingDealbreakerType.relationshipIntention,
        isLoading: false,
      );

  Onboarding4State copyWith({
    OnboardingDealbreakerType? selectedDealbreaker,
    bool? isLoading,
  }) {
    return Onboarding4State(
      selectedDealbreaker: selectedDealbreaker ?? this.selectedDealbreaker,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
