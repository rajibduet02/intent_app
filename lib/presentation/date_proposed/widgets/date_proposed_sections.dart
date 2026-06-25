import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';

class DateProposedIntroText extends StatelessWidget {
  const DateProposedIntroText({
    super.key,
    this.proposerName = 'Julian',
  });

  final String proposerName;

  @override
  Widget build(BuildContext context) {
    return Text(
      '$proposerName has suggested a date through Intent’s guided date flow.',
      textAlign: TextAlign.center,
      style: IntentLoginStyles.onboardingSubtitle.copyWith(
        fontSize: 16,
        height: 1.45,
      ),
    );
  }
}

class DateProposedMatchSummary extends StatelessWidget {
  const DateProposedMatchSummary({
    super.key,
    this.proposerName = 'Julian',
    this.harmonyPercent = 94,
  });

  final String proposerName;
  final int harmonyPercent;

  @override
  Widget build(BuildContext context) {
    final proposerInitial =
        proposerName.isNotEmpty ? proposerName[0].toUpperCase() : '?';

    return Column(
      children: [
        Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _MatchAvatar(initial: proposerInitial),
              SizedBox(
                width: 36,
                child: CustomPaint(
                  painter: _DottedLinePainter(),
                  child: const SizedBox(height: 2),
                ),
              ),
              Container(
                width: 26,
                height: 26,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.intentInputBorder.withValues(alpha: 0.7),
                  ),
                ),
                child: Icon(
                  Icons.favorite_border,
                  size: 13,
                  color: AppColors.intentGold.withValues(alpha: 0.95),
                ),
              ),
              SizedBox(
                width: 36,
                child: CustomPaint(
                  painter: _DottedLinePainter(),
                  child: const SizedBox(height: 2),
                ),
              ),
              const _MatchAvatar(initial: 'Y'),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Text(
          '$proposerName & You',
          style: IntentLoginStyles.onboardingTitle.copyWith(fontSize: 24),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: const Color(0xFFF8E9B8),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppColors.intentGoldMuted.withValues(alpha: 0.4),
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
                '$harmonyPercent% Harmony',
                style: IntentLoginStyles.onboardingSubtitle.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.intentText,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _MatchAvatar extends StatelessWidget {
  const _MatchAvatar({required this.initial});

  final String initial;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: AppColors.intentForest,
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.intentInputBorder.withValues(alpha: 0.35),
        ),
        boxShadow: AppShadows.intentInput,
      ),
      alignment: Alignment.center,
      child: Text(
        initial,
        style: IntentLoginStyles.onboardingTitle.copyWith(
          fontSize: 24,
          color: AppColors.white,
        ),
      ),
    );
  }
}

class _DottedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.intentInputBorder.withValues(alpha: 0.9)
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;

    const dashWidth = 3.0;
    const dashSpace = 3.0;
    var startX = 0.0;
    final y = size.height / 2;

    while (startX < size.width) {
      canvas.drawLine(Offset(startX, y), Offset(startX + dashWidth, y), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

const _planCardBg = Color(0xFFFDFBFA);
const _planIconBg = Color(0xFFF4F7FB);

class DateProposedPlanCard extends StatelessWidget {
  const DateProposedPlanCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 18),
      decoration: BoxDecoration(
        color: _planCardBg,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: AppColors.intentInputBorder.withValues(alpha: 0.35),
        ),
        boxShadow: AppShadows.intentInput,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Proposed plan',
            style: IntentLoginStyles.onboardingSectionTitle.copyWith(
              fontSize: 20,
              color: AppColors.intentText,
            ),
          ),
          const SizedBox(height: 18),
          const _PlanDetailRow(
            icon: Icons.calendar_today_outlined,
            label: 'Date',
            value: 'Friday, June 21',
            iconBackground: _planIconBg,
          ),
          const _PlanRowDivider(),
          const _PlanDetailRow(
            icon: Icons.schedule_outlined,
            label: 'Time',
            value: '6:30 PM',
            iconBackground: _planIconBg,
          ),
          const _PlanRowDivider(),
          const _PlanDetailRow(
            icon: Icons.location_on_outlined,
            label: 'Location',
            value: 'Bloom Café, Downtown',
            subValue: 'Public place',
            iconBackground: _planIconBg,
          ),
          const _PlanRowDivider(),
          const _PlanDetailRow(
            icon: Icons.people_outline,
            label: 'Date type',
            value: 'In person',
            iconBackground: _planIconBg,
          ),
          const SizedBox(height: 16),
          const _ProposerMessageCard(),
        ],
      ),
    );
  }
}

class _PlanRowDivider extends StatelessWidget {
  const _PlanRowDivider();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Divider(
        height: 1,
        thickness: 1,
        color: AppColors.intentInputBorder.withValues(alpha: 0.4),
      ),
    );
  }
}

class _PlanDetailRow extends StatelessWidget {
  const _PlanDetailRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.iconBackground,
    this.subValue,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color iconBackground;
  final String? subValue;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment:
          subValue != null ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: iconBackground,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            size: 20,
            color: AppColors.intentTextSoft,
          ),
        ),
        const SizedBox(width: 14),
        Text(
          label,
          style: IntentLoginStyles.onboardingSubtitle.copyWith(
            fontSize: 16,
            color: AppColors.intentTextSoft,
          ),
        ),
        const Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              value,
              textAlign: TextAlign.right,
              style: IntentLoginStyles.onboardingCardFieldLabel.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.intentText,
              ),
            ),
            if (subValue != null) ...[
              const SizedBox(height: 2),
              Text(
                subValue!,
                style: IntentLoginStyles.onboardingSubtitle.copyWith(
                  fontSize: 13,
                  color: AppColors.intentTextSoft,
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }
}

class _ProposerMessageCard extends StatelessWidget {
  const _ProposerMessageCard();

  static const _messageBg = Color(0xFFFAF7F2);
  static const _quoteCircle = Color(0xFFFBE9E0);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _messageBg,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: const BoxDecoration(
              color: _quoteCircle,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              '“',
              style: IntentLoginStyles.onboardingTitle.copyWith(
                fontSize: 18,
                height: 1,
                color: AppColors.intentGold,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Julian’s message',
                  style: IntentLoginStyles.onboardingSubtitle.copyWith(
                    fontSize: 14,
                    color: AppColors.intentTextSoft,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'I thought this could be a comfortable first plan for us. '
                  'Coffee feels simple, public, and easy to talk.',
                  style: IntentLoginStyles.onboardingSubtitle.copyWith(
                    fontSize: 16,
                    color: AppColors.intentText,
                    height: 1.45,
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

class DateProposedPhotoReleaseNote extends StatelessWidget {
  const DateProposedPhotoReleaseNote({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: const Color(0xFFFFF0E0),
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.intentGoldMuted.withValues(alpha: 0.35),
            ),
          ),
          child: Icon(
            Icons.lock_outline,
            size: 18,
            color: AppColors.intentGold.withValues(alpha: 0.95),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            'Once a date is proposed, both users may release one selected '
            'preview photo. Full galleries remain private until after the date '
            'flow progresses.',
            style: IntentLoginStyles.onboardingSubtitle.copyWith(
              fontSize: 14,
              height: 1.45,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Column(
          children: [
            Icon(
              Icons.auto_awesome,
              size: 14,
              color: AppColors.intentGold.withValues(alpha: 0.85),
            ),
            const SizedBox(height: 4),
            Icon(
              Icons.auto_awesome,
              size: 10,
              color: AppColors.intentGold.withValues(alpha: 0.65),
            ),
          ],
        ),
      ],
    );
  }
}

class DateProposedSafetyCard extends StatelessWidget {
  const DateProposedSafetyCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppColors.intentInputBorder.withValues(alpha: 0.55),
            ),
            boxShadow: AppShadows.intentInput,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: const Color(0xFFE8EEF2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.verified_user_outlined,
                  size: 18,
                  color: AppColors.intentTextSoft,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Safety reminder',
                      style: IntentLoginStyles.onboardingCardFieldLabel
                          .copyWith(fontSize: 16),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'For first dates, choose public places and keep plans '
                      'inside Intent until both people feel comfortable. You '
                      'can update, report, or cancel plans anytime.',
                      style: IntentLoginStyles.onboardingSubtitle.copyWith(
                        fontSize: 14,
                        height: 1.45,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                size: 20,
                color: AppColors.intentTextSoft,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DateProposedAcceptButton extends StatelessWidget {
  const DateProposedAcceptButton({super.key, this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          AppSpacing.primaryButtonBorderRadius,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.intentForest.withValues(alpha: 0.22),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: SizedBox(
        width: double.infinity,
        height: AppSpacing.primaryButtonHeight,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.intentForest,
            elevation: 0,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                AppSpacing.primaryButtonBorderRadius,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: AppColors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.event_available_outlined,
                  size: 16,
                  color: AppColors.white,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                'Accept',
                style: IntentLoginStyles.onboardingContinue.copyWith(
                  letterSpacing: 0.6,
                ),
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.chevron_right,
                color: AppColors.white,
                size: 22,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DateProposedSuggestTimeButton extends StatelessWidget {
  const DateProposedSuggestTimeButton({super.key, this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: AppSpacing.primaryButtonHeight,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.white,
          foregroundColor: AppColors.intentText,
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              AppSpacing.primaryButtonBorderRadius,
            ),
            side: BorderSide(
              color: AppColors.intentInputBorder.withValues(alpha: 0.85),
            ),
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.schedule_outlined,
              size: 20,
              color: AppColors.intentText.withValues(alpha: 0.85),
            ),
            const SizedBox(width: AppSpacing.xs),
            Expanded(
              child: Text(
                'Suggest another time',
                style: IntentLoginStyles.onboardingContinue.copyWith(
                  color: AppColors.intentText,
                  letterSpacing: 0.2,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right,
              size: 22,
              color: AppColors.intentTextSoft,
            ),
          ],
        ),
      ),
    );
  }
}

class DateProposedDeclineButton extends StatelessWidget {
  const DateProposedDeclineButton({super.key, this.onPressed});

  final VoidCallback? onPressed;

  static const _declineText = Color(0xFF8B5E4B);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: AppSpacing.primaryButtonHeight,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFF9F1EF),
          foregroundColor: _declineText,
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              AppSpacing.primaryButtonBorderRadius,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 22,
              height: 22,
              decoration: const BoxDecoration(
                color: _declineText,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.close,
                size: 14,
                color: AppColors.white,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              'Decline respectfully',
              style: IntentLoginStyles.onboardingContinue.copyWith(
                color: _declineText,
                letterSpacing: 0.2,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DateProposedPrivacyFooter extends StatelessWidget {
  const DateProposedPrivacyFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.lock_outline,
            size: 14,
            color: AppColors.intentTextSoft.withValues(alpha: 0.9),
          ),
          const SizedBox(width: AppSpacing.xs),
          Flexible(
            child: Text(
              'Your response is kept private until a decision is made.',
              textAlign: TextAlign.center,
              style: IntentLoginStyles.onboardingSubtitle.copyWith(
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
