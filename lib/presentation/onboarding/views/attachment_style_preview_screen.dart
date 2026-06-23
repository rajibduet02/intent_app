import 'package:flutter/material.dart';
import 'package:intent_app/app/routes/app_router.dart';
import 'package:intent_app/app/routes/app_routes.dart';
import 'package:intent_app/app/theme/theme.dart';
import 'package:intent_app/presentation/auth/widgets/login/login_brand_header.dart';
import 'package:intent_app/presentation/auth/widgets/shared/fixed_background_auth_scaffold.dart';
import 'package:intent_app/presentation/onboarding/widgets/onboarding_continue_button.dart';

class AttachmentStylePreviewScreen extends StatelessWidget {
  const AttachmentStylePreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FixedBackgroundAuthScaffold(
      pinnedFooter: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
        child: OnboardingContinueButton(
          showArrow: true,
          arrowColor: AppColors.white,
          onPressed: () => appRouter.go(AppRoutes.loveLanguage),
        ),
      ),
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24).copyWith(
          bottom: 24 + _previewPinnedFooterHeight,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [
            _PreviewHeader(),
            SizedBox(height: AppSpacing.xs),
            _TopIntro(),
            SizedBox(height: 16),
            _ResultCard(),
            SizedBox(height: 16),
            _CompatibilityNote(),
          ],
        ),
      ),
    );
  }
}

class _PreviewHeader extends StatelessWidget {
  const _PreviewHeader();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: Row(
        children: [
          IntentBackButton(
            onPressed: () => appRouter.go(AppRoutes.attachmentStyle),
          ),
        ],
      ),
    );
  }
}

class _TopIntro extends StatelessWidget {
  const _TopIntro();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Center(child: IntentLogo()),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'Your attachment style',
          textAlign: TextAlign.center,
          style: IntentLoginStyles.onboardingTitle,
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'Understanding how you connect helps Intent suggest healthier, more aligned matches.',
          textAlign: TextAlign.center,
          style: IntentLoginStyles.onboardingSubtitle,
        ),
      ],
    );
  }
}

class _ResultCard extends StatelessWidget {
  const _ResultCard();

  static const _cardRadius = 32.0;
  static const _featureCardFill = Color(0xFFF2EEE4);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(_cardRadius),
        boxShadow: AppShadows.intentInput,
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 28, 20, 24),
        child: Column(
          children: [
            const _AttachmentIconCluster(),
            const SizedBox(height: 14),
            const _PreviewBadge(),
            const SizedBox(height: 14),
            Text(
              'Secure-Leaning',
              textAlign: TextAlign.center,
              style: IntentLoginStyles.onboardingSectionTitle.copyWith(
                fontSize: 28,
                height: 1.15,
              ),
            ),
            const SizedBox(height: 14),
            const _RkBrandDivider(),
            const SizedBox(height: 16),
            Text(
              'You tend to communicate with openness, value emotional '
              'closeness, and feel comfortable building trust at a '
              'steady pace.',
              textAlign: TextAlign.center,
              style: IntentLoginStyles.onboardingSubtitle.copyWith(
                fontSize: 12,
                height: 1.55,
              ),
            ),
            const SizedBox(height: 16),
            const _TraitRow(
              icon: Icons.chat_bubble_outline,
              title: 'Communication',
              subtitle: 'Open and steady',
            ),
            const SizedBox(height: 10),
            const _TraitRow(
              icon: Icons.favorite_border,
              title: 'Closeness',
              subtitle: 'Comfortable with trust',
            ),
          ],
        ),
      ),
    );
  }
}

class _AttachmentIconCluster extends StatelessWidget {
  const _AttachmentIconCluster();

  static const _circleSize = 120.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _circleSize,
      height: _circleSize,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Container(
            width: _circleSize,
            height: _circleSize,
            decoration: const BoxDecoration(
              color: Color(0xFFF0EDE6),
              shape: BoxShape.circle,
            ),
          ),
          Image.asset(
            AppAssets.lovePerson,
            width: 54,
            height: 54,
            fit: BoxFit.contain,
          ),
          Positioned(
            top: 8,
            right: 2,
            child: Image.asset(
              AppAssets.rkBrand1,
              width: 46,
              height: 22,
              fit: BoxFit.contain,
            ),
          ),
          Positioned(
            left: 6,
            bottom: 10,
            child: Opacity(
              opacity: 0.22,
              child: Image.asset(
                AppAssets.rkBrand1,
                width: 38,
                height: 18,
                fit: BoxFit.contain,
              ),
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F0D8),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.intentGoldMuted.withValues(alpha: 0.55),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            AppAssets.rkBrand,
            height: 14,
            fit: BoxFit.contain,
          ),
          const SizedBox(width: 6),
          Text(
            'PREVIEW',
            style: IntentLoginStyles.onboardingSubtitle.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.intentGold,
              letterSpacing: 0.8,
            ),
          ),
        ],
      ),
    );
  }
}

class _RkBrandDivider extends StatelessWidget {
  const _RkBrandDivider();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 1,
            color: AppColors.intentInputBorder.withValues(alpha: 0.85),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Image.asset(
            AppAssets.rkBrand,
            height: 16,
            fit: BoxFit.contain,
          ),
        ),
        Expanded(
          child: Container(
            height: 1,
            color: AppColors.intentInputBorder.withValues(alpha: 0.85),
          ),
        ),
      ],
    );
  }
}

class _TraitRow extends StatelessWidget {
  const _TraitRow({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: _ResultCard._featureCardFill,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: AppColors.intentTextSoft,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: IntentLoginStyles.onboardingAssessmentTitle,
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: IntentLoginStyles.onboardingSubtitle.copyWith(
                    fontSize: 12,
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

class _CompatibilityNote extends StatelessWidget {
  const _CompatibilityNote();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          // padding: const EdgeInsets.only(top: 3, right: 10),
          padding: const EdgeInsets.only(top: 0, right: 0),
          child: Icon(
            Icons.verified_user_outlined,
            size: 18,
            color: AppColors.intentGold.withValues(alpha: 0.9),
          ),
        ),
        Expanded(
          child: Text(
            'Your answers help Intent understand compatibility beyond surface-level attraction.',
            textAlign: TextAlign.center,
            style: IntentLoginStyles.onboardingHelper.copyWith(
              fontStyle: FontStyle.normal,
            ),
          ),
        ),
      ],
    );
  }
}

const double _previewPinnedFooterHeight = 92;
