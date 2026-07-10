import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intent_app/app/routes/app_router.dart';
import 'package:intent_app/app/routes/app_routes.dart';
import 'package:intent_app/app/theme/theme.dart';
import 'package:intent_app/presentation/auth/widgets/login/login_brand_header.dart';
import 'package:intent_app/presentation/auth/widgets/shared/fixed_background_auth_scaffold.dart';
import 'package:intent_app/presentation/onboarding/providers/relationship_style_assessment_provider.dart';
import 'package:intent_app/presentation/onboarding/widgets/onboarding_continue_button.dart';

class ProfileOverviewScreen extends ConsumerWidget {
  const ProfileOverviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final relationshipResult =
        ref.watch(relationshipStyleAssessmentProvider).result;
    final relationshipValue = relationshipResult?.primaryLabel ??
        'Steady / Secure';
    final relationshipSubtitle = relationshipResult?.secondaryLabel == null
        ? null
        : 'With ${relationshipResult!.secondaryLabel!.toLowerCase()} tendencies';

    return FixedBackgroundAuthScaffold(
      pinnedFooter: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
        child: OnboardingContinueButton(
          onPressed: () => appRouter.go(AppRoutes.photoUnlockIntention),
        ),
      ),
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24).copyWith(
          bottom: 24 + _previewPinnedFooterHeight,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _ProfileOverviewHeader(),
            const SizedBox(height: AppSpacing.xs),
            _HeroIcon(),
            const SizedBox(height: AppSpacing.sm),
            const _HeroCopy(),
            const SizedBox(height: AppSpacing.lg),
            _ProfileOverviewCard(
              relationshipStyleValue: relationshipValue,
              relationshipStyleSubtitle: relationshipSubtitle,
            ),
            const SizedBox(height: AppSpacing.md),
            const _SummaryInfoBox(),
            const SizedBox(height: AppSpacing.md),
            const _ConnectionPlusCard(),
            const SizedBox(height: AppSpacing.md),
            const _FooterNote(),
          ],
        ),
      ),
    );
  }
}

class _ProfileOverviewHeader extends StatelessWidget {
  const _ProfileOverviewHeader();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: Row(
        children: [
          IntentBackButton(
            onPressed: () => appRouter.go(AppRoutes.loveLanguage),
          ),
        ],
      ),
    );
  }
}

class _HeroIcon extends StatelessWidget {
  const _HeroIcon();

  @override
  Widget build(BuildContext context) {
    return const Center(child: IntentLogo());
  }
}

class _HeroCopy extends StatelessWidget {
  const _HeroCopy();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Your compatibility profile is taking shape',
          textAlign: TextAlign.center,
          style: IntentLoginStyles.onboardingTitle,
        ),
        const SizedBox(height: 10),
        Text(
          'Here’s a quick overview of what we’ve learned about how you connect.',
          textAlign: TextAlign.center,
          style: IntentLoginStyles.onboardingSubtitle,
        ),
      ],
    );
  }
}

class _ProfileOverviewCard extends StatelessWidget {
  const _ProfileOverviewCard({
    required this.relationshipStyleValue,
    this.relationshipStyleSubtitle,
  });

  final String relationshipStyleValue;
  final String? relationshipStyleSubtitle;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: AppShadows.intentInput,
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
        child: Column(
          children: [
            Text(
              'YOUR PROFILE OVERVIEW',
              style: IntentLoginStyles.onboardingAssessmentCategory.copyWith(
                letterSpacing: 1.2,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            const _ProfileTraitRow(
              icon: Icons.psychology_outlined,
              label: 'MBTI',
              value: 'INFJ - Insightful Connector',
            ),
            const _ProfileTraitRow(
              icon: Icons.edit_note_outlined,
              label: 'INTENT REFLECTIONS',
              value: 'Completed',
            ),
            _ProfileTraitRow(
              icon: Icons.groups_outlined,
              label: 'RELATIONSHIP STYLE',
              value: relationshipStyleValue,
              subtitle: relationshipStyleSubtitle,
            ),
            const _ProfileTraitRow(
              icon: Icons.schedule_outlined,
              label: 'LOVE LANGUAGE',
              value: 'Quality Time - Presence and connection',
            ),
            const _ProfileTraitRow(
              icon: Icons.auto_awesome_outlined,
              label: 'VIBE PROFILE',
              value: 'Calm · Deep · Intentional',
              subtitle: 'Values depth and emotional rhythm',
              showDivider: false,
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileTraitRow extends StatelessWidget {
  const _ProfileTraitRow({
    required this.icon,
    required this.label,
    required this.value,
    this.subtitle,
    this.showDivider = true,
  });

  final IconData icon;
  final String label;
  final String value;
  final String? subtitle;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.intentCreamDeep,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 20,
                  color: AppColors.intentForest,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: IntentLoginStyles.onboardingAssessmentCategory
                          .copyWith(
                        fontSize: 10,
                        letterSpacing: 1.1,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      value,
                      style: IntentLoginStyles.onboardingAssessmentTitle
                          .copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        subtitle!,
                        style: IntentLoginStyles.onboardingSubtitle.copyWith(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ],
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

class _SummaryInfoBox extends StatelessWidget {
  const _SummaryInfoBox();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.intentCreamDeep.withValues(alpha: 0.75),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.intentInputBorder.withValues(alpha: 0.45),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.visibility_outlined,
            size: 18,
            color: AppColors.intentTextSoft,
          ),
          const SizedBox(width: AppSpacing.xs),
          Expanded(
            child: Text(
              'You can see your short compatibility summary and core profile traits.',
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

class _ConnectionPlusCard extends StatelessWidget {
  const _ConnectionPlusCard();

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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Stack(
          children: [
            Positioned(
              right: -8,
              top: 8,
              bottom: 8,
              child: CustomPaint(
                size: const Size(90, 56),
                painter: _ConnectionPlusWavePainter(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              child: Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: AppColors.intentGoldMuted.withValues(alpha: 0.35),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.lock_outline,
                      size: 18,
                      color: AppColors.intentGold,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        style: IntentLoginStyles.onboardingAssessmentTitle
                            .copyWith(fontWeight: FontWeight.w500),
                        children: [
                          const TextSpan(
                            text:
                                'Unlock deeper personality insights, match explanations, and patterns with ',
                          ),
                          TextSpan(
                            text: 'Connection Plus',
                            style: IntentLoginStyles.onboardingAssessmentTitle
                                .copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColors.intentGold,
                            ),
                          ),
                          const TextSpan(text: '.'),
                        ],
                      ),
                    ),
                  ),
                  Icon(
                    Icons.chevron_right,
                    color: AppColors.intentGold,
                    size: 20,
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

class _ConnectionPlusWavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.intentInputBorder.withValues(alpha: 0.35)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    final path = Path()
      ..moveTo(0, size.height * 0.75)
      ..quadraticBezierTo(
        size.width * 0.25,
        size.height * 0.2,
        size.width * 0.5,
        size.height * 0.45,
      )
      ..quadraticBezierTo(
        size.width * 0.75,
        size.height * 0.7,
        size.width,
        size.height * 0.35,
      );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _FooterNote extends StatelessWidget {
  const _FooterNote();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 0, right: AppSpacing.xs),
          child: Icon(
            Icons.shield_outlined,
            size: 16,
            color: AppColors.intentGold.withValues(alpha: 0.95),
          ),
        ),
        Expanded(
          child: Text(
            'Your profile will keep improving as Intent learns more about your connection style.',
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

const double _previewPinnedFooterHeight = 92;
