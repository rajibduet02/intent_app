import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';

const _cardCream = Color(0xFFFDF8F2);
const _harmonyBadgeBg = Color(0xFFF8E9B8);
const _completedBadgeBg = Color(0xFFE8F0EA);
const _journeyGold = Color(0xFFB8860B);
const _previewBadgeBg = Color(0xCC1E3F35);

class FullGalleryUnlockedIntroSection extends StatelessWidget {
  const FullGalleryUnlockedIntroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Icon(
                Icons.auto_awesome,
                size: 14,
                color: AppColors.intentGold.withValues(alpha: 0.85),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'Now that the date happened, you can view the full photo '
                'gallery.',
                textAlign: TextAlign.center,
                style: IntentLoginStyles.onboardingSubtitle.copyWith(
                  fontSize: 16,
                  height: 1.45,
                ),
              ),
            ),
            const SizedBox(width: 4),
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Icon(
                Icons.auto_awesome,
                size: 14,
                color: AppColors.intentGold.withValues(alpha: 0.85),
              ),
            ),
            const SizedBox(width: 4),
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Icon(
                Icons.favorite,
                size: 12,
                color: AppColors.intentGold.withValues(alpha: 0.7),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Center(child: FullGalleryUnlockedBadge()),
      ],
    );
  }
}

class FullGalleryUnlockedBadge extends StatelessWidget {
  const FullGalleryUnlockedBadge({super.key});

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
            Icons.lock_open_outlined,
            size: 14,
            color: AppColors.intentGold.withValues(alpha: 0.95),
          ),
          const SizedBox(width: 6),
          Text(
            'Unlocked after date',
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

class FullGalleryUnlockedProfileCard extends StatelessWidget {
  const FullGalleryUnlockedProfileCard({
    super.key,
    this.name = 'Julian',
    this.harmonyPercent = 94,
  });

  final String name;
  final int harmonyPercent;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.intentInputBorder.withValues(alpha: 0.4),
        ),
        boxShadow: AppShadows.intentInput,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(28),
            child: Image.asset(
              AppAssets.demoPreviewPhoto,
              width: 56,
              height: 56,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: IntentLoginStyles.onboardingSectionTitle
                      .copyWith(fontSize: 20),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 6,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _harmonyBadgeBg,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.auto_awesome,
                            size: 11,
                            color: AppColors.intentGold.withValues(alpha: 0.95),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '$harmonyPercent% Harmony',
                            style: IntentLoginStyles.onboardingSubtitle
                                .copyWith(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: AppColors.intentText,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _completedBadgeBg,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.check_circle_outline,
                            size: 11,
                            color: AppColors.intentForest,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Date completed',
                            style: IntentLoginStyles.onboardingSubtitle
                                .copyWith(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: AppColors.intentForest,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Photo sharing has progressed through the Intent date flow.',
                  style: IntentLoginStyles.onboardingSubtitle.copyWith(
                    fontSize: 12,
                    height: 1.4,
                    color: AppColors.intentTextSoft,
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

class FullGalleryUnlockedGallerySection extends StatelessWidget {
  const FullGalleryUnlockedGallerySection({
    super.key,
    this.name = 'Julian',
  });

  final String name;

  static const _galleryAlignments = [
    Alignment.center,
    Alignment.topRight,
    Alignment.bottomLeft,
    Alignment.topLeft,
    Alignment.centerRight,
    Alignment.bottomCenter,
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          '$name\'s gallery',
          style: IntentLoginStyles.onboardingSectionTitle.copyWith(
            fontSize: 20,
            color: AppColors.intentText,
          ),
        ),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 6,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1.05,
          ),
          itemBuilder: (context, index) {
            return _GalleryTile(
              imageAsset: AppAssets.demoGalleryPhoto,
              alignment: _galleryAlignments[index],
              showPreviewBadge: index == 0,
            );
          },
        ),
      ],
    );
  }
}

class _GalleryTile extends StatelessWidget {
  const _GalleryTile({
    required this.imageAsset,
    required this.alignment,
    this.showPreviewBadge = false,
  });

  final String imageAsset;
  final Alignment alignment;
  final bool showPreviewBadge;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            imageAsset,
            fit: BoxFit.cover,
            alignment: alignment,
          ),
          if (showPreviewBadge)
            Positioned(
              top: 8,
              left: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _previewBadgeBg,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.auto_awesome,
                      size: 10,
                      color: AppColors.intentGold.withValues(alpha: 0.95),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Preview photo',
                      style: IntentLoginStyles.onboardingSubtitle.copyWith(
                        fontSize: 9,
                        fontWeight: FontWeight.w600,
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          Positioned(
            top: 8,
            right: 8,
            child: Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.35),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.open_in_full,
                size: 14,
                color: AppColors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FullGalleryUnlockJourneyCard extends StatelessWidget {
  const FullGalleryUnlockJourneyCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 18),
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
          Text(
            'Your photo unlock journey',
            style: IntentLoginStyles.onboardingSectionTitle.copyWith(
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 18),
          const _UnlockJourneyStepper(),
        ],
      ),
    );
  }
}

class _UnlockJourneyStepper extends StatelessWidget {
  const _UnlockJourneyStepper();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _JourneyStep(
            node: const _JourneyNode.completed(),
            title: 'Date proposed',
            subtitle: 'Completed',
            titleColor: AppColors.intentText,
          ),
        ),
        SizedBox(
          width: 24,
          child: Padding(
            padding: const EdgeInsets.only(top: 14),
            child: Container(height: 2, color: AppColors.intentForest),
          ),
        ),
        Expanded(
          child: _JourneyStep(
            node: const _JourneyNode.completed(),
            title: 'Preview photo unlocked',
            subtitle: 'Completed',
            titleColor: AppColors.intentText,
          ),
        ),
        SizedBox(
          width: 24,
          child: Padding(
            padding: const EdgeInsets.only(top: 14),
            child: Container(height: 2, color: AppColors.intentForest),
          ),
        ),
        Expanded(
          child: _JourneyStep(
            node: const _JourneyNode.current(stepNumber: 3),
            title: 'Full gallery unlocked',
            subtitle: 'Now available',
            titleColor: _journeyGold,
            subtitleColor: _journeyGold,
          ),
        ),
      ],
    );
  }
}

class _JourneyStep extends StatelessWidget {
  const _JourneyStep({
    required this.node,
    required this.title,
    required this.subtitle,
    required this.titleColor,
    this.subtitleColor,
  });

  final _JourneyNode node;
  final String title;
  final String subtitle;
  final Color titleColor;
  final Color? subtitleColor;

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
            fontSize: 10,
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
            color: subtitleColor ?? AppColors.intentTextSoft,
          ),
        ),
      ],
    );
  }
}

class _JourneyNode extends StatelessWidget {
  const _JourneyNode.completed()
      : isCompleted = true,
        stepNumber = null,
        isCurrent = false;

  const _JourneyNode.current({required this.stepNumber})
      : isCompleted = false,
        isCurrent = true;

  final bool isCompleted;
  final int? stepNumber;
  final bool isCurrent;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: isCurrent ? AppColors.intentText : AppColors.intentForest,
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

class FullGalleryUnlockedInfoCard extends StatelessWidget {
  const FullGalleryUnlockedInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppColors.intentInputBorder.withValues(alpha: 0.45),
            ),
            boxShadow: AppShadows.intentInput,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F0D8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.verified_user_outlined,
                  size: 18,
                  color: AppColors.intentGold.withValues(alpha: 0.95),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Intent reveals photos gradually so connection can '
                      'build through comfort, trust, and real interaction.',
                      style: IntentLoginStyles.onboardingCardFieldLabel
                          .copyWith(
                        fontSize: 14,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'You can still control your own gallery visibility '
                      'from profile settings.',
                      style: IntentLoginStyles.onboardingSubtitle.copyWith(
                        fontSize: 12,
                        height: 1.4,
                        color: AppColors.intentTextSoft,
                      ),
                    ),
                  ],
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

class FullGalleryUnlockedReportRow extends StatelessWidget {
  const FullGalleryUnlockedReportRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              Icon(
                Icons.warning_amber_outlined,
                size: 16,
                color: AppColors.intentTextSoft,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Report or block options remain available anytime.',
                  style: IntentLoginStyles.onboardingSubtitle.copyWith(
                    fontSize: 13,
                    color: AppColors.intentTextSoft,
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

class FullGalleryUnlockedViewProfileButton extends StatelessWidget {
  const FullGalleryUnlockedViewProfileButton({super.key, this.onPressed});

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
                  Icons.person_outline,
                  size: 16,
                  color: AppColors.white,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                'View Full Profile',
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

class FullGalleryUnlockedContinueChatLink extends StatelessWidget {
  const FullGalleryUnlockedContinueChatLink({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: Text(
          'Continue Chat',
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
