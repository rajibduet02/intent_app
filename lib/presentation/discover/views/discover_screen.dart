import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:intent_app/app/routes/app_routes.dart';
import 'package:intent_app/app/theme/theme.dart';
import 'package:intent_app/core/utils/custom_tab_navigation.dart';
import 'package:intent_app/core/widgets/custom_bottom_nav.dart';
import 'package:intent_app/presentation/discover/widgets/discover_focus_card.dart';
import 'package:intent_app/presentation/discover/widgets/discover_match_card.dart';
import 'package:intent_app/presentation/discover/widgets/discover_scaffold.dart';
import 'package:intent_app/presentation/discover/widgets/discover_top_bar.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DiscoverScaffold(
      bottomNavigationBar: DiscoverBottomNav(
        selectedTab: CustomBottomNavTab.discover,
        onTabSelected: (tab) => navigateCustomBottomNavTab(context, tab),
        messagesBadgeCount: 5,
      ),
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DiscoverTopBar(
              onNotificationsTap: () => context.push(AppRoutes.notifications),
            ),
            const SizedBox(height: AppSpacing.sm),
            const _PhotosHiddenBadge(),
            const SizedBox(height: AppSpacing.lg),
            DiscoverMatchCardList(
              onCardTap: () => context.go(AppRoutes.profilePreview),
              onViewCompatibility: () =>
                  context.go(AppRoutes.compatibilityPreview),
              onConnectWithIntention: () => context.push(AppRoutes.whyMatches),
              onPassRespectfully: () {},
            ),
            const SizedBox(height: AppSpacing.lg),
            const DiscoverFocusCard(),
          ],
        ),
      ),
    );
  }
}

class _PhotosHiddenBadge extends StatelessWidget {
  const _PhotosHiddenBadge();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.intentSegmentFill,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppColors.intentInputBorder.withValues(alpha: 0.55),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.lock_outline,
              size: 13,
              color: AppColors.intentTextSoft,
            ),
            const SizedBox(width: 4),
            Text(
              'Photos hidden by default',
              style: IntentLoginStyles.onboardingSubtitle.copyWith(
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
