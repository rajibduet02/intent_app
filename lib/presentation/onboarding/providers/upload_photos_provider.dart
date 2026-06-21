import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intent_app/app/routes/app_router.dart';
import 'package:intent_app/app/routes/app_routes.dart';
import 'package:intent_app/presentation/onboarding/providers/upload_photos_state.dart';

final uploadPhotosProvider =
    NotifierProvider<UploadPhotosNotifier, UploadPhotosState>(
  UploadPhotosNotifier.new,
);

class UploadPhotosNotifier extends Notifier<UploadPhotosState> {
  @override
  UploadPhotosState build() => UploadPhotosState.initial();

  void setPhoto(int index, String path) {
    final updated = List<String?>.from(state.photoPaths);
    updated[index] = path;
    state = state.copyWith(
      photoPaths: updated,
      previewPhotoSlotIndex:
          state.previewPhotoSlotIndex ?? index,
    );
  }

  void removePhoto(int index) {
    final updated = List<String?>.from(state.photoPaths);
    updated[index] = null;
    final shouldClearPreview = state.previewPhotoSlotIndex == index;
    state = state.copyWith(
      photoPaths: updated,
      clearPreviewPhotoSlotIndex: shouldClearPreview,
      previewPhotoSlotIndex: shouldClearPreview
          ? _firstUploadedSlot(updated)
          : state.previewPhotoSlotIndex,
    );
  }

  void selectPreviewPhoto(int slotIndex) {
    if (state.photoPaths[slotIndex] == null) {
      return;
    }
    state = state.copyWith(previewPhotoSlotIndex: slotIndex);
  }

  void ensurePreviewSelection() {
    if (state.previewPhotoSlotIndex != null &&
        state.photoPaths[state.previewPhotoSlotIndex!] != null) {
      return;
    }
    state = state.copyWith(
      previewPhotoSlotIndex: _firstUploadedSlot(state.photoPaths),
    );
  }

  int? _firstUploadedSlot(List<String?> paths) {
    for (var i = 0; i < paths.length; i++) {
      if (paths[i] != null) {
        return i;
      }
    }
    return null;
  }

  void onBack() {
    appRouter.go(AppRoutes.photoUnlockIntention);
  }

  void onBackFromPreview() {
    appRouter.go(AppRoutes.uploadPhotos);
  }

  Future<void> submit() async {
    if (!state.canContinue) {
      return;
    }
    state = state.copyWith(
      isLoading: true,
      previewPhotoSlotIndex:
          state.previewPhotoSlotIndex ?? _firstUploadedSlot(state.photoPaths),
    );
    try {
      appRouter.go(AppRoutes.choosePreviewPhotos);
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> savePreviewPhoto() async {
    if (!state.canSavePreview) {
      return;
    }
    state = state.copyWith(isLoading: true);
    try {
      appRouter.go(AppRoutes.uploadId);
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}
