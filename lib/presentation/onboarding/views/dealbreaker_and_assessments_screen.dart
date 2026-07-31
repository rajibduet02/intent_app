import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intent_app/app/theme/theme.dart';
import 'package:intent_app/presentation/auth/widgets/shared/fixed_background_auth_scaffold.dart';
import 'package:intent_app/presentation/onboarding/models/onboarding_phase.dart';
import 'package:intent_app/presentation/onboarding/providers/dealbreaker_and_assessments_provider.dart';
import 'package:intent_app/presentation/onboarding/widgets/onboarding_assessment_tile.dart';
import 'package:intent_app/presentation/onboarding/widgets/onboarding_continue_button.dart';
import 'package:intent_app/presentation/onboarding/widgets/onboarding_progress_header.dart';
import 'package:intent_app/presentation/onboarding/widgets/onboarding_progress_sync.dart';

/// Phase 2 hub: personality assessments only (dealbreakers moved to Phase 3).
class DealbreakerAndAssessmentsScreen extends ConsumerWidget {
  const DealbreakerAndAssessmentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(dealbreakerAndAssessmentsProvider.notifier);
    final state = ref.watch(dealbreakerAndAssessmentsProvider);

    final completedCount = [
      state.corePersonalityCompleted,
      state.intentReflectionsCompleted,
      state.relationshipStyleCompleted,
      state.loveLanguageCompleted,
      state.vibeSlidersCompleted,
    ].where((done) => done).length;

    final questionIndex = completedCount == 0 ? 1 : completedCount.clamp(1, 5);

    return OnboardingProgressSync(
      phase: OnboardingPhase.howYouConnect,
      questionIndex: questionIndex,
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
            bottom: 24 + _onboarding4PinnedFooterHeight,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              OnboardingProgressHeader(
                onBack: notifier.onBack,
                questionLabelOverride:
                    'Assessment ${completedCount.clamp(0, 5)} of 5',
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'Complete your connection profile',
                style: IntentLoginStyles.onboardingTitle,
              ),
              const SizedBox(height: 8),
              Text(
                'These short assessments help Intent understand your '
                'personality, emotional style, and how you connect — '
                'without asking you to label yourself.',
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
                    for (var i = 0;
                        i < DealbreakerAndAssessmentsNotifier.assessments.length;
                        i++)
                      OnboardingAssessmentTile(
                        item: DealbreakerAndAssessmentsNotifier.assessments[i],
                        onTap: () => notifier.onAssessmentTap(i),
                        isCompleted: (i == 0 &&
                                state.corePersonalityCompleted) ||
                            (i == 1 && state.intentReflectionsCompleted) ||
                            (i == 2 && state.relationshipStyleCompleted) ||
                            (i == 3 && state.loveLanguageCompleted) ||
                            (i == 4 && state.vibeSlidersCompleted),
                        showDivider: i <
                            DealbreakerAndAssessmentsNotifier.assessments.length -
                                1,
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
      ),
    );
  }
}

const double _onboarding4PinnedFooterHeight = 76;
