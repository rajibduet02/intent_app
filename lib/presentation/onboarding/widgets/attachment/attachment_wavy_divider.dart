import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';

class AttachmentWavyDivider extends StatelessWidget {
  const AttachmentWavyDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 16,
      width: double.infinity,
      child: CustomPaint(
        painter: _WavyDividerPainter(
          color: AppColors.intentInputBorder.withValues(alpha: 0.7),
        ),
      ),
    );
  }
}

class _WavyDividerPainter extends CustomPainter {
  _WavyDividerPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final path = Path();
    const waveLength = 24.0;
    final midY = size.height / 2;

    path.moveTo(0, midY);
    for (var x = 0.0; x <= size.width; x += 1) {
      final y = midY + math.sin(x / waveLength * math.pi * 2) * 3;
      path.lineTo(x, y);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
