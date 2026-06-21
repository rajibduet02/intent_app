import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intent_app/app/theme/theme.dart';
import 'package:intent_app/presentation/auth/widgets/shared/fixed_background_auth_scaffold.dart';
import 'package:intent_app/presentation/onboarding/providers/upload_id_provider.dart';
import 'package:intent_app/presentation/onboarding/widgets/onboarding_continue_button.dart';
import 'package:permission_handler/permission_handler.dart';

class UploadIdScreen extends ConsumerStatefulWidget {
  const UploadIdScreen({super.key});

  @override
  ConsumerState<UploadIdScreen> createState() => _UploadIdScreenState();
}

class _UploadIdScreenState extends ConsumerState<UploadIdScreen> {
  final ImagePicker _imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(uploadIdProvider.notifier);
    final state = ref.watch(uploadIdProvider);

    return FixedBackgroundAuthScaffold(
      pinnedFooter: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
        child: OnboardingContinueButton(
          label: 'Submit ID',
          showArrow: false,
          isLoading: state.isLoading,
          onPressed: state.canSubmit ? () => unawaited(notifier.submit()) : null,
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
            _UploadIdHeader(onBack: notifier.onBack),
            const SizedBox(height: 20),
            Text(
              'Upload your ID',
              textAlign: TextAlign.center,
              style: IntentLoginStyles.onboardingTitle,
            ),
            const SizedBox(height: 10),
            Text(
              'To maintain our community\'s integrity, we require a quick identity check. Your data is encrypted and used only for verification.',
              textAlign: TextAlign.center,
              style: IntentLoginStyles.onboardingSubtitle,
            ),
            const SizedBox(height: 20),
            _IdUploadCard(
              documentPath: state.documentPath,
              documentName: state.documentName,
              isPdf: state.isPdf,
              onTap: _pickDocument,
              onClear: notifier.clearDocument,
            ),
            const SizedBox(height: 16),
            const _SecureProcessingNote(),
          ],
        ),
      ),
    );
  }

  Future<void> _pickDocument() async {
    final source = await showModalBottomSheet<_IdPickSource>(
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
                  'Add document',
                  style: IntentLoginStyles.fieldLabel.copyWith(fontSize: 16),
                ),
                const SizedBox(height: 8),
                ListTile(
                  leading: const Icon(Icons.photo_camera_outlined),
                  title: const Text('Take Photo'),
                  onTap: () =>
                      Navigator.of(sheetContext).pop(_IdPickSource.camera),
                ),
                ListTile(
                  leading: const Icon(Icons.photo_library_outlined),
                  title: const Text('Choose from Gallery'),
                  onTap: () =>
                      Navigator.of(sheetContext).pop(_IdPickSource.gallery),
                ),
                ListTile(
                  leading: const Icon(Icons.picture_as_pdf_outlined),
                  title: const Text('Choose PDF'),
                  onTap: () =>
                      Navigator.of(sheetContext).pop(_IdPickSource.pdf),
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

    await Future<void>.delayed(const Duration(milliseconds: 250));
    if (!mounted) {
      return;
    }

    try {
      switch (source) {
        case _IdPickSource.camera:
        case _IdPickSource.gallery:
          final imageSource = source == _IdPickSource.camera
              ? ImageSource.camera
              : ImageSource.gallery;
          final hasPermission = await _requestPhotoPermission(imageSource);
          if (!mounted || !hasPermission) {
            if (mounted && !hasPermission) {
              _showPickerError(
                imageSource == ImageSource.camera
                    ? 'Camera permission is required to take a photo.'
                    : 'Photo library permission is required to choose a photo.',
              );
            }
            return;
          }

          final picked = await _imagePicker.pickImage(
            source: imageSource,
            imageQuality: 90,
          );
          if (!mounted || picked == null) {
            return;
          }

          ref.read(uploadIdProvider.notifier).setDocument(
                path: picked.path,
                name: picked.name,
                isPdf: false,
              );
        case _IdPickSource.pdf:
          final result = await FilePicker.pickFiles(
            type: FileType.custom,
            allowedExtensions: const ['pdf'],
          );
          if (!mounted || result == null || result.files.isEmpty) {
            return;
          }

          final file = result.files.single;
          final path = file.path;
          if (path == null) {
            return;
          }

          ref.read(uploadIdProvider.notifier).setDocument(
                path: path,
                name: file.name,
                isPdf: true,
              );
      }
    } catch (_) {
      if (!mounted) {
        return;
      }
      _showPickerError('Could not open the document picker. Please try again.');
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

enum _IdPickSource { camera, gallery, pdf }

class _UploadIdHeader extends StatelessWidget {
  const _UploadIdHeader({required this.onBack});

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

class _IdUploadCard extends StatelessWidget {
  const _IdUploadCard({
    required this.documentPath,
    required this.documentName,
    required this.isPdf,
    required this.onTap,
    required this.onClear,
  });

  final String? documentPath;
  final String? documentName;
  final bool isPdf;
  final VoidCallback onTap;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: AppShadows.intentInput,
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (documentPath == null)
              _EmptyIdUploadZone(onTap: onTap)
            else
              _SelectedIdPreview(
                documentPath: documentPath!,
                documentName: documentName ?? 'Document',
                isPdf: isPdf,
                onTap: onTap,
                onClear: onClear,
              ),
            const SizedBox(height: 18),
            const _IdChecklistItem(
              text: 'Ensure your name and photo are clearly visible',
            ),
            const SizedBox(height: 10),
            const _IdChecklistItem(
              text: 'Avoid glare and blurry edges',
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyIdUploadZone extends StatelessWidget {
  const _EmptyIdUploadZone({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.intentSegmentFill,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: CustomPaint(
          painter: _DashedBorderPainter(
            color: AppColors.intentInputBorder,
            radius: 14,
          ),
          child: SizedBox(
            // height: 260,
            height: 300,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: const BoxDecoration(
                      color: Color(0xFFD5E8D4),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.photo_camera_outlined,
                      size: 28,
                      color: AppColors.intentForest,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Capture or select document',
                    textAlign: TextAlign.center,
                    style: IntentLoginStyles.onboardingCardFieldLabel.copyWith(
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Supports JPG, PNG, or PDF',
                    textAlign: TextAlign.center,
                    style: IntentLoginStyles.onboardingSubtitle.copyWith(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SelectedIdPreview extends StatelessWidget {
  const _SelectedIdPreview({
    required this.documentPath,
    required this.documentName,
    required this.isPdf,
    required this.onTap,
    required this.onClear,
  });

  final String documentPath;
  final String documentName;
  final bool isPdf;
  final VoidCallback onTap;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: Stack(
        children: [
          Material(
            color: AppColors.intentSegmentFill,
            child: InkWell(
              onTap: onTap,
              child: SizedBox(
                // height: 260,
                height: 300,
                width: double.infinity,
                child: isPdf
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.picture_as_pdf_outlined,
                            size: 40,
                            color: AppColors.intentForest,
                          ),
                          const SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              documentName,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: IntentLoginStyles.onboardingSubtitle
                                  .copyWith(
                                fontSize: 12,
                                color: AppColors.intentText,
                              ),
                            ),
                          ),
                        ],
                      )
                    : Image.file(
                        File(documentPath),
                        fit: BoxFit.cover,
                      ),
              ),
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: Material(
              color: AppColors.white.withValues(alpha: 0.92),
              shape: const CircleBorder(),
              child: InkWell(
                onTap: onClear,
                customBorder: const CircleBorder(),
                child: const SizedBox(
                  width: 32,
                  height: 32,
                  child: Icon(
                    Icons.close,
                    size: 18,
                    color: AppColors.intentText,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _IdChecklistItem extends StatelessWidget {
  const _IdChecklistItem({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(
          Icons.check_circle_outline,
          size: 18,
          color: AppColors.intentTextSoft,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: IntentLoginStyles.onboardingSubtitle.copyWith(
              fontSize: 12,
              color: AppColors.intentText,
            ),
          ),
        ),
      ],
    );
  }
}

class _SecureProcessingNote extends StatelessWidget {
  const _SecureProcessingNote();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.lock_outline,
            size: 14,
            color: AppColors.intentTextSoft.withValues(alpha: 0.9),
          ),
          const SizedBox(width: 6),
          Text(
            'SECURE PROCESSING',
            style: IntentLoginStyles.onboardingAssessmentCategory.copyWith(
              fontSize: 10,
              letterSpacing: 1.2,
              fontWeight: FontWeight.w600,
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
