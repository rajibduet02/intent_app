class Onboarding2State {
  const Onboarding2State({
    this.relationshipIntention,
    this.religionBeliefs,
    this.importanceLevel,
    required this.isLoading,
  });

  final String? relationshipIntention;
  final String? religionBeliefs;
  final String? importanceLevel;
  final bool isLoading;

  factory Onboarding2State.initial() => const Onboarding2State(
        importanceLevel: 'Very important',
        isLoading: false,
      );

  Onboarding2State copyWith({
    String? relationshipIntention,
    String? religionBeliefs,
    String? importanceLevel,
    bool? isLoading,
  }) {
    return Onboarding2State(
      relationshipIntention:
          relationshipIntention ?? this.relationshipIntention,
      religionBeliefs: religionBeliefs ?? this.religionBeliefs,
      importanceLevel: importanceLevel ?? this.importanceLevel,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
