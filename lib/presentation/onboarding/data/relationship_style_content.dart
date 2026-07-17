import 'package:intent_app/presentation/onboarding/models/relationship_style.dart';

/// User-facing content for Relationship Style results (no clinical labels).
abstract final class RelationshipStyleContent {
  RelationshipStyleContent._();

  static RelationshipStyleProfile profileFor(RelationshipStyle style) {
    return switch (style) {
      RelationshipStyle.steadySecure => const RelationshipStyleProfile(
          description:
              'You usually feel comfortable with closeness and independence. '
              'You can stay present through conflict without losing yourself.',
          strengths: [
            'You communicate needs calmly',
            'You recover from tension with care',
            'You offer consistency others can rely on',
          ],
          growthAreas: [
            'Watch for assuming others regulate as easily as you do',
            'Invite partners to share worries even when things feel fine',
          ],
          compatibilityInsight:
              'You may value consistency in relationships and appreciate '
              'partners who communicate clearly.',
        ),
      RelationshipStyle.reassuranceSeeking => const RelationshipStyleProfile(
          description:
              'Connection matters deeply to you. You feel most secure when '
              'affection and follow-through are clear and consistent.',
          strengths: [
            'You notice emotional nuance early',
            'You invest warmly in the people you care about',
            'You advocate for closeness and clarity',
          ],
          growthAreas: [
            'Practice trusting space without reading it as distance',
            'Ask for reassurance directly when you need it',
          ],
          compatibilityInsight:
              'You appreciate healthy communication and partners who check in '
              'with warmth and reliability.',
        ),
      RelationshipStyle.selfProtective => const RelationshipStyleProfile(
          description:
              'You protect your independence and pace carefully. Trust grows '
              'when you feel respected and unpressured.',
          strengths: [
            'You honor personal boundaries',
            'You think before reacting',
            'You value emotional self-sufficiency',
          ],
          growthAreas: [
            'Share a little sooner when you feel safe',
            'Let trusted partners support you without losing autonomy',
          ],
          compatibilityInsight:
              'You may value consistency paired with breathing room, and '
              'partners who respect your pace.',
        ),
      RelationshipStyle.pushPull => const RelationshipStyleProfile(
          description:
              'You can desire closeness and space in waves. Understanding that '
              'rhythm helps you stay intentional with partners.',
          strengths: [
            'You feel relationships deeply',
            'You notice shifts in emotional energy quickly',
            'You care about authentic connection',
          ],
          growthAreas: [
            'Name your needs early instead of withdrawing',
            'Build steadier rituals of connection during calm seasons',
          ],
          compatibilityInsight:
              'You appreciate healthy communication and partners who stay '
              'steady when emotions ebb and flow.',
        ),
    };
  }
}

class RelationshipStyleProfile {
  const RelationshipStyleProfile({
    required this.description,
    required this.strengths,
    required this.growthAreas,
    required this.compatibilityInsight,
  });

  final String description;
  final List<String> strengths;
  final List<String> growthAreas;
  final String compatibilityInsight;
}
