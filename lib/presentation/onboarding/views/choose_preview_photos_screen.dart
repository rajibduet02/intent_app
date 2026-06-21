import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intent_app/app/theme/theme.dart';
import 'package:intent_app/presentation/auth/widgets/shared/fixed_background_auth_scaffold.dart';
import 'package:intent_app/presentation/onboarding/providers/upload_photos_provider.dart';
import 'package:intent_app/presentation/onboarding/widgets/onboarding_continue_button.dart';

class ChoosePreviewPhotosScreen extends ConsumerStatefulWidget {
  const ChoosePreviewPhotosScreen({super.key});

  @override
  ConsumerState<ChoosePreviewPhotosScreen> createState() =>
      _ChoosePreviewPhotosScreenState();
}

class _ChoosePreviewPhotosScreenState
    extends ConsumerState<ChoosePreviewPhotosScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(uploadPhotosProvider.notifier).ensurePreviewSelection();
    });
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(uploadPhotosProvider.notifier);
    final state = ref.watch(uploadPhotosProvider);
    final uploadedPhotos = state.uploadedPhotos;

    return FixedBackgroundAuthScaffold(
      pinnedFooter: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
        child: OnboardingContinueButton(
          label: 'Save Preview Photo',
          showArrow: true,
          arrowColor: AppColors.intentGold,
          isLoading: state.isLoading,
          onPressed: state.canSavePreview
              ? () => unawaited(notifier.savePreviewPhoto())
              : null,
        ),
      ),
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24).copyWith(
          bottom: 24 + _pinnedFooterHeight,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _ChoosePreviewHeader(onBack: notifier.onBackFromPreview),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Choose your preview photo',
              textAlign: TextAlign.center,
              style: IntentLoginStyles.onboardingTitle,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'This is the one photo you can release when a date is proposed.',
              textAlign: TextAlign.center,
              style: IntentLoginStyles.onboardingSubtitle,
            ),
            const SizedBox(height: AppSpacing.md),
            const _PreviewBadge(),
            const SizedBox(height: AppSpacing.lg),
            _PreviewPhotoGrid(
              uploadedPhotos: uploadedPhotos,
              selectedSlotIndex: state.previewPhotoSlotIndex,
              onPhotoSelected: notifier.selectPreviewPhoto,
            ),
            const SizedBox(height: 16),
            const _PreviewPrivacyBox(),
          ],
        ),
      ),
    );
  }
}

class _ChoosePreviewHeader extends StatelessWidget {
  const _ChoosePreviewHeader({required this.onBack});

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

class _PreviewBadge extends StatelessWidget {
  const _PreviewBadge();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.intentCreamDeep.withValues(alpha: 0.8),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppColors.intentInputBorder.withValues(alpha: 0.55),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.shield_outlined,
              size: 14,
              color: AppColors.intentTextSoft,
            ),
            const SizedBox(width: AppSpacing.xs),
            Text(
              'ONLY ONE PREVIEW PHOTO UNLOCKS FIRST',
              style: IntentLoginStyles.onboardingAssessmentCategory.copyWith(
                fontSize: 9,
                letterSpacing: 0.9,
                fontWeight: FontWeight.w700,
                color: AppColors.intentTextSoft,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PreviewPhotoGrid extends StatelessWidget {
  const _PreviewPhotoGrid({
    required this.uploadedPhotos,
    required this.selectedSlotIndex,
    required this.onPhotoSelected,
  });

  final List<MapEntry<int, String>> uploadedPhotos;
  final int? selectedSlotIndex;
  final ValueChanged<int> onPhotoSelected;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: AppShadows.intentInput,
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: uploadedPhotos.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 0.78,
          ),
          itemBuilder: (context, index) {
            final entry = uploadedPhotos[index];
            final isSelected = selectedSlotIndex == entry.key;
            return _PreviewPhotoTile(
              imagePath: entry.value,
              isSelected: isSelected,
              onTap: () => onPhotoSelected(entry.key),
            );
          },
        ),
      ),
    );
  }
}

class _PreviewPhotoTile extends StatelessWidget {
  const _PreviewPhotoTile({
    required this.imagePath,
    required this.isSelected,
    required this.onTap,
  });

  final String imagePath;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? AppColors.intentText : Colors.transparent,
              width: isSelected ? 2 : 0,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.file(
                  File(imagePath),
                  fit: BoxFit.cover,
                ),
                if (isSelected) ...[
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      width: 22,
                      height: 22,
                      decoration: const BoxDecoration(
                        color: AppColors.intentForest,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check,
                        size: 14,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      color: const Color(0xFFE9C46A),
                      child: Text(
                        'PREVIEW PHOTO',
                        textAlign: TextAlign.center,
                        style: IntentLoginStyles.onboardingAssessmentCategory
                            .copyWith(
                          fontSize: 8,
                          letterSpacing: 0.8,
                          fontWeight: FontWeight.w700,
                          color: AppColors.intentText,
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PreviewPrivacyBox extends StatelessWidget {
  const _PreviewPrivacyBox();

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
          Icon(
            Icons.lock_outline,
            size: 18,
            color: AppColors.intentGold.withValues(alpha: 0.95),
          ),
          const SizedBox(width: AppSpacing.xs),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: IntentLoginStyles.onboardingSubtitle.copyWith(
                  fontSize: 12,
                  height: 1.45,
                ),
                children: const [
                  TextSpan(
                    text:
                        'This photo stays private and blurred for everyone until a formal date proposal is exchanged. ',
                  ),
                  TextSpan(
                    text: 'You can change this photo anytime.',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

const double _pinnedFooterHeight = 72;
