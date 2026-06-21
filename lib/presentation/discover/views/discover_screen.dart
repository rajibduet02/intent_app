import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';
import 'package:intent_app/core/utils/custom_tab_navigation.dart';
import 'package:intent_app/presentation/discover/widgets/discover_action_button.dart';
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
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const DiscoverTopBar(),
            const SizedBox(height: 22),
            Text(
              'Discover',
              style: IntentLoginStyles.onboardingTitle.copyWith(fontSize: 30),
            ),
            const SizedBox(height: 8),
            Text(
              'Meet with intention',
              style: IntentLoginStyles.onboardingCardFieldLabel.copyWith(
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Profiles are shown through compatibility first. Photos unlock '
              'only through the date flow.',
              style: IntentLoginStyles.onboardingSubtitle.copyWith(
                fontSize: 13,
                height: 1.45,
              ),
            ),
            const SizedBox(height: 12),
            const _PhotosHiddenBadge(),
            const SizedBox(height: 20),
            const DiscoverMatchCard(),
            const SizedBox(height: 14),
            DiscoverActionButton(
              label: 'View Compatibility',
              icon: Icons.visibility_outlined,
              onPressed: () {},
            ),
            const SizedBox(height: 10),
            DiscoverActionButton(
              label: 'Connect with Intention',
              icon: Icons.favorite_border,
              style: DiscoverActionStyle.outlined,
              onPressed: () {},
            ),
            const SizedBox(height: 10),
            DiscoverActionButton(
              label: 'Pass respectfully',
              icon: Icons.cancel_outlined,
              style: DiscoverActionStyle.muted,
              showChevron: false,
              onPressed: () {},
            ),
            const SizedBox(height: 18),
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
            const SizedBox(width: 6),
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
