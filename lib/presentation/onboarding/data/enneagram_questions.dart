class EnneagramQuestion {
  const EnneagramQuestion({
    required this.question,
    required this.options,
  });

  final String question;
  final List<String> options;
}

abstract final class EnneagramQuestions {
  EnneagramQuestions._();

  static const totalQuestions = 16;

  static const questions = [
    EnneagramQuestion(
      question: 'When you feel stressed, you tend to...',
      options: [
        'Take charge and fix things quickly',
        'Help others and stay positive',
        'Focus on goals and achievement',
        'Withdraw and process alone',
      ],
    ),
    EnneagramQuestion(
      question: 'In your closest relationships, you most value...',
      options: [
        'Loyalty and emotional depth',
        'Honesty and direct communication',
        'Stability and mutual support',
        'Freedom and personal space',
      ],
    ),
    EnneagramQuestion(
      question: 'When making decisions, you rely primarily on...',
      options: [
        'Logic and objective facts',
        'Gut feelings and intuition',
        'What feels right emotionally',
        'Advice from people you trust',
      ],
    ),
    EnneagramQuestion(
      question: 'Your biggest fear in relationships is...',
      options: [
        'Being controlled or manipulated',
        'Being abandoned or unloved',
        'Being seen as inadequate',
        'Losing your independence',
      ],
    ),
    EnneagramQuestion(
      question: 'When conflict arises, you usually...',
      options: [
        'Address it directly and move on',
        'Avoid it until things calm down',
        'Try to keep everyone happy',
        'Stand firm on your principles',
      ],
    ),
    EnneagramQuestion(
      question: 'You feel most fulfilled when you...',
      options: [
        'Accomplish something meaningful',
        'Connect deeply with someone',
        'Help others succeed',
        'Live authentically on your terms',
      ],
    ),
    EnneagramQuestion(
      question: 'Under pressure, others might describe you as...',
      options: [
        'Intense and driven',
        'Analytical and reserved',
        'Warm and accommodating',
        'Independent and self-reliant',
      ],
    ),
    EnneagramQuestion(
      question: 'Your ideal weekend usually involves...',
      options: [
        'Quality time with close friends',
        'Pursuing a personal project',
        'Rest and quiet reflection',
        'New experiences and adventure',
      ],
    ),
    EnneagramQuestion(
      question: 'When someone criticizes you, you tend to...',
      options: [
        'Take it personally and reflect deeply',
        'Defend yourself immediately',
        'Consider if there is truth in it',
        'Dismiss it and move forward',
      ],
    ),
    EnneagramQuestion(
      question: 'You are most motivated by...',
      options: [
        'Making a positive impact',
        'Achieving recognition',
        'Maintaining inner peace',
        'Pursuing truth and understanding',
      ],
    ),
    EnneagramQuestion(
      question: 'In social situations, you prefer to...',
      options: [
        'Observe before engaging',
        'Be the center of attention',
        'Have deep one-on-one conversations',
        'Keep things light and fun',
      ],
    ),
    EnneagramQuestion(
      question: 'When plans change unexpectedly, you...',
      options: [
        'Adapt easily and go with it',
        'Feel frustrated but adjust',
        'Need time to process the change',
        'Prefer to stick to the original plan',
      ],
    ),
    EnneagramQuestion(
      question: 'Your approach to personal growth is...',
      options: [
        'Constant self-improvement',
        'Learning through relationships',
        'Seeking wisdom and insight',
        'Taking action and proving yourself',
      ],
    ),
    EnneagramQuestion(
      question: 'You handle uncertainty by...',
      options: [
        'Creating structure and plans',
        'Trusting your instincts',
        'Seeking reassurance from others',
        'Staying busy and productive',
      ],
    ),
    EnneagramQuestion(
      question: 'What matters most in a partner is...',
      options: [
        'Emotional availability',
        'Shared values and integrity',
        'Ambition and drive',
        'Intellectual connection',
      ],
    ),
    EnneagramQuestion(
      question: 'In a group setting, you usually find yourself...',
      options: [
        'Leading the conversation',
        'Listening and observing',
        'Mediating between others',
        'Contributing when asked',
      ],
    ),
  ];
}
