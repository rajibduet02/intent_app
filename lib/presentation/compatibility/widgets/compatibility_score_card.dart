import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';

class CompatibilityScoreCard extends StatelessWidget {
  const CompatibilityScoreCard({super.key});

  static const double _matchPercent = 0.87;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: AppShadows.intentInput,
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 88,
                  height: 88,
                  child: _CompatibilityDonut(percent: _matchPercent),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'WEIGHTED COMPATIBILITY SCORE',
                        style: IntentLoginStyles.onboardingAssessmentCategory
                            .copyWith(
                          fontSize: 8,
                          letterSpacing: 1.1,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '87% \nMatch',
                        style: IntentLoginStyles.onboardingTitle.copyWith(
                          fontSize: 24,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Based on intentions, values, lifestyle, personality '
                        'patterns, and dealbreaker alignment.',
                        style: IntentLoginStyles.onboardingSubtitle.copyWith(
                          fontSize: 11,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: const [
                _ScoreTag(
                  label: 'Intentions',
                  icon: Icons.adjust,
                  backgroundColor: Color(0xFFF6E8E8),
                  iconColor: Color(0xFFB86B6B),
                ),
                _ScoreTag(
                  label: 'Values',
                  icon: Icons.favorite_border,
                  backgroundColor: Color(0xFFF8ECE8),
                  iconColor: Color(0xFFAA6A5A),
                ),
                _ScoreTag(
                  label: 'Lifestyle',
                  icon: Icons.eco_outlined,
                  backgroundColor: Color(0xFFEDE8DF),
                  iconColor: Color(0xFF7A6A52),
                ),
                _ScoreTag(
                  label: 'Personality',
                  icon: Icons.face_outlined,
                  backgroundColor: Color(0xFFF5E8EE),
                  iconColor: Color(0xFF9A5A72),
                ),
                _ScoreTag(
                  label: 'Dealbreakers',
                  icon: Icons.check_circle_outline,
                  backgroundColor: Color(0xFFE6EFE9),
                  iconColor: AppColors.intentForest,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _CompatibilityDonut extends StatelessWidget {
  const _CompatibilityDonut({required this.percent});

  final double percent;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DonutPainter(percent: percent),
      child: Center(
        child: Text(
          'MATCH',
          style: IntentLoginStyles.onboardingAssessmentCategory.copyWith(
            fontSize: 8,
            letterSpacing: 1,
            color: AppColors.intentGold,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class _DonutPainter extends CustomPainter {
  const _DonutPainter({required this.percent});

  final double percent;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 6;
    const stroke = 8.0;

    final trackPaint = Paint()
      ..color = AppColors.intentProgressInactive.withValues(alpha: 0.45)
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round;

    final progressPaint = Paint()
      ..color = AppColors.intentForest
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, trackPaint);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      math.pi * 2 * percent,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _DonutPainter oldDelegate) {
    return oldDelegate.percent != percent;
  }
}

class _ScoreTag extends StatelessWidget {
  const _ScoreTag({
    required this.label,
    required this.icon,
    required this.backgroundColor,
    required this.iconColor,
  });

  final String label;
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: iconColor),
          const SizedBox(width: 4),
          Text(
            label,
            style: IntentLoginStyles.onboardingSubtitle.copyWith(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: AppColors.intentText,
            ),
          ),
        ],
      ),
    );
  }
}
