class MbtiQuestion {
  const MbtiQuestion({
    required this.question,
    required this.options,
  });

  final String question;
  final List<String> options;
}

/// MBTI short assessment copy aligned with Figma sections 1–16.
abstract final class MbtiQuestions {
  MbtiQuestions._();

  static const totalSections = 16;

  static const sections = [
    MbtiQuestion(
      question: 'When you go somewhere for the day, would you rather',
      options: [
        'Plan what you will do',
        'Just go',
        'Go with the flow',
        'Decide when you get there',
      ],
    ),
    MbtiQuestion(
      question: 'Which word in each pair appeals to you more?',
      options: [
        'Children are more',
        'Gentle',
        'Firmness',
        'Logic and reason',
      ],
    ),
    MbtiQuestion(
      question: 'In a group setting, would you rather',
      options: [
        'Introduce yourself',
        'Wait to be introduced',
        'Talk to people you know',
        "Talk to people you don't know",
      ],
    ),
    MbtiQuestion(
      question: 'When making decisions, do you usually rely on',
      options: [
        'Facts and logic',
        'Your gut feeling',
        'A mix of both',
        'What feels right in the moment',
      ],
    ),
    MbtiQuestion(
      question: 'After spending time with others, you tend to feel',
      options: [
        'Energized',
        'Content',
        'A little drained',
        'Ready for quiet time',
      ],
    ),
    MbtiQuestion(
      question: 'When starting a new project, you prefer to',
      options: [
        'Outline every step first',
        'Have a rough idea and begin',
        'Brainstorm with others',
        'Wait until inspiration strikes',
      ],
    ),
    MbtiQuestion(
      question: 'In conversations, you are more likely to',
      options: [
        'Listen carefully',
        'Share your thoughts openly',
        'Ask questions',
        'Keep things light',
      ],
    ),
    MbtiQuestion(
      question: 'Your ideal weekend usually involves',
      options: [
        'Social plans with friends',
        'A mix of social and solo time',
        'Quiet time at home',
        'Spontaneous adventures',
      ],
    ),
    MbtiQuestion(
      question: 'When solving problems, you tend to focus on',
      options: [
        'What works best logically',
        'How people will be affected',
        'Past experiences',
        'Creative alternatives',
      ],
    ),
    MbtiQuestion(
      question: 'You feel most comfortable when plans are',
      options: [
        'Clearly defined',
        'Flexible with room to adapt',
        'Open-ended',
        'Made together with others',
      ],
    ),
    MbtiQuestion(
      question: 'When learning something new, you prefer',
      options: [
        'Hands-on practice',
        'Reading and research',
        'Discussing with others',
        'Watching and observing first',
      ],
    ),
    MbtiQuestion(
      question: 'In stressful situations, you usually',
      options: [
        'Stay calm and analytical',
        'Look for emotional support',
        'Take space to process',
        'Act quickly to fix things',
      ],
    ),
    MbtiQuestion(
      question: 'You are more drawn to ideas that are',
      options: [
        'Practical and proven',
        'Imaginative and new',
        'Meaningful to you personally',
        'Useful for the group',
      ],
    ),
    MbtiQuestion(
      question: 'When meeting new people, you typically',
      options: [
        'Warm up quickly',
        'Take time to open up',
        'Observe before engaging',
        'Let them lead the conversation',
      ],
    ),
    MbtiQuestion(
      question: 'You prefer feedback that is',
      options: [
        'Direct and honest',
        'Gentle and encouraging',
        'Detailed and specific',
        'Focused on growth',
      ],
    ),
    MbtiQuestion(
      question: 'When thinking about the future, you focus more on',
      options: [
        'Realistic next steps',
        'Big possibilities',
        'Personal values',
        'How it affects relationships',
      ],
    ),
  ];
}
