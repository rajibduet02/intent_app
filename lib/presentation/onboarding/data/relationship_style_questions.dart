import 'package:intent_app/presentation/onboarding/models/assessment_question.dart';
import 'package:intent_app/presentation/onboarding/models/relationship_style.dart';

abstract final class RelationshipStyleQuestions {
  RelationshipStyleQuestions._();

  static const totalQuestions = 16;

  static const partOneLabel = 'PART I · BUILDING CONNECTION';
  static const partTwoLabel = 'PART II · FEELING SECURE';
  static const partThreeLabel = 'PART III · CONFLICT & UNCERTAINTY';
  static const partFourLabel = 'PART IV · LONG-TERM CONNECTION';

  static String sectionLabelForIndex(int index) {
    if (index < 4) return partOneLabel;
    if (index < 8) return partTwoLabel;
    if (index < 12) return partThreeLabel;
    return partFourLabel;
  }

  static const _styleOrder = [
    RelationshipStyle.steadySecure,
    RelationshipStyle.reassuranceSeeking,
    RelationshipStyle.selfProtective,
    RelationshipStyle.pushPull,
  ];

  static List<RelationshipStyleAnswer> _answers(
    String questionId,
    List<String> texts,
  ) {
    const suffixes = ['a', 'b', 'c', 'd'];
    return List.generate(
      texts.length,
      (index) => RelationshipStyleAnswer(
        id: '${questionId}_${suffixes[index]}',
        text: texts[index],
        style: _styleOrder[index],
      ),
    );
  }

  static final questions = [
    AssessmentQuestion(
      id: 'relationship_q1',
      title: 'Feeling Emotionally Safe',
      prompt:
          'As you get to know someone you’re excited about dating, what usually helps you feel comfortable becoming emotionally vulnerable?',
      sectionLabel: partOneLabel,
      answers: _answers('relationship_q1', [
        'Trust builds for me through consistency. The more someone shows up the same way over time, the easier it is for me to open up.',
        'If I feel a strong connection, I usually want to open up pretty quickly because sharing emotionally helps me feel closer.',
        'Even when I really like someone, I tend to open up in layers. I think trust feels stronger when it has time to grow instead of rushing into everything emotionally.',
        'People may think I’m open because I can talk about personal things, but there are certain feelings I still keep pretty guarded.',
      ]),
    ),
    AssessmentQuestion(
      id: 'relationship_q2',
      title: 'When Communication Slows Down',
      prompt:
          'Someone you’ve really enjoyed getting to know tells you they’re going to be extremely busy over the next few days and may not be able to talk very much. As those days go by, what tends to happen internally?',
      sectionLabel: partOneLabel,
      answers: _answers('relationship_q2', [
        'I miss talking to them, but I can usually trust that we’ll reconnect when life settles down.',
        'I understand they’re busy, but even a small check-in helps me feel connected while we’re not talking as much.',
        'I usually take it as a sign to stay grounded in my own life too. I don’t think a connection needs constant attention to be real.',
        'Part of me understands, but another part starts noticing the distance more than I want to.',
      ]),
    ),
    AssessmentQuestion(
      id: 'relationship_q3',
      title: 'Growing Closer',
      prompt:
          'As a relationship becomes more emotionally serious, what usually feels most natural?',
      sectionLabel: partOneLabel,
      answers: _answers('relationship_q3', [
        'I like growing closer while still feeling like we both have room to be ourselves.',
        'The more I care about someone, the more I naturally want to share my life with them and feel included in theirs.',
        'I enjoy getting closer, but I also think relationships stay healthier when both people keep enough space to remain their own person.',
        'I want the closeness, but sometimes when someone starts to really matter to me, I feel both excited and uneasy.',
      ]),
    ),
    AssessmentQuestion(
      id: 'relationship_q4',
      title: 'Leaning on Someone',
      prompt:
          'You’ve had an emotionally exhausting day. What usually feels most natural?',
      sectionLabel: partOneLabel,
      answers: _answers('relationship_q4', [
        'Talking to someone I trust helps. They don’t have to fix it — sometimes it just feels good not to hold everything alone.',
        'I feel better when I can hear from them or know they’re there. That kind of support helps me feel connected.',
        'I usually sort through things on my own first. I think it’s healthy to understand what I’m feeling before bringing someone else into it.',
        'Part of me wants support, but another part worries that needing someone too much could make me feel exposed.',
      ]),
    ),
    AssessmentQuestion(
      id: 'relationship_q5',
      title: 'When Their Energy Changes',
      prompt:
          'You’ve been dating someone for a couple of months. One evening, they seem quieter than usual and less affectionate than they normally are. When you ask if everything is okay, they say they’re just mentally exhausted from work. As the evening continues, what usually happens inside you?',
      sectionLabel: partTwoLabel,
      answers: _answers('relationship_q5', [
        'I believe them and try to stay present instead of assuming it means something about us.',
        'I get that they’re tired, but a little warmth from them helps me not overthink the shift.',
        'I usually give them room and don’t press too much. If they say it’s work stress, I’d rather not turn it into a relationship issue unless there’s a real pattern.',
        'I know they may just be tired, but part of me still starts wondering if something shifted between us.',
      ]),
    ),
    AssessmentQuestion(
      id: 'relationship_q6',
      title: 'Feeling Chosen',
      prompt:
          'Your partner is invited to something with friends. You thought you might go together, but they decide to go on their own because they assumed you’d enjoy having a quiet evening to yourself. What thought feels most natural?',
      sectionLabel: partTwoLabel,
      answers: _answers('relationship_q6', [
        'I get where they were coming from, but I’d probably tell them I’d rather they ask me next time instead of assuming.',
        'I’d probably feel a little disappointed. Being invited in, even to small things, is one of the ways I feel considered.',
        'I’d probably be fine with it. I think it’s healthy for both people to make plans separately sometimes instead of needing every experience to be shared.',
        'Even if their explanation makes sense, part of me might still wonder if they didn’t really want me there.',
      ]),
    ),
    AssessmentQuestion(
      id: 'relationship_q7',
      title: 'Letting Someone In',
      prompt:
          'You’re going through something important, but you haven’t talked about it with your partner yet. What usually feels most true?',
      sectionLabel: partTwoLabel,
      answers: _answers('relationship_q7', [
        'Once I feel ready, sharing it usually makes me feel closer to them.',
        'I want to tell them because feeling emotionally known matters to me, but I may need a little reassurance that it’s okay to bring it up.',
        'I usually wait until I’ve made sense of it myself. I don’t mind being supported, but I don’t like depending on someone else to help me figure out my emotions.',
        'Part of me wants to tell them, but another part wonders if being that honest might change how they see me.',
      ]),
    ),
    AssessmentQuestion(
      id: 'relationship_q8',
      title: 'Consistency',
      prompt:
          'You’ve been seeing someone consistently for several months. They treat you well, communicate regularly, and make time for you. As the relationship becomes more stable, what usually happens inside you?',
      sectionLabel: partTwoLabel,
      answers: _answers('relationship_q8', [
        'The consistency helps me relax and enjoy the relationship more.',
        'The consistency means a lot to me. It helps me feel closer when someone keeps showing, through small things, that they’re still choosing me.',
        'I enjoy the consistency, but I still pay attention to keeping my own rhythm. I think relationships work better when stability doesn’t turn into too much emotional reliance.',
        'When things are going really well, I enjoy it — but I also catch myself wondering if I should trust it fully yet.',
      ]),
    ),
    AssessmentQuestion(
      id: 'relationship_q9',
      title: 'Taking Space',
      prompt:
          'You and your partner have a disagreement. Before continuing the conversation, they say: “I really want to work through this, but I need a little time to clear my head so I can come back in the right mindset.” Which thought feels most natural?',
      sectionLabel: partThreeLabel,
      answers: _answers('relationship_q9', [
        'I may not love waiting, but I can respect that they’re trying to come back to the conversation in a better place.',
        'I understand why they need space, but I still feel better once we’ve reconnected and I know we’re okay.',
        'I can respect it, but if someone regularly needs space before difficult conversations, I may start wondering whether we process conflict in compatible ways.',
        'Even if I know the space is probably healthy, it’s hard not to feel emotionally disconnected until we’re talking again.',
      ]),
    ),
    AssessmentQuestion(
      id: 'relationship_q10',
      title: 'Feeling Misunderstood',
      prompt:
          'You’re trying to explain why something hurt your feelings, but your partner keeps saying, “That wasn’t my intention.” They seem genuine, but you still don’t feel fully understood. Which thought feels most natural?',
      sectionLabel: partThreeLabel,
      answers: _answers('relationship_q10', [
        'I’d probably want us to slow down and try again, because sometimes people miss each other even when they care.',
        'I appreciate that they didn’t mean to hurt me, but I still need them to care about how it landed.',
        'If I don’t feel understood after trying, I usually stop explaining for a while. I’d rather step back than keep pushing a conversation that isn’t landing.',
        'Part of me still wants to be understood, but another part starts pulling back because it feels vulnerable to keep trying.',
      ]),
    ),
    AssessmentQuestion(
      id: 'relationship_q11',
      title: 'Being Seen',
      prompt:
          'Your partner notices you’ve been quieter than usual and gently asks if you’re okay. What feels most natural?',
      sectionLabel: partThreeLabel,
      answers: _answers('relationship_q11', [
        'I appreciate that they noticed. If I trust them, it usually feels safe to share what’s going on.',
        'It feels good that they noticed, and I usually feel closer when someone checks in like that.',
        'My first instinct is usually to keep it light and say I’m fine. I appreciate them noticing, but I don’t always want every emotion to become a conversation.',
        'Part of me wants to tell them, but another part worries I’ll become too much if I let them see all of it.',
      ]),
    ),
    AssessmentQuestion(
      id: 'relationship_q12',
      title: 'Love During Stress',
      prompt:
          'Your partner has been under a lot of stress lately. They’re still kind to you, but they’re quieter, less affectionate, and seem emotionally drained. Which thought feels most natural?',
      sectionLabel: partThreeLabel,
      answers: _answers('relationship_q12', [
        'I assume they’re carrying a lot right now and try to support them without taking it personally.',
        'I understand they’re stressed, but little signs of connection help me remember we’re still okay.',
        'I usually give them room and focus on my own things. I don’t think every quiet season needs to be pulled apart unless they make it clear something is wrong.',
        'I know it may not be about me, but I still feel unsettled until the connection feels normal again.',
      ]),
    ),
    AssessmentQuestion(
      id: 'relationship_q13',
      title: 'Consistently Loved',
      prompt:
          'Over the past several months, your partner has consistently found thoughtful ways to make you feel loved. Not because you asked. Not because they’re making up for something. It’s simply how they naturally love you. What thought feels most natural?',
      sectionLabel: partFourLabel,
      answers: _answers('relationship_q13', [
        'Honestly, it feels really good. Over time, their consistency makes it easier for me to just receive it without overthinking.',
        'I start thinking, “Okay, how can I make them feel this appreciated too?”',
        'I appreciate it, but I’d probably make sure things stay balanced. I think love feels healthier when neither person becomes too used to being carried by the other.',
        'Part of me loves it, and another part needs time to trust that kind of consistency because I’m not fully used to it.',
      ]),
    ),
    AssessmentQuestion(
      id: 'relationship_q14',
      title: 'Depending on Someone',
      prompt:
          'Over time, you realize you’re starting to rely on your partner emotionally more than you expected. One day, you catch yourself thinking...',
      sectionLabel: partFourLabel,
      answers: _answers('relationship_q14', [
        '“I didn’t realize how much lighter life can feel when you don’t have to carry everything alone.”',
        '“This feels really good. I hope they feel how much I’d show up for them too.”',
        '“I care about them, but I’d probably pull back a little. Loving each other is healthy, but I don’t want the relationship to become something I depend on to feel okay.”',
        '“Depending on someone this much feels a little scary because people and relationships can change.”',
      ]),
    ),
    AssessmentQuestion(
      id: 'relationship_q15',
      title: 'Being Loved Well',
      prompt:
          'Over the past year, your relationship has been consistently healthy. You feel respected. Arguments get resolved. You trust each other. The relationship feels peaceful. One day, you catch yourself thinking...',
      sectionLabel: partFourLabel,
      answers: _answers('relationship_q15', [
        '“This feels peaceful in a way I didn’t know I needed.”',
        '“I love this. I just need to keep feeling that we’re both still choosing this.”',
        '“This feels good, but I’d still want to make sure we don’t become too wrapped up in the relationship. I think love stays healthier when both people can stand firmly on their own.”',
        '“Sometimes peace feels so unfamiliar that I catch myself wondering if something is going to change.”',
      ]),
    ),
    AssessmentQuestion(
      id: 'relationship_q16',
      title: 'Looking Back',
      prompt:
          'Imagine you’re looking back many years from now on a happy, healthy relationship. When people ask what made it last, which answer feels most like something you’d genuinely say?',
      sectionLabel: partFourLabel,
      answers: _answers('relationship_q16', [
        '“We kept choosing each other, communicating honestly, and growing together.”',
        '“We never stopped making each other feel wanted, valued, and emotionally safe.”',
        '“We gave each other love, but also enough space to keep becoming ourselves.”',
        '“Neither of us was perfect. We just kept giving each other reasons to trust the relationship.”',
      ]),
    ),
  ];

  static RelationshipStyleAnswer? answerById(String answerId) {
    for (final question in questions) {
      for (final answer in question.answers) {
        if (answer is RelationshipStyleAnswer && answer.id == answerId) {
          return answer;
        }
      }
    }
    return null;
  }

  static RelationshipStyleResult calculateResult(
    Map<String, String> selectedAnswers,
  ) {
    final counts = {
      for (final style in RelationshipStyle.values) style: 0,
    };

    for (final answerId in selectedAnswers.values) {
      final answer = answerById(answerId);
      if (answer != null) {
        counts[answer.style] = counts[answer.style]! + 1;
      }
    }

    final sorted = counts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    final primary = sorted.first.key;
    RelationshipStyle? secondary;

    if (sorted.length > 1) {
      final runnerUp = sorted[1];
      if (runnerUp.value == sorted.first.value ||
          sorted.first.value - runnerUp.value <= 1) {
        secondary = runnerUp.key;
      }
    }

    return RelationshipStyleResult(primary: primary, secondary: secondary);
  }
}
