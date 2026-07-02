import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intent_app/app/theme/theme.dart';
import 'package:intent_app/presentation/auth/widgets/shared/fixed_background_auth_scaffold.dart';
import 'package:intent_app/presentation/onboarding/providers/onboarding_3_provider.dart';
import 'package:intent_app/presentation/onboarding/widgets/onboarding_continue_button.dart';
import 'package:intent_app/presentation/onboarding/widgets/onboarding_header.dart';
import 'package:intent_app/presentation/onboarding/widgets/onboarding_multi_select_sheet.dart';
import 'package:intent_app/presentation/onboarding/widgets/onboarding_select_field.dart';
import 'package:intent_app/presentation/onboarding/widgets/onboarding_select_sheet.dart';
import 'package:intent_app/presentation/onboarding/widgets/onboarding_value_chip.dart';

class Onboarding3Screen extends ConsumerWidget {
  const Onboarding3Screen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(onboarding3Provider.notifier);
    final state = ref.watch(onboarding3Provider);

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
          bottom: 24 + _onboarding3PinnedFooterHeight,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            OnboardingHeader(
              currentStep: 3,
              totalSteps: 5,
              showLogo: false,
              showProgressDots: false,
              onBack: notifier.onBack,
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              'Family goals',
              textAlign: TextAlign.center,
              style: IntentLoginStyles.onboardingTitle,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Tell us more about your future plans and everyday lifestyle '
              'so Intent can show more meaningful matches.',
              textAlign: TextAlign.center,
              style: IntentLoginStyles.onboardingSubtitle,
            ),
            const SizedBox(height: 24),
            DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.intentCreamDeep,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    OnboardingSelectField(
                      label: 'Family goals',
                      placeholder: 'Select your family goal',
                      value: state.familyGoal,
                      onTap: () => unawaited(_pickFamilyGoal(context, ref)),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Make this a dealbreaker',
                            style: IntentLoginStyles.onboardingDealbreaker,
                          ),
                        ),
                        Switch.adaptive(
                          value: state.isDealbreaker,
                          onChanged: notifier.setIsDealbreaker,
                          activeTrackColor:
                              AppColors.intentForest.withValues(alpha: 0.35),
                          activeThumbColor: AppColors.intentForest,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    OnboardingSelectField(
                      label: 'Your lifestyle',
                      placeholder: 'Choose lifestyle preferences ...',
                      onTap: () => unawaited(_pickLifestyle(context, ref)),
                    ),
                    if (state.lifestylePreferences.isNotEmpty) ...[
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          for (final item in state.lifestylePreferences)
                            OnboardingLifestyleChip(
                              label: item,
                              onRemove: () => notifier.removeLifestyle(item),
                            ),
                        ],
                      ),
                    ],
                    const SizedBox(height: 12),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 6, right: 8),
                          child: Container(
                            width: 4,
                            height: 4,
                            decoration: const BoxDecoration(
                              color: AppColors.intentTextSoft,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'These details help Intent find stronger '
                            'compatibility beyond surface-level attraction.',
                            style: IntentLoginStyles.onboardingHelper,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'What matters most to you?',
                      textAlign: TextAlign.center,
                      style: IntentLoginStyles.onboardingSectionTitle,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Choose the values that guide how you build connection.',
                      textAlign: TextAlign.center,
                      style: IntentLoginStyles.onboardingSubtitle,
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      alignment: WrapAlignment.center,
                      children: [
                        for (final value in Onboarding3Notifier.values)
                          OnboardingValueChip(
                            label: value,
                            isSelected: state.selectedValues.contains(value),
                            onTap: () => notifier.toggleValue(value),
                          ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Select 5-8 values',
                      textAlign: TextAlign.center,
                      style: IntentLoginStyles.onboardingFooterNote,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickFamilyGoal(BuildContext context, WidgetRef ref) async {
    final selected = await showOnboardingSelectSheet(
      context: context,
      title: 'Family goals',
      options: Onboarding3Notifier.familyGoals,
    );
    if (selected != null) {
      ref.read(onboarding3Provider.notifier).setFamilyGoal(selected);
    }
  }

  Future<void> _pickLifestyle(BuildContext context, WidgetRef ref) async {
    final state = ref.read(onboarding3Provider);
    final selected = await showOnboardingMultiSelectSheet(
      context: context,
      title: 'Your lifestyle',
      options: Onboarding3Notifier.lifestyleOptions,
      initialSelected: state.lifestylePreferences,
    );
    if (selected != null) {
      ref.read(onboarding3Provider.notifier).setLifestylePreferences(selected);
    }
  }
}

const double _onboarding3PinnedFooterHeight = 76;
