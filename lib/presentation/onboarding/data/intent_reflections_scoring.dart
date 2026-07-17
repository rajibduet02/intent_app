import 'package:intent_app/presentation/onboarding/models/intent_reflection_result.dart';

/// Maps selected answer IDs to user-facing construct results.
/// Answer letter suffix (_a/_b/_c/_d) drives category — display order is unrelated.
abstract final class IntentReflectionsScoring {
  IntentReflectionsScoring._();

  static IntentReflectionsResult calculate(Map<String, String> selectedAnswers) {
    final constructs = <IntentReflectionConstructResult>[];
    for (final entry in _constructs) {
      final answerId = selectedAnswers[entry.questionId];
      final category = _categoryFromAnswerId(answerId);
      constructs.add(
        IntentReflectionConstructResult(
          constructName: entry.name,
          category: category,
          shortDescription: entry.shortDescription,
          whatThisMeasures: entry.whatThisMeasures,
          whatResponsesSuggest: entry.suggestFor(category),
          whyItMatters: entry.whyItMatters,
          reflectionInsight: entry.insightFor(category),
          conversationStarter: entry.conversationStarter,
        ),
      );
    }
    return IntentReflectionsResult(constructs: constructs);
  }

  static ReflectionCategory _categoryFromAnswerId(String? answerId) {
    if (answerId == null || answerId.isEmpty) {
      return ReflectionCategory.healthy;
    }
    final suffix = answerId.split('_').last;
    return switch (suffix) {
      'a' => ReflectionCategory.strength,
      'b' => ReflectionCategory.healthy,
      'c' => ReflectionCategory.roomForGrowth,
      'd' => ReflectionCategory.requiresGreaterIntentionality,
      _ => ReflectionCategory.healthy,
    };
  }

  static const _constructs = <_ConstructBlueprint>[
    _ConstructBlueprint(
      questionId: 'intent_reflection_1',
      name: 'Accountability',
      shortDescription:
          'How you take ownership after conflict and what you learn from it.',
      whatThisMeasures:
          'Your willingness to look at your own role in disagreements '
          'without unfairly blaming yourself or others.',
      whyItMatters:
          'Accountability builds trust. Partners feel safer when ownership '
          'is shared and growth-oriented.',
      conversationStarter:
          'What helps you feel understood after a disagreement?',
      strengthSuggest:
          'You tend to treat conflict as a chance to understand yourself '
          'more deeply.',
      healthySuggest:
          'You own your part when it feels fair, and you protect yourself '
          'from unnecessary self-blame.',
      growthSuggest:
          'You often reflect carefully — and sometimes may revisit moments '
          'longer than you need to.',
      intentionalitySuggest:
          'You may carry more responsibility than belongs to you. Softening '
          'self-blame can create healthier repair.',
      strengthInsight: 'You tend to value accountability in relationships.',
      healthyInsight: 'You balance self-reflection with self-compassion.',
      growthInsight:
          'You care about getting things right — and that care can deepen with balance.',
      intentionalityInsight:
          'You take relationships seriously, and learning where responsibility ends can help you feel freer.',
    ),
    _ConstructBlueprint(
      questionId: 'intent_reflection_2',
      name: 'Emotional Regulation',
      shortDescription:
          'How you stay steady when a conversation needs a pause.',
      whatThisMeasures:
          'Your comfort with taking space during conflict without losing '
          'connection or escalating.',
      whyItMatters:
          'Regulation helps conversations stay respectful and productive '
          'instead of reactive.',
      conversationStarter:
          'What helps you feel calm enough to return to a hard conversation?',
      strengthSuggest:
          'You can pause thoughtfully and return when both of you are ready.',
      healthySuggest:
          'You prefer resolution, but you can accept a break when needed.',
      growthSuggest:
          'Pauses may leave you wondering — reassurance during breaks can help.',
      intentionalitySuggest:
          'A request for space may feel like withdrawal. Naming that feeling '
          'can open healthier dialogue.',
      strengthInsight: 'You value calm, intentional pacing in conflict.',
      healthyInsight: 'You want clarity and can still honor a pause.',
      growthInsight: 'You care about staying connected even during hard moments.',
      intentionalityInsight:
          'You want commitment during conflict — and space can still be part of care.',
    ),
    _ConstructBlueprint(
      questionId: 'intent_reflection_3',
      name: 'Respect & Validation',
      shortDescription:
          'How you respond when your partner shares that they felt hurt.',
      whatThisMeasures:
          'Your ability to honor someone’s emotional experience before '
          'defending your intentions.',
      whyItMatters:
          'Validation is one of the fastest ways to restore emotional safety.',
      conversationStarter:
          'When you feel hurt, what kind of response helps you feel seen?',
      strengthSuggest:
          'You naturally prioritize understanding their experience first.',
      healthySuggest:
          'You want mutual understanding — both impact and intention matter to you.',
      growthSuggest:
          'You care about fairness, and apologizing can feel hard when intent was kind.',
      intentionalitySuggest:
          'Explaining yourself may come first. Leading with empathy can deepen connection.',
      strengthInsight: 'You tend to lead with empathy when someone is hurt.',
      healthyInsight: 'You want both people to feel understood.',
      growthInsight: 'You value fairness — and validation can sit alongside it.',
      intentionalityInsight:
          'Being understood matters to you, and feeling heard often starts with listening first.',
    ),
    _ConstructBlueprint(
      questionId: 'intent_reflection_4',
      name: 'Boundaries',
      shortDescription:
          'How you view togetherness, space, and individual recharge.',
      whatThisMeasures:
          'Your comfort with healthy autonomy inside a committed relationship.',
      whyItMatters:
          'Clear boundaries prevent burnout and protect intimacy over time.',
      conversationStarter:
          'What does healthy space look like for you in a relationship?',
      strengthSuggest:
          'You see quality time and personal recharge as complementary.',
      healthySuggest:
          'You enjoy consistency and still respect the need for individual space.',
      growthSuggest:
          'Frequent requests for space may raise questions for you about readiness.',
      intentionalitySuggest:
          'Space may feel like distance. Exploring that together can build security.',
      strengthInsight: 'You value balance between closeness and independence.',
      healthyInsight: 'You appreciate connection while leaving room to breathe.',
      growthInsight: 'Closeness matters deeply to you.',
      intentionalityInsight:
          'You want a relationship that feels present — and space can still mean care.',
    ),
    _ConstructBlueprint(
      questionId: 'intent_reflection_5',
      name: 'Conflict Mindset',
      shortDescription:
          'How you interpret disagreement and shared responsibility.',
      whatThisMeasures:
          'Whether you approach conflict as shared learning or as blame.',
      whyItMatters:
          'A constructive conflict mindset turns tension into understanding.',
      conversationStarter:
          'What helps a disagreement feel productive instead of personal?',
      strengthSuggest:
          'You usually look for both perspectives when conflict shows up.',
      healthySuggest:
          'You can name imbalance and still stay curious about both sides.',
      growthSuggest:
          'You protect your boundaries firmly when they are ignored.',
      intentionalitySuggest:
          'Sensitivity in others may frustrate you. Softening that lens can open repair.',
      strengthInsight: 'You see conflict as something to understand together.',
      healthyInsight: 'You balance honesty with curiosity.',
      growthInsight: 'You take your boundaries seriously.',
      intentionalityInsight:
          'You want clarity in conflict — curiosity can make that clearer.',
    ),
    _ConstructBlueprint(
      questionId: 'intent_reflection_6',
      name: 'Repair',
      shortDescription: 'How you reconnect after things cool down.',
      whatThisMeasures:
          'Your instinct to reopen, wait, reflect, or move on after conflict.',
      whyItMatters:
          'Repair is what turns rupture into resilience in a relationship.',
      conversationStarter:
          'After a hard conversation, what helps you feel reconnected?',
      strengthSuggest:
          'You often initiate reconnection so both people feel heard.',
      healthySuggest:
          'You give space and return when the other person seems ready.',
      growthSuggest:
          'You prefer one meaningful conversation after thoughtful reflection.',
      intentionalitySuggest:
          'If you still feel right, revisiting may not feel urgent. Soft repair still builds trust.',
      strengthInsight: 'You tend to prioritize reconnection after conflict.',
      healthyInsight: 'You respect pacing while still valuing repair.',
      growthInsight: 'You want thoughtful conversations, not rushed ones.',
      intentionalityInsight:
          'Standing by your perspective matters to you — and repair can still be kind.',
    ),
    _ConstructBlueprint(
      questionId: 'intent_reflection_7',
      name: 'Relationship Assumptions',
      shortDescription:
          'How you advise others when a relationship looks different than expected.',
      whatThisMeasures:
          'Your openness to healthy love that arrives with complexity.',
      whyItMatters:
          'Assumptions shape how open you are to real people, not just ideal pictures.',
      conversationStarter:
          'What assumptions have you reconsidered as you’ve grown?',
      strengthSuggest:
          'You encourage people to follow kindness and emotional maturity.',
      healthySuggest:
          'You support happiness while urging honest conversations about the future.',
      growthSuggest:
          'You tend to urge caution when a relationship includes added complexity.',
      intentionalitySuggest:
          'You may prioritize avoiding responsibility over exploring potential.',
      strengthInsight: 'You value emotional health over perfect circumstances.',
      healthyInsight: 'You balance openness with practical conversations.',
      growthInsight: 'You want people to choose carefully and thoughtfully.',
      intentionalityInsight:
          'Protection matters to you — curiosity can sit beside caution.',
    ),
    _ConstructBlueprint(
      questionId: 'intent_reflection_8',
      name: 'Expectations vs. Reality',
      shortDescription:
          'How flexible you are when real connection challenges old standards.',
      whatThisMeasures:
          'Your willingness to update preferences when someone feels right.',
      whyItMatters:
          'Rigid expectations can block meaningful connection that doesn’t fit a script.',
      conversationStarter:
          'Have your standards ever changed after meeting the right person?',
      strengthSuggest:
          'You encourage getting to know people beyond the picture in your head.',
      healthySuggest:
          'You celebrate unexpected connection while checking long-term alignment.',
      growthSuggest:
          'You revisit original standards carefully before revising them.',
      intentionalitySuggest:
          'You often prefer sticking to long-held preferences.',
      strengthInsight: 'You believe real connection can rewrite old scripts.',
      healthyInsight: 'You stay open while staying grounded in values.',
      growthInsight: 'You take your standards seriously.',
      intentionalityInsight:
          'Your preferences come from somewhere — and they can still evolve with intention.',
    ),
    _ConstructBlueprint(
      questionId: 'intent_reflection_9',
      name: 'Modern Dating',
      shortDescription:
          'How you think about effort, compromise, and “the right person.”',
      whatThisMeasures:
          'Whether you expect ease alone, or ease plus shared effort.',
      whyItMatters:
          'Healthy relationships include both chemistry and intentional work.',
      conversationStarter:
          'What does healthy effort look like to you in a relationship?',
      strengthSuggest:
          'You recognize that healthy love still requires communication and care.',
      healthySuggest:
          'You won’t chase someone who won’t choose you — and you still value compromise.',
      growthSuggest:
          'Early difficulty makes you pause and ask whether it’s the right fit.',
      intentionalitySuggest:
          'You may equate hard moments with the wrong relationship.',
      strengthInsight: 'You appreciate healthy communication and shared effort.',
      healthyInsight: 'You want mutual choice and mutual care.',
      growthInsight: 'You trust your instincts when something feels off.',
      intentionalityInsight:
          'You want love that feels right — and effort can still be part of that.',
    ),
    _ConstructBlueprint(
      questionId: 'intent_reflection_10',
      name: 'Reciprocity',
      shortDescription:
          'How you interpret uneven effort and consistency in dating.',
      whatThisMeasures:
          'Your expectations around mutual initiative and follow-through.',
      whyItMatters:
          'Reciprocity protects self-worth and keeps relationships balanced.',
      conversationStarter:
          'How do you usually talk about effort when it feels one-sided?',
      strengthSuggest:
          'You encourage honest conversation when effort feels uneven.',
      healthySuggest:
          'You allow for seasons of imbalance while watching for long-term balance.',
      growthSuggest:
          'You may pull back to see if the other person’s effort becomes clearer.',
      intentionalitySuggest:
          'You may minimize your needs around consistency.',
      strengthInsight: 'You value mutual effort and clear communication.',
      healthyInsight: 'You give grace while still wanting balance.',
      growthInsight: 'You notice when you’re carrying too much.',
      intentionalityInsight:
          'You want to be fair — and your needs for consistency matter too.',
    ),
  ];
}

class _ConstructBlueprint {
  const _ConstructBlueprint({
    required this.questionId,
    required this.name,
    required this.shortDescription,
    required this.whatThisMeasures,
    required this.whyItMatters,
    required this.conversationStarter,
    required this.strengthSuggest,
    required this.healthySuggest,
    required this.growthSuggest,
    required this.intentionalitySuggest,
    required this.strengthInsight,
    required this.healthyInsight,
    required this.growthInsight,
    required this.intentionalityInsight,
  });

  final String questionId;
  final String name;
  final String shortDescription;
  final String whatThisMeasures;
  final String whyItMatters;
  final String conversationStarter;
  final String strengthSuggest;
  final String healthySuggest;
  final String growthSuggest;
  final String intentionalitySuggest;
  final String strengthInsight;
  final String healthyInsight;
  final String growthInsight;
  final String intentionalityInsight;

  String suggestFor(ReflectionCategory category) => switch (category) {
        ReflectionCategory.strength => strengthSuggest,
        ReflectionCategory.healthy => healthySuggest,
        ReflectionCategory.roomForGrowth => growthSuggest,
        ReflectionCategory.requiresGreaterIntentionality =>
          intentionalitySuggest,
      };

  String insightFor(ReflectionCategory category) => switch (category) {
        ReflectionCategory.strength => strengthInsight,
        ReflectionCategory.healthy => healthyInsight,
        ReflectionCategory.roomForGrowth => growthInsight,
        ReflectionCategory.requiresGreaterIntentionality =>
          intentionalityInsight,
      };
}
