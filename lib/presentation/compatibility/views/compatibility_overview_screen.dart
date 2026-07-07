import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:intent_app/app/routes/app_routes.dart';
import 'package:intent_app/app/theme/theme.dart';
import 'package:intent_app/core/utils/custom_tab_navigation.dart';
import 'package:intent_app/core/widgets/custom_bottom_nav.dart';
import 'package:intent_app/presentation/compatibility/widgets/compatibility_ai_insights_card.dart';
import 'package:intent_app/presentation/compatibility/widgets/compatibility_alignments_card.dart';
import 'package:intent_app/presentation/compatibility/widgets/compatibility_dealbreaker_card.dart';
import 'package:intent_app/presentation/compatibility/widgets/compatibility_difference_card.dart';
import 'package:intent_app/presentation/compatibility/widgets/compatibility_overview_header.dart';
import 'package:intent_app/presentation/compatibility/widgets/compatibility_profiles_section.dart';
import 'package:intent_app/presentation/compatibility/widgets/compatibility_score_card.dart';
import 'package:intent_app/presentation/discover/widgets/discover_action_button.dart';
import 'package:intent_app/presentation/discover/widgets/discover_scaffold.dart';

class CompatibilityPreviewScreen extends StatelessWidget {
  const CompatibilityPreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DiscoverScaffold(
      bottomNavigationBar: DiscoverBottomNav(
        selectedTab: CustomBottomNavTab.compatibility,
        onTabSelected: (tab) => navigateCustomBottomNavTab(context, tab),
        messagesBadgeCount: 5,
      ),
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CompatibilityPreviewHeader(
              onBack: () => context.go(AppRoutes.discover),
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
                onTap: () => context.go(AppRoutes.profile),
                child: Text(
                  'Not ready yet? Return to profile',
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
