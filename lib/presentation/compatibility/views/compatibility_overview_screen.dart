import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:intent_app/app/routes/app_routes.dart';
import 'package:intent_app/app/theme/theme.dart';
import 'package:intent_app/presentation/auth/widgets/shared/fixed_background_auth_scaffold.dart';
import 'package:intent_app/presentation/compatibility/widgets/compatibility_ai_insights_card.dart';
import 'package:intent_app/presentation/compatibility/widgets/compatibility_alignments_card.dart';
import 'package:intent_app/presentation/compatibility/widgets/compatibility_dealbreaker_card.dart';
import 'package:intent_app/presentation/compatibility/widgets/compatibility_difference_card.dart';
import 'package:intent_app/presentation/compatibility/widgets/compatibility_overview_header.dart';
import 'package:intent_app/presentation/compatibility/widgets/compatibility_profiles_section.dart';
import 'package:intent_app/presentation/compatibility/widgets/compatibility_score_card.dart';
import 'package:intent_app/presentation/discover/widgets/discover_action_button.dart';

class CompatibilityPreviewScreen extends StatelessWidget {
  const CompatibilityPreviewScreen({super.key});

  void _onBack(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FixedBackgroundAuthScaffold(
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CompatibilityPreviewHeader(
              onBack: () => _onBack(context),
            ),
            const SizedBox(height: 18),
            const CompatibilityProfilesSection(),
            const SizedBox(height: 18),
            const CompatibilityScoreCard(),
            const SizedBox(height: 14),
            const CompatibilityAlignmentsCard(
              items: [
                CompatibilityAlignmentItem(
                  icon: Icons.favorite_border,
                  title: 'Both looking for a serious \nrelationship',
                  subtitle:
                      'Your relationship intentions are strongly aligned.',
                ),
                CompatibilityAlignmentItem(
                  icon: Icons.home_outlined,
                  title: 'Shared value: family',
                  subtitle:
                      'Family and long-term connection are core for both of you.',
                ),
                CompatibilityAlignmentItem(
                  icon: Icons.chat_bubble_outline,
                  title: 'Similar communication rhythm',
                  subtitle: 'You both prefer depth over small talk.',
                ),
              ],
            ),
            const SizedBox(height: 14),
            const CompatibilityDifferenceCard(),
            const SizedBox(height: 14),
            const CompatibilityDealbreakerCard(
              items: [
                CompatibilityDealbreakerItem(
                  icon: Icons.favorite_border,
                  label: 'RELATIONSHIP \nINTENTIONS',
                  status: 'Aligned',
                ),
                CompatibilityDealbreakerItem(
                  icon: Icons.account_balance_outlined,
                  label: 'RELIGION / BELIEFS',
                  status: 'Compatible',
                ),
                CompatibilityDealbreakerItem(
                  icon: Icons.family_restroom_outlined,
                  label: 'CHILDREN / FAMILY \nGOALS',
                  status: 'Matched',
                ),
                CompatibilityDealbreakerItem(
                  icon: Icons.shield_outlined,
                  label: 'LIFESTYLE \nDEALBREAKERS',
                  status: 'No conflicts',
                ),
              ],
            ),
            const SizedBox(height: 14),
            const CompatibilityAiInsightsCard(),
            const SizedBox(height: 18),
            DiscoverActionButton(
              label: 'Start Conversation',
              icon: Icons.chat_bubble_outline,
              showChevron: false,
              onPressed: () => context.push(AppRoutes.chat),
            ),
            const SizedBox(height: 12),
            Center(
              child: GestureDetector(
                onTap: () => _onBack(context),
                child: Text(
                  'Not ready yet? Go back',
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
