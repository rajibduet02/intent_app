import 'package:flutter/material.dart';

import 'package:intent_app/presentation/auth/widgets/shared/fixed_background_auth_scaffold.dart';

class EnneagramAssessmentHeader extends StatelessWidget {
  const EnneagramAssessmentHeader({
    super.key,
    required this.onBack,
  });

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: Row(
        children: [
          IntentBackButton(onPressed: onBack),
        ],
      ),
    );
  }
}
