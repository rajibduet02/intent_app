import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intent_app/app/theme/theme.dart';
import 'package:intent_app/presentation/auth/widgets/shared/fixed_background_auth_scaffold.dart';
import 'package:intent_app/presentation/onboarding/providers/community_commitment_provider.dart';
import 'package:intent_app/presentation/onboarding/providers/community_commitment_state.dart';
import 'package:intent_app/presentation/onboarding/widgets/onboarding_continue_button.dart';

class CommunityCommitmentScreen extends ConsumerWidget {
  const CommunityCommitmentScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(communityCommitmentProvider.notifier);
    final state = ref.watch(communityCommitmentProvider);

    return FixedBackgroundAuthScaffold(
      pinnedFooter: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
        child: OnboardingContinueButton(
          label: 'I Agree',
          showArrow: false,
          isLoading: state.isLoading,
          onPressed: state.canAgree ? () => unawaited(notifier.submit()) : null,
        ),
      ),
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24).copyWith(
          bottom: 24 + _pinnedFooterHeight,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _CommunityCommitmentHeader(onBack: notifier.onBack),
            const SizedBox(height: 12),
            Divider(
              height: 1,
              color: AppColors.intentInputBorder.withValues(alpha: 0.7),
            ),
            const SizedBox(height: 24),
            Text(
              'Intent is built on respect',
              textAlign: TextAlign.center,
              style: IntentLoginStyles.onboardingTitle,
            ),
            const SizedBox(height: 10),
            Text(
              'Before you continue, please agree to help keep Intent safe, honest, and intentional.',
              textAlign: TextAlign.center,
              style: IntentLoginStyles.onboardingSubtitle,
            ),
            const SizedBox(height: 22),
            _CommitmentCard(
              agreements: state.agreements,
              onToggle: notifier.toggleAgreement,
            ),
            const SizedBox(height: 14),
            const _RespectInfoBox(),
            const SizedBox(height: 18),
            const _CommitmentWaveDecor(),
          ],
        ),
      ),
    );
  }
}

class _CommunityCommitmentHeader extends StatelessWidget {
  const _CommunityCommitmentHeader({required this.onBack});

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

class _CommitmentCard extends StatelessWidget {
  const _CommitmentCard({
    required this.agreements,
    required this.onToggle,
  });

  final List<bool> agreements;
  final ValueChanged<int> onToggle;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: AppShadows.intentInput,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
              color: AppColors.intentCreamDeep.withValues(alpha: 0.85),
              child: Text(
                'Community commitment',
                textAlign: TextAlign.center,
                style: IntentLoginStyles.onboardingSectionTitle.copyWith(
                  fontSize: 18,
                ),
              ),
            ),
            for (var i = 0; i < CommunityCommitmentState.commitmentItems.length; i++)
              _CommitmentRow(
                label: CommunityCommitmentState.commitmentItems[i],
                isChecked: agreements[i],
                showDivider: i < CommunityCommitmentState.commitmentItems.length - 1,
                onTap: () => onToggle(i),
              ),
          ],
        ),
      ),
    );
  }
}

class _CommitmentRow extends StatelessWidget {
  const _CommitmentRow({
    required this.label,
    required this.isChecked,
    required this.showDivider,
    required this.onTap,
  });

  final String label;
  final bool isChecked;
  final bool showDivider;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 22,
                    height: 22,
                    child: Checkbox(
                      value: isChecked,
                      onChanged: (_) => onTap(),
                      activeColor: AppColors.intentForest,
                      checkColor: AppColors.white,
                      side: BorderSide(
                        color: AppColors.intentInputBorder.withValues(alpha: 0.9),
                        width: 1.5,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      visualDensity: VisualDensity.compact,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 1),
                      child: Text(
                        label,
                        style: IntentLoginStyles.onboardingSubtitle.copyWith(
                          fontSize: 13,
                          color: AppColors.intentText,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (showDivider)
          Divider(
            height: 1,
            indent: 16,
            endIndent: 16,
            color: AppColors.intentInputBorder.withValues(alpha: 0.65),
          ),
      ],
    );
  }
}

class _RespectInfoBox extends StatelessWidget {
  const _RespectInfoBox();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.intentCreamDeep.withValues(alpha: 0.75),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppColors.intentInputBorder.withValues(alpha: 0.45),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 2),
            child: Icon(
              Icons.lock_outline,
              size: 18,
              color: AppColors.intentText,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Respect, honesty, and clear boundaries help create better connections for everyone.',
                  style: IntentLoginStyles.onboardingCardFieldLabel.copyWith(
                    fontSize: 13,
                    height: 1.45,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Reports are reviewed to help protect the community.',
                  style: IntentLoginStyles.onboardingSubtitle.copyWith(
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CommitmentWaveDecor extends StatelessWidget {
  const _CommitmentWaveDecor();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 120,
        height: 28,
        child: CustomPaint(
          painter: _CommitmentWavePainter(),
        ),
      ),
    );
  }
}

class _CommitmentWavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.intentInputBorder.withValues(alpha: 0.45)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4
      ..strokeCap = StrokeCap.round;

    void drawWave(double verticalOffset) {
      final path = Path()
        ..moveTo(0, size.height * 0.55 + verticalOffset)
        ..quadraticBezierTo(
          size.width * 0.25,
          size.height * 0.15 + verticalOffset,
          size.width * 0.5,
          size.height * 0.5 + verticalOffset,
        )
        ..quadraticBezierTo(
          size.width * 0.75,
          size.height * 0.85 + verticalOffset,
          size.width,
          size.height * 0.4 + verticalOffset,
        );
      canvas.drawPath(path, paint);
    }

    drawWave(-4);
    drawWave(4);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

const double _pinnedFooterHeight = 72;
