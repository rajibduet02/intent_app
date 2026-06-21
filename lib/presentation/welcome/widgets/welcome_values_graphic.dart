import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';
import 'package:intent_app/presentation/auth/widgets/login/login_brand_header.dart';

class WelcomeValuesGraphic extends StatelessWidget {
  const WelcomeValuesGraphic({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: const Size(220, 220),
            painter: _ConcentricRingsPainter(),
          ),
          const IntentFourPointStar(size: 14),
          const Positioned(
            top: 28,
            left: 8,
            child: _ValueCard(label: 'Values'),
          ),
          const Positioned(
            top: 98,
            right: 4,
            child: _ValueCard(label: 'Personality'),
          ),
          const Positioned(
            bottom: 24,
            left: 20,
            child: _ValueCard(label: 'Intention'),
          ),
        ],
      ),
    );
  }
}

class _ValueCard extends StatelessWidget {
  const _ValueCard({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: AppShadows.intentInput,
        border: Border.all(
          color: AppColors.intentInputBorder.withValues(alpha: 0.6),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 22,
            height: 22,
            decoration: const BoxDecoration(
              color: AppColors.intentForest,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check,
              size: 14,
              color: AppColors.white,
            ),
          ),
          const SizedBox(width: 8),
          Text(label, style: IntentLoginStyles.welcomeValueLabel),
        ],
      ),
    );
  }
}

class _ConcentricRingsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radii = [38.0, 58.0, 78.0, 98.0];

    for (final radius in radii) {
      final paint = Paint()
        ..color = AppColors.intentGold.withValues(alpha: 0.22)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1;
      canvas.drawCircle(center, radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
