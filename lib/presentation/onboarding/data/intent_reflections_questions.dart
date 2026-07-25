import 'package:intent_app/presentation/onboarding/models/assessment_question.dart';

abstract final class IntentReflectionsQuestions {
  IntentReflectionsQuestions._();

  static const totalQuestions = 10;

  // OLD CLIENT COPY
  /*
  static const partOneLabel = 'PART I · HOW YOU SHOW UP';
  static const partTwoLabel = 'PART II · HOW YOU SEE OTHERS';
  */
  static const partOneLabel = '';
  static const partTwoLabel = '';

  static String sectionLabelForIndex(int index) =>
      index < 6 ? partOneLabel : partTwoLabel;

  static const questions = [
    AssessmentQuestion(
      id: 'intent_reflection_1',
      // title: 'Accountability',
      title: '',
      prompt: 'Which statement feels closest to your view?',
      // sectionLabel: partOneLabel,
      sectionLabel: '',
      answers: [
        AssessmentAnswer(
          id: 'intent_reflection_1_a',
          text:
              'Every disagreement teaches me something about myself, even if I wasn’t the main cause.',
        ),
        AssessmentAnswer(
          id: 'intent_reflection_1_b',
          text:
              'If I genuinely believe I handled a situation appropriately, I don’t usually spend much time revisiting it.',
        ),
        AssessmentAnswer(
          id: 'intent_reflection_1_c',
          text:
              'Even when I think my perspective was valid, I usually reflect on whether my delivery or timing could have been better.',
        ),
        AssessmentAnswer(
          id: 'intent_reflection_1_d',
          text:
              'I usually assume I could’ve prevented the disagreement somehow, even when I’m not sure that’s fair to myself.',
        ),
      ],
    ),
    AssessmentQuestion(
      id: 'intent_reflection_2',
      // title: 'Emotional Regulation',
      title: '',
      prompt:
          'Your partner says: “I don’t think this conversation is going anywhere right now. Can we take a break and come back to it later?” What’s your first thought?',
      // sectionLabel: partOneLabel,
      sectionLabel: '',
      answers: [
        AssessmentAnswer(
          id: 'intent_reflection_2_a',
          text:
              'That sounds fair. I’d rather pause than say something I’ll regret.',
        ),
        AssessmentAnswer(
          id: 'intent_reflection_2_b',
          text:
              'I’d rather finish talking now. Sitting with unresolved conflict makes me anxious.',
        ),
        AssessmentAnswer(
          id: 'intent_reflection_2_c',
          text:
              'I’d agree to the break, but I’d probably spend that time wondering what they’re really thinking.',
        ),
        AssessmentAnswer(
          id: 'intent_reflection_2_d',
          text:
              'If someone wants to pause an important conversation, I’d naturally question whether they’re actually committed to working through problems together.',
        ),
      ],
    ),
    AssessmentQuestion(
      id: 'intent_reflection_3',
      // title: 'Respect & Validation',
      title: '',
      prompt:
          'Your partner says: “I know you didn’t mean to hurt me, but what happened really hurt.” What’s your first instinct?',
      // sectionLabel: partOneLabel,
      sectionLabel: '',
      answers: [
        AssessmentAnswer(
          id: 'intent_reflection_3_a',
          text:
              'I want to understand what that experience felt like for them before explaining my perspective.',
        ),
        AssessmentAnswer(
          id: 'intent_reflection_3_b',
          text:
              'I want to understand them, but I also hope they’ll understand where I was coming from.',
        ),
        AssessmentAnswer(
          id: 'intent_reflection_3_c',
          text:
              'I feel bad that they were hurt. But if I honestly don’t believe I did anything wrong, I find it difficult to apologize just to make things smoother.',
        ),
        AssessmentAnswer(
          id: 'intent_reflection_3_d',
          text:
              'My first instinct is usually to explain my intentions because I don’t want to be misunderstood.',
        ),
      ],
    ),
    AssessmentQuestion(
      id: 'intent_reflection_4',
      // title: 'Boundaries',
      title: '',
      prompt: 'Which statement feels closest to your view?',
      // sectionLabel: partOneLabel,
      sectionLabel: '',
      answers: [
        AssessmentAnswer(
          id: 'intent_reflection_4_a',
          text:
              'Healthy relationships include both quality time together and time to recharge individually.',
        ),
        AssessmentAnswer(
          id: 'intent_reflection_4_b',
          text:
              'I’d enjoy hearing from my partner every day, but I understand that everyone needs space sometimes.',
        ),
        AssessmentAnswer(
          id: 'intent_reflection_4_c',
          text:
              'If someone regularly asks for space, I’d probably question whether they’re truly ready to build a relationship with someone else.',
        ),
        AssessmentAnswer(
          id: 'intent_reflection_4_d',
          text:
              'If we’re committed, I don’t really understand why we’d need space from one another unless something is wrong.',
        ),
      ],
    ),
    AssessmentQuestion(
      id: 'intent_reflection_5',
      // title: 'Conflict Mindset',
      title: '',
      prompt: 'Which statement feels closest to your view?',
      // sectionLabel: partOneLabel,
      sectionLabel: '',
      answers: [
        AssessmentAnswer(
          id: 'intent_reflection_5_a',
          text:
              'Most disagreements happen because both people contributed something worth understanding.',
        ),
        AssessmentAnswer(
          id: 'intent_reflection_5_b',
          text:
              'Sometimes one person is mostly responsible, but it’s still valuable to hear both perspectives.',
        ),
        AssessmentAnswer(
          id: 'intent_reflection_5_c',
          text:
              'If someone repeatedly ignores my boundaries, I don’t think I owe them much explanation before creating distance.',
        ),
        AssessmentAnswer(
          id: 'intent_reflection_5_d',
          text:
              'People are generally too sensitive these days, and many disagreements happen because people take things too personally.',
        ),
      ],
    ),
    AssessmentQuestion(
      id: 'intent_reflection_6',
      // title: 'Repair',
      title: '',
      prompt:
          'After you’ve both had time to cool down, what’s usually your next move?',
      // sectionLabel: partOneLabel,
      sectionLabel: '',
      answers: [
        AssessmentAnswer(
          id: 'intent_reflection_6_a',
          text:
              'I like to reconnect and make sure we’ve both had a chance to feel heard.',
        ),
        AssessmentAnswer(
          id: 'intent_reflection_6_b',
          text:
              'I usually wait until the other person seems ready before bringing it back up.',
        ),
        AssessmentAnswer(
          id: 'intent_reflection_6_c',
          text:
              'I spend time reflecting first because I’d rather have one meaningful conversation than several emotional ones.',
        ),
        AssessmentAnswer(
          id: 'intent_reflection_6_d',
          text:
              'If I still believe I was right, I don’t usually feel a strong need to revisit it unless they bring it up.',
        ),
      ],
    ),
    AssessmentQuestion(
      id: 'intent_reflection_7',
      // title: 'Relationship Assumptions',
      title: '',
      prompt:
          'Your best friend tells you: “I’ve been dating this woman for a few months, and honestly, it’s the healthiest relationship I’ve ever had. She’s kind, emotionally mature, we communicate really well, and I genuinely feel at peace with her. The only thing that made me hesitate at first is that she has two children from a previous relationship.” What’s your first instinct?',
      // sectionLabel: partTwoLabel,
      sectionLabel: '',
      answers: [
        AssessmentAnswer(
          id: 'intent_reflection_7_a',
          text:
              'If she’s treating him well and he’s genuinely happy, I’d encourage him to keep getting to know her.',
        ),
        AssessmentAnswer(
          id: 'intent_reflection_7_b',
          text:
              'I’d tell him to enjoy where things are going but also have honest conversations about parenting, expectations, and what their future might realistically look like.',
        ),
        AssessmentAnswer(
          id: 'intent_reflection_7_c',
          text:
              'I’d probably encourage him to slow things down. Relationships that already include children often come with additional responsibilities, and I’d want him to think carefully before becoming more invested.',
        ),
        AssessmentAnswer(
          id: 'intent_reflection_7_d',
          text:
              'I’d probably encourage him to take a step back. Even if things are going well, I’d question whether taking on that kind of responsibility is worth it this early.',
        ),
      ],
    ),
    AssessmentQuestion(
      id: 'intent_reflection_8',
      // title: 'Expectations vs. Reality',
      title: '',
      prompt:
          'Your friend tells you: “I always said I’d never date someone who had already been married or whose life looked so different from mine. But somehow... I’ve never felt this understood before. I honestly can’t remember the last time I laughed this much or felt this comfortable being myself.” What’s your first instinct?',
      // sectionLabel: partTwoLabel,
      sectionLabel: '',
      answers: [
        AssessmentAnswer(
          id: 'intent_reflection_8_a',
          text:
              'I’d tell them that’s exactly why it’s important to get to know people instead of only dating the picture we create in our heads.',
        ),
        AssessmentAnswer(
          id: 'intent_reflection_8_b',
          text:
              'I’d be happy for them, but I’d also encourage them to keep paying attention to whether their values and long-term goals still align.',
        ),
        AssessmentAnswer(
          id: 'intent_reflection_8_c',
          text:
              'I’d probably ask what made those things important to them in the first place. Sometimes our original standards exist for a reason, and sometimes they deserve to be challenged.',
        ),
        AssessmentAnswer(
          id: 'intent_reflection_8_d',
          text:
              'I’d probably remind them that there’s nothing wrong with sticking to the standards they’ve always had. Those preferences usually come from somewhere.',
        ),
      ],
    ),
    AssessmentQuestion(
      id: 'intent_reflection_9',
      // title: 'Modern Dating',
      title: '',
      prompt:
          'A friend sends you a dating video that says: “Never settle. If you have to compromise, they’re not your person. The right relationship shouldn’t feel this hard.” They text you: “Honestly... what do you think? Is that actually true?” Which response feels closest to what you’d say?',
      // sectionLabel: partTwoLabel,
      sectionLabel: '',
      answers: [
        AssessmentAnswer(
          id: 'intent_reflection_9_a',
          text:
              'I’d probably tell them every healthy relationship requires effort sometimes. I’d be careful not to mistake normal challenges for incompatibility.',
        ),
        AssessmentAnswer(
          id: 'intent_reflection_9_b',
          text:
              'I’d tell them there’s some truth to it. You shouldn’t have to convince someone to choose you, but every relationship still requires communication and compromise.',
        ),
        AssessmentAnswer(
          id: 'intent_reflection_9_c',
          text:
              'I’d probably tell them to trust their instincts. If something feels difficult from the beginning, it may be worth asking whether it’s the right relationship.',
        ),
        AssessmentAnswer(
          id: 'intent_reflection_9_d',
          text:
              'I’d probably agree with the video. Life is too short to spend years trying to make something work when the right relationship shouldn’t require that much effort.',
        ),
      ],
    ),
    AssessmentQuestion(
      id: 'intent_reflection_10',
      // title: 'Reciprocity',
      title: '',
      prompt:
          'Your friend says: “I really like the person I’m dating, but lately I feel like I’m always the one making plans, checking in, and keeping the relationship moving. When we’re together everything feels great... but if I don’t reach out first, we can go several days without talking.” What’s your first instinct?',
      // sectionLabel: partTwoLabel,
      sectionLabel: '',
      answers: [
        AssessmentAnswer(
          id: 'intent_reflection_10_a',
          text:
              'I’d probably encourage them to bring it up. Healthy relationships work best when both people understand how the other experiences effort and consistency.',
        ),
        AssessmentAnswer(
          id: 'intent_reflection_10_b',
          text:
              'I’d remind them that relationships naturally ebb and flow. Sometimes one person carries more for a season, but it’s worth seeing whether things balance out over time.',
        ),
        AssessmentAnswer(
          id: 'intent_reflection_10_c',
          text:
              'I’d probably tell them to step back for a bit. If someone is interested, their effort usually becomes clearer when you stop doing all the work.',
        ),
        AssessmentAnswer(
          id: 'intent_reflection_10_d',
          text:
              'I’d wonder whether they’re expecting too much. Some people simply aren’t big planners or communicators, and that doesn’t necessarily mean they care less.',
        ),
      ],
    ),
  ];
}
