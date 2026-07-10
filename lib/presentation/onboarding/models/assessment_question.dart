class AssessmentAnswer {
  const AssessmentAnswer({
    required this.id,
    required this.text,
  });

  final String id;
  final String text;
}

class AssessmentQuestion {
  const AssessmentQuestion({
    required this.id,
    required this.title,
    required this.prompt,
    required this.sectionLabel,
    required this.answers,
  });

  final String id;
  final String title;
  final String prompt;
  final String sectionLabel;
  final List<AssessmentAnswer> answers;
}
