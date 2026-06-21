class Onboarding3State {
  const Onboarding3State({
    this.familyGoal,
    required this.isDealbreaker,
    required this.lifestylePreferences,
    required this.selectedValues,
    required this.isLoading,
  });

  final String? familyGoal;
  final bool isDealbreaker;
  final Set<String> lifestylePreferences;
  final Set<String> selectedValues;
  final bool isLoading;

  factory Onboarding3State.initial() => const Onboarding3State(
        isDealbreaker: false,
        lifestylePreferences: {},
        selectedValues: {},
        isLoading: false,
      );

  Onboarding3State copyWith({
    String? familyGoal,
    bool? isDealbreaker,
    Set<String>? lifestylePreferences,
    Set<String>? selectedValues,
    bool? isLoading,
    bool clearFamilyGoal = false,
  }) {
    return Onboarding3State(
      familyGoal: clearFamilyGoal ? null : (familyGoal ?? this.familyGoal),
      isDealbreaker: isDealbreaker ?? this.isDealbreaker,
      lifestylePreferences: lifestylePreferences ?? this.lifestylePreferences,
      selectedValues: selectedValues ?? this.selectedValues,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
