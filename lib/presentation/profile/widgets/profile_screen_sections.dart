import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';

class ProfileScreenSection extends StatelessWidget {
  const ProfileScreenSection({
    super.key,
    required this.title,
    required this.child,
  });

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: AppShadows.intentInput,
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _SectionTitleRow(title: title),
            const SizedBox(height: 14),
            child,
          ],
        ),
      ),
    );
  }
}

class _SectionTitleRow extends StatelessWidget {
  const _SectionTitleRow({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: IntentLoginStyles.onboardingSectionTitle.copyWith(
              fontSize: 18,
            ),
          ),
        ),
        Icon(
          Icons.chevron_right,
          size: 22,
          color: AppColors.intentTextSoft.withValues(alpha: 0.75),
        ),
      ],
    );
  }
}

class ProfileKeyValueRow extends StatelessWidget {
  const ProfileKeyValueRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.intentTextSoft),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            label,
            style: IntentLoginStyles.onboardingSubtitle.copyWith(fontSize: 13),
          ),
        ),
        Text(
          value,
          style: IntentLoginStyles.onboardingCardFieldLabel.copyWith(
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class ProfileSectionDivider extends StatelessWidget {
  const ProfileSectionDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Divider(
        height: 1,
        color: AppColors.intentInputBorder.withValues(alpha: 0.55),
      ),
    );
  }
}

class ProfileRelationshipIntentionCard extends StatelessWidget {
  const ProfileRelationshipIntentionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileScreenSection(
      title: 'Relationship Intention',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.intentGoldMuted.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.favorite_border,
                  size: 20,
                  color: AppColors.intentGold,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Marriage-minded',
                      style: IntentLoginStyles.onboardingCardFieldLabel
                          .copyWith(fontSize: 15),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Looking for a serious relationship with long-term '
                      'potential.',
                      style: IntentLoginStyles.onboardingSubtitle.copyWith(
                        fontSize: 12,
                        height: 1.45,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8F0D8),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: AppColors.intentGoldMuted.withValues(
                            alpha: 0.45,
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.star,
                            size: 11,
                            color: AppColors.intentGold.withValues(alpha: 0.95),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'CORE PREFERENCE',
                            style: IntentLoginStyles.onboardingAssessmentCategory
                                .copyWith(
                              fontSize: 9,
                              letterSpacing: 0.8,
                              fontWeight: FontWeight.w700,
                              color: AppColors.intentGold,
                            ),
                          ),
                        ],
                      ),
                    ),
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

class ProfileValuesCard extends StatelessWidget {
  const ProfileValuesCard({super.key});

  static const _values = [
    'Family',
    'Honesty',
    'Emotional maturity',
    'Faith importance',
    'Stability',
    'Growth',
  ];

  @override
  Widget build(BuildContext context) {
    return ProfileScreenSection(
      title: 'Values',
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          for (final value in _values)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.intentSegmentFill,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: AppColors.intentInputBorder.withValues(alpha: 0.55),
                ),
              ),
              child: Text(
                value,
                style: IntentLoginStyles.onboardingSubtitle.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.intentText,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class ProfilePersonalityCard extends StatelessWidget {
  const ProfilePersonalityCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileScreenSection(
      title: 'Personality Summary',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const ProfileKeyValueRow(
            icon: Icons.psychology_outlined,
            label: 'MBTI',
            value: 'INFJ',
          ),
          const ProfileSectionDivider(),
          const ProfileKeyValueRow(
            icon: Icons.favorite_outline,
            label: 'Attachment style',
            value: 'Secure',
          ),
          const ProfileSectionDivider(),
          const ProfileKeyValueRow(
            icon: Icons.volunteer_activism_outlined,
            label: 'Love language',
            value: 'Quality time',
          ),
          const ProfileSectionDivider(),
          const ProfileKeyValueRow(
            icon: Icons.chat_bubble_outline,
            label: 'Communication style',
            value: 'Thoughtful and direct',
          ),
          const ProfileSectionDivider(),
          Text(
            'You tend to value emotional depth, meaningful conversation, '
            'and steady connection.',
            style: IntentLoginStyles.onboardingSubtitle.copyWith(
              fontSize: 12,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileHiddenGalleryCard extends StatelessWidget {
  const ProfileHiddenGalleryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileScreenSection(
      title: 'Hidden Photo Gallery',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 6,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 1,
            ),
            itemBuilder: (context, index) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  color: AppColors.intentCreamDeep.withValues(alpha: 0.85),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.intentInputBorder.withValues(alpha: 0.5),
                  ),
                ),
                child: Icon(
                  Icons.lock_outline,
                  size: 20,
                  color: AppColors.intentTextSoft.withValues(alpha: 0.65),
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          Text(
            'Full gallery hidden',
            style: IntentLoginStyles.onboardingSubtitle.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.intentGold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Your full gallery unlocks only after the date flow progresses.',
            style: IntentLoginStyles.onboardingSubtitle.copyWith(
              fontSize: 11,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

class ProfilePreviewPhotoCard extends StatelessWidget {
  const ProfilePreviewPhotoCard({super.key});

  static const _photoWidth = 92.0;
  static const _photoHeight = 118.0;
  static const _photoRadius = 14.0;

  @override
  Widget build(BuildContext context) {
    return ProfileScreenSection(
      title: 'Preview Photo',
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(_photoRadius),
            child: SizedBox(
              width: _photoWidth,
              height: _photoHeight,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ImageFiltered(
                    imageFilter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
                    child: Image.asset(
                      AppAssets.lovePerson,
                      width: _photoWidth + 24,
                      height: _photoHeight + 24,
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.intentForest.withValues(alpha: 0.88),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(_photoRadius),
                          bottomRight: Radius.circular(_photoRadius),
                        ),
                      ),
                      child: Text(
                        'Selected preview',
                        textAlign: TextAlign.center,
                        style: IntentLoginStyles.onboardingSubtitle.copyWith(
                          fontSize: 9,
                          color: AppColors.white,
                          fontWeight: FontWeight.w500,
                          height: 1.1,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'This is the one photo that can unlock after a date is '
                  'proposed.',
                  style: IntentLoginStyles.onboardingSubtitle.copyWith(
                    fontSize: 12,
                    height: 1.45,
                    color: AppColors.intentTextSoft,
                  ),
                ),
                const SizedBox(height: 12),
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.intentText,
                    backgroundColor: AppColors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    side: BorderSide(
                      color: AppColors.intentInputBorder.withValues(
                        alpha: 0.85,
                      ),
                    ),
                    shape: const StadiumBorder(),
                  ),
                  child: Text(
                    'Change preview photo',
                    style: IntentLoginStyles.onboardingCardFieldLabel.copyWith(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
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

class ProfileVerificationCard extends StatelessWidget {
  const ProfileVerificationCard({super.key});

  static const _rows = [
    (label: 'ID verification', status: 'Verified'),
    (label: 'Safety acknowledgement', status: 'Completed'),
    (label: 'Profile authenticity', status: 'Active'),
  ];

  @override
  Widget build(BuildContext context) {
    return ProfileScreenSection(
      title: 'Verification Status',
      child: Column(
        children: [
          for (var i = 0; i < _rows.length; i++) ...[
            if (i > 0) const SizedBox(height: 14),
            _VerificationRow(
              label: _rows[i].label,
              status: _rows[i].status,
            ),
          ],
        ],
      ),
    );
  }
}

class _VerificationRow extends StatelessWidget {
  const _VerificationRow({
    required this.label,
    required this.status,
  });

  final String label;
  final String status;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.check_circle_outline,
          size: 18,
          color: AppColors.intentTextSoft.withValues(alpha: 0.85),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            label,
            style: IntentLoginStyles.onboardingCardFieldLabel.copyWith(
              fontSize: 13,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Text(
          status,
          style: IntentLoginStyles.onboardingCardFieldLabel.copyWith(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 6),
        Container(
          width: 18,
          height: 18,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: AppColors.intentText,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.check,
            size: 11,
            color: AppColors.white,
          ),
        ),
      ],
    );
  }
}

class ProfileDealbreakersCard extends StatelessWidget {
  const ProfileDealbreakersCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileScreenSection(
      title: 'Dealbreakers',
      child: Column(
        children: const [
          _DealbreakerDualRow(
            icon: Icons.favorite_border,
            label: 'Relationship intention',
            value: 'Marriage-minded',
            showValueStar: true,
          ),
          SizedBox(height: 16),
          _DealbreakerDualRow(
            icon: Icons.blur_on,
            label: 'Religion / beliefs',
            value: 'Compatible',
          ),
          SizedBox(height: 16),
          _DealbreakerDualRow(
            icon: Icons.circle_outlined,
            label: 'Children / family goals',
            value: 'Wants children',
          ),
        ],
      ),
    );
  }
}

class _DealbreakerDualRow extends StatelessWidget {
  const _DealbreakerDualRow({
    required this.icon,
    required this.label,
    required this.value,
    this.showValueStar = false,
  });

  final IconData icon;
  final String label;
  final String value;
  final bool showValueStar;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _DealbreakerIconCell(
            icon: icon,
            label: label,
            value: value,
            showValueStar: showValueStar,
          ),
        ),
        const SizedBox(width: 12),
        const Expanded(child: SizedBox.shrink()),
      ],
    );
  }
}

class _DealbreakerIconCell extends StatelessWidget {
  const _DealbreakerIconCell({
    required this.icon,
    required this.label,
    required this.value,
    this.showValueStar = false,
  });

  final IconData icon;
  final String label;
  final String value;
  final bool showValueStar;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 1),
          child: Icon(
            icon,
            size: 14,
            color: AppColors.intentTextSoft.withValues(alpha: 0.8),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: IntentLoginStyles.onboardingSubtitle.copyWith(
                  fontSize: 11,
                  height: 1.35,
                  color: AppColors.intentTextSoft,
                ),
              ),
              const SizedBox(height: 2),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      value,
                      style: IntentLoginStyles.onboardingCardFieldLabel
                          .copyWith(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        height: 1.35,
                      ),
                    ),
                  ),
                  if (showValueStar) ...[
                    const SizedBox(width: 4),
                    Icon(
                      Icons.star_outline,
                      size: 12,
                      color: AppColors.intentTextSoft.withValues(alpha: 0.75),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ProfileUnlockBanner extends StatelessWidget {
  const ProfileUnlockBanner({super.key});

  static const _sparkleColor = AppColors.intentGold;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFFBF6E8),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: AppColors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.lock_outline,
                    size: 20,
                    color: _sparkleColor.withValues(alpha: 0.95),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Your profile is designed to show compatibility '
                        'first.',
                        style: IntentLoginStyles.onboardingCardFieldLabel
                            .copyWith(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          height: 1.35,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Photos and gallery visibility follow intentional '
                        'gradual unlock flow.',
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
          ),
          Positioned(
            top: 10,
            right: 12,
            child: Icon(
              Icons.auto_awesome,
              size: 10,
              color: _sparkleColor.withValues(alpha: 0.85),
            ),
          ),
          Positioned(
            bottom: 10,
            right: 16,
            child: Icon(
              Icons.auto_awesome,
              size: 12,
              color: _sparkleColor.withValues(alpha: 0.9),
            ),
          ),
        ],
      ),
    );
  }
}
