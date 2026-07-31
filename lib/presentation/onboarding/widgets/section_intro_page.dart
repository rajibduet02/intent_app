import 'package:flutter/material.dart';
import 'package:intent_app/app/theme/theme.dart';
import 'package:intent_app/presentation/auth/widgets/login/login_brand_header.dart';
import 'package:intent_app/presentation/auth/widgets/shared/fixed_background_auth_scaffold.dart';
import 'package:intent_app/presentation/onboarding/widgets/onboarding_continue_button.dart';

const double sectionIntroPinnedFooterHeight = 76;

/// Lightweight intro used for product intros and phase openers.
class SectionIntroPage extends StatelessWidget {
  const SectionIntroPage({
    super.key,
    this.onBack,
    required this.title,
    required this.subtitle,
    required this.onContinue,
    this.continueLabel = 'Continue',
    this.eyebrow,
    this.illustration,
    this.extra,
    this.showLogo = true,
  });

  final VoidCallback? onBack;
  final String title;
  final String subtitle;
  final VoidCallback onContinue;
  final String continueLabel;
  final String? eyebrow;
  final Widget? illustration;
  final Widget? extra;
  final bool showLogo;

  @override
  Widget build(BuildContext context) {
    return FixedBackgroundAuthScaffold(
      pinnedFooter: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
        child: OnboardingContinueButton(
          label: continueLabel,
          onPressed: onContinue,
        ),
      ),
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24).copyWith(
          bottom: 24 + sectionIntroPinnedFooterHeight,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 48,
              child: Row(
                children: [
                  if (onBack != null)
                    IntentBackButton(onPressed: onBack!)
                  else
                    const SizedBox(width: 40),
                ],
              ),
            ),
            if (showLogo) ...[
              const SizedBox(height: AppSpacing.xs),
              const Center(child: IntentLogo()),
              const SizedBox(height: AppSpacing.sm),
            ],
            if (eyebrow != null) ...[
              Align(
                alignment: Alignment.center,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                  decoration: BoxDecoration(
                    color: AppColors.intentGoldMuted.withValues(alpha: 0.14),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Text(
                    eyebrow!,
                    style:
                        IntentLoginStyles.onboardingAssessmentCategory.copyWith(
                      color: AppColors.intentGold,
                      letterSpacing: 1.6,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
            ],
            Text(
              title,
              textAlign: TextAlign.center,
              style: IntentLoginStyles.onboardingTitle,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: IntentLoginStyles.onboardingSubtitle,
            ),
            if (illustration != null) ...[
              const SizedBox(height: 28),
              illustration!,
            ],
            if (extra != null) ...[
              const SizedBox(height: 24),
              extra!,
            ],
          ],
        ),
      ),
    );
  }
}
