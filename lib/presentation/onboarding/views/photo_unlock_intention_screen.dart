import 'package:flutter/material.dart';
import 'package:intent_app/app/routes/app_router.dart';
import 'package:intent_app/app/routes/app_routes.dart';
import 'package:intent_app/app/theme/theme.dart';
import 'package:intent_app/presentation/auth/widgets/shared/fixed_background_auth_scaffold.dart';
import 'package:intent_app/presentation/onboarding/widgets/onboarding_continue_button.dart';

class PhotoUnlockIntentionScreen extends StatelessWidget {
  const PhotoUnlockIntentionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FixedBackgroundAuthScaffold(
      pinnedFooter: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
        child: OnboardingContinueButton(
          label: 'I Understand',
          showArrow: true,
          arrowColor: AppColors.intentGold,
          onPressed: () => appRouter.go(AppRoutes.uploadPhotos),
        ),
      ),
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24).copyWith(
          bottom: 24 + _pinnedFooterHeight,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [
            _PhotoUnlockHeader(),
            SizedBox(height: 20),
            _TitleSection(),
            SizedBox(height: 28),
            _UnlockTimeline(),
            SizedBox(height: 24),
            _PrivacyNote(),
          ],
        ),
      ),
    );
  }
}

class _PhotoUnlockHeader extends StatelessWidget {
  const _PhotoUnlockHeader();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: Row(
        children: [
          IntentBackButton(
            onPressed: () => appRouter.go(AppRoutes.profileOverview),
          ),
        ],
      ),
    );
  }
}

class _TitleSection extends StatelessWidget {
  const _TitleSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Photos unlock with\nintention',
          textAlign: TextAlign.center,
          style: IntentLoginStyles.onboardingTitle,
        ),
        const SizedBox(height: 10),
        Text(
          'Intent prioritizes meaningful connection over surface-level attraction.',
          textAlign: TextAlign.center,
          style: IntentLoginStyles.onboardingSubtitle,
        ),
      ],
    );
  }
}

class _UnlockTimeline extends StatelessWidget {
  const _UnlockTimeline();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        _TimelineStep(
          icon: Icons.visibility_off_outlined,
          title: 'Initial Connection',
          body: 'Before date proposal: icon or initial only',
          showLineBelow: true,
        ),
        _TimelineStep(
          icon: Icons.photo_outlined,
          title: 'Date proposed:',
          body: 'one selected preview photo can unlock',
          showGrowingBadge: true,
          showLineBelow: true,
        ),
        _TimelineStep(
          icon: null,
          title: 'Real World Meeting',
          body: 'After the date: full gallery can unlock',
          isFinalNode: true,
        ),
      ],
    );
  }
}

class _TimelineStep extends StatelessWidget {
  const _TimelineStep({
    required this.title,
    required this.body,
    this.icon,
    this.showGrowingBadge = false,
    this.showLineBelow = false,
    this.isFinalNode = false,
  });

  final IconData? icon;
  final String title;
  final String body;
  final bool showGrowingBadge;
  final bool showLineBelow;
  final bool isFinalNode;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 44,
            child: Column(
              children: [
                _TimelineNode(
                  icon: icon,
                  isFinalNode: isFinalNode,
                ),
                if (showLineBelow)
                  Expanded(
                    child: Container(
                      width: 2,
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      color: AppColors.intentInputBorder.withValues(alpha: 0.7),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: showLineBelow ? 18 : 0),
              child: _TimelineCard(
                title: title,
                body: body,
                showGrowingBadge: showGrowingBadge,
                showDecorativeArc: isFinalNode,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TimelineNode extends StatelessWidget {
  const _TimelineNode({
    required this.icon,
    required this.isFinalNode,
  });

  final IconData? icon;
  final bool isFinalNode;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isFinalNode ? AppColors.intentForest : AppColors.white,
        border: isFinalNode
            ? null
            : Border.all(
                color: AppColors.intentInputBorder.withValues(alpha: 0.7),
              ),
        boxShadow: isFinalNode ? null : AppShadows.intentInput,
      ),
      child: icon == null
          ? null
          : Icon(
              icon,
              size: 20,
              color: AppColors.intentText,
            ),
    );
  }
}

class _TimelineCard extends StatelessWidget {
  const _TimelineCard({
    required this.title,
    required this.body,
    this.showGrowingBadge = false,
    this.showDecorativeArc = false,
  });

  final String title;
  final String body;
  final bool showGrowingBadge;
  final bool showDecorativeArc;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: AppShadows.intentInput,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Stack(
          children: [
            if (showDecorativeArc)
              Positioned(
                right: -6,
                top: 6,
                child: CustomPaint(
                  size: const Size(48, 32),
                  painter: _CardArcPainter(),
                ),
              ),
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (showGrowingBadge) ...[
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.intentCreamDeep,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.intentInputBorder.withValues(
                            alpha: 0.5,
                          ),
                        ),
                      ),
                      child: Text(
                        'GROWING',
                        style: IntentLoginStyles.onboardingAssessmentCategory
                            .copyWith(
                          fontSize: 9,
                          letterSpacing: 1.2,
                          fontWeight: FontWeight.w700,
                          color: AppColors.intentTextSoft,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'INTENT',
                      style: IntentLoginStyles.brandTitle.copyWith(
                        fontSize: 11,
                        color: AppColors.intentText,
                        letterSpacing: 1.4,
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                  Text(
                    title,
                    style: IntentLoginStyles.onboardingAssessmentTitle.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    body,
                    style: IntentLoginStyles.onboardingSubtitle.copyWith(
                      fontSize: 12,
                      height: 1.4,
                      color: AppColors.intentText,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CardArcPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.intentInputBorder.withValues(alpha: 0.35)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    final path = Path()
      ..moveTo(0, size.height)
      ..quadraticBezierTo(
        size.width * 0.5,
        size.height * 0.1,
        size.width,
        size.height * 0.55,
      );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _PrivacyNote extends StatelessWidget {
  const _PrivacyNote();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 2, right: 8),
          child: Icon(
            Icons.verified_user_outlined,
            size: 16,
            color: AppColors.intentGold.withValues(alpha: 0.95),
          ),
        ),
        Expanded(
          child: Text(
            'Your privacy is protected until you choose to share more.',
            textAlign: TextAlign.center,
            style: IntentLoginStyles.onboardingHelper.copyWith(
              fontStyle: FontStyle.normal,
              fontSize: 12,
              height: 1.45,
            ),
          ),
        ),
      ],
    );
  }
}

const double _pinnedFooterHeight = 92;
