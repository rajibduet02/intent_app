import 'package:flutter/material.dart';
import 'package:intent_app/app/routes/app_router.dart';
import 'package:intent_app/app/routes/app_routes.dart';
import 'package:intent_app/app/theme/theme.dart';
import 'package:intent_app/presentation/auth/widgets/shared/fixed_background_auth_scaffold.dart';
import 'package:intent_app/presentation/onboarding/widgets/onboarding_continue_button.dart';

class SafetyStartsScreen extends StatelessWidget {
  const SafetyStartsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FixedBackgroundAuthScaffold(
      pinnedFooter: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            OnboardingContinueButton(
              label: 'Verify ID',
              onPressed: () => appRouter.go(AppRoutes.faceVerification),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () => _showWhyWeAsk(context),
              style: TextButton.styleFrom(
                foregroundColor: AppColors.intentText,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                'Why we ask',
                style: IntentLoginStyles.onboardingCardFieldLabel.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
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
            const _SafetyStartsHeader(),
            const SizedBox(height: AppSpacing.sm),
            const _SafetyHeroIcon(),
            const SizedBox(height: AppSpacing.lg),
            const _SafetyHeroCopy(),
            const SizedBox(height: AppSpacing.lg),
            const _SafetyInfoCard(
              icon: Icons.visibility_off_outlined,
              title: 'Your privacy first',
              body:
                  'IDs are processed securely and never shared with other members.',
            ),
            const SizedBox(height: AppSpacing.md),
            const _SafetyInfoCard(
              icon: Icons.verified_outlined,
              title: 'Authentic Community',
              body:
                  'Every profile you see has been vetted to ensure it\'s a real person.',
            ),
            const SizedBox(height: 16),
            const _SafetyFooterBadge(),
          ],
        ),
      ),
    );
  }

  void _showWhyWeAsk(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      useRootNavigator: true,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Why we ask',
                  textAlign: TextAlign.center,
                  style: IntentLoginStyles.onboardingSectionTitle.copyWith(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'ID verification helps keep Intent a trusted space. We use your document only to confirm you are a real person, and we never display it on your profile.',
                  textAlign: TextAlign.center,
                  style: IntentLoginStyles.onboardingSubtitle.copyWith(
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _SafetyStartsHeader extends StatelessWidget {
  const _SafetyStartsHeader();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: Row(
        children: [
          IntentBackButton(
            onPressed: () => appRouter.go(AppRoutes.uploadId),
          ),
        ],
      ),
    );
  }
}

class _SafetyHeroIcon extends StatelessWidget {
  const _SafetyHeroIcon();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 92,
        height: 92,
        decoration: BoxDecoration(
          color: AppColors.white,
          shape: BoxShape.circle,
          border: Border.all(
            color: AppColors.intentGoldMuted.withValues(alpha: 0.65),
            width: 1.5,
          ),
          boxShadow: AppShadows.intentInput,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Icon(
              Icons.shield_outlined,
              size: 38,
              color: AppColors.intentForest,
            ),
            Positioned(
              bottom: 24,
              child: Container(
                width: 16,
                height: 16,
                decoration: const BoxDecoration(
                  color: AppColors.intentForest,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check,
                  size: 11,
                  color: AppColors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SafetyHeroCopy extends StatelessWidget {
  const _SafetyHeroCopy();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Safety starts with\nverification',
          textAlign: TextAlign.center,
          style: IntentLoginStyles.onboardingTitle,
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'Intent requires ID verification before browsing to help create a safer dating experience.',
          textAlign: TextAlign.center,
          style: IntentLoginStyles.onboardingSubtitle,
        ),
      ],
    );
  }
}

class _SafetyInfoCard extends StatelessWidget {
  const _SafetyInfoCard({
    required this.icon,
    required this.title,
    required this.body,
  });

  final IconData icon;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: AppShadows.intentInput,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.intentSegmentFill,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                size: 20,
                color: AppColors.intentForest,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: IntentLoginStyles.onboardingCardFieldLabel.copyWith(
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    body,
                    style: IntentLoginStyles.onboardingSubtitle.copyWith(
                      fontSize: 12,
                      height: 1.45,
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

class _SafetyFooterBadge extends StatelessWidget {
  const _SafetyFooterBadge();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Opacity(
        opacity: 0.45,
        child: Container(
          width: 34,
          height: 22,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: AppColors.intentInputBorder.withValues(alpha: 0.8),
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Icon(
                Icons.badge_outlined,
                size: 14,
                color: AppColors.intentTextSoft.withValues(alpha: 0.8),
              ),
              Positioned(
                right: 3,
                bottom: 2,
                child: Icon(
                  Icons.shield,
                  size: 8,
                  color: AppColors.intentGold.withValues(alpha: 0.9),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

const double _pinnedFooterHeight = 116;
