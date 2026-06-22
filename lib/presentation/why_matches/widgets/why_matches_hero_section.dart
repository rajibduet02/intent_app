import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';

class WhyMatchesHeroSection extends StatelessWidget {
  const WhyMatchesHeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: const Color(0xFFF8E9D8),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppColors.intentGoldMuted.withValues(alpha: 0.35),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.auto_awesome,
                size: 12,
                color: AppColors.intentGold.withValues(alpha: 0.95),
              ),
              const SizedBox(width: 5),
              Text(
                'Connection Plus',
                style: IntentLoginStyles.onboardingSubtitle.copyWith(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: AppColors.intentText,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const _HeroAvatar(
              initial: 'J',
              backgroundColor: AppColors.intentForest,
              foregroundColor: AppColors.white,
            ),
            const SizedBox(width: 10),
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: AppColors.white,
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.intentInputBorder.withValues(alpha: 0.7),
                ),
              ),
              child: Icon(
                Icons.favorite_border,
                size: 14,
                color: AppColors.intentForest.withValues(alpha: 0.85),
              ),
            ),
            const SizedBox(width: 10),
            const _HeroAvatar(
              initial: 'Y',
              backgroundColor: Color(0xFFE8DCC8),
              foregroundColor: AppColors.intentTextSoft,
            ),
          ],
        ),
        const SizedBox(height: 14),
        Text(
          'Julian & You',
          style: IntentLoginStyles.onboardingTitle.copyWith(fontSize: 28),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          decoration: BoxDecoration(
            color: AppColors.intentSegmentFill,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppColors.intentInputBorder.withValues(alpha: 0.5),
            ),
          ),
          child: Text(
            '94% Harmony',
            style: IntentLoginStyles.onboardingCardFieldLabel.copyWith(
              fontSize: 12,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Stack(
          alignment: Alignment.center,
          children: [
            CustomPaint(
              size: const Size(280, 40),
              painter: _WaveAccentPainter(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                'AI-powered insight based on intentions, values, lifestyle, '
                'personality, and dealbreaker alignment.',
                textAlign: TextAlign.center,
                style: IntentLoginStyles.onboardingFooterNote.copyWith(
                  fontSize: 12,
                  height: 1.45,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _HeroAvatar extends StatelessWidget {
  const _HeroAvatar({
    required this.initial,
    required this.backgroundColor,
    required this.foregroundColor,
  });

  final String initial;
  final Color backgroundColor;
  final Color foregroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.intentInputBorder.withValues(alpha: 0.45),
        ),
        boxShadow: AppShadows.intentInput,
      ),
      alignment: Alignment.center,
      child: Text(
        initial,
        style: IntentLoginStyles.onboardingTitle.copyWith(
          fontSize: 26,
          color: foregroundColor,
        ),
      ),
    );
  }
}

class _WaveAccentPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.intentGoldMuted.withValues(alpha: 0.22)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    final path = Path()
      ..moveTo(0, size.height * 0.55)
      ..quadraticBezierTo(
        size.width * 0.25,
        size.height * 0.15,
        size.width * 0.5,
        size.height * 0.55,
      )
      ..quadraticBezierTo(
        size.width * 0.75,
        size.height * 0.95,
        size.width,
        size.height * 0.55,
      );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
