import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:intent_app/app/routes/app_routes.dart';
import 'package:intent_app/app/theme/theme.dart';
import 'package:intent_app/presentation/auth/widgets/shared/fixed_background_auth_scaffold.dart';
import 'package:intent_app/presentation/why_matches/widgets/why_matches_header.dart';
import 'package:intent_app/presentation/why_matches/widgets/why_matches_hero_section.dart';
import 'package:intent_app/presentation/why_matches/widgets/why_matches_sections.dart';

class WhyMatchesScreen extends StatelessWidget {
  const WhyMatchesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FixedBackgroundAuthScaffold(
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            WhyMatchesHeader(
              onBack: () {
                if (context.canPop()) {
                  context.pop();
                } else {
                  context.go(AppRoutes.discover);
                }
              },
            ),
            const SizedBox(height: 16),
            const WhyMatchesHeroSection(),
            const SizedBox(height: 18),
            const WhyMatchesInsightCard(),
            const SizedBox(height: 12),
            const WhyMatchesStrongAlignmentCard(),
            const SizedBox(height: 12),
            const WhyMatchesCommunicationCard(),
            const SizedBox(height: 12),
            const WhyMatchesSharedValuesCard(),
            const SizedBox(height: 12),
            const WhyMatchesLifestyleCard(),
            const SizedBox(height: 12),
            const WhyMatchesGrowthAreasCard(),
            const SizedBox(height: 12),
            const WhyMatchesConversationStartersCard(),
            const SizedBox(height: 20),
            _StartConversationButton(
              onPressed: () => context.push(AppRoutes.chat),
            ),
            const SizedBox(height: 12),
            Center(
              child: GestureDetector(
                onTap: () => context.go(AppRoutes.compatibilityPreview),
                child: Text(
                  'Back to Compatibility Overview',
                  style: IntentLoginStyles.onboardingSubtitle.copyWith(
                    fontSize: 12,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.intentTextSoft,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StartConversationButton extends StatelessWidget {
  const _StartConversationButton({required this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: AppSpacing.primaryButtonHeight,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.intentForest,
          disabledBackgroundColor: AppColors.intentForest.withValues(alpha: 0.6),
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(AppSpacing.primaryButtonBorderRadius),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.auto_awesome,
              color: AppColors.white,
              size: 18,
            ),
            const SizedBox(width: AppSpacing.xs),
            Text(
              'START CONVERSATION',
              style: IntentLoginStyles.onboardingContinue,
            ),
          ],
        ),
      ),
    );
  }
}
