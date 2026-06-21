import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';

class VerifyProgressStepper extends StatelessWidget {
  const VerifyProgressStepper({super.key});

  static const _labels = [
    'Create\nAccount',
    'Verify\nEmail/Phone',
    'Verify\nPhone',
    'Verify\nCode',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            for (var i = 0; i < 4; i++) ...[
              if (i > 0)
                Expanded(
                  child: Container(
                    height: 2,
                    color: i < 3
                        ? AppColors.intentForest
                        : AppColors.intentGold.withValues(alpha: 0.7),
                  ),
                ),
              _StepCircle(index: i),
            ],
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            for (var i = 0; i < 4; i++)
              Expanded(
                child: Text(
                  _labels[i],
                  textAlign: TextAlign.center,
                  style: i == 3
                      ? IntentLoginStyles.verifyStepLabelActive
                      : IntentLoginStyles.verifyStepLabel,
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class _StepCircle extends StatelessWidget {
  const _StepCircle({required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    if (index < 3) {
      return Container(
        width: 28,
        height: 28,
        decoration: const BoxDecoration(
          color: AppColors.intentForest,
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.check, size: 16, color: AppColors.white),
      );
    }

    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.intentGold, width: 2),
        color: AppColors.white,
      ),
      alignment: Alignment.center,
      child: Text(
        '4',
        style: IntentLoginStyles.verifyStepLabelActive.copyWith(fontSize: 12),
      ),
    );
  }
}
