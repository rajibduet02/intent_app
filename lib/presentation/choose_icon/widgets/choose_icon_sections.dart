import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';
import 'package:intent_app/presentation/choose_icon/models/choose_icon_option.dart';

class ChooseIconNewMatchHeader extends StatelessWidget {
  const ChooseIconNewMatchHeader({
    super.key,
    this.matchName = 'Emma',
  });

  final String matchName;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: IntentLoginStyles.onboardingTitle.copyWith(fontSize: 28),
            children: [
              const TextSpan(text: "It's a "),
              TextSpan(
                text: 'New Match!',
                style: IntentLoginStyles.onboardingTitle.copyWith(
                  fontSize: 28,
                  fontStyle: FontStyle.italic,
                  color: AppColors.intentForest,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'You and $matchName like each other.',
          textAlign: TextAlign.center,
          style: IntentLoginStyles.onboardingSubtitle.copyWith(fontSize: 13),
        ),
      ],
    );
  }
}

class ChooseIconInstructions extends StatelessWidget {
  const ChooseIconInstructions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Choose icons that remind you of yourself',
          textAlign: TextAlign.center,
          style: IntentLoginStyles.onboardingCardFieldLabel.copyWith(
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Select up to 5',
          textAlign: TextAlign.center,
          style: IntentLoginStyles.onboardingSubtitle.copyWith(
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

class ChooseIconTabBar extends StatelessWidget {
  const ChooseIconTabBar({
    super.key,
    required this.selectedTab,
    required this.onTabSelected,
  });

  final ChooseIconTab selectedTab;
  final ValueChanged<ChooseIconTab> onTabSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.intentSegmentFill,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: AppColors.intentInputBorder.withValues(alpha: 0.45),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: _SegmentTab(
              label: 'Free',
              icon: Icons.folder_outlined,
              isSelected: selectedTab == ChooseIconTab.free,
              onTap: () => onTabSelected(ChooseIconTab.free),
            ),
          ),
          Expanded(
            child: _SegmentTab(
              label: 'Premium',
              icon: Icons.lock_outline,
              isSelected: selectedTab == ChooseIconTab.premium,
              onTap: () => onTabSelected(ChooseIconTab.premium),
            ),
          ),
        ],
      ),
    );
  }
}

class _SegmentTab extends StatelessWidget {
  const _SegmentTab({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final activeColor = AppColors.intentForest;
    final inactiveColor = AppColors.intentTextSoft;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(24),
          boxShadow: isSelected ? AppShadows.intentInput : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 16,
              color: isSelected ? activeColor : inactiveColor,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: IntentLoginStyles.onboardingSubtitle.copyWith(
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected ? activeColor : inactiveColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChooseIconGrid extends StatelessWidget {
  const ChooseIconGrid({
    super.key,
    required this.icons,
    required this.selectedIds,
    required this.onIconTap,
    this.locked = false,
  });

  final List<ChooseIconOption> icons;
  final Set<String> selectedIds;
  final ValueChanged<ChooseIconOption> onIconTap;
  final bool locked;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: icons.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        // mainAxisSpacing: 14,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        // crossAxisSpacing: 8,
        childAspectRatio: 0.78,
      ),
      itemBuilder: (context, index) {
        final option = icons[index];
        final isSelected = selectedIds.contains(option.id);

        return _IconTile(
          option: option,
          isSelected: isSelected,
          isLocked: locked || option.isLocked || option.isPremium,
          onTap: () => onIconTap(option),
        );
      },
    );
  }
}

class _IconTile extends StatelessWidget {
  const _IconTile({
    required this.option,
    required this.isSelected,
    required this.isLocked,
    required this.onTap,
  });

  final ChooseIconOption option;
  final bool isSelected;
  final bool isLocked;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLocked ? null : onTap,
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected
                      ? AppColors.intentForest.withValues(alpha: 0.06)
                      : Colors.transparent,
                  border: Border.all(
                    color: isSelected
                        ? AppColors.intentForest
                        : AppColors.intentInputBorder.withValues(alpha: 0.75),
                    width: isSelected ? 1.5 : 1,
                  ),
                ),
                child: Icon(
                  option.icon,
                  size: 22,
                  color: isSelected
                      ? AppColors.intentForest
                      : AppColors.intentTextSoft.withValues(alpha: 0.85),
                ),
              ),
              if (isSelected)
                Positioned(
                  top: -2,
                  right: -2,
                  child: Container(
                    width: 18,
                    height: 18,
                    decoration: const BoxDecoration(
                      color: AppColors.intentForest,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check,
                      size: 11,
                      color: AppColors.white,
                    ),
                  ),
                ),
              if (isLocked && !isSelected)
                Positioned(
                  top: -2,
                  right: -2,
                  child: Container(
                    width: 18,
                    height: 18,
                    decoration: BoxDecoration(
                      color: AppColors.intentTextSoft.withValues(alpha: 0.4),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.lock,
                      size: 10,
                      color: AppColors.white.withValues(alpha: 0.95),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            option.label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: IntentLoginStyles.onboardingSubtitle.copyWith(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: isSelected
                  ? AppColors.intentText
                  : AppColors.intentTextSoft.withValues(alpha: 0.9),
            ),
          ),
        ],
      ),
    );
  }
}

class ChooseIconSelectionPill extends StatelessWidget {
  const ChooseIconSelectionPill({
    super.key,
    required this.selectedCount,
    required this.maxCount,
  });

  final int selectedCount;
  final int maxCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.intentForest,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.intentForest.withValues(alpha: 0.25),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.check, size: 14, color: AppColors.white),
          const SizedBox(width: 6),
          Text(
            '$selectedCount/$maxCount selected',
            style: IntentLoginStyles.onboardingSubtitle.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class ChooseIconProfileSummary extends StatelessWidget {
  const ChooseIconProfileSummary({
    super.key,
    this.name = 'Emma',
    this.age = 27,
    this.location = 'Austin, TX',
  });

  final String name;
  final int age;
  final String location;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '$name, $age',
              style: IntentLoginStyles.onboardingTitle.copyWith(fontSize: 26),
            ),
            const SizedBox(width: 6),
            Icon(
              Icons.star_rounded,
              size: 18,
              color: AppColors.accentBlue.withValues(alpha: 0.85),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.location_on_outlined,
              size: 14,
              color: AppColors.intentTextSoft,
            ),
            const SizedBox(width: 2),
            Text(
              location,
              style: IntentLoginStyles.onboardingSubtitle.copyWith(
                fontSize: 12,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class ChooseIconWhyMatchedCard extends StatelessWidget {
  const ChooseIconWhyMatchedCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.intentCreamDeep.withValues(alpha: 0.65),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.intentInputBorder.withValues(alpha: 0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Icon(
                Icons.auto_awesome,
                size: 16,
                color: AppColors.intentGold.withValues(alpha: 0.95),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  'Why you matched',
                  style: IntentLoginStyles.onboardingCardFieldLabel.copyWith(
                    fontSize: 14,
                  ),
                ),
              ),
              _PremiumTag(),
            ],
          ),
          const SizedBox(height: 10),
          const _MatchReasonChip(
            icon: Icons.favorite_border,
            label: 'Shared value in honesty',
          ),
          const SizedBox(height: 8),
          const _MatchReasonChip(
            icon: Icons.terrain_outlined,
            label: 'Both love outdoor travel',
          ),
          const SizedBox(height: 8),
          const _MatchReasonChip(
            icon: Icons.music_note_outlined,
            label: 'Similar taste in music',
          ),
        ],
      ),
    );
  }
}

class _PremiumTag extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.white.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.intentInputBorder.withValues(alpha: 0.55),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.lock_outline,
            size: 11,
            color: AppColors.intentTextSoft,
          ),
          const SizedBox(width: 3),
          Text(
            'PREMIUM',
            style: IntentLoginStyles.onboardingSubtitle.copyWith(
              fontSize: 9,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _MatchReasonChip extends StatelessWidget {
  const _MatchReasonChip({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.intentInputBorder.withValues(alpha: 0.45),
        ),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: AppColors.intentForest),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              label,
              style: IntentLoginStyles.onboardingSubtitle.copyWith(
                fontSize: 12,
                color: AppColors.intentText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChooseIconIcebreakerSection extends StatelessWidget {
  const ChooseIconIcebreakerSection({super.key});

  static const _prompts = [
    "What's your favorite outdoor adventure you've ever been on?",
    'If you could travel anywhere tomorrow, where would you go?',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Icon(
              Icons.chevron_left,
              size: 18,
              color: AppColors.intentTextSoft,
            ),
            const SizedBox(width: 4),
            Text(
              'Icebreaker suggestions',
              style: IntentLoginStyles.onboardingCardFieldLabel.copyWith(
                fontSize: 14,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        for (final prompt in _prompts) ...[
          _IcebreakerCard(prompt: prompt),
          const SizedBox(height: 8),
        ],
      ],
    );
  }
}

class _IcebreakerCard extends StatelessWidget {
  const _IcebreakerCard({required this.prompt});

  final String prompt;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppColors.intentInputBorder.withValues(alpha: 0.55),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              prompt,
              style: IntentLoginStyles.onboardingSubtitle.copyWith(
                fontSize: 12,
                height: 1.4,
                color: AppColors.intentText,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Icon(
            Icons.chat_bubble_outline,
            size: 18,
            color: AppColors.intentTextSoft.withValues(alpha: 0.8),
          ),
        ],
      ),
    );
  }
}

class ChooseIconPhotoUnlockBanner extends StatelessWidget {
  const ChooseIconPhotoUnlockBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.intentSegmentFill,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppColors.intentInputBorder.withValues(alpha: 0.5),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.lock_outline,
            size: 16,
            color: AppColors.intentForest,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'PHOTOS UNLOCK ONCE YOUR DATE IS SCHEDULED.',
              style: IntentLoginStyles.onboardingSubtitle.copyWith(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.3,
                color: AppColors.intentText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChooseIconActionButtons extends StatelessWidget {
  const ChooseIconActionButtons({
    super.key,
    this.onStartChat,
    this.onProposeDate,
    this.onSaveForLater,
  });

  final VoidCallback? onStartChat;
  final VoidCallback? onProposeDate;
  final VoidCallback? onSaveForLater;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          width: double.infinity,
          height: AppSpacing.primaryButtonHeight,
          child: ElevatedButton(
            onPressed: onStartChat,
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
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.chat_bubble_outline,
                  size: 18,
                  color: AppColors.white,
                ),
                const SizedBox(width: 4),
                Text(
                  'START CHAT',
                  style: IntentLoginStyles.onboardingContinue,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              AppSpacing.primaryButtonBorderRadius,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.intentForest.withValues(alpha: 0.14),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: SizedBox(
            width: double.infinity,
            height: AppSpacing.primaryButtonHeight,
            child: ElevatedButton(
              onPressed: onProposeDate,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.intentCreamDeep.withValues(alpha: 0.85),
                foregroundColor: AppColors.intentText,
                elevation: 0,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    AppSpacing.primaryButtonBorderRadius,
                  ),
                  side: BorderSide(
                    color: AppColors.intentInputBorder.withValues(alpha: 0.9),
                    width: 1.25,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    size: 18,
                    color: AppColors.intentText.withValues(alpha: 0.9),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'PROPOSE DATE',
                    style: IntentLoginStyles.onboardingContinue.copyWith(
                      color: AppColors.intentText,
                      letterSpacing: 0.8,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 14),
        Center(
          child: GestureDetector(
            onTap: onSaveForLater,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.bookmark_border,
                  size: 16,
                  color: AppColors.intentTextSoft,
                ),
                const SizedBox(width: 4),
                Text(
                  'Save For Later',
                  style: IntentLoginStyles.onboardingSubtitle.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.intentTextSoft,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
