import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intent_app/app/theme/theme.dart';
import 'package:intent_app/presentation/auth/widgets/shared/fixed_background_auth_scaffold.dart';
import 'package:intent_app/presentation/onboarding/providers/intention_success_provider.dart';
import 'package:intent_app/presentation/onboarding/widgets/onboarding_continue_button.dart';

class IntentionSuccessScreen extends ConsumerWidget {
  const IntentionSuccessScreen({super.key});

  static const List<String> _profileIncludes = [
    'About You',
    'Personality',
    'Compatibility',
    'Privacy & Safety',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(intentionSuccessProvider.notifier);
    final state = ref.watch(intentionSuccessProvider);

    return FixedBackgroundAuthScaffold(
      pinnedFooter: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
        child: OnboardingContinueButton(
          label: 'Start Discovering',
          isLoading: state.isLoading,
          onPressed: () => unawaited(notifier.startDiscovering()),
        ),
      ),
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24).copyWith(
          bottom: 24 + _pinnedFooterHeight,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _IntentionSuccessHeader(onBack: notifier.onBack),
            const SizedBox(height: AppSpacing.sm),
            const _SuccessHeroIcon(),
            const SizedBox(height: AppSpacing.sm),
            const _SuccessHeroCopy(),
            const SizedBox(height: AppSpacing.lg),
            const _CompatibilityPreviewCard(),
            const SizedBox(height: AppSpacing.md),
            _ProfileIncludesCard(items: _profileIncludes),
            const SizedBox(height: AppSpacing.md),
            const _SettingsNote(),
          ],
        ),
      ),
    );
  }
}

class _IntentionSuccessHeader extends StatelessWidget {
  const _IntentionSuccessHeader({required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: Row(
        children: [
          IntentBackButton(onPressed: onBack),
        ],
      ),
    );
  }
}

class _SuccessHeroIcon extends StatelessWidget {
  const _SuccessHeroIcon();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 96,
        height: 96,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            Container(
              width: 88,
              height: 88,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.intentProgressInactive.withValues(alpha: 0.9),
                  width: 2,
                ),
              ),
            ),
            CustomPaint(
              size: const Size(54, 54),
              painter: _ScallopedBadgePainter(),
              child: const Center(
                child: Icon(
                  Icons.check_rounded,
                  color: AppColors.white,
                  size: 26,
                ),
              ),
            ),
            Positioned(
              top: 2,
              right: 18,
              child: Icon(
                Icons.favorite,
                size: 15,
                color: AppColors.intentGold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ScallopedBadgePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    const bumps = 12;

    final path = Path();
    for (var i = 0; i < bumps * 2; i++) {
      final r = i.isEven ? radius : radius * 0.86;
      final angle = (i * math.pi) / bumps - math.pi / 2;
      final point = center + Offset(math.cos(angle) * r, math.sin(angle) * r);
      if (i == 0) {
        path.moveTo(point.dx, point.dy);
      } else {
        path.lineTo(point.dx, point.dy);
      }
    }
    path.close();

    final fill = Paint()
      ..color = AppColors.intentForest
      ..style = PaintingStyle.fill;
    canvas.drawPath(path, fill);

    final stroke = Paint()
      ..color = AppColors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8;
    canvas.drawPath(path, stroke);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _SuccessHeroCopy extends StatelessWidget {
  const _SuccessHeroCopy();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "You're ready to meet with \nintention",
          textAlign: TextAlign.center,
          style: IntentLoginStyles.onboardingTitle,
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'Your profile is built around who you are, not just how you look.',
          textAlign: TextAlign.center,
          style: IntentLoginStyles.onboardingSubtitle,
        ),
      ],
    );
  }
}

class _CompatibilityPreviewCard extends StatelessWidget {
  const _CompatibilityPreviewCard();

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
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const _PreviewAvatar(),
                const SizedBox(width: 12),
                const Expanded(child: _PreviewProfileInfo()),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'MATCH',
                      style: IntentLoginStyles.onboardingAssessmentCategory
                          .copyWith(
                        fontSize: 9,
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '94%',
                      style: IntentLoginStyles.onboardingTitle.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        height: 1,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 14),
            const _CompatibilityDivider(),
            const SizedBox(height: 10),
            Text(
              'COMPATIBILITY',
              style: IntentLoginStyles.onboardingAssessmentCategory.copyWith(
                fontSize: 9,
                letterSpacing: 1.3,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            const Row(
              children: [
                Expanded(
                  child: _MetricProgress(
                    label: 'VALUES',
                    percent: 0.8,
                    percentLabel: '80%',
                  ),
                ),
                SizedBox(width: 14),
                Expanded(
                  child: _MetricProgress(
                    label: 'LIFESTYLE',
                    percent: 0.65,
                    percentLabel: '65%',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PreviewAvatar extends StatelessWidget {
  const _PreviewAvatar();

  static const String _demoInitial = 'J';

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.intentForest,
            border: Border.all(
              color: AppColors.intentInputBorder.withValues(alpha: 0.55),
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            _demoInitial,
            style: IntentLoginStyles.onboardingContinue.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Positioned(
          bottom: -1,
          right: -1,
          child: Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              color: AppColors.intentForest,
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.white,
                width: 1.5,
              ),
            ),
            child: const Icon(
              Icons.check,
              size: 10,
              color: AppColors.white,
            ),
          ),
        ),
      ],
    );
  }
}

class _PreviewProfileInfo extends StatelessWidget {
  const _PreviewProfileInfo();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Julian, 31',
          style: IntentLoginStyles.onboardingCardFieldLabel.copyWith(
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Icon(
              Icons.location_on_outlined,
              size: 13,
              color: AppColors.intentTextSoft,
            ),
            const SizedBox(width: 4),
            Text(
              'San Francisco',
              style: IntentLoginStyles.onboardingSubtitle.copyWith(
                fontSize: 12,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _CompatibilityDivider extends StatelessWidget {
  const _CompatibilityDivider();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 28,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Divider(
            height: 1,
            color: AppColors.intentInputBorder.withValues(alpha: 0.7),
          ),
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: AppColors.intentCreamDeep,
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.intentInputBorder.withValues(alpha: 0.55),
              ),
            ),
            child: const Icon(
              Icons.favorite,
              size: 13,
              color: AppColors.intentGold,
            ),
          ),
        ],
      ),
    );
  }
}

class _MetricProgress extends StatelessWidget {
  const _MetricProgress({
    required this.label,
    required this.percent,
    required this.percentLabel,
  });

  final String label;
  final double percent;
  final String percentLabel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: IntentLoginStyles.onboardingAssessmentCategory.copyWith(
                fontSize: 8,
                letterSpacing: 1.1,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              percentLabel,
              style: IntentLoginStyles.onboardingCardFieldLabel.copyWith(
                fontSize: 11,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: percent,
            minHeight: 5,
            backgroundColor: AppColors.intentSegmentFill,
            valueColor: const AlwaysStoppedAnimation<Color>(
              AppColors.intentForest,
            ),
          ),
        ),
      ],
    );
  }
}

class _ProfileIncludesCard extends StatelessWidget {
  const _ProfileIncludesCard({required this.items});

  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppColors.intentInputBorder.withValues(alpha: 0.55),
        ),
        boxShadow: AppShadows.intentInput,
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'YOUR INTENT PROFILE INCLUDES',
              textAlign: TextAlign.center,
              style: IntentLoginStyles.onboardingAssessmentCategory.copyWith(
                letterSpacing: 1.2,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            for (var i = 0; i < items.length; i++)
              _ProfileIncludeRow(
                label: items[i],
                showDivider: i < items.length - 1,
              ),
          ],
        ),
      ),
    );
  }
}

class _ProfileIncludeRow extends StatelessWidget {
  const _ProfileIncludeRow({
    required this.label,
    required this.showDivider,
  });

  final String label;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 11),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  style: IntentLoginStyles.onboardingSubtitle.copyWith(
                    fontSize: 13,
                    color: AppColors.intentText,
                  ),
                ),
              ),
              Container(
                width: 22,
                height: 22,
                decoration: const BoxDecoration(
                  color: AppColors.intentForest,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_rounded,
                  size: 14,
                  color: AppColors.white,
                ),
              ),
            ],
          ),
        ),
        if (showDivider)
          Divider(
            height: 1,
            color: AppColors.intentInputBorder.withValues(alpha: 0.55),
          ),
      ],
    );
  }
}

class _SettingsNote extends StatelessWidget {
  const _SettingsNote();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.intentCreamDeep.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.intentInputBorder.withValues(alpha: 0.45),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.shield_outlined,
            size: 16,
            color: AppColors.intentGold.withValues(alpha: 0.95),
          ),
          const SizedBox(width: AppSpacing.xs),
          Expanded(
            child: Text(
              'You can update your answers anytime from your profile settings.',
              style: IntentLoginStyles.onboardingSubtitle.copyWith(
                fontSize: 12,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

const double _pinnedFooterHeight = 72;
