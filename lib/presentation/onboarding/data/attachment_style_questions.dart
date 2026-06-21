class AttachmentStyleQuestion {
  const AttachmentStyleQuestion({
    required this.question,
    required this.options,
  });

  final String question;
  final List<String> options;
}

abstract final class AttachmentStyleQuestions {
  AttachmentStyleQuestions._();

  static const totalQuestions = 16;

  static const questions = [
    AttachmentStyleQuestion(
      question: 'When someone you care about becomes distant, you usually...',
      options: [
        'Feel anxious and seek clarity',
        'Give them space and pull back',
        'Communicate directly',
        'Try not to think about it',
      ],
    ),
    AttachmentStyleQuestion(
      question: 'When you are getting close to someone, you usually feel...',
      options: [
        'Comfortable and open',
        'Excited but a little worried',
        'Unsure and protective of your space',
        'Interested, but afraid it may not last',
      ],
    ),
    AttachmentStyleQuestion(
      question: 'When a message is not replied to quickly, you usually...',
      options: [
        'Assume they are busy',
        'Wonder if something is wrong',
        'Prefer not to depend on replies',
        'Feel mixed and unsure what to do',
      ],
    ),
    AttachmentStyleQuestion(
      question: 'In a close relationship, you most want...',
      options: [
        'Trust, honesty, and steady communication',
        'Reassurance and emotional closeness',
        'Independence and personal space',
        'Closeness, but only when it feels safe',
      ],
    ),
    AttachmentStyleQuestion(
      question: 'When someone shares their feelings with you, you usually...',
      options: [
        'Listen and respond with care',
        'Feel closer and want more connection',
        'Need time to process before responding',
        'Feel touched but also overwhelmed',
      ],
    ),
    AttachmentStyleQuestion(
      question: 'When there is conflict, you usually...',
      options: [
        'Talk through it calmly',
        'Seek reassurance that things are okay',
        'Step back until emotions settle',
        'Feel unsure whether to move closer or pull away',
      ],
    ),
    AttachmentStyleQuestion(
      question: 'You feel most secure when someone...',
      options: [
        'Is consistent and communicates clearly',
        'Regularly reassures you',
        'Respects your independence',
        'Shows care without pressuring you',
      ],
    ),
    AttachmentStyleQuestion(
      question:
          'When someone wants more closeness than you expected, you usually...',
      options: [
        'Talk about pace and comfort',
        'Feel happy but want reassurance',
        'Feel the need to create space',
        'Feel both drawn in and nervous',
      ],
    ),
    AttachmentStyleQuestion(
      question: 'When you care deeply about someone, you often...',
      options: [
        'Show up consistently',
        'Want frequent signs that they care too',
        'Keep some emotions private',
        'Worry about being too much or not enough',
      ],
    ),
    AttachmentStyleQuestion(
      question: 'If someone disappoints you, you usually...',
      options: [
        'Share how you feel and try to repair it',
        'Feel hurt and look for reassurance',
        'Pull back and handle it alone',
        'Feel confused about whether to stay open',
      ],
    ),
    AttachmentStyleQuestion(
      question: 'In dating, you prefer a connection that feels...',
      options: [
        'Honest, steady, and emotionally safe',
        'Deep, expressive, and reassuring',
        'Calm, spacious, and pressure-free',
        'Meaningful, but not overwhelming',
      ],
    ),
    AttachmentStyleQuestion(
      question: 'When someone is very independent, you usually feel...',
      options: [
        'Fine, as long as communication is clear',
        'Worried they may not need you',
        'Comfortable because space feels natural',
        'Interested, but uncertain about where you stand',
      ],
    ),
    AttachmentStyleQuestion(
      question: 'When your feelings grow stronger, you usually...',
      options: [
        'Communicate with honesty',
        'Want more closeness and clarity',
        'Slow down and protect your space',
        'Feel both excited and cautious',
      ],
    ),
    AttachmentStyleQuestion(
      question: 'You feel cared for when someone...',
      options: [
        'Is reliable and emotionally present',
        'Gives affection and regular reassurance',
        'Respects your boundaries',
        'Makes you feel safe without rushing you',
      ],
    ),
    AttachmentStyleQuestion(
      question: 'When you need support, you usually...',
      options: [
        'Ask directly when you feel ready',
        'Reach out and hope they respond warmly',
        'Try to manage it by yourself first',
        'Want support but find it hard to ask',
      ],
    ),
    AttachmentStyleQuestion(
      question: 'Your ideal relationship pace is...',
      options: [
        'Natural, steady, and mutually clear',
        'Close and emotionally expressive',
        'Slow, spacious, and independent',
        'Gentle, patient, and trust-building',
      ],
    ),
  ];
}
