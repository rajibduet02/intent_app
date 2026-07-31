import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intent_app/app/theme/theme.dart';
import 'package:intent_app/presentation/auth/widgets/shared/fixed_background_auth_scaffold.dart';
import 'package:intent_app/presentation/onboarding/providers/relationship_intention_provider.dart';
import 'package:intent_app/presentation/onboarding/models/onboarding_phase.dart';
import 'package:intent_app/presentation/onboarding/widgets/onboarding_continue_button.dart';
import 'package:intent_app/presentation/onboarding/widgets/onboarding_intent_accent.dart';
import 'package:intent_app/presentation/onboarding/widgets/onboarding_progress_header.dart';
import 'package:intent_app/presentation/onboarding/widgets/onboarding_progress_sync.dart';
import 'package:intent_app/presentation/onboarding/widgets/onboarding_select_field.dart';
import 'package:intent_app/presentation/onboarding/widgets/onboarding_select_sheet.dart';

class RelationshipIntentionScreen extends ConsumerWidget {
  const RelationshipIntentionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(relationshipIntentionProvider.notifier);
    final state = ref.watch(relationshipIntentionProvider);
    final isLoading = state.isLoading;

    return OnboardingProgressSync(
      phase: OnboardingPhase.aboutYou,
      questionIndex: 2,
      child: FixedBackgroundAuthScaffold(
      pinnedFooter: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            OnboardingContinueButton(
              isLoading: isLoading,
              onPressed: () => unawaited(notifier.submit()),
            ),
            const SizedBox(height: 16),
            Text(
              'You can update these later from your profile.',
              textAlign: TextAlign.center,
              style: IntentLoginStyles.onboardingFooterNote,
            ),
          ],
        ),
      ),
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24).copyWith(
          bottom: 24 + _onboarding2PinnedFooterHeight,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            OnboardingProgressHeader(onBack: notifier.onBack),
            const SizedBox(height: AppSpacing.xs),
            const Center(child: OnboardingIntentAccent()),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'What are you looking for?',
              textAlign: TextAlign.center,
              style: IntentLoginStyles.onboardingTitle,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Help Intent understand your values, lifestyle, and '
              'relationship direction so we can show more meaningful matches.',
              textAlign: TextAlign.center,
              style: IntentLoginStyles.onboardingSubtitle,
            ),
            const SizedBox(height: AppSpacing.lg),
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
                      label: 'Relationship intention',
                      placeholder: 'Select your intention',
                      value: state.relationshipIntention,
                      onTap: () => unawaited(_pickRelationshipIntention(context, ref)),
                    ),
                    const SizedBox(height: 20),
                    OnboardingSelectField(
                      label: 'Religion and beliefs',
                      placeholder: 'Select your belief or religion',
                      value: state.religionBeliefs,
                      onTap: () => unawaited(_pickReligionBeliefs(context, ref)),
                    ),
                    const SizedBox(height: 20),
                    OnboardingSelectField(
                      label: 'How important is this to you?',
                      placeholder: 'Select importance',
                      value: state.importanceLevel,
                      onTap: () => unawaited(_pickImportanceLevel(context, ref)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }

  Future<void> _pickRelationshipIntention(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final selected = await showOnboardingSelectSheet(
      context: context,
      title: 'Relationship intention',
      options: RelationshipIntentionNotifier.relationshipIntentions,
    );
    if (selected != null) {
      ref.read(relationshipIntentionProvider.notifier).setRelationshipIntention(selected);
    }
  }

  Future<void> _pickReligionBeliefs(BuildContext context, WidgetRef ref) async {
    final selected = await showOnboardingSelectSheet(
      context: context,
      title: 'Religion and beliefs',
      options: RelationshipIntentionNotifier.religionBeliefs,
    );
    if (selected != null) {
      ref.read(relationshipIntentionProvider.notifier).setReligionBeliefs(selected);
    }
  }

  Future<void> _pickImportanceLevel(BuildContext context, WidgetRef ref) async {
    final selected = await showOnboardingSelectSheet(
      context: context,
      title: 'How important is this to you?',
      options: RelationshipIntentionNotifier.importanceLevels,
    );
    if (selected != null) {
      ref.read(relationshipIntentionProvider.notifier).setImportanceLevel(selected);
    }
  }
}

const double _onboarding2PinnedFooterHeight = 108;
