import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';

const _premiumBadgeBg = Color(0xFFF8E9D8);
const _goldBorder = Color(0xFFE6D79A);
const _featureIconBg = Color(0xFFF4E8BF);
const _previewCardBg = Color(0xFFF8F0DC);

class ConnectionPlusHeroSection extends StatelessWidget {
  const ConnectionPlusHeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Icon(
                Icons.auto_awesome,
                size: 14,
                color: AppColors.intentGold.withValues(alpha: 0.85),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'Go deeper with Connection Plus',
                textAlign: TextAlign.center,
                style: IntentLoginStyles.onboardingTitle.copyWith(
                  fontSize: 28,
                  height: 1.2,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Icon(
                Icons.auto_awesome,
                size: 14,
                color: AppColors.intentGold.withValues(alpha: 0.85),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          'Unlock richer compatibility insights, deeper personality '
          'understanding, and more intentional ways to find aligned matches.',
          textAlign: TextAlign.center,
          style: IntentLoginStyles.onboardingSubtitle.copyWith(
            fontSize: 15,
            height: 1.45,
          ),
        ),
        const SizedBox(height: 14),
        Center(child: ConnectionPlusPremiumBadge()),
      ],
    );
  }
}

class ConnectionPlusPremiumBadge extends StatelessWidget {
  const ConnectionPlusPremiumBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: _premiumBadgeBg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.intentGoldMuted.withValues(alpha: 0.45),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.auto_awesome,
            size: 12,
            color: AppColors.intentGold.withValues(alpha: 0.95),
          ),
          const SizedBox(width: 6),
          Text(
            'PREMIUM',
            style: IntentLoginStyles.onboardingSubtitle.copyWith(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
              color: AppColors.intentGold,
            ),
          ),
        ],
      ),
    );
  }
}

class ConnectionPlusPricingCard extends StatelessWidget {
  const ConnectionPlusPricingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _goldBorder),
        boxShadow: AppShadows.intentInput,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: _featureIconBg,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.intentGoldMuted.withValues(alpha: 0.35),
              ),
            ),
            child: Icon(
              Icons.workspace_premium_outlined,
              size: 22,
              color: AppColors.intentGold,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Connection Plus',
                  style: IntentLoginStyles.onboardingSectionTitle.copyWith(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'For users who want deeper clarity before they connect.',
                  style: IntentLoginStyles.onboardingSubtitle.copyWith(
                    fontSize: 13,
                    height: 1.4,
                    color: AppColors.intentTextSoft,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                r'$9.99 / MONTH',
                style: IntentLoginStyles.onboardingCardFieldLabel.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: AppColors.intentGold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Choose your plan',
                style: IntentLoginStyles.onboardingSubtitle.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.intentGold,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.intentGold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ConnectionPlusUnlockSection extends StatelessWidget {
  const ConnectionPlusUnlockSection({super.key});

  static const _features = [
    _UnlockFeature(
      Icons.auto_awesome_outlined,
      'AI-powered compatibility insights',
      'Understand why a match may work beyond the percentage.',
    ),
    _UnlockFeature(
      Icons.psychology_outlined,
      'Deeper personality breakdowns',
      'See more context from MBTI, Enneagram, and attachment style.',
    ),
    _UnlockFeature(
      Icons.filter_alt_outlined,
      'More dealbreaker categories',
      'Add more filters that reflect what matters most to you.',
    ),
    _UnlockFeature(
      Icons.diamond_outlined,
      'Premium icons',
      'Choose from a wider set of profile icons.',
    ),
    _UnlockFeature(
      Icons.insights_outlined,
      'Enhanced match insights',
      'Get richer explanations behind your strongest matches.',
    ),
    _UnlockFeature(
      Icons.tune_outlined,
      'More refined filters',
      'Discover with more intentional search controls.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.intentInputBorder.withValues(alpha: 0.35),
        ),
        boxShadow: AppShadows.intentInput,
      ),
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'What you unlock',
            style: IntentLoginStyles.onboardingSectionTitle.copyWith(
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 12),
          for (var i = 0; i < _features.length; i++) ...[
            if (i > 0)
              Divider(
                height: 1,
                thickness: 1,
                color: AppColors.intentInputBorder.withValues(alpha: 0.3),
              ),
            _UnlockFeatureTile(feature: _features[i]),
          ],
        ],
      ),
    );
  }
}

class _UnlockFeature {
  const _UnlockFeature(this.icon, this.title, this.subtitle);

  final IconData icon;
  final String title;
  final String subtitle;
}

class _UnlockFeatureTile extends StatelessWidget {
  const _UnlockFeatureTile({required this.feature});

  final _UnlockFeature feature;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: _featureIconBg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              feature.icon,
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
                  feature.title,
                  style: IntentLoginStyles.onboardingCardFieldLabel.copyWith(
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  feature.subtitle,
                  style: IntentLoginStyles.onboardingSubtitle.copyWith(
                    fontSize: 12,
                    height: 1.35,
                    color: AppColors.intentTextSoft,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: _featureIconBg,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.check,
              size: 14,
              color: AppColors.intentGold,
            ),
          ),
        ],
      ),
    );
  }
}

class ConnectionPlusComparisonRow extends StatelessWidget {
  const ConnectionPlusComparisonRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Expanded(child: ConnectionPlusFreeComparisonCard()),
        SizedBox(width: 12),
        Expanded(child: ConnectionPlusInsightPreviewCard()),
      ],
    );
  }
}

class ConnectionPlusFreeComparisonCard extends StatelessWidget {
  const ConnectionPlusFreeComparisonCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.intentInputBorder.withValues(alpha: 0.35),
        ),
        boxShadow: AppShadows.intentInput,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Free vs Connection Plus',
            style: IntentLoginStyles.onboardingCardFieldLabel.copyWith(
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          _ComparisonHeaderRow(),
          const SizedBox(height: 8),
          const _ComparisonDataRow(label: 'Weight comp.', plusIncluded: true),
          const SizedBox(height: 6),
          const _ComparisonDataRow(label: 'Alignment pts', plusIncluded: true),
          const SizedBox(height: 6),
          const _ComparisonDataRow(label: 'Dealbreakers', plusIncluded: true),
        ],
      ),
    );
  }
}

class _ComparisonHeaderRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(flex: 2, child: SizedBox()),
        Expanded(
          child: Text(
            'Free',
            textAlign: TextAlign.center,
            style: IntentLoginStyles.onboardingSubtitle.copyWith(
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          child: Text(
            'Plus',
            textAlign: TextAlign.center,
            style: IntentLoginStyles.onboardingSubtitle.copyWith(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: AppColors.intentGold,
            ),
          ),
        ),
      ],
    );
  }
}

class _ComparisonDataRow extends StatelessWidget {
  const _ComparisonDataRow({
    required this.label,
    required this.plusIncluded,
  });

  final String label;
  final bool plusIncluded;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: IntentLoginStyles.onboardingSubtitle.copyWith(
              fontSize: 11,
              color: AppColors.intentTextSoft,
            ),
          ),
        ),
        Expanded(
          child: Icon(
            Icons.remove,
            size: 14,
            color: AppColors.intentTextSoft.withValues(alpha: 0.5),
          ),
        ),
        Expanded(
          child: Icon(
            plusIncluded ? Icons.check : Icons.remove,
            size: 14,
            color: AppColors.intentGold,
          ),
        ),
      ],
    );
  }
}

class ConnectionPlusInsightPreviewCard extends StatelessWidget {
  const ConnectionPlusInsightPreviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _previewCardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.intentGoldMuted.withValues(alpha: 0.35),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Preview of premium insight',
            style: IntentLoginStyles.onboardingCardFieldLabel.copyWith(
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          const _BlurredPreviewLine(widthFactor: 1),
          const SizedBox(height: 6),
          const _BlurredPreviewLine(widthFactor: 0.85),
          const SizedBox(height: 6),
          const _BlurredPreviewLine(widthFactor: 0.7),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.lock_outline,
                size: 14,
                color: AppColors.intentGold,
              ),
              const SizedBox(width: 4),
              Text(
                'Unlock full insight',
                style: IntentLoginStyles.onboardingSubtitle.copyWith(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: AppColors.intentGold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _BlurredPreviewLine extends StatelessWidget {
  const _BlurredPreviewLine({required this.widthFactor});

  final double widthFactor;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: FractionallySizedBox(
        widthFactor: widthFactor,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
            child: Container(
              height: 8,
              color: AppColors.intentGoldMuted.withValues(alpha: 0.45),
            ),
          ),
        ),
      ),
    );
  }
}

class ConnectionPlusPrivacyCard extends StatelessWidget {
  const ConnectionPlusPrivacyCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.intentInputBorder.withValues(alpha: 0.35),
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
              color: _featureIconBg,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.verified_user_outlined,
              size: 18,
              color: AppColors.intentGold,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Upgrading does not change your privacy',
                  style: IntentLoginStyles.onboardingSectionTitle.copyWith(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Photos still unlock only through the Intentional Dating flow.',
                  style: IntentLoginStyles.onboardingSubtitle.copyWith(
                    fontSize: 13,
                    height: 1.45,
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

class ConnectionPlusUpgradeButton extends StatelessWidget {
  const ConnectionPlusUpgradeButton({super.key, this.onPressed});

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
              const SizedBox(width: 10),
              Text(
                'Upgrade to Connection Plus',
                style: IntentLoginStyles.onboardingContinue.copyWith(
                  letterSpacing: 0.4,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ConnectionPlusMaybeLaterLink extends StatelessWidget {
  const ConnectionPlusMaybeLaterLink({super.key, this.onTap});

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
            'Maybe later',
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
