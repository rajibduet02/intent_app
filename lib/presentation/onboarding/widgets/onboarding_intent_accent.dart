import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';

/// Small gold accent mark above onboarding section titles.
class OnboardingIntentAccent extends StatelessWidget {
  const OnboardingIntentAccent({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(36, 20),
      painter: _OnboardingIntentAccentPainter(),
    );
  }
}

class _OnboardingIntentAccentPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.intentGold
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path()
      ..moveTo(size.width * 0.1, size.height * 0.85)
      ..lineTo(size.width * 0.72, size.height * 0.2);

    canvas.drawPath(path, paint);

    final arrowPaint = Paint()
      ..color = AppColors.intentGold
      ..style = PaintingStyle.fill;

    final tip = Offset(size.width * 0.72, size.height * 0.2);
    final arrow = Path()
      ..moveTo(tip.dx, tip.dy)
      ..lineTo(tip.dx - 7, tip.dy + 1)
      ..lineTo(tip.dx - 1, tip.dy + 7)
      ..close();

    canvas.drawPath(arrow, arrowPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
