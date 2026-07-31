import 'package:flutter/material.dart';
import 'package:intent_app/app/routes/app_router.dart';
import 'package:intent_app/app/routes/app_routes.dart';
import 'package:intent_app/app/theme/theme.dart';
import 'package:intent_app/presentation/onboarding/widgets/section_intro_page.dart';

class IntroThoughtfulProfileScreen extends StatelessWidget {
  const IntroThoughtfulProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionIntroPage(
      onBack: () => appRouter.go(AppRoutes.introConnectionBeforeAttraction),
      title: 'How your profile is built',
      subtitle:
          'A short guided setup helps Intent understand how you connect — '
          'usually about five minutes.',
      continueLabel: 'Begin Setup',
      extra: const _SetupStats(),
      onContinue: () => appRouter.go(AppRoutes.phaseAboutYou),
    );
  }
}

class _SetupStats extends StatelessWidget {
  const _SetupStats();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: _StatCard(
            value: '≈5 minutes',
            label: 'Typical setup time',
          ),
        ),
        const SizedBox(width: 12),
        const Expanded(
          child: _StatCard(
            value: '25–30',
            label: 'Guided questions',
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.value,
    required this.label,
  });

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: AppShadows.intentInput,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
        child: Column(
          children: [
            Text(
              value,
              textAlign: TextAlign.center,
              style: IntentLoginStyles.onboardingAssessmentTitle.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              label,
              textAlign: TextAlign.center,
              style: IntentLoginStyles.onboardingSubtitle.copyWith(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
