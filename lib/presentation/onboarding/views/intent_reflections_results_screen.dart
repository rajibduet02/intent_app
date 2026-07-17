import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:intent_app/app/theme/theme.dart';
import 'package:intent_app/presentation/auth/widgets/login/login_brand_header.dart';
import 'package:intent_app/presentation/auth/widgets/shared/fixed_background_auth_scaffold.dart';
import 'package:intent_app/presentation/onboarding/models/intent_reflection_result.dart';
import 'package:intent_app/presentation/onboarding/providers/intent_reflections_provider.dart';
import 'package:intent_app/presentation/onboarding/widgets/onboarding_continue_button.dart';

const double _resultsPinnedFooterHeight = 76;

class IntentReflectionsResultsScreen extends ConsumerWidget {
  const IntentReflectionsResultsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(intentReflectionsProvider.notifier);
    final result = ref.watch(intentReflectionsProvider).result;

    if (result == null || result.constructs.isEmpty) {
      return FixedBackgroundAuthScaffold(
        child: Center(
          child: Text(
            'Your reflections are still loading.',
            style: IntentLoginStyles.onboardingSubtitle,
          ),
        ),
      );
    }

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
              'Your Intent Reflections',
              textAlign: TextAlign.center,
              style: IntentLoginStyles.onboardingTitle,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'A thoughtful look at how you show up — without scores or labels '
              'that reduce who you are.',
              textAlign: TextAlign.center,
              style: IntentLoginStyles.onboardingSubtitle,
            ),
            const SizedBox(height: 24),
            for (var i = 0; i < result.constructs.length; i++) ...[
              if (i > 0) const SizedBox(height: 16),
              _ConstructCard(construct: result.constructs[i]),
              const SizedBox(height: 12),
              _ConversationInsightCard(construct: result.constructs[i]),
            ],
            const SizedBox(height: 16),
            const _CompatibilityInsightBanner(),
          ],
        ),
      ),
    );
  }
}

class _ConstructCard extends StatelessWidget {
  const _ConstructCard({required this.construct});

  final IntentReflectionConstructResult construct;

  Color get _badgeColor => switch (construct.category) {
        ReflectionCategory.strength => AppColors.intentForest,
        ReflectionCategory.healthy => AppColors.intentGold,
        ReflectionCategory.roomForGrowth => const Color(0xFFB07A3A),
        ReflectionCategory.requiresGreaterIntentionality =>
          AppColors.intentTextSoft,
      };

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
            Row(
              children: [
                Expanded(
                  child: Text(
                    construct.constructName,
                    style: IntentLoginStyles.onboardingTitle.copyWith(
                      fontSize: 20,
                    ),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: _badgeColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: _badgeColor.withValues(alpha: 0.35),
                    ),
                  ),
                  child: Text(
                    construct.category.displayLabel,
                    style: IntentLoginStyles.onboardingAssessmentCategory
                        .copyWith(
                      color: _badgeColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 10,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              construct.shortDescription,
              style: IntentLoginStyles.onboardingSubtitle.copyWith(
                fontSize: 14,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 16),
            _LabeledBody(
              label: 'What this measures',
              body: construct.whatThisMeasures,
            ),
            const SizedBox(height: 12),
            _LabeledBody(
              label: 'What your responses suggest',
              body: construct.whatResponsesSuggest,
            ),
            const SizedBox(height: 12),
            _LabeledBody(
              label: 'Why it matters',
              body: construct.whyItMatters,
            ),
          ],
        ),
      ),
    );
  }
}

class _ConversationInsightCard extends StatelessWidget {
  const _ConversationInsightCard({required this.construct});

  final IntentReflectionConstructResult construct;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.intentCreamDeep.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.intentInputBorder.withValues(alpha: 0.5),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Reflection',
              style: IntentLoginStyles.onboardingAssessmentCategory.copyWith(
                color: AppColors.intentGold,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.1,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '"${construct.reflectionInsight}"',
              style: IntentLoginStyles.mbtiQuestion.copyWith(
                fontSize: 15,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 14),
            Text(
              'Conversation Starter',
              style: IntentLoginStyles.onboardingAssessmentCategory.copyWith(
                color: AppColors.intentForest,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.1,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '"${construct.conversationStarter}"',
              style: IntentLoginStyles.onboardingSubtitle.copyWith(
                fontSize: 14,
                height: 1.4,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CompatibilityInsightBanner extends StatelessWidget {
  const _CompatibilityInsightBanner();

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
              'You appreciate healthy communication and intentional growth. '
              'Partners who value honesty and repair will likely feel aligned '
              'with how you show up.',
              style: IntentLoginStyles.onboardingSubtitle.copyWith(
                fontSize: 13,
                height: 1.45,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LabeledBody extends StatelessWidget {
  const _LabeledBody({required this.label, required this.body});

  final String label;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: IntentLoginStyles.onboardingCardFieldLabel.copyWith(
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          body,
          style: IntentLoginStyles.onboardingSubtitle.copyWith(
            fontSize: 13,
            height: 1.4,
          ),
        ),
      ],
    );
  }
}
