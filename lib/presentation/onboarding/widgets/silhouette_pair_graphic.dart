import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:intent_app/app/theme/theme.dart';

/// Animated male and female icon pair with a divider and light particles.
class SilhouettePairGraphic extends StatelessWidget {
  const SilhouettePairGraphic({
    super.key,
    this.height = 180,
    this.dividerOpacity = 1,
    this.dividerSlideY = 0,
    this.closeness = 0,
    this.particlesOpacity = 0,
    this.particleProgress = 0,
  });

  final double height;

  /// 1 = fully visible thin divider; 0 = hidden.
  final double dividerOpacity;

  /// Vertical offset applied to the divider (slides downward when animated).
  final double dividerSlideY;

  /// 0 = apart; 1 = slightly closer.
  final double closeness;

  final double particlesOpacity;
  final double particleProgress;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final travel = constraints.maxWidth * 0.09;
          final horizontalOffset = travel * (1 - closeness);
          final iconHeight = height * 0.78;

          return Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              Positioned.fill(
                right: constraints.maxWidth / 2,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Transform.translate(
                    offset: Offset(-horizontalOffset, 0),
                    child: _BrandIcon(
                      asset: AppAssets.maleIcon,
                      height: iconHeight,
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                left: constraints.maxWidth / 2,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Transform.translate(
                    offset: Offset(horizontalOffset, 0),
                    child: _BrandIcon(
                      asset: AppAssets.femaleIcon,
                      height: iconHeight,
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: IgnorePointer(
                  child: Transform.translate(
                    offset: Offset(0, dividerSlideY),
                    child: CustomPaint(
                      painter: _DividerPainter(
                        dividerOpacity: dividerOpacity,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: IgnorePointer(
                  child: CustomPaint(
                    painter: _ParticlesPainter(
                      particlesOpacity: particlesOpacity,
                      particleProgress: particleProgress,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _BrandIcon extends StatelessWidget {
  const _BrandIcon({
    required this.asset,
    required this.height,
  });

  final String asset;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      asset,
      height: height,
      width: height,
      fit: BoxFit.contain,
      filterQuality: FilterQuality.high,
    );
  }
}

class _DividerPainter extends CustomPainter {
  _DividerPainter({required this.dividerOpacity});

  final double dividerOpacity;

  @override
  void paint(Canvas canvas, Size size) {
    if (dividerOpacity <= 0.01) return;

    final center = Offset(size.width / 2, size.height / 2);
    final dividerPaint = Paint()
      ..color = AppColors.intentGold.withValues(alpha: 0.55 * dividerOpacity)
      ..strokeWidth = 1.2
      ..strokeCap = StrokeCap.round;
    final top = center.dy - size.height * 0.28;
    final bottom = center.dy + size.height * 0.28;
    canvas.drawLine(
      Offset(center.dx, top),
      Offset(center.dx, bottom),
      dividerPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _DividerPainter oldDelegate) {
    return oldDelegate.dividerOpacity != dividerOpacity;
  }
}

class _ParticlesPainter extends CustomPainter {
  _ParticlesPainter({
    required this.particlesOpacity,
    required this.particleProgress,
  });

  final double particlesOpacity;
  final double particleProgress;

  @override
  void paint(Canvas canvas, Size size) {
    if (particlesOpacity <= 0.01) return;

    final center = Offset(size.width / 2, size.height / 2);
    final particleWidth = size.width * 0.18;
    _drawParticles(canvas, size, center, particleWidth);
  }

  void _drawParticles(Canvas canvas, Size size, Offset center, double gap) {
    final rng = math.Random(7);
    final paint = Paint()..style = PaintingStyle.fill;
    final count = 14;
    for (var i = 0; i < count; i++) {
      final t = (i / count + particleProgress * 0.35) % 1.0;
      final x = center.dx +
          (rng.nextDouble() - 0.5) * gap * 1.6 +
          math.sin(t * math.pi * 2 + i) * 6;
      final y = center.dy -
          size.height * 0.28 +
          t * size.height * 0.55 +
          math.cos(t * math.pi * 2 + i * 0.7) * 4;
      final r = 1.2 + rng.nextDouble() * 1.8;
      final alpha = particlesOpacity * (0.25 + 0.55 * math.sin(t * math.pi));
      paint.color = AppColors.intentGold.withValues(alpha: alpha.clamp(0, 1));
      canvas.drawCircle(Offset(x, y), r, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _ParticlesPainter oldDelegate) {
    return oldDelegate.particlesOpacity != particlesOpacity ||
        oldDelegate.particleProgress != particleProgress;
  }
}
