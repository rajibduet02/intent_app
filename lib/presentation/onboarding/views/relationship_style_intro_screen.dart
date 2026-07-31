import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:intent_app/presentation/onboarding/providers/relationship_style_assessment_provider.dart';
import 'package:intent_app/presentation/onboarding/widgets/assessment/assessment_intro_screen.dart';

class RelationshipStyleIntroScreen extends ConsumerWidget {
  const RelationshipStyleIntroScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(relationshipStyleAssessmentProvider.notifier);
    final state = ref.watch(relationshipStyleAssessmentProvider);
    final continueLabel = state.selectedAnswers.isEmpty
        ? 'BEGIN'
        : state.isComplete
            // ? 'SEE RESULTS'
            ? 'CONTINUE'
            : 'CONTINUE';

    return AssessmentIntroScreen(
      onBack: notifier.onBackFromIntro,
      title: 'Relationship Style',
      description:
          'These questions help Intent understand what connection tends to feel like for you how you experience closeness, space, reassurance, and trust in relationships.',
      instruction:
          'Choose the answer that sounds most like your natural thought or internal reaction. There are no perfect answers.',
      onContinue: notifier.continueFromIntro,
      continueLabel: continueLabel,
      assessmentIndex: 3,
    );
  }
}
