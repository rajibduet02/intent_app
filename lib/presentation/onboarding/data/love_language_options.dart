import 'package:flutter/material.dart';

enum LoveLanguageType {
  wordsOfAffirmation,
  qualityTime,
  actsOfService,
  physicalTouch,
  receivingGifts,
}

class LoveLanguageOption {
  const LoveLanguageOption({
    required this.type,
    required this.label,
    required this.icon,
  });

  final LoveLanguageType type;
  final String label;
  final IconData icon;
}

class RelationshipVibeAxis {
  const RelationshipVibeAxis({
    required this.id,
    required this.leftLabel,
    required this.rightLabel,
  });

  final String id;
  final String leftLabel;
  final String rightLabel;
}

abstract final class LoveLanguageOptions {
  LoveLanguageOptions._();

  static const options = [
    LoveLanguageOption(
      type: LoveLanguageType.wordsOfAffirmation,
      label: 'Words of affirmation',
      icon: Icons.chat_bubble_outline,
    ),
    LoveLanguageOption(
      type: LoveLanguageType.qualityTime,
      label: 'Quality time',
      icon: Icons.schedule_outlined,
    ),
    LoveLanguageOption(
      type: LoveLanguageType.actsOfService,
      label: 'Acts of service',
      icon: Icons.volunteer_activism_outlined,
    ),
    LoveLanguageOption(
      type: LoveLanguageType.physicalTouch,
      label: 'Physical touch',
      icon: Icons.favorite_border,
    ),
    LoveLanguageOption(
      type: LoveLanguageType.receivingGifts,
      label: 'Receiving gifts',
      icon: Icons.card_giftcard_outlined,
    ),
  ];

  static const vibeAxes = [
    RelationshipVibeAxis(
      id: 'introvert_extrovert',
      leftLabel: 'INTROVERTED',
      rightLabel: 'EXTROVERTED',
    ),
    RelationshipVibeAxis(
      id: 'structured_spontaneous',
      leftLabel: 'STRUCTURED',
      rightLabel: 'SPONTANEOUS',
    ),
    RelationshipVibeAxis(
      id: 'calm_energetic',
      leftLabel: 'CALM',
      rightLabel: 'ENERGETIC',
    ),
    RelationshipVibeAxis(
      id: 'traditional_modern',
      leftLabel: 'TRADITIONAL',
      rightLabel: 'MODERN',
    ),
    RelationshipVibeAxis(
      id: 'private_social',
      leftLabel: 'PRIVATE',
      rightLabel: 'SOCIAL',
    ),
    RelationshipVibeAxis(
      id: 'deep_lighthearted',
      leftLabel: 'DEEP TALKS',
      rightLabel: 'LIGHTHEARTED FUN',
    ),
  ];
}
