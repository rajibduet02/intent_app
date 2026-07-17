import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:intent_app/presentation/onboarding/providers/intent_reflections_provider.dart';
import 'package:intent_app/presentation/onboarding/widgets/assessment/assessment_intro_screen.dart';

class IntentReflectionsIntroScreen extends ConsumerWidget {
  const IntentReflectionsIntroScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(intentReflectionsProvider.notifier);
    final state = ref.watch(intentReflectionsProvider);
    final continueLabel = state.selectedAnswers.isEmpty
        ? 'BEGIN'
        : state.isComplete
            // ? 'SEE RESULTS'
            ? 'CONTINUE'
            : 'CONTINUE';

    return AssessmentIntroScreen(
      onBack: notifier.onBackFromIntro,
      title: 'Intent Reflections',
      subtitle: 'How You Show Up & How You See Others',
      description:
          'These reflections help Intent understand how you approach connection, conflict, expectations, repair, and openness in relationships.',
      instruction:
          'Choose the answer that feels closest to your honest first instinct. There are no perfect answers.',
      onContinue: notifier.continueFromIntro,
      continueLabel: continueLabel,
    );
  }
}
