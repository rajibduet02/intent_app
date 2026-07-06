import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';

class AssessmentProgressIndicator extends StatelessWidget {
  const AssessmentProgressIndicator({
    super.key,
    required this.answeredCount,
    required this.total,
  });

  final int answeredCount;
  final int total;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        '$answeredCount of $total answered',
        style: IntentLoginStyles.mbtiProgress,
      ),
    );
  }
}
