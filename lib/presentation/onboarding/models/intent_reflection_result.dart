enum ReflectionCategory {
  strength,
  healthy,
  roomForGrowth,
  requiresGreaterIntentionality,
}

extension ReflectionCategoryLabels on ReflectionCategory {
  String get displayLabel => switch (this) {
        ReflectionCategory.strength => 'Strength',
        ReflectionCategory.healthy => 'Healthy',
        ReflectionCategory.roomForGrowth => 'Room for Growth',
        ReflectionCategory.requiresGreaterIntentionality =>
          'Requires Greater Intentionality',
      };
}

class IntentReflectionConstructResult {
  const IntentReflectionConstructResult({
    required this.constructName,
    required this.category,
    required this.shortDescription,
    required this.whatThisMeasures,
    required this.whatResponsesSuggest,
    required this.whyItMatters,
    required this.reflectionInsight,
    required this.conversationStarter,
  });

  final String constructName;
  final ReflectionCategory category;
  final String shortDescription;
  final String whatThisMeasures;
  final String whatResponsesSuggest;
  final String whyItMatters;
  final String reflectionInsight;
  final String conversationStarter;
}

class IntentReflectionsResult {
  const IntentReflectionsResult({required this.constructs});

  final List<IntentReflectionConstructResult> constructs;
}
