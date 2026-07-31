/// Four guided onboarding phases after account creation.
enum OnboardingPhase {
  aboutYou(
    number: 1,
    title: 'About You',
    subtitle: 'Build your profile foundation.',
    totalQuestions: 2,
    progressUnit: 'Question',
  ),
  howYouConnect(
    number: 2,
    title: 'How You Connect',
    subtitle: 'Understand how you naturally build emotional connections.',
    totalQuestions: 5,
    progressUnit: 'Assessment',
  ),
  compatibilityPreferences(
    number: 3,
    title: 'Compatibility Preferences',
    subtitle: 'Tell us what matters most.',
    totalQuestions: 3,
    progressUnit: 'Step',
  ),
  privacyAndSafety(
    number: 4,
    title: 'Privacy & Safety',
    subtitle: 'Protect your identity while building trust.',
    totalQuestions: 7,
    progressUnit: 'Step',
  );

  const OnboardingPhase({
    required this.number,
    required this.title,
    required this.subtitle,
    required this.totalQuestions,
    required this.progressUnit,
  });

  final int number;
  final String title;
  final String subtitle;
  final int totalQuestions;

  /// Label used in progress text, e.g. Question / Assessment / Step.
  final String progressUnit;

  static const int totalPhases = 4;
}
