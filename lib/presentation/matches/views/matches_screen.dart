import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:intent_app/app/routes/app_routes.dart';
import 'package:intent_app/core/utils/custom_tab_navigation.dart';
import 'package:intent_app/core/widgets/custom_bottom_nav.dart';
import 'package:intent_app/presentation/discover/widgets/discover_scaffold.dart';
import 'package:intent_app/presentation/matches/models/match_profile.dart';
import 'package:intent_app/presentation/matches/widgets/match_profile_card.dart';
import 'package:intent_app/presentation/matches/widgets/matches_header.dart';
import 'package:intent_app/presentation/matches/widgets/matches_photo_unlock_card.dart';
import 'package:intent_app/presentation/matches/widgets/matches_tab_bar.dart';
import 'package:intent_app/presentation/matches/widgets/matches_tips_card.dart';

class MatchesScreen extends StatelessWidget {
  const MatchesScreen({super.key});

  static const int matchesCount = 19;
  static const int conversationsCount = 31;

  @override
  Widget build(BuildContext context) {
    final matches = MatchProfile.samples;

    return DiscoverScaffold(
      topBar: const MatchesHeader(),
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
            const SizedBox(height: 6),
            MatchesTabBar(
              selectedTab: MatchesScreenTab.matches,
              matchesCount: matchesCount,
              conversationsCount: conversationsCount,
              onTabSelected: (tab) {
                if (tab == MatchesScreenTab.conversations) {
                  context.go(AppRoutes.messages);
                }
              },
            ),
            const SizedBox(height: 16),
            const MatchesPhotoUnlockCard(),
            const SizedBox(height: 12),
            for (var i = 0; i < matches.length; i++) ...[
              if (i > 0) const SizedBox(height: 10),
              MatchProfileCard(
                match: matches[i],
                onTap: () => context.go(AppRoutes.profilePreview),
                onAvatarTap: () => context.push(AppRoutes.chooseIcon),
                onMessageTap: () => context.push(AppRoutes.chat),
              ),
            ],
            const SizedBox(height: 16),
            MatchesTipsCard(
              onViewTips: () {},
            ),
          ],
        ),
      ),
    );
  }
}
