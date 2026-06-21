import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';

/// Intent app logo from bundled asset.
class IntentLogo extends StatelessWidget {
  const IntentLogo({super.key, this.size = 56});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AppAssets.mainLogo,
      width: size,
      height: size,
      fit: BoxFit.contain,
    );
  }
}

/// Prominent Intent logo + wordmark (shared by splash and login).
class IntentBrandMark extends StatelessWidget {
  const IntentBrandMark({
    super.key,
    this.logoSize = 56,
    this.titleStyle,
    this.spacing,
  });

  final double logoSize;
  final TextStyle? titleStyle;
  final double? spacing;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IntentLogo(size: logoSize),
        SizedBox(height: spacing ?? AppSpacing.sm),
        Text(
          'Intent',
          style: titleStyle ?? IntentLoginStyles.signupTitle,
        ),
      ],
    );
  }
}

/// Brand header: logo, title, star divider, taglines.
class LoginBrandHeader extends StatelessWidget {
  const LoginBrandHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const IntentBrandMark(),
        const SizedBox(height: 12),
        const IntentStarDivider(),
        const SizedBox(height: 12),
        Text('Date with intention.', style: IntentLoginStyles.tagline),
        const SizedBox(height: 8),
        Text(
          'MORE CHEMISTRY. LESS GUESSING.',
          style: IntentLoginStyles.subTagline,
        ),
      ],
    );
  }
}

class IntentStarDivider extends StatelessWidget {
  const IntentStarDivider({super.key, this.showLines = true});

  final bool showLines;

  @override
  Widget build(BuildContext context) {
    if (!showLines) {
      return const IntentFourPointStar(size: 8);
    }
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 1,
            color: AppColors.intentDividerGold.withValues(alpha: 0.5),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: IntentFourPointStar(size: 8),
        ),
        Expanded(
          child: Container(
            height: 1,
            color: AppColors.intentDividerGold.withValues(alpha: 0.5),
          ),
        ),
      ],
    );
  }
}

class IntentFourPointStar extends StatelessWidget {
  const IntentFourPointStar({super.key, this.size = 8});

  final double size;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _MiniStarPainter(),
    );
  }
}

class _MiniStarPainter extends CustomPainter {
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
