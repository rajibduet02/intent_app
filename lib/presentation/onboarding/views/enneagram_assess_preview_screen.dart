import 'package:flutter/material.dart';
import 'package:intent_app/app/routes/app_router.dart';
import 'package:intent_app/app/routes/app_routes.dart';
import 'package:intent_app/app/theme/theme.dart';
import 'package:intent_app/presentation/auth/widgets/login/login_brand_header.dart';
import 'package:intent_app/presentation/auth/widgets/shared/fixed_background_auth_scaffold.dart';
import 'package:intent_app/presentation/onboarding/widgets/onboarding_continue_button.dart';

class EnneagramAssessPreviewScreen extends StatelessWidget {
  const EnneagramAssessPreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FixedBackgroundAuthScaffold(
      pinnedFooter: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
        child: OnboardingContinueButton(
          showArrow: true,
          arrowColor: AppColors.intentGold,
          onPressed: () => appRouter.go(AppRoutes.attachmentStyle),
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
            _ConnectionPlusCard(),
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
            onPressed: () => appRouter.go(AppRoutes.enneagramAssessment),
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
          'Your Enneagram style',
          textAlign: TextAlign.center,
          style: IntentLoginStyles.onboardingTitle,
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'A glimpse into your relationship patterns helps us suggest more aligned matches.',
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
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 18),
        child: Column(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: const BoxDecoration(
                color: Color(0xFFE3EFE6),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.favorite,
                color: AppColors.intentForest,
                size: 26,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFF8F0D8),
                borderRadius: BorderRadius.circular(20),
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
                    'Preview',
                    style: IntentLoginStyles.onboardingSubtitle.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.intentGold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            Text(
              'Type 2 — The \nSupportive Partner',
              textAlign: TextAlign.center,
              style: IntentLoginStyles.onboardingSectionTitle.copyWith(
                fontSize: 16,
              ),
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
              'You naturally show love through care, support, and attentiveness, often making others feel deeply valued and emotionally safe.',
              textAlign: TextAlign.center,
              style: IntentLoginStyles.onboardingSubtitle.copyWith(height: 1.55),
            ),
          ],
        ),
      ),
    );
  }
}

class _ConnectionPlusCard extends StatelessWidget {
  const _ConnectionPlusCard();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: const Color(0xFFF4E8BF),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE6D79A)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppColors.intentForest,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.lock, size: 18, color: AppColors.white),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'Unlock deeper compatibility insights with Connection Plus.',
                style: IntentLoginStyles.onboardingAssessmentTitle,
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: AppColors.intentText,
              size: 20,
            ),
          ],
        ),
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
