import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intent_app/app/theme/theme.dart';
import 'package:intent_app/presentation/auth/widgets/shared/fixed_background_auth_scaffold.dart';
import 'package:intent_app/presentation/onboarding/models/onboarding_phase.dart';
import 'package:intent_app/presentation/onboarding/providers/dealbreakers_provider.dart';
import 'package:intent_app/presentation/onboarding/providers/dealbreaker_and_assessments_state.dart';
import 'package:intent_app/presentation/onboarding/widgets/onboarding_continue_button.dart';
import 'package:intent_app/presentation/onboarding/widgets/onboarding_dealbreaker_option.dart';
import 'package:intent_app/presentation/onboarding/widgets/onboarding_progress_header.dart';
import 'package:intent_app/presentation/onboarding/widgets/onboarding_progress_sync.dart';

class DealbreakersScreen extends ConsumerWidget {
  const DealbreakersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(dealbreakersProvider.notifier);
    final state = ref.watch(dealbreakersProvider);
    final dealbreakers = OnboardingDealbreakerType.values;

    return OnboardingProgressSync(
      phase: OnboardingPhase.compatibilityPreferences,
      questionIndex: 2,
      child: FixedBackgroundAuthScaffold(
        pinnedFooter: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
          child: OnboardingContinueButton(
            label: 'CONTINUE',
            isLoading: state.isLoading,
            onPressed: () => unawaited(notifier.submit()),
          ),
        ),
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24).copyWith(
            bottom: 24 + _pinnedFooterHeight,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              OnboardingProgressHeader(onBack: notifier.onBack),
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
                        isSelected:
                            state.selectedDealbreaker == dealbreakers[i],
                        onTap: () =>
                            notifier.selectDealbreaker(dealbreakers[i]),
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
            ],
          ),
        ),
      ),
    );
  }
}

const double _pinnedFooterHeight = 76;
