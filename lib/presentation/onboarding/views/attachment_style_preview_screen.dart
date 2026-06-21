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
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
        child: OnboardingContinueButton(
          showArrow: true,
          arrowColor: AppColors.white,
          onPressed: () => appRouter.go(AppRoutes.loveLanguage),
        ),
      ),
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24).copyWith(
          bottom: 24 + _previewPinnedFooterHeight,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [
            _PreviewHeader(),
            SizedBox(height: 24),
            _TopIntro(),
            SizedBox(height: 20),
            _ResultCard(),
            SizedBox(height: 18),
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
        DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.intentForest,
            borderRadius: BorderRadius.circular(14),
            boxShadow: AppShadows.intentInput,
          ),
          child: const SizedBox(
            width: 54,
            height: 54,
            child: Center(child: IntentLogo(size: 28)),
          ),
        ),
        const SizedBox(height: 18),
        Text(
          'Your attachment style',
          textAlign: TextAlign.center,
          style: IntentLoginStyles.onboardingTitle,
        ),
        const SizedBox(height: 10),
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

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: AppShadows.intentInput,
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
        child: Column(
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: const BoxDecoration(
                color: Color(0xFFF0EDE6),
                shape: BoxShape.circle,
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Icon(
                    Icons.favorite_border,
                    size: 28,
                    color: AppColors.intentForest.withValues(alpha: 0.85),
                  ),
                  Positioned(
                    bottom: 14,
                    child: Icon(
                      Icons.people_outline,
                      size: 16,
                      color: AppColors.intentTextSoft.withValues(alpha: 0.8),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFF8F0D8),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: AppColors.intentGoldMuted.withValues(alpha: 0.5),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.star,
                    size: 12,
                    color: AppColors.intentGold.withValues(alpha: 0.95),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    'PREVIEW',
                    style: IntentLoginStyles.onboardingSubtitle.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.intentGold,
                      letterSpacing: 0.8,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            Text(
              'Secure-Leaning',
              textAlign: TextAlign.center,
              style: IntentLoginStyles.onboardingSectionTitle,
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 1,
                    color: AppColors.intentInputBorder,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  Icons.auto_awesome,
                  size: 12,
                  color: AppColors.intentGold.withValues(alpha: 0.9),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    height: 1,
                    color: AppColors.intentInputBorder,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'You tend to communicate with openness, value emotional closeness, and feel comfortable building trust at a steady pace.',
              textAlign: TextAlign.center,
              style: IntentLoginStyles.onboardingSubtitle.copyWith(height: 1.55),
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
        color: AppColors.intentCreamDeep.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.intentInputBorder.withValues(alpha: 0.6),
        ),
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
                  style: IntentLoginStyles.onboardingSubtitle,
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
          padding: const EdgeInsets.only(top: 3, right: 10),
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
