class IntentionSuccessState {
  const IntentionSuccessState({this.isLoading = false});

  final bool isLoading;

  IntentionSuccessState copyWith({bool? isLoading}) {
    return IntentionSuccessState(isLoading: isLoading ?? this.isLoading);
  }
}
