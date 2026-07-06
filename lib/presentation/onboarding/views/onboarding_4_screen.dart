import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intent_app/app/theme/theme.dart';
import 'package:intent_app/presentation/auth/widgets/shared/fixed_background_auth_scaffold.dart';
import 'package:intent_app/presentation/onboarding/providers/onboarding_4_provider.dart';
import 'package:intent_app/presentation/onboarding/providers/onboarding_4_state.dart';
import 'package:intent_app/presentation/onboarding/widgets/onboarding_assessment_tile.dart';
import 'package:intent_app/presentation/onboarding/widgets/onboarding_continue_button.dart';
import 'package:intent_app/presentation/onboarding/widgets/onboarding_dealbreaker_option.dart';
import 'package:intent_app/presentation/onboarding/widgets/onboarding_header.dart';

class Onboarding4Screen extends ConsumerWidget {
  const Onboarding4Screen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(onboarding4Provider.notifier);
    final state = ref.watch(onboarding4Provider);
    final dealbreakers = OnboardingDealbreakerType.values;

    return FixedBackgroundAuthScaffold(
      pinnedFooter: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
        child: OnboardingContinueButton(
          label: 'BEGIN',
          isLoading: state.isLoading,
          onPressed: () => unawaited(notifier.submit()),
        ),
      ),
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24).copyWith(
          bottom: 24 + _onboarding4PinnedFooterHeight,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            OnboardingHeader(
              currentStep: 4,
              totalSteps: 5,
              showLogo: false,
              showProgressDots: false,
              onBack: notifier.onBack,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Choose your dealbreaker',
              style: IntentLoginStyles.onboardingTitle,
            ),
            const SizedBox(height: 8),
            Text(
              'Dealbreakers help Intent protect your time and show '
              'stronger matches.',
              style: IntentLoginStyles.onboardingSubtitle,
            ),
            const SizedBox(height: 16),
            DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.intentCreamDeep,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  for (var i = 0; i < dealbreakers.length; i++)
                    OnboardingDealbreakerOption(
                      label: dealbreakers[i].label,
                      isSelected: state.selectedDealbreaker == dealbreakers[i],
                      onTap: () => notifier.selectDealbreaker(dealbreakers[i]),
                      showDivider: i < dealbreakers.length - 1,
                    ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Free members can choose 1 dealbreaker.',
              textAlign: TextAlign.center,
              style: IntentLoginStyles.onboardingHelper.copyWith(
                fontStyle: FontStyle.normal,
              ),
            ),
            const SizedBox(height: 8),
            const OnboardingPlusNote(),
            const SizedBox(height: 28),
            Text(
              "Now let's understand your compatibility style",
              style: IntentLoginStyles.onboardingTitle,
            ),
            const SizedBox(height: 8),
            Text(
              'Answer short guided questions instead of choosing your own '
              'type. This helps improve accuracy.',
              style: IntentLoginStyles.onboardingSubtitle,
            ),
            const SizedBox(height: 16),
            DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: AppShadows.intentInput,
              ),
              child: Column(
                children: [
                  for (var i = 0; i < Onboarding4Notifier.assessments.length; i++)
                    OnboardingAssessmentTile(
                      item: Onboarding4Notifier.assessments[i],
                      onTap: () {},
                      showDivider:
                          i < Onboarding4Notifier.assessments.length - 1,
                    ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'These answers help Intent create more meaningful '
              'compatibility insights.',
              textAlign: TextAlign.center,
              style: IntentLoginStyles.onboardingFooterNote,
            ),
          ],
        ),
      ),
    );
  }
}

const double _onboarding4PinnedFooterHeight = 76;
