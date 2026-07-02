import 'package:flutter/material.dart';
import 'package:intent_app/app/theme/theme.dart';
import 'package:intent_app/app/routes/app_router.dart';
import 'package:intent_app/app/routes/app_routes.dart';
import 'package:intent_app/presentation/auth/widgets/login/login_brand_header.dart';
import 'package:intent_app/presentation/auth/widgets/shared/fixed_background_auth_scaffold.dart';
import 'package:intent_app/presentation/onboarding/widgets/onboarding_continue_button.dart';

class MbtiAssessPreviewScreen extends StatelessWidget {
  const MbtiAssessPreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FixedBackgroundAuthScaffold(
      pinnedFooter: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
        child: OnboardingContinueButton(
          onPressed: () => appRouter.go(AppRoutes.enneagramAssessment),
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
            SizedBox(height: 24),
            _ResultCard(),
            SizedBox(height: 16),
            _ConnectionPlusCard(),
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
          IntentBackButton(onPressed: () => Navigator.of(context).maybePop()),
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
          'Your MBTI style',
          textAlign: TextAlign.center,
          style: IntentLoginStyles.onboardingTitle,
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'A glimpse of your personality style helps us suggest more aligned matches.',
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
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
        child: Column(
          children: [
            Row(
              children: [
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.intentInputBorder),
                    color: AppColors.intentInputFill,
                  ),
                  child: Text(
                    'PREVIEW',
                    style: IntentLoginStyles.onboardingSubtitle.copyWith(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              width: 42,
              height: 42,
              decoration: const BoxDecoration(
                color: AppColors.intentCreamDeep,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(height: 14),
            Text(
              'INFJ - The Insightful\nConnector',
              textAlign: TextAlign.center,
              style: IntentLoginStyles.onboardingSectionTitle,
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: Container(height: 1, color: AppColors.intentInputBorder),
                ),
                const SizedBox(width: 8),
                Icon(
                  Icons.auto_awesome,
                  size: 12,
                  color: AppColors.intentGold.withValues(alpha: 0.9),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(height: 1, color: AppColors.intentInputBorder),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'You tend to value depth, meaning, and emotional connection. Your presence often acts as a bridge for others to discover their authentic selves.',
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
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFE3C85D),
              ),
              child: const Icon(Icons.lock, size: 18, color: AppColors.intentText),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Connection Plus',
                    style: IntentLoginStyles.onboardingAssessmentTitle,
                  ),
                  Text(
                    'Unlock deeper compatibility insights.',
                    style: IntentLoginStyles.onboardingSubtitle,
                  ),
                ],
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
