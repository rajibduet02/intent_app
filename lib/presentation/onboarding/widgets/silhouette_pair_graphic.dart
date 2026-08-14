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
    this.iconScale = 1,
    this.connectionGlow = 0,
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

  /// Intro or emphasis scale applied to both icons.
  final double iconScale;

  /// Soft golden pulse between the pair when they connect (0–1).
  final double connectionGlow;

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
          final normalizedCloseness = closeness.clamp(0.0, 1.25) / 1.25;
          final approachScale = 1 + normalizedCloseness * 0.045;
          final combinedScale = iconScale * approachScale;

          return Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              if (connectionGlow > 0.01)
                Positioned.fill(
                  child: IgnorePointer(
                    child: CustomPaint(
                      painter: _ConnectionGlowPainter(
                        glow: connectionGlow,
                      ),
                    ),
                  ),
                ),
              Positioned.fill(
                right: constraints.maxWidth / 2,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Transform.translate(
                    offset: Offset(-horizontalOffset, 0),
                    child: Transform.scale(
                      scale: combinedScale,
                      child: _BrandIcon(
                        asset: AppAssets.maleIcon,
                        height: iconHeight,
                      ),
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
                    child: Transform.scale(
                      scale: combinedScale,
                      child: _BrandIcon(
                        asset: AppAssets.femaleIcon,
                        height: iconHeight,
                      ),
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
                      connectionGlow: connectionGlow,
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

class _ConnectionGlowPainter extends CustomPainter {
  _ConnectionGlowPainter({required this.glow});

  final double glow;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.14;
    final rect = Rect.fromCircle(center: center, radius: radius);
    final gradient = RadialGradient(
      colors: [
        AppColors.intentGold.withValues(alpha: 0.28 * glow),
        AppColors.intentGoldMuted.withValues(alpha: 0.12 * glow),
        Colors.transparent,
      ],
      stops: const [0.0, 0.45, 1.0],
    );
    canvas.drawOval(
      rect,
      Paint()..shader = gradient.createShader(rect),
    );
  }

  @override
  bool shouldRepaint(covariant _ConnectionGlowPainter oldDelegate) {
    return oldDelegate.glow != glow;
  }
}

class _DividerPainter extends CustomPainter {
  _DividerPainter({required this.dividerOpacity});

  final double dividerOpacity;

  @override
  void paint(Canvas canvas, Size size) {
    if (dividerOpacity <= 0.01) return;

    final center = Offset(size.width / 2, size.height / 2);
    final top = center.dy - size.height * 0.28;
    final bottom = center.dy + size.height * 0.28;
    final line = Offset(center.dx, top);
    final end = Offset(center.dx, bottom);

    canvas.drawLine(
      line,
      end,
      Paint()
        ..color = AppColors.intentGold.withValues(alpha: 0.14 * dividerOpacity)
        ..strokeWidth = 4.5
        ..strokeCap = StrokeCap.round,
    );
    canvas.drawLine(
      line,
      end,
      Paint()
        ..color = AppColors.intentGold.withValues(alpha: 0.55 * dividerOpacity)
        ..strokeWidth = 1.2
        ..strokeCap = StrokeCap.round,
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
    required this.connectionGlow,
  });

  final double particlesOpacity;
  final double particleProgress;
  final double connectionGlow;

  @override
  void paint(Canvas canvas, Size size) {
    if (particlesOpacity <= 0.01 && connectionGlow <= 0.01) return;

    final center = Offset(size.width / 2, size.height / 2);
    final particleWidth = size.width * 0.2;
    _drawConnectionArc(canvas, center, particleWidth);
    _drawSparkBurst(canvas, center, particleWidth);
    _drawParticles(canvas, size, center, particleWidth);
  }

  void _drawConnectionArc(Canvas canvas, Offset center, double gap) {
    if (connectionGlow <= 0.05) return;

    final arcPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4
      ..strokeCap = StrokeCap.round
      ..color = AppColors.intentGold.withValues(alpha: 0.35 * connectionGlow);
    final rect = Rect.fromCenter(
      center: center,
      width: gap * 1.1,
      height: gap * 0.55,
    );
    canvas.drawArc(rect, math.pi * 0.15, math.pi * 0.7, false, arcPaint);
  }

  void _drawSparkBurst(Canvas canvas, Offset center, double gap) {
    if (particlesOpacity <= 0.2) return;

    final burstPaint = Paint()
      ..strokeWidth = 1.1
      ..strokeCap = StrokeCap.round;
    const rays = 6;
    for (var i = 0; i < rays; i++) {
      final angle = (i / rays) * math.pi * 2 + particleProgress * math.pi;
      final inner = gap * 0.08;
      final outer = gap * (0.22 + 0.08 * math.sin(particleProgress * math.pi * 2 + i));
      final alpha = particlesOpacity * (0.15 + 0.35 * math.sin(angle));
      burstPaint.color = AppColors.intentGold.withValues(alpha: alpha.clamp(0, 1));
      final start = center + Offset(math.cos(angle) * inner, math.sin(angle) * inner * 0.6);
      final end = center + Offset(math.cos(angle) * outer, math.sin(angle) * outer * 0.6);
      canvas.drawLine(start, end, burstPaint);
    }
  }

  void _drawParticles(Canvas canvas, Size size, Offset center, double gap) {
    if (particlesOpacity <= 0.01) return;

    final rng = math.Random(7);
    final paint = Paint()..style = PaintingStyle.fill;
    const count = 18;
    for (var i = 0; i < count; i++) {
      final t = (i / count + particleProgress * 0.4) % 1.0;
      final drift = math.sin(t * math.pi * 2 + i) * 8;
      final x = center.dx +
          (rng.nextDouble() - 0.5) * gap * 1.5 +
          drift;
      final y = center.dy -
          size.height * 0.3 +
          t * size.height * 0.58 +
          math.cos(t * math.pi * 2 + i * 0.7) * 5;
      final r = 1.0 + rng.nextDouble() * 2.2;
      final alpha = particlesOpacity * (0.2 + 0.6 * math.sin(t * math.pi));
      paint.color = AppColors.intentGold.withValues(alpha: alpha.clamp(0, 1));
      canvas.drawCircle(Offset(x, y), r, paint);

      if (i.isEven && alpha > 0.35) {
        _drawMiniStar(canvas, Offset(x, y), r * 1.6, alpha * 0.7);
      }
    }
  }

  void _drawMiniStar(Canvas canvas, Offset center, double size, double alpha) {
    final paint = Paint()
      ..color = AppColors.intentGoldMuted.withValues(alpha: alpha)
      ..style = PaintingStyle.fill;
    final path = Path();
    for (var i = 0; i < 4; i++) {
      final angle = i * math.pi / 2 + math.pi / 4;
      final point = center + Offset(math.cos(angle) * size, math.sin(angle) * size);
      if (i == 0) {
        path.moveTo(point.dx, point.dy);
      } else {
        path.lineTo(point.dx, point.dy);
      }
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _ParticlesPainter oldDelegate) {
    return oldDelegate.particlesOpacity != particlesOpacity ||
        oldDelegate.particleProgress != particleProgress ||
        oldDelegate.connectionGlow != connectionGlow;
  }
}
