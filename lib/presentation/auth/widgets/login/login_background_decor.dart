import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';

/// Decorative cream background with gold swoosh, stars, and bottom waves.
class LoginBackgroundDecor extends StatelessWidget {
  const LoginBackgroundDecor({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.intentCream,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CustomPaint(painter: _BottomWavesPainter()),
          CustomPaint(painter: _GoldSwooshPainter()),
          Positioned(
            top: 48,
            left: -20,
            child: Opacity(
              opacity: 0.12,
              child: Icon(
                Icons.eco_outlined,
                size: 140,
                color: AppColors.intentTextSoft.withValues(alpha: 0.6),
              ),
            ),
          ),
          const Positioned(top: 72, right: 48, child: _FourPointStar(size: 10)),
          const Positioned(top: 118, right: 28, child: _FourPointStar(size: 6)),
          const Positioned(top: 200, left: 32, child: _FourPointStar(size: 5)),
          const Positioned(bottom: 180, right: 40, child: _FourPointStar(size: 7)),
        ],
      ),
    );
  }
}

class _FourPointStar extends StatelessWidget {
  const _FourPointStar({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _FourPointStarPainter(),
    );
  }
}

class _FourPointStarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.intentGold
      ..style = PaintingStyle.fill;

    final cx = size.width / 2;
    final cy = size.height / 2;
    final r = size.width / 2;

    final path = Path();
    for (var i = 0; i < 8; i++) {
      final angle = (i * math.pi / 4) - math.pi / 2;
      final radius = i.isEven ? r : r * 0.35;
      final x = cx + radius * math.cos(angle);
      final y = cy + radius * math.sin(angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _GoldSwooshPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width * 0.52, size.height * 0.14);

    for (var i = 0; i < 4; i++) {
      final paint = Paint()
        ..shader = LinearGradient(
          colors: [
            AppColors.intentGold.withValues(alpha: 0.0),
            AppColors.intentGold.withValues(alpha: 0.35 - i * 0.06),
            AppColors.intentGold.withValues(alpha: 0.0),
          ],
          stops: const [0.0, 0.5, 1.0],
        ).createShader(Rect.fromLTWH(0, 0, size.width, size.height * 0.3))
        ..strokeWidth = 1.5 + i * 0.5
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;

      final path = Path()
        ..moveTo(center.dx - 80, center.dy + 20 + i * 6)
        ..quadraticBezierTo(
          center.dx + 40,
          center.dy - 30 - i * 8,
          size.width * 0.88,
          center.dy - 10 - i * 4,
        );
      canvas.drawPath(path, paint);
    }

    const starSize = Size(14, 14);
    final starPainter = _FourPointStarPainter();
    canvas.save();
    canvas.translate(size.width * 0.86, size.height * 0.1);
    starPainter.paint(canvas, starSize);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _BottomWavesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final wave1 = Paint()..color = AppColors.intentCreamDeep.withValues(alpha: 0.55);
    final wave2 = Paint()..color = const Color(0xFFE8DFD2).withValues(alpha: 0.7);
    final wave3 = Paint()..color = const Color(0xFFF0E8DC).withValues(alpha: 0.5);

    void drawWave(Paint paint, double baseY, double amplitude) {
      final path = Path()..moveTo(0, size.height);
      for (var x = 0.0; x <= size.width; x += 4) {
        final y = baseY +
            math.sin((x / size.width) * math.pi * 2.5) * amplitude;
        path.lineTo(x, y);
      }
      path.lineTo(size.width, size.height);
      path.close();
      canvas.drawPath(path, paint);
    }

    drawWave(wave3, size.height * 0.78, 18);
    drawWave(wave2, size.height * 0.82, 14);
    drawWave(wave1, size.height * 0.86, 10);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
