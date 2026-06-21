import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:intent_app/app/theme/theme.dart';
import 'package:intent_app/presentation/auth/widgets/shared/fixed_background_auth_scaffold.dart';
import 'package:intent_app/presentation/onboarding/providers/upload_photos_provider.dart';
import 'package:intent_app/presentation/onboarding/providers/upload_photos_state.dart';
import 'package:intent_app/presentation/onboarding/widgets/onboarding_continue_button.dart';

class UploadPhotosScreen extends ConsumerStatefulWidget {
  const UploadPhotosScreen({super.key});

  @override
  ConsumerState<UploadPhotosScreen> createState() => _UploadPhotosScreenState();
}

class _UploadPhotosScreenState extends ConsumerState<UploadPhotosScreen> {
  final ImagePicker _imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(uploadPhotosProvider.notifier);
    final state = ref.watch(uploadPhotosProvider);

    return FixedBackgroundAuthScaffold(
      pinnedFooter: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
        child: OnboardingContinueButton(
          showArrow: false,
          isLoading: state.isLoading,
          onPressed: state.canContinue
              ? () => unawaited(notifier.submit())
              : null,
        ),
      ),
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24).copyWith(
          bottom: 24 + _pinnedFooterHeight,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _UploadPhotosHeader(onBack: notifier.onBack),
            const SizedBox(height: 20),
            Text(
              'Upload your photos',
              textAlign: TextAlign.center,
              style: IntentLoginStyles.onboardingTitle,
            ),
            const SizedBox(height: 10),
            Text(
              'These photos stay private until the date flow unlocks them.',
              textAlign: TextAlign.center,
              style: IntentLoginStyles.onboardingSubtitle,
            ),
            const SizedBox(height: 14),
            const _PrivateBadge(),
            const SizedBox(height: 20),
            _PhotoUploadCard(
              photoPaths: state.photoPaths,
              photoCount: state.photoCount,
              progress: state.progress,
              onAddPhoto: _pickPhoto,
              onEditPhoto: _pickPhoto,
              onRemovePhoto: notifier.removePhoto,
            ),
            const SizedBox(height: 16),
            const _PrivacyInfoBox(),
          ],
        ),
      ),
    );
  }

  Future<void> _pickPhoto(int slotIndex) async {
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Add photo',
                  style: IntentLoginStyles.fieldLabel.copyWith(fontSize: 16),
                ),
                const SizedBox(height: 8),
                ListTile(
                  leading: const Icon(Icons.photo_camera_outlined),
                  title: const Text('Take Photo'),
                  onTap: () =>
                      Navigator.of(sheetContext).pop(ImageSource.camera),
                ),
                ListTile(
                  leading: const Icon(Icons.photo_library_outlined),
                  title: const Text('Choose from Gallery'),
                  onTap: () =>
                      Navigator.of(sheetContext).pop(ImageSource.gallery),
                ),
              ],
            ),
          ),
        );
      },
    );

    if (!mounted || source == null) {
      return;
    }

    final hasPermission = await _requestPhotoPermission(source);
    if (!mounted) {
      return;
    }
    if (!hasPermission) {
      _showPickerError(
        source == ImageSource.camera
            ? 'Camera permission is required to take a photo.'
            : 'Photo library permission is required to choose a photo.',
      );
      return;
    }

    // Let the bottom sheet finish closing before launching the native picker.
    await Future<void>.delayed(const Duration(milliseconds: 250));
    if (!mounted) {
      return;
    }

    try {
      final picked = await _imagePicker.pickImage(
        source: source,
        imageQuality: 85,
      );

      if (!mounted || picked == null) {
        return;
      }

      ref.read(uploadPhotosProvider.notifier).setPhoto(slotIndex, picked.path);
    } catch (error) {
      if (!mounted) {
        return;
      }
      _showPickerError('Could not open ${source.name}. Please try again.');
    }
  }

  Future<bool> _requestPhotoPermission(ImageSource source) async {
    if (source == ImageSource.camera) {
      final status = await Permission.camera.request();
      return status.isGranted || status.isLimited;
    }

    if (Platform.isIOS) {
      final status = await Permission.photos.request();
      return status.isGranted || status.isLimited;
    }

    final photosStatus = await Permission.photos.request();
    if (photosStatus.isGranted || photosStatus.isLimited) {
      return true;
    }

    final storageStatus = await Permission.storage.request();
    return storageStatus.isGranted;
  }

  void _showPickerError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}

class _UploadPhotosHeader extends StatelessWidget {
  const _UploadPhotosHeader({required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: Row(
        children: [
          IntentBackButton(onPressed: onBack),
          const Spacer(),
          const SizedBox(
            width: AppSpacing.backButtonSize,
            height: AppSpacing.backButtonSize,
            child: Icon(
              Icons.lock_outline,
              size: 20,
              color: AppColors.intentTextSoft,
            ),
          ),
        ],
      ),
    );
  }
}

class _PrivateBadge extends StatelessWidget {
  const _PrivateBadge();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0xFFD5E8D4),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.lock_outline,
              size: 14,
              color: AppColors.intentForest,
            ),
            const SizedBox(width: 6),
            Text(
              'PRIVATE BY DEFAULT',
              style: IntentLoginStyles.onboardingAssessmentCategory.copyWith(
                fontSize: 10,
                letterSpacing: 1.1,
                fontWeight: FontWeight.w700,
                color: AppColors.intentForest,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PhotoUploadCard extends StatelessWidget {
  const _PhotoUploadCard({
    required this.photoPaths,
    required this.photoCount,
    required this.progress,
    required this.onAddPhoto,
    required this.onEditPhoto,
    required this.onRemovePhoto,
  });

  final List<String?> photoPaths;
  final int photoCount;
  final double progress;
  final ValueChanged<int> onAddPhoto;
  final ValueChanged<int> onEditPhoto;
  final ValueChanged<int> onRemovePhoto;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: AppShadows.intentInput,
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 16),
        child: Column(
          children: [
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: UploadPhotosState.totalSlots,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 0.78,
              ),
              itemBuilder: (context, index) {
                final path = photoPaths[index];
                if (path != null) {
                  return _FilledPhotoSlot(
                    imagePath: path,
                    onEdit: () => onEditPhoto(index),
                    onRemove: () => onRemovePhoto(index),
                  );
                }
                return _EmptyPhotoSlot(onTap: () => onAddPhoto(index));
              },
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Text(
                  'MINIMUM 3 PHOTOS REQUIRED',
                  style: IntentLoginStyles.onboardingAssessmentCategory.copyWith(
                    fontSize: 9,
                    letterSpacing: 0.8,
                    fontWeight: FontWeight.w700,
                    color: AppColors.intentText,
                  ),
                ),
                const Spacer(),
                RichText(
                  text: TextSpan(
                    style: IntentLoginStyles.onboardingSubtitle.copyWith(
                      fontSize: 12,
                      color: AppColors.intentText,
                    ),
                    children: [
                      TextSpan(
                        text: '$photoCount of ${UploadPhotosState.minimumPhotos}',
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                      const TextSpan(text: ' added'),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(2),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 4,
                backgroundColor: AppColors.intentProgressInactive,
                color: AppColors.intentForest,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyPhotoSlot extends StatelessWidget {
  const _EmptyPhotoSlot({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.intentSegmentFill,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: CustomPaint(
          painter: _DashedBorderPainter(
            color: AppColors.intentInputBorder,
            radius: 12,
          ),
          child: const SizedBox.expand(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add,
                  size: 22,
                  color: AppColors.intentTextSoft,
                ),
                SizedBox(height: 8),
                Text(
                  'ADD PHOTO',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.8,
                    color: AppColors.intentTextSoft,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FilledPhotoSlot extends StatelessWidget {
  const _FilledPhotoSlot({
    required this.imagePath,
    required this.onEdit,
    required this.onRemove,
  });

  final String imagePath;
  final VoidCallback onEdit;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.file(
            File(imagePath),
            fit: BoxFit.cover,
          ),
          Positioned(
            top: 8,
            right: 8,
            child: Row(
              children: [
                _PhotoActionButton(
                  icon: Icons.edit_outlined,
                  backgroundColor: AppColors.white.withValues(alpha: 0.92),
                  iconColor: AppColors.intentText,
                  onTap: onEdit,
                ),
                const SizedBox(width: 6),
                _PhotoActionButton(
                  icon: Icons.close,
                  backgroundColor: AppColors.danger,
                  iconColor: AppColors.white,
                  onTap: onRemove,
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              color: const Color(0xFFE9C46A),
              child: Text(
                'Unlocks after date proposal',
                textAlign: TextAlign.center,
                style: IntentLoginStyles.onboardingAssessmentCategory.copyWith(
                  fontSize: 8,
                  letterSpacing: 0.2,
                  fontWeight: FontWeight.w600,
                  color: AppColors.intentText,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PhotoActionButton extends StatelessWidget {
  const _PhotoActionButton({
    required this.icon,
    required this.backgroundColor,
    required this.iconColor,
    required this.onTap,
  });

  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: 28,
          height: 28,
          child: Icon(icon, size: 16, color: iconColor),
        ),
      ),
    );
  }
}

class _PrivacyInfoBox extends StatelessWidget {
  const _PrivacyInfoBox();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F0E9),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppColors.intentInputBorder.withValues(alpha: 0.45),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.shield_outlined,
            size: 18,
            color: AppColors.intentText,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your full gallery is never shown immediately.',
                  style: IntentLoginStyles.onboardingAssessmentTitle.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'One selected preview photo may unlock after a date is proposed, and your full gallery can unlock after the date flow progresses.',
                  style: IntentLoginStyles.onboardingSubtitle.copyWith(
                    fontSize: 12,
                    height: 1.45,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'You stay in control of what is shared.',
                  style: IntentLoginStyles.onboardingSubtitle.copyWith(
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  _DashedBorderPainter({
    required this.color,
    required this.radius,
  });

  final Color color;
  final double radius;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(1, 1, size.width - 2, size.height - 2),
      Radius.circular(radius),
    );

    const dashWidth = 5.0;
    const dashSpace = 4.0;
    final path = Path()..addRRect(rect);
    final metrics = path.computeMetrics();

    for (final metric in metrics) {
      var distance = 0.0;
      while (distance < metric.length) {
        final end = distance + dashWidth;
        canvas.drawPath(
          metric.extractPath(distance, end.clamp(0, metric.length)),
          paint,
        );
        distance = end + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DashedBorderPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.radius != radius;
  }
}

const double _pinnedFooterHeight = 72;
