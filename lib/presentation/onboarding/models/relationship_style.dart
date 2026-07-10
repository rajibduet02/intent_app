import 'package:intent_app/presentation/onboarding/models/assessment_question.dart';

enum RelationshipStyle {
  steadySecure,
  reassuranceSeeking,
  selfProtective,
  pushPull,
}

extension RelationshipStyleLabels on RelationshipStyle {
  String get displayLabel => switch (this) {
        RelationshipStyle.steadySecure => 'Steady / Secure',
        RelationshipStyle.reassuranceSeeking => 'Reassurance-Seeking',
        RelationshipStyle.selfProtective => 'Self-Protective',
        RelationshipStyle.pushPull => 'Push-Pull',
      };
}

class RelationshipStyleAnswer extends AssessmentAnswer {
  const RelationshipStyleAnswer({
    required super.id,
    required super.text,
    required this.style,
  });

  final RelationshipStyle style;
}

class RelationshipStyleResult {
  const RelationshipStyleResult({
    required this.primary,
    this.secondary,
  });

  final RelationshipStyle primary;
  final RelationshipStyle? secondary;

  String get primaryLabel => primary.displayLabel;

  String? get secondaryLabel => secondary?.displayLabel;
}
