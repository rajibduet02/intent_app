class UploadIdState {
  const UploadIdState({
    required this.documentPath,
    required this.documentName,
    required this.isPdf,
    required this.isLoading,
  });

  final String? documentPath;
  final String? documentName;
  final bool isPdf;
  final bool isLoading;

  factory UploadIdState.initial() {
    return const UploadIdState(
      documentPath: null,
      documentName: null,
      isPdf: false,
      isLoading: false,
    );
  }

  bool get canSubmit => documentPath != null;

  UploadIdState copyWith({
    String? documentPath,
    String? documentName,
    bool? isPdf,
    bool? isLoading,
    bool clearDocument = false,
  }) {
    return UploadIdState(
      documentPath: clearDocument ? null : documentPath ?? this.documentPath,
      documentName: clearDocument ? null : documentName ?? this.documentName,
      isPdf: clearDocument ? false : isPdf ?? this.isPdf,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
