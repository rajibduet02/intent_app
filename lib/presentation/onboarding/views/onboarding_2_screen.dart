import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intent_app/app/theme/theme.dart';
import 'package:intent_app/presentation/auth/widgets/shared/fixed_background_auth_scaffold.dart';
import 'package:intent_app/presentation/onboarding/providers/onboarding_2_provider.dart';
import 'package:intent_app/presentation/onboarding/widgets/onboarding_continue_button.dart';
import 'package:intent_app/presentation/onboarding/widgets/onboarding_intent_accent.dart';
import 'package:intent_app/presentation/onboarding/widgets/onboarding_select_field.dart';
import 'package:intent_app/presentation/onboarding/widgets/onboarding_select_sheet.dart';

class Onboarding2Screen extends ConsumerWidget {
  const Onboarding2Screen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(onboarding2Provider.notifier);
    final state = ref.watch(onboarding2Provider);
    final isLoading = state.isLoading;

    return FixedBackgroundAuthScaffold(
      pinnedFooter: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            OnboardingContinueButton(
              isLoading: isLoading,
              showArrow: false,
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
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24).copyWith(
          bottom: 24 + _onboarding2PinnedFooterHeight,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Center(child: OnboardingIntentAccent()),
            const SizedBox(height: 16),
            Text(
              'What are you looking for?',
              textAlign: TextAlign.center,
              style: IntentLoginStyles.onboardingTitle,
            ),
            const SizedBox(height: 12),
            Text(
              'Help Intent understand your values, lifestyle, and '
              'relationship direction so we can show more meaningful matches.',
              textAlign: TextAlign.center,
              style: IntentLoginStyles.onboardingSubtitle,
            ),
            const SizedBox(height: 28),
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
    );
  }

  Future<void> _pickRelationshipIntention(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final selected = await showOnboardingSelectSheet(
      context: context,
      title: 'Relationship intention',
      options: Onboarding2Notifier.relationshipIntentions,
    );
    if (selected != null) {
      ref.read(onboarding2Provider.notifier).setRelationshipIntention(selected);
    }
  }

  Future<void> _pickReligionBeliefs(BuildContext context, WidgetRef ref) async {
    final selected = await showOnboardingSelectSheet(
      context: context,
      title: 'Religion and beliefs',
      options: Onboarding2Notifier.religionBeliefs,
    );
    if (selected != null) {
      ref.read(onboarding2Provider.notifier).setReligionBeliefs(selected);
    }
  }

  Future<void> _pickImportanceLevel(BuildContext context, WidgetRef ref) async {
    final selected = await showOnboardingSelectSheet(
      context: context,
      title: 'How important is this to you?',
      options: Onboarding2Notifier.importanceLevels,
    );
    if (selected != null) {
      ref.read(onboarding2Provider.notifier).setImportanceLevel(selected);
    }
  }
}

const double _onboarding2PinnedFooterHeight = 108;
