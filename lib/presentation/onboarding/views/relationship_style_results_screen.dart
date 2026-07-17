import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:intent_app/app/theme/theme.dart';
import 'package:intent_app/presentation/auth/widgets/login/login_brand_header.dart';
import 'package:intent_app/presentation/auth/widgets/shared/fixed_background_auth_scaffold.dart';
import 'package:intent_app/presentation/onboarding/data/relationship_style_content.dart';
import 'package:intent_app/presentation/onboarding/providers/relationship_style_assessment_provider.dart';
import 'package:intent_app/presentation/onboarding/widgets/onboarding_continue_button.dart';

const double _resultsPinnedFooterHeight = 76;

class RelationshipStyleResultsScreen extends ConsumerWidget {
  const RelationshipStyleResultsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(relationshipStyleAssessmentProvider.notifier);
    final result = ref.watch(relationshipStyleAssessmentProvider).result;

    if (result == null) {
      return FixedBackgroundAuthScaffold(
        child: Center(
          child: Text(
            'Your relationship style is still loading.',
            style: IntentLoginStyles.onboardingSubtitle,
          ),
        ),
      );
    }

    final primaryProfile =
        RelationshipStyleContent.profileFor(result.primary);
    final secondary = result.secondary;
    final secondaryProfile = secondary == null
        ? null
        : RelationshipStyleContent.profileFor(secondary);

    return FixedBackgroundAuthScaffold(
      pinnedFooter: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
        child: OnboardingContinueButton(
          label: 'CONTINUE',
          onPressed: notifier.continueFromResults,
        ),
      ),
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24).copyWith(
          bottom: 24 + _resultsPinnedFooterHeight,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 48,
              child: Row(
                children: [
                  IntentBackButton(onPressed: notifier.onBackFromResults),
                ],
              ),
            ),
            const Center(child: IntentLogo()),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Your Relationship Style',
              textAlign: TextAlign.center,
              style: IntentLoginStyles.onboardingTitle,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'A plain-language look at how you tend to connect — '
              'without clinical labels.',
              textAlign: TextAlign.center,
              style: IntentLoginStyles.onboardingSubtitle,
            ),
            const SizedBox(height: 24),
            _PrimaryStyleCard(
              label: result.primaryLabel,
              profile: primaryProfile,
            ),
            if (secondary != null && secondaryProfile != null) ...[
              const SizedBox(height: 14),
              _SecondaryTendencyCard(
                label: result.secondaryLabel!,
                profile: secondaryProfile,
              ),
            ],
            const SizedBox(height: 14),
            _CompatibilityInsightCard(
              insight: primaryProfile.compatibilityInsight,
            ),
          ],
        ),
      ),
    );
  }
}

class _PrimaryStyleCard extends StatelessWidget {
  const _PrimaryStyleCard({
    required this.label,
    required this.profile,
  });

  final String label;
  final RelationshipStyleProfile profile;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: AppShadows.intentInput,
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Primary Style',
              style: IntentLoginStyles.onboardingAssessmentCategory.copyWith(
                color: AppColors.intentGold,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: IntentLoginStyles.onboardingTitle.copyWith(fontSize: 24),
            ),
            const SizedBox(height: 12),
            Text(
              profile.description,
              style: IntentLoginStyles.onboardingSubtitle.copyWith(
                fontSize: 14,
                height: 1.45,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Strengths',
              style: IntentLoginStyles.onboardingCardFieldLabel,
            ),
            const SizedBox(height: 8),
            for (final item in profile.strengths) ...[
              _BulletRow(text: item),
              const SizedBox(height: 6),
            ],
            const SizedBox(height: 10),
            Text(
              'Growth areas',
              style: IntentLoginStyles.onboardingCardFieldLabel,
            ),
            const SizedBox(height: 8),
            for (final item in profile.growthAreas) ...[
              _BulletRow(text: item),
              const SizedBox(height: 6),
            ],
          ],
        ),
      ),
    );
  }
}

class _SecondaryTendencyCard extends StatelessWidget {
  const _SecondaryTendencyCard({
    required this.label,
    required this.profile,
  });

  final String label;
  final RelationshipStyleProfile profile;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.intentCreamDeep.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.intentInputBorder.withValues(alpha: 0.5),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Secondary Tendency',
              style: IntentLoginStyles.onboardingAssessmentCategory.copyWith(
                color: AppColors.intentForest,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'You also show $label tendencies.',
              style: IntentLoginStyles.onboardingTitle.copyWith(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              profile.description,
              style: IntentLoginStyles.onboardingSubtitle.copyWith(
                fontSize: 13,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CompatibilityInsightCard extends StatelessWidget {
  const _CompatibilityInsightCard({required this.insight});

  final String insight;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: AppShadows.intentInput,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Compatibility insight',
              style: IntentLoginStyles.onboardingCardFieldLabel,
            ),
            const SizedBox(height: 8),
            Text(
              insight,
              style: IntentLoginStyles.onboardingSubtitle.copyWith(
                fontSize: 14,
                height: 1.45,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BulletRow extends StatelessWidget {
  const _BulletRow({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Container(
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              color: AppColors.intentGold,
              shape: BoxShape.circle,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: IntentLoginStyles.onboardingSubtitle.copyWith(
              fontSize: 13,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}
