import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intent_app/app/routes/app_router.dart';
import 'package:intent_app/app/routes/app_routes.dart';
import 'package:intent_app/presentation/onboarding/models/onboarding_phase.dart';
import 'package:intent_app/presentation/onboarding/providers/onboarding_progress_provider.dart';
import 'package:intent_app/presentation/onboarding/widgets/section_intro_page.dart';

class PhasePrivacySafetyIntroScreen extends ConsumerWidget {
  const PhasePrivacySafetyIntroScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final phase = OnboardingPhase.privacyAndSafety;
    return SectionIntroPage(
      onBack: () => appRouter.go(AppRoutes.profileOverview),
      eyebrow: 'PHASE ${phase.number} OF ${OnboardingPhase.totalPhases}',
      title: phase.title,
      subtitle: phase.subtitle,
      onContinue: () {
        ref.read(onboardingProgressProvider.notifier).setPhase(phase);
        appRouter.go(AppRoutes.photoUnlockIntention);
      },
    );
  }
}
