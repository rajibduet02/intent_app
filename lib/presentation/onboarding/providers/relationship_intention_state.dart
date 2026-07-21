class RelationshipIntentionState {
  const RelationshipIntentionState({
    this.relationshipIntention,
    this.religionBeliefs,
    this.importanceLevel,
    required this.isLoading,
  });

  final String? relationshipIntention;
  final String? religionBeliefs;
  final String? importanceLevel;
  final bool isLoading;

  factory RelationshipIntentionState.initial() => const RelationshipIntentionState(
        importanceLevel: 'Very important',
        isLoading: false,
      );

  RelationshipIntentionState copyWith({
    String? relationshipIntention,
    String? religionBeliefs,
    String? importanceLevel,
    bool? isLoading,
  }) {
    return RelationshipIntentionState(
      relationshipIntention:
          relationshipIntention ?? this.relationshipIntention,
      religionBeliefs: religionBeliefs ?? this.religionBeliefs,
      importanceLevel: importanceLevel ?? this.importanceLevel,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
