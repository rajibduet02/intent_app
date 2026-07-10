import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';

class AssessmentProgress extends StatelessWidget {
  const AssessmentProgress({
    super.key,
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        label,
        style: IntentLoginStyles.mbtiProgress,
      ),
    );
  }
}
