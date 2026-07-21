enum OnboardingDealbreakerType {
  religionBeliefs('Religion / beliefs'),
  childrenFamilyGoals('Children / family goals'),
  relationshipIntention('Relationship intention'),
  lifestyle('Lifestyle'),
  coreValues('Values');

  const OnboardingDealbreakerType(this.label);

  final String label;
}

class DealbreakerAndAssessmentsState {
  const DealbreakerAndAssessmentsState({
    this.selectedDealbreaker,
    required this.isLoading,
    this.corePersonalityCompleted = false,
    this.intentReflectionsCompleted = false,
    this.relationshipStyleCompleted = false,
    this.loveLanguageCompleted = false,
    this.vibeSlidersCompleted = false,
  });

  final OnboardingDealbreakerType? selectedDealbreaker;
  final bool isLoading;
  final bool corePersonalityCompleted;
  final bool intentReflectionsCompleted;
  final bool relationshipStyleCompleted;
  final bool loveLanguageCompleted;
  final bool vibeSlidersCompleted;

  bool get allAssessmentsCompleted =>
      corePersonalityCompleted &&
      intentReflectionsCompleted &&
      relationshipStyleCompleted &&
      loveLanguageCompleted &&
      vibeSlidersCompleted;

  factory DealbreakerAndAssessmentsState.initial() => const DealbreakerAndAssessmentsState(
        isLoading: false,
      );

  DealbreakerAndAssessmentsState copyWith({
    OnboardingDealbreakerType? selectedDealbreaker,
    bool? isLoading,
    bool? corePersonalityCompleted,
    bool? intentReflectionsCompleted,
    bool? relationshipStyleCompleted,
    bool? loveLanguageCompleted,
    bool? vibeSlidersCompleted,
  }) {
    return DealbreakerAndAssessmentsState(
      selectedDealbreaker: selectedDealbreaker ?? this.selectedDealbreaker,
      isLoading: isLoading ?? this.isLoading,
      corePersonalityCompleted:
          corePersonalityCompleted ?? this.corePersonalityCompleted,
      intentReflectionsCompleted:
          intentReflectionsCompleted ?? this.intentReflectionsCompleted,
      relationshipStyleCompleted:
          relationshipStyleCompleted ?? this.relationshipStyleCompleted,
      loveLanguageCompleted:
          loveLanguageCompleted ?? this.loveLanguageCompleted,
      vibeSlidersCompleted:
          vibeSlidersCompleted ?? this.vibeSlidersCompleted,
    );
  }
}
