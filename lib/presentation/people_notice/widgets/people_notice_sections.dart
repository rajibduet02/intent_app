import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';

enum _NoticeChipStyle { normal, highlighted, noted }

const _harmonyBadgeBg = Color(0xFFF8E9B8);

class PeopleNoticeIntroSection extends StatelessWidget {
  const PeopleNoticeIntroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Icon(
                Icons.auto_awesome,
                size: 14,
                color: AppColors.intentGold.withValues(alpha: 0.85),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'What people \nnotice about them',
                textAlign: TextAlign.center,
                style: IntentLoginStyles.onboardingTitle.copyWith(fontSize: 26),
              ),
            ),
            const SizedBox(width: 8),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Icon(
                Icons.auto_awesome,
                size: 14,
                color: AppColors.intentGold.withValues(alpha: 0.85),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          'These are positive qualities shared from past respectful '
          'interactions.',
          textAlign: TextAlign.center,
          style: IntentLoginStyles.onboardingSubtitle.copyWith(
            fontSize: 16,
            height: 1.45,
          ),
        ),
        const SizedBox(height: 14),
        Center(child: PeopleNoticeHighlightsBadge()),
      ],
    );
  }
}

class PeopleNoticeHighlightsBadge extends StatelessWidget {
  const PeopleNoticeHighlightsBadge({super.key});

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
            Icons.verified_user_outlined,
            size: 14,
            color: AppColors.intentGold.withValues(alpha: 0.95),
          ),
          const SizedBox(width: 6),
          Text(
            'POSITIVE HIGHLIGHTS ONLY',
            style: IntentLoginStyles.onboardingSubtitle.copyWith(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.8,
              color: AppColors.intentGold.withValues(alpha: 0.95),
            ),
          ),
        ],
      ),
    );
  }
}

class PeopleNoticeProfileCard extends StatelessWidget {
  const PeopleNoticeProfileCard({
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
          color: AppColors.intentInputBorder.withValues(alpha: 0.35),
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
                  style: IntentLoginStyles.onboardingSectionTitle.copyWith(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _harmonyBadgeBg,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '+ $harmonyPercent% Harmony',
                    style: IntentLoginStyles.onboardingSubtitle.copyWith(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: AppColors.intentText,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Attributes are based on positive feedback patterns.',
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

class _NoticeQuality {
  const _NoticeQuality({
    required this.label,
    this.icon,
    this.emoji,
    this.style = _NoticeChipStyle.normal,
  });

  final String label;
  final IconData? icon;
  final String? emoji;
  final _NoticeChipStyle style;
}

class PeopleNoticeQualitiesCard extends StatelessWidget {
  const PeopleNoticeQualitiesCard({super.key});

  static const _qualities = [
    _NoticeQuality(label: 'Thoughtful', icon: Icons.favorite_border),
    _NoticeQuality(label: 'Kind', icon: Icons.check_circle_outline),
    _NoticeQuality(
      label: 'Emotionally mature',
      icon: Icons.public_outlined,
      style: _NoticeChipStyle.highlighted,
    ),
    _NoticeQuality(
      label: 'Respectful',
      icon: Icons.people_outline,
      style: _NoticeChipStyle.noted,
    ),
    _NoticeQuality(
      label: 'Good listener',
      icon: Icons.mic_none_outlined,
      style: _NoticeChipStyle.highlighted,
    ),
    _NoticeQuality(
      label: 'Intentional',
      icon: Icons.assignment_outlined,
      style: _NoticeChipStyle.noted,
    ),
    _NoticeQuality(label: 'Funny', emoji: '😊'),
    _NoticeQuality(label: 'Ambitious', icon: Icons.star_outline),
    _NoticeQuality(label: 'Warm', icon: Icons.wb_sunny_outlined),
    _NoticeQuality(label: 'Honest', icon: Icons.verified_user_outlined),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
      decoration: BoxDecoration(
        color: AppColors.white,
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
            'Positive qualities',
            style: IntentLoginStyles.onboardingSectionTitle.copyWith(
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final quality in _qualities)
                _NoticeQualityChip(quality: quality),
            ],
          ),
        ],
      ),
    );
  }
}

class _NoticeQualityChip extends StatelessWidget {
  const _NoticeQualityChip({required this.quality});

  final _NoticeQuality quality;

  @override
  Widget build(BuildContext context) {
    final isHighlighted = quality.style == _NoticeChipStyle.highlighted;
    final showPlus = quality.style != _NoticeChipStyle.normal;
    final contentColor =
        isHighlighted ? AppColors.white : AppColors.intentText;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isHighlighted ? AppColors.intentForest : AppColors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isHighlighted
              ? AppColors.intentForest
              : AppColors.intentInputBorder.withValues(alpha: 0.55),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (quality.emoji != null)
            Text(
              quality.emoji!,
              style: const TextStyle(fontSize: 14, height: 1),
            )
          else
            Icon(quality.icon, size: 15, color: contentColor),
          const SizedBox(width: 6),
          Text(
            quality.label,
            style: IntentLoginStyles.onboardingSubtitle.copyWith(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: contentColor,
            ),
          ),
          if (showPlus) ...[
            const SizedBox(width: 8),
            const _GoldPlusBadge(),
          ],
        ],
      ),
    );
  }
}

class _GoldPlusBadge extends StatelessWidget {
  const _GoldPlusBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 16,
      height: 16,
      decoration: BoxDecoration(
        color: AppColors.intentGold,
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.add,
        size: 11,
        color: AppColors.white,
      ),
    );
  }
}

class PeopleNoticeMostNoticedCard extends StatelessWidget {
  const PeopleNoticeMostNoticedCard({super.key});

  static const _items = [
    _MostNoticedItem('Good listener', Icons.mic_none_outlined),
    _MostNoticedItem('Respectful', Icons.verified_user_outlined),
    _MostNoticedItem('Intentional', Icons.gps_fixed),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 16),
      decoration: BoxDecoration(
        color: AppColors.white,
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
            'Most noticed qualities',
            style: IntentLoginStyles.onboardingSectionTitle.copyWith(
              fontSize: 18,
              color: AppColors.intentText,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              for (var i = 0; i < _items.length; i++) ...[
                if (i > 0) const SizedBox(width: 10),
                Expanded(child: _MostNoticedTile(item: _items[i])),
              ],
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'People often describe Julian as thoughtful, present, and easy '
            'to talk to.',
            textAlign: TextAlign.center,
            style: IntentLoginStyles.onboardingSubtitle.copyWith(
              fontSize: 13,
              height: 1.45,
              color: AppColors.intentTextSoft,
            ),
          ),
        ],
      ),
    );
  }
}

class _MostNoticedItem {
  const _MostNoticedItem(this.label, this.icon);

  final String label;
  final IconData icon;
}

class _MostNoticedTile extends StatelessWidget {
  const _MostNoticedTile({required this.item});

  final _MostNoticedItem item;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: AppColors.intentInputBorder.withValues(alpha: 0.5),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              item.icon,
              size: 24,
              color: AppColors.intentForest,
            ),
            const SizedBox(height: 10),
            Text(
              item.label,
              textAlign: TextAlign.center,
              style: IntentLoginStyles.onboardingCardFieldLabel.copyWith(
                fontSize: 12,
                color: AppColors.intentForest,
                height: 1.25,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PeopleNoticePrivateCard extends StatelessWidget {
  const PeopleNoticePrivateCard({super.key});

  @override
  Widget build(BuildContext context) {
    return _PeopleNoticeInfoCard(
      icon: Icons.verified_user_outlined,
      title: 'Private and respectful',
      body:
          'Highlights are shared thoughtfully and never include private '
          'feedback details.',
    );
  }
}

class PeopleNoticeCharacterCard extends StatelessWidget {
  const PeopleNoticeCharacterCard({super.key});

  @override
  Widget build(BuildContext context) {
    return _PeopleNoticeInfoCard(
      icon: Icons.favorite_border,
      body:
          'Intent helps you understand character beyond photos through '
          'positive patterns over time.',
    );
  }
}

class _PeopleNoticeInfoCard extends StatelessWidget {
  const _PeopleNoticeInfoCard({
    required this.icon,
    this.title,
    required this.body,
  });

  final IconData icon;
  final String? title;
  final String body;

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
                  icon,
                  size: 18,
                  color: AppColors.intentGold.withValues(alpha: 0.95),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (title != null) ...[
                      Text(
                        title!,
                        style: IntentLoginStyles.onboardingCardFieldLabel
                            .copyWith(fontSize: 15),
                      ),
                      const SizedBox(height: 4),
                    ],
                    Text(
                      body,
                      style: IntentLoginStyles.onboardingSubtitle.copyWith(
                        fontSize: 13,
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

class PeopleNoticeContinueButton extends StatelessWidget {
  const PeopleNoticeContinueButton({super.key, this.onPressed});

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
              const Icon(
                Icons.favorite_border,
                size: 18,
                color: AppColors.white,
              ),
              const SizedBox(width: 10),
              Text(
                'Continue',
                style: IntentLoginStyles.onboardingContinue.copyWith(
                  letterSpacing: 0.6,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PeopleNoticeBackToProfileLink extends StatelessWidget {
  const PeopleNoticeBackToProfileLink({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: Text(
          'Back to profile',
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
