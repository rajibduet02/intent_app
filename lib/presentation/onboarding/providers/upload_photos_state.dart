class UploadPhotosState {
  const UploadPhotosState({
    required this.photoPaths,
    required this.previewPhotoSlotIndex,
    required this.isLoading,
  });

  static const int totalSlots = 6;
  static const int minimumPhotos = 3;

  final List<String?> photoPaths;
  final int? previewPhotoSlotIndex;
  final bool isLoading;

  factory UploadPhotosState.initial() {
    return UploadPhotosState(
      photoPaths: List<String?>.filled(totalSlots, null),
      previewPhotoSlotIndex: null,
      isLoading: false,
    );
  }

  int get photoCount => photoPaths.where((path) => path != null).length;

  bool get canContinue => photoCount >= minimumPhotos;

  bool get canSavePreview => previewPhotoSlotIndex != null;

  List<MapEntry<int, String>> get uploadedPhotos {
    return photoPaths
        .asMap()
        .entries
        .where((entry) => entry.value != null)
        .map((entry) => MapEntry(entry.key, entry.value!))
        .toList();
  }

  double get progress =>
      (photoCount / minimumPhotos).clamp(0.0, 1.0).toDouble();

  UploadPhotosState copyWith({
    List<String?>? photoPaths,
    int? previewPhotoSlotIndex,
    bool? isLoading,
    bool clearPreviewPhotoSlotIndex = false,
  }) {
    return UploadPhotosState(
      photoPaths: photoPaths ?? this.photoPaths,
      previewPhotoSlotIndex: clearPreviewPhotoSlotIndex
          ? null
          : previewPhotoSlotIndex ?? this.previewPhotoSlotIndex,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
