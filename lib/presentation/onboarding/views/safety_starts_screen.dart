import 'package:flutter/material.dart';
import 'package:intent_app/app/routes/app_router.dart';
import 'package:intent_app/app/routes/app_routes.dart';
import 'package:intent_app/app/theme/theme.dart';
import 'package:intent_app/presentation/auth/widgets/shared/fixed_background_auth_scaffold.dart';
import 'package:intent_app/presentation/onboarding/models/onboarding_phase.dart';
import 'package:intent_app/presentation/onboarding/widgets/onboarding_continue_button.dart';
import 'package:intent_app/presentation/onboarding/widgets/onboarding_progress_header.dart';
import 'package:intent_app/presentation/onboarding/widgets/onboarding_progress_sync.dart';

/// Short safety intro placed before ID verification.
class SafetyStartsScreen extends StatelessWidget {
  const SafetyStartsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return OnboardingProgressSync(
      phase: OnboardingPhase.privacyAndSafety,
      questionIndex: 4,
      child: FixedBackgroundAuthScaffold(
        pinnedFooter: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
          child: OnboardingContinueButton(
            label: 'Continue',
            onPressed: () => appRouter.go(AppRoutes.uploadId),
          ),
        ),
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24).copyWith(
            bottom: 100,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              OnboardingProgressHeader(
                onBack: () => appRouter.go(AppRoutes.choosePreviewPhotos),
              ),
              const SizedBox(height: AppSpacing.sm),
              const _SafetyHeroIcon(),
              const SizedBox(height: AppSpacing.lg),
              Text(
                'Safety starts with trust',
                textAlign: TextAlign.center,
                style: IntentLoginStyles.onboardingTitle,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'Every member verifies their identity before browsing to help '
                'create a safer community.',
                textAlign: TextAlign.center,
                style: IntentLoginStyles.onboardingSubtitle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SafetyHeroIcon extends StatelessWidget {
  const _SafetyHeroIcon();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 92,
        height: 92,
        decoration: BoxDecoration(
          color: AppColors.white,
          shape: BoxShape.circle,
          border: Border.all(
            color: AppColors.intentGoldMuted.withValues(alpha: 0.65),
            width: 1.5,
          ),
          boxShadow: AppShadows.intentInput,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Icon(
              Icons.shield_outlined,
              size: 38,
              color: AppColors.intentForest,
            ),
            Positioned(
              bottom: 24,
              child: Container(
                width: 16,
                height: 16,
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
          ],
        ),
      ),
    );
  }
}
