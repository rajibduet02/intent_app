import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';
import 'package:intent_app/presentation/onboarding/data/love_language_options.dart';

class RelationshipVibeSlider extends StatelessWidget {
  const RelationshipVibeSlider({
    super.key,
    required this.axis,
    required this.value,
    required this.onChanged,
  });

  final RelationshipVibeAxis axis;
  final double value;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                axis.leftLabel,
                style: IntentLoginStyles.onboardingAssessmentCategory.copyWith(
                  fontSize: 9,
                  letterSpacing: 0.8,
                  fontWeight: FontWeight.w600,
                  color: AppColors.intentTextSoft,
                ),
              ),
            ),
            Expanded(
              child: Text(
                axis.rightLabel,
                textAlign: TextAlign.right,
                style: IntentLoginStyles.onboardingAssessmentCategory.copyWith(
                  fontSize: 9,
                  letterSpacing: 0.8,
                  fontWeight: FontWeight.w600,
                  color: AppColors.intentTextSoft,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        SliderTheme(
          data: SliderThemeData(
            trackHeight: 2,
            activeTrackColor: AppColors.intentText,
            inactiveTrackColor: AppColors.intentProgressInactive,
            thumbShape: const _VibeSliderThumbShape(),
            overlayShape: SliderComponentShape.noOverlay,
            trackShape: const RoundedRectSliderTrackShape(),
          ),
          child: Slider(
            value: value,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}

class _VibeSliderThumbShape extends SliderComponentShape {
  const _VibeSliderThumbShape();

  static const double _thumbRadius = 10;

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return const Size.fromRadius(_thumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final canvas = context.canvas;
    canvas.drawCircle(
      center,
      _thumbRadius,
      Paint()
        ..color = AppColors.intentGold
        ..style = PaintingStyle.fill,
    );
    canvas.drawCircle(
      center,
      _thumbRadius,
      Paint()
        ..color = AppColors.intentText
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.2,
    );
  }
}
