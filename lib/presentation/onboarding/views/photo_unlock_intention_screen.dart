import 'package:flutter/material.dart';
import 'package:intent_app/app/routes/app_router.dart';
import 'package:intent_app/app/routes/app_routes.dart';
import 'package:intent_app/app/theme/theme.dart';
import 'package:intent_app/presentation/auth/widgets/shared/fixed_background_auth_scaffold.dart';
import 'package:intent_app/presentation/onboarding/models/onboarding_phase.dart';
import 'package:intent_app/presentation/onboarding/widgets/onboarding_continue_button.dart';
import 'package:intent_app/presentation/onboarding/widgets/onboarding_progress_header.dart';
import 'package:intent_app/presentation/onboarding/widgets/onboarding_progress_sync.dart';
import 'package:intent_app/presentation/onboarding/widgets/onboarding_timeline.dart';

class PhotoUnlockIntentionScreen extends StatelessWidget {
  const PhotoUnlockIntentionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return OnboardingProgressSync(
      phase: OnboardingPhase.privacyAndSafety,
      questionIndex: 1,
      child: FixedBackgroundAuthScaffold(
        pinnedFooter: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
          child: OnboardingContinueButton(
            label: 'I Understand',
            onPressed: () => appRouter.go(AppRoutes.uploadPhotos),
          ),
        ),
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24).copyWith(
            bottom: 24 + _pinnedFooterHeight,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              OnboardingProgressHeader(
                onBack: () => appRouter.go(AppRoutes.phasePrivacySafety),
              ),
              const SizedBox(height: AppSpacing.sm),
              const _TitleSection(),
              const SizedBox(height: 24),
              const OnboardingTimeline(
                items: [
                  OnboardingTimelineItem(
                    icon: Icons.person_outline,
                    title: 'Profile Created',
                  ),
                  OnboardingTimelineItem(
                    icon: Icons.visibility_off_outlined,
                    title: 'Photos Hidden',
                  ),
                  OnboardingTimelineItem(
                    icon: Icons.event_available_outlined,
                    title: 'Date Proposed',
                  ),
                  OnboardingTimelineItem(
                    icon: Icons.photo_outlined,
                    title: 'Preview Photo Unlocks',
                  ),
                  OnboardingTimelineItem(
                    icon: Icons.favorite_outline,
                    title: 'Real Meeting',
                  ),
                  OnboardingTimelineItem(
                    icon: Icons.photo_library_outlined,
                    title: 'Gallery Available',
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const _PrivacyNote(),
            ],
          ),
        ),
      ),
    );
  }
}

class _TitleSection extends StatelessWidget {
  const _TitleSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Photos unlock with\nintention',
          textAlign: TextAlign.center,
          style: IntentLoginStyles.onboardingTitle,
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'Intent prioritizes meaningful connection over surface-level attraction.',
          textAlign: TextAlign.center,
          style: IntentLoginStyles.onboardingSubtitle,
        ),
      ],
    );
  }
}

class _PrivacyNote extends StatelessWidget {
  const _PrivacyNote();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.verified_user_outlined,
          size: 16,
          color: AppColors.intentGold.withValues(alpha: 0.95),
        ),
        Expanded(
          child: Text(
            'Your privacy is protected until you choose to share more.',
            textAlign: TextAlign.center,
            style: IntentLoginStyles.onboardingHelper.copyWith(
              fontStyle: FontStyle.normal,
              fontSize: 12,
              height: 1.45,
            ),
          ),
        ),
      ],
    );
  }
}

const double _pinnedFooterHeight = 92;
