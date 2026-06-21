class CommunityCommitmentState {
  const CommunityCommitmentState({
    required this.agreements,
    required this.isLoading,
  });

  static const List<String> commitmentItems = [
    'I will be honest in my profile',
    'I will communicate respectfully',
    'I will not pressure others to move off-platform',
    'I understand unsafe behavior can be reported',
    'I understand restricted accounts may lose access',
  ];

  final List<bool> agreements;
  final bool isLoading;

  factory CommunityCommitmentState.initial() {
    return CommunityCommitmentState(
      agreements: List<bool>.filled(commitmentItems.length, false),
      isLoading: false,
    );
  }

  bool get canAgree => agreements.every((agreed) => agreed);

  CommunityCommitmentState copyWith({
    List<bool>? agreements,
    bool? isLoading,
  }) {
    return CommunityCommitmentState(
      agreements: agreements ?? this.agreements,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
