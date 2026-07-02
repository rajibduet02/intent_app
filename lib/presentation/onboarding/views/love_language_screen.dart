import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intent_app/app/theme/theme.dart';
import 'package:intent_app/presentation/auth/widgets/login/login_brand_header.dart';
import 'package:intent_app/presentation/auth/widgets/shared/fixed_background_auth_scaffold.dart';
import 'package:intent_app/presentation/onboarding/data/love_language_options.dart';
import 'package:intent_app/presentation/onboarding/providers/love_language_provider.dart';
import 'package:intent_app/presentation/onboarding/widgets/love_language/love_language_header.dart';
import 'package:intent_app/presentation/onboarding/widgets/love_language/love_language_option_card.dart';
import 'package:intent_app/presentation/onboarding/widgets/love_language/relationship_vibe_slider.dart';
import 'package:intent_app/presentation/onboarding/widgets/onboarding_continue_button.dart';

class LoveLanguageScreen extends ConsumerWidget {
  const LoveLanguageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(loveLanguageProvider.notifier);
    final state = ref.watch(loveLanguageProvider);

    return FixedBackgroundAuthScaffold(
      pinnedFooter: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
        child: OnboardingContinueButton(
          isLoading: state.isLoading,
          onPressed: () => unawaited(notifier.submit()),
        ),
      ),
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24).copyWith(
          bottom: 24 + _loveLanguagePinnedFooterHeight,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LoveLanguageHeader(onBack: notifier.onBack),
            const SizedBox(height: AppSpacing.xs),
            const Center(child: IntentLogo()),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'How do you feel most connected?',
              textAlign: TextAlign.center,
              style: IntentLoginStyles.onboardingTitle,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Choose the ways you most naturally give and receive love.',
              textAlign: TextAlign.center,
              style: IntentLoginStyles.onboardingSubtitle,
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              'LOVE LANGUAGE',
              style: IntentLoginStyles.onboardingAssessmentCategory.copyWith(
                fontSize: 12,
                letterSpacing: 1.4,
                fontWeight: FontWeight.w700,
                color: AppColors.intentText,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Select your top 2 or rank them by priority.',
              style: IntentLoginStyles.onboardingHelper.copyWith(
                fontStyle: FontStyle.normal,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            for (var i = 0; i < LoveLanguageOptions.options.length; i++) ...[
              if (i > 0) const SizedBox(height: AppSpacing.sm),
              LoveLanguageOptionCard(
                option: LoveLanguageOptions.options[i],
                rank: state.rankFor(LoveLanguageOptions.options[i].type),
                onTap: () => notifier.toggleLanguage(
                  LoveLanguageOptions.options[i].type,
                ),
              ),
            ],
            const SizedBox(height: AppSpacing.lg),
            Text(
              'Your relationship vibe',
              textAlign: TextAlign.center,
              style: IntentLoginStyles.onboardingSectionTitle,
            ),
            const SizedBox(height: 8),
            Text(
              'Help Intent understand the energy and rhythm you bring into connection.',
              textAlign: TextAlign.center,
              style: IntentLoginStyles.onboardingSubtitle,
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.fromLTRB(16, 18, 16, 10),
              decoration: BoxDecoration(
                color: AppColors.intentCreamDeep.withValues(alpha: 0.55),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.intentInputBorder.withValues(alpha: 0.5),
                ),
              ),
              child: Column(
                children: [
                  for (var i = 0; i < LoveLanguageOptions.vibeAxes.length; i++) ...[
                    if (i > 0) const SizedBox(height: 8),
                    RelationshipVibeSlider(
                      axis: LoveLanguageOptions.vibeAxes[i],
                      value: state.vibeValues[LoveLanguageOptions.vibeAxes[i].id]!,
                      onChanged: (value) => notifier.setVibeValue(
                        LoveLanguageOptions.vibeAxes[i].id,
                        value,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 24),
            const _CompatibilityNote(),
            const SizedBox(height: 16),
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
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.intentGoldMuted.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.intentGoldMuted.withValues(alpha: 0.35),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.shield_outlined,
            size: 18,
            color: AppColors.intentGold.withValues(alpha: 0.95),
          ),
          const SizedBox(width: AppSpacing.xs),
          Expanded(
            child: Text(
              'Your answers help Intent understand compatibility beyond surface-level attraction.',
              style: IntentLoginStyles.onboardingHelper.copyWith(
                fontStyle: FontStyle.normal,
                fontSize: 12,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

const double _loveLanguagePinnedFooterHeight = 72;
