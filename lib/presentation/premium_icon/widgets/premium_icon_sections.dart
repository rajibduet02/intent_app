import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';

const _tanBg = Color(0xFFF4E8BF);
const _tanBorder = Color(0xFFE6D79A);
const _previewCircleBg = Color(0xFFF8F0DC);
const _badgeBg = Color(0xFFF8E9D8);
const _benefitCheckBg = Color(0xFFE3C85D);
const _privacyCardBg = Color(0xFFFAF5EB);
const _iconTileBg = Color(0xFFFAF7F2);

enum PremiumIconOption {
  moon(Icons.nightlight_outlined, 'Moon'),
  compass(Icons.explore_outlined, 'Compass'),
  flower(Icons.local_florist_outlined, 'Flower'),
  sparkle(Icons.auto_awesome_outlined, 'Sparkle'),
  heart(Icons.favorite_border, 'Heart'),
  book(Icons.menu_book_outlined, 'Book');

  const PremiumIconOption(this.icon, this.label);

  final IconData icon;
  final String label;
}

class PremiumIconIntroSection extends StatelessWidget {
  const PremiumIconIntroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(child: PremiumIconPurchaseBadge()),
        const SizedBox(height: 14),
        Text(
          'Make your profile \nfeel more like you',
          textAlign: TextAlign.center,
          style: IntentLoginStyles.onboardingTitle.copyWith(
            fontSize: 28,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Choose a premium icon that represents your personality before '
          'photos unlock.',
          textAlign: TextAlign.center,
          style: IntentLoginStyles.onboardingSubtitle.copyWith(
            fontSize: 15,
            height: 1.45,
          ),
        ),
      ],
    );
  }
}

class PremiumIconPurchaseBadge extends StatelessWidget {
  const PremiumIconPurchaseBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: _badgeBg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.intentGoldMuted.withValues(alpha: 0.45),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.lock_outline,
            size: 12,
            color: AppColors.intentGold,
          ),
          const SizedBox(width: 6),
          Text(
            'ONE-TIME PURCHASE',
            style: IntentLoginStyles.onboardingSubtitle.copyWith(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.1,
              color: AppColors.intentGold,
            ),
          ),
        ],
      ),
    );
  }
}

class PremiumIconPreviewCard extends StatelessWidget {
  const PremiumIconPreviewCard({
    super.key,
    required this.selected,
  });

  final PremiumIconOption selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.intentInputBorder.withValues(alpha: 0.35),
        ),
        boxShadow: AppShadows.intentInput,
      ),
      child: Column(
        children: [
          Container(
            width: 96,
            height: 96,
            decoration: BoxDecoration(
              color: _previewCircleBg,
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.intentGoldMuted.withValues(alpha: 0.35),
              ),
            ),
            child: Icon(
              selected.icon,
              size: 36,
              color: AppColors.intentText,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Premium Identity Icon',
            style: IntentLoginStyles.onboardingSubtitle.copyWith(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.intentGold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Divider(
              height: 1,
              thickness: 1,
              color: AppColors.intentInputBorder.withValues(alpha: 0.35),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const _ComparisonAvatar(
                label: 'DEFAULT',
                backgroundColor: Color(0xFFE8EEF2),
                child: Text(
                  'Y',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.intentTextSoft,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Icon(
                  Icons.arrow_forward,
                  size: 18,
                  color: AppColors.intentTextSoft.withValues(alpha: 0.5),
                ),
              ),
              _ComparisonAvatar(
                label: 'PREMIUM',
                backgroundColor: AppColors.intentForest,
                child: Icon(
                  selected.icon,
                  size: 20,
                  color: AppColors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ComparisonAvatar extends StatelessWidget {
  const _ComparisonAvatar({
    required this.label,
    required this.child,
    required this.backgroundColor,
  });

  final String label;
  final Widget child;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: backgroundColor,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: child,
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: IntentLoginStyles.onboardingSubtitle.copyWith(
            fontSize: 9,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.8,
            color: AppColors.intentTextSoft,
          ),
        ),
      ],
    );
  }
}

class PremiumIconSelectionSection extends StatelessWidget {
  const PremiumIconSelectionSection({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  final PremiumIconOption selected;
  final ValueChanged<PremiumIconOption> onSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: AppColors.intentInputBorder.withValues(alpha: 0.35),
        ),
        boxShadow: AppShadows.intentInput,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Choose your icon',
            style: IntentLoginStyles.onboardingSectionTitle.copyWith(
              fontSize: 20,
              color: AppColors.intentForest,
            ),
          ),
          const SizedBox(height: 16),
          GridView.count(
            crossAxisCount: 3,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: 0.78,
            children: PremiumIconOption.values.map((option) {
              return _PremiumIconGridTile(
                option: option,
                isSelected: selected == option,
                onTap: () => onSelected(option),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _PremiumIconGridTile extends StatelessWidget {
  const _PremiumIconGridTile({
    required this.option,
    required this.isSelected,
    required this.onTap,
  });

  final PremiumIconOption option;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: _iconTileBg,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isSelected
                ? AppColors.intentForest
                : AppColors.intentInputBorder.withValues(alpha: 0.55),
            width: isSelected ? 2.5 : 1,
          ),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            SizedBox.expand(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    option.icon,
                    size: 26,
                    color: AppColors.intentForest,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    option.label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: IntentLoginStyles.onboardingSubtitle.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.intentTextSoft,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Positioned(
                top: 6,
                right: 6,
                child: Container(
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    color: AppColors.intentForest,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.intentForest.withValues(alpha: 0.25),
                        blurRadius: 4,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.check,
                    size: 13,
                    color: AppColors.white,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class PremiumIconPricingCard extends StatelessWidget {
  const PremiumIconPricingCard({super.key});

  static const _benefits = [
    'Use it before photos unlock',
    'Change back anytime',
    'No subscription required',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _tanBg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _tanBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              style: IntentLoginStyles.onboardingSectionTitle.copyWith(
                fontSize: 22,
              ),
              children: [
                const TextSpan(text: r'$2.99 '),
                TextSpan(
                  text: 'TOTAL',
                  style: IntentLoginStyles.onboardingSubtitle.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.intentTextSoft,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Unlock this icon permanently for your profile.',
            style: IntentLoginStyles.onboardingSubtitle.copyWith(
              fontSize: 13,
              height: 1.4,
              color: AppColors.intentTextSoft,
            ),
          ),
          const SizedBox(height: 14),
          for (final benefit in _benefits) ...[
            _BenefitRow(text: benefit),
            if (benefit != _benefits.last) const SizedBox(height: 10),
          ],
        ],
      ),
    );
  }
}

class _BenefitRow extends StatelessWidget {
  const _BenefitRow({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: const BoxDecoration(
            color: _benefitCheckBg,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.check,
            size: 12,
            color: AppColors.intentText,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: IntentLoginStyles.onboardingCardFieldLabel.copyWith(
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}

class PremiumIconPrivacyCard extends StatelessWidget {
  const PremiumIconPrivacyCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _privacyCardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.intentInputBorder.withValues(alpha: 0.35),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.lock_outline,
            size: 16,
            color: AppColors.intentTextSoft,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: IntentLoginStyles.onboardingSubtitle.copyWith(
                  fontSize: 13,
                  height: 1.45,
                  color: AppColors.intentTextSoft,
                ),
                children: [
                  const TextSpan(
                    text: 'Premium icons do not change your privacy settings. '
                        'Photos still unlock only through ',
                  ),
                  TextSpan(
                    text: 'Intent\'s',
                    style: IntentLoginStyles.onboardingCardFieldLabel.copyWith(
                      fontSize: 13,
                      height: 1.45,
                      fontWeight: FontWeight.w600,
                      color: AppColors.intentText,
                    ),
                  ),
                  const TextSpan(
                    text: ' intentional date flow.',
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

class PremiumIconUnlockButton extends StatelessWidget {
  const PremiumIconUnlockButton({super.key, this.onPressed});

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
              Icon(
                Icons.auto_awesome,
                size: 16,
                color: AppColors.intentGold.withValues(alpha: 0.95),
              ),
              const SizedBox(width: 4),
              Text(
                'Unlock Icon',
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

class PremiumIconKeepDefaultLink extends StatelessWidget {
  const PremiumIconKeepDefaultLink({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            'Keep Default Initial',
            style: IntentLoginStyles.onboardingSectionTitle.copyWith(
              fontSize: 16,
              decoration: TextDecoration.underline,
              decorationColor: AppColors.intentText,
              height: 1.3,
            ),
          ),
        ),
      ),
    );
  }
}
