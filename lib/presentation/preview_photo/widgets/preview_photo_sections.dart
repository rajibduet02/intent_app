import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';

const _cardCream = Color(0xFFFDF8F2);
const _lockCircleBg = Color(0xFFFFF0E0);
const _previewBadgeBg = Color(0xCC1E3F35);

class PreviewPhotoIntroSection extends StatelessWidget {
  const PreviewPhotoIntroSection({
    super.key,
    this.matchName = 'Julian',
  });

  final String matchName;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Preview photo unlocked',
          textAlign: TextAlign.center,
          style: IntentLoginStyles.onboardingTitle.copyWith(fontSize: 28),
        ),
        const SizedBox(height: 10),
        Text(
          '$matchName has shared one selected preview photo after the '
          'date proposal.',
          textAlign: TextAlign.center,
          style: IntentLoginStyles.onboardingSubtitle.copyWith(
            fontSize: 16,
            height: 1.45,
          ),
        ),
        const SizedBox(height: 14),
        Center(child: PreviewPhotoUnlockedBadge()),
      ],
    );
  }
}

class PreviewPhotoUnlockedBadge extends StatelessWidget {
  const PreviewPhotoUnlockedBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF4E8),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.intentGoldMuted.withValues(alpha: 0.55),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.add_circle_outline,
            size: 14,
            color: AppColors.intentGold.withValues(alpha: 0.95),
          ),
          const SizedBox(width: 6),
          Text(
            'One photo unlocked',
            style: IntentLoginStyles.onboardingSubtitle.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.intentText,
            ),
          ),
        ],
      ),
    );
  }
}

class PreviewPhotoMainCard extends StatelessWidget {
  const PreviewPhotoMainCard({
    super.key,
    this.name = 'Julian',
    this.age = 31,
  });

  final String name;
  final int age;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: AppColors.intentInputBorder.withValues(alpha: 0.4),
        ),
        boxShadow: AppShadows.intentInput,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          children: [
            AspectRatio(
              aspectRatio: 4 / 5,
              child: Image.asset(
                AppAssets.demoPreviewPhoto,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 14,
              left: 14,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: _previewBadgeBg,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.photo_outlined,
                      size: 12,
                      color: AppColors.white,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      'PREVIEW PHOTO',
                      style: IntentLoginStyles.onboardingSubtitle.copyWith(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.6,
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 14,
              right: 14,
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.white.withValues(alpha: 0.95),
                  shape: BoxShape.circle,
                  boxShadow: AppShadows.intentInput,
                ),
                child: Icon(
                  Icons.lock_open_outlined,
                  size: 18,
                  color: AppColors.intentGold.withValues(alpha: 0.95),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.55),
                    ],
                  ),
                ),
                child: Row(
                  children: [
                    Text(
                      '$name, $age',
                      style: IntentLoginStyles.onboardingSectionTitle.copyWith(
                        fontSize: 22,
                        color: AppColors.white,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: AppColors.intentGold,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check,
                        size: 12,
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PreviewPhotoGalleryPrivateCard extends StatelessWidget {
  const PreviewPhotoGalleryPrivateCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _cardCream,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.intentInputBorder.withValues(alpha: 0.35),
        ),
        boxShadow: AppShadows.intentInput,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: _lockCircleBg,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.intentGoldMuted.withValues(alpha: 0.35),
                  ),
                ),
                child: Icon(
                  Icons.lock_outline,
                  size: 20,
                  color: AppColors.intentGold.withValues(alpha: 0.95),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Full gallery remains private',
                      style: IntentLoginStyles.onboardingSectionTitle.copyWith(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'The full gallery unlocks only after the date flow '
                      'progresses. Intent reveals photos gradually so '
                      'connection can build with comfort and trust.',
                      style: IntentLoginStyles.onboardingSubtitle.copyWith(
                        fontSize: 13,
                        height: 1.45,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Text(
                'Full gallery locked',
                style: IntentLoginStyles.onboardingSubtitle.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.intentTextSoft,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Row(
                  children: const [
                    Expanded(child: _LockedGalleryThumbnail()),
                    SizedBox(width: 8),
                    Expanded(child: _LockedGalleryThumbnail()),
                    SizedBox(width: 8),
                    Expanded(child: _LockedGalleryThumbnail()),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _LockedGalleryThumbnail extends StatelessWidget {
  const _LockedGalleryThumbnail();

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          fit: StackFit.expand,
          children: [
            ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
              child: Image.asset(
                AppAssets.demoPreviewPhoto,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              color: Colors.black.withValues(alpha: 0.18),
            ),
            Center(
              child: Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: AppColors.white.withValues(alpha: 0.92),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.lock_outline,
                  size: 14,
                  color: AppColors.intentTextSoft,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PreviewPhotoDateFlowProgressCard extends StatelessWidget {
  const PreviewPhotoDateFlowProgressCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 18),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.intentInputBorder.withValues(alpha: 0.4),
        ),
        boxShadow: AppShadows.intentInput,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Your date flow progress',
            style: IntentLoginStyles.onboardingCardFieldLabel.copyWith(
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 18),
          const _DateFlowStepper(),
        ],
      ),
    );
  }
}

class _DateFlowStepper extends StatelessWidget {
  const _DateFlowStepper();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _DateFlowStep(
            node: const _StepNode.completed(),
            title: 'Date proposed',
            subtitle: 'Completed',
            titleColor: AppColors.intentText,
          ),
        ),
        SizedBox(
          width: 28,
          child: Padding(
            padding: const EdgeInsets.only(top: 14),
            child: Container(
              height: 2,
              color: AppColors.intentForest,
            ),
          ),
        ),
        Expanded(
          child: _DateFlowStep(
            node: const _StepNode.current(stepNumber: 2),
            title: 'Preview photo unlocked',
            subtitle: 'You are here',
            titleColor: const Color(0xFFB8860B),
          ),
        ),
        SizedBox(
          width: 28,
          child: Padding(
            padding: const EdgeInsets.only(top: 14),
            child: CustomPaint(
              painter: _DashedLinePainter(),
              size: const Size(28, 2),
            ),
          ),
        ),
        Expanded(
          child: _DateFlowStep(
            node: const _StepNode.upcoming(stepNumber: 3),
            title: 'Full gallery',
            subtitle: 'Unlocks after the date',
            titleColor: AppColors.intentTextSoft,
          ),
        ),
      ],
    );
  }
}

class _DateFlowStep extends StatelessWidget {
  const _DateFlowStep({
    required this.node,
    required this.title,
    required this.subtitle,
    required this.titleColor,
  });

  final _StepNode node;
  final String title;
  final String subtitle;
  final Color titleColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        node,
        const SizedBox(height: 10),
        Text(
          title,
          textAlign: TextAlign.center,
          style: IntentLoginStyles.onboardingCardFieldLabel.copyWith(
            fontSize: 11,
            color: titleColor,
            height: 1.25,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: IntentLoginStyles.onboardingSubtitle.copyWith(
            fontSize: 10,
            height: 1.3,
            color: AppColors.intentTextSoft,
          ),
        ),
      ],
    );
  }
}

class _StepNode extends StatelessWidget {
  const _StepNode.completed()
      : isCompleted = true,
        stepNumber = null,
        isUpcoming = false;

  const _StepNode.current({required this.stepNumber})
      : isCompleted = false,
        isUpcoming = false;

  const _StepNode.upcoming({required this.stepNumber})
      : isCompleted = false,
        isUpcoming = true;

  final bool isCompleted;
  final int? stepNumber;
  final bool isUpcoming;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: isUpcoming
            ? AppColors.intentInputBorder.withValues(alpha: 0.35)
            : AppColors.intentForest,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: isCompleted
          ? const Icon(Icons.check, size: 16, color: AppColors.white)
          : Text(
              '$stepNumber',
              style: IntentLoginStyles.onboardingContinue.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
    );
  }
}

class _DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.intentInputBorder.withValues(alpha: 0.8)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    const dashWidth = 4.0;
    const dashSpace = 3.0;
    var startX = 0.0;
    final y = size.height / 2;

    while (startX < size.width) {
      canvas.drawLine(Offset(startX, y), Offset(startX + dashWidth, y), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class PreviewPhotoSafetyTip extends StatelessWidget {
  const PreviewPhotoSafetyTip({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppColors.intentInputBorder.withValues(alpha: 0.45),
            ),
            boxShadow: AppShadows.intentInput,
          ),
          child: Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F0D8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.verified_user_outlined,
                  size: 16,
                  color: AppColors.intentGold.withValues(alpha: 0.95),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Photo sharing stays gradual and controlled inside Intent.',
                  style: IntentLoginStyles.onboardingSubtitle.copyWith(
                    fontSize: 13,
                    height: 1.35,
                  ),
                ),
              ),
              Icon(
                Icons.chevron_right,
                size: 18,
                color: AppColors.intentTextSoft.withValues(alpha: 0.75),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PreviewPhotoContinueChatButton extends StatelessWidget {
  const PreviewPhotoContinueChatButton({super.key, this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          AppSpacing.primaryButtonBorderRadius,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.intentForest.withValues(alpha: 0.22),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: SizedBox(
        width: double.infinity,
        height: AppSpacing.primaryButtonHeight,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.intentForest,
            elevation: 0,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                AppSpacing.primaryButtonBorderRadius,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: AppColors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.chat_bubble_outline,
                  size: 16,
                  color: AppColors.white,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                'Continue Chat',
                style: IntentLoginStyles.onboardingContinue.copyWith(
                  letterSpacing: 0.6,
                ),
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.chevron_right,
                color: AppColors.white,
                size: 22,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PreviewPhotoViewProposalLink extends StatelessWidget {
  const PreviewPhotoViewProposalLink({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: Text(
          'View date proposal',
          style: IntentLoginStyles.onboardingSectionTitle.copyWith(
            fontSize: 16,
            decoration: TextDecoration.underline,
            decorationColor: AppColors.intentText,
            height: 1.3,
          ),
        ),
      ),
    );
  }
}
