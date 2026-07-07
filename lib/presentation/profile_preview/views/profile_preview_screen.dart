import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:intent_app/app/routes/app_routes.dart';
import 'package:intent_app/app/theme/theme.dart';
import 'package:intent_app/presentation/auth/widgets/shared/fixed_background_auth_scaffold.dart';
import 'package:intent_app/presentation/discover/widgets/discover_action_button.dart';
import 'package:intent_app/presentation/profile_preview/widgets/profile_photo_privacy_banner.dart';
import 'package:intent_app/presentation/profile_preview/widgets/profile_preview_header.dart';
import 'package:intent_app/presentation/profile_preview/widgets/profile_section_card.dart';
import 'package:intent_app/presentation/profile_preview/widgets/profile_summary_card.dart';

class ProfilePreviewScreen extends StatelessWidget {
  const ProfilePreviewScreen({super.key});

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
            ProfilePreviewHeader(
              onBack: () => _onBack(context),
            ),
            const SizedBox(height: 12),
            Text(
              "Here's a compatibility-first preview. Photos unlock only "
              'through the date flow.',
              textAlign: TextAlign.center,
              style: IntentLoginStyles.onboardingSubtitle.copyWith(
                fontSize: 12,
                height: 1.45,
              ),
            ),
            const SizedBox(height: 18),
            const ProfileSummaryCard(),
            const SizedBox(height: 14),
            const ProfileSectionCard(
              title: 'Intentions & Values',
              headerIcon: Icons.favorite_border,
              items: [
                ProfileSectionItem(
                  icon: Icons.favorite_border,
                  label: 'Relationship intention',
                  badge: 'Aligned ✓',
                ),
                ProfileSectionItem(
                  icon: Icons.star_outline,
                  label: 'Key values',
                  value: 'Family, honesty, emotional growth',
                  badge: 'Strong match ✓',
                ),
                ProfileSectionItem(
                  icon: Icons.account_balance_outlined,
                  label: 'Religion / belief importance',
                  value: 'Faith is important',
                  badge: 'Compatible',
                ),
                ProfileSectionItem(
                  icon: Icons.family_restroom_outlined,
                  label: 'Family goals',
                  value: 'Wants children',
                  badge: 'Aligned ✓',
                ),
              ],
            ),
            const SizedBox(height: 14),
            const ProfileSectionCard(
              title: 'Lifestyle Compatibility',
              headerIcon: Icons.change_history_outlined,
              headerBadge: '9/10 Lifestyle Match',
              items: [
                ProfileSectionItem(
                  icon: Icons.schedule_outlined,
                  label: 'Routine style',
                  value: 'Balanced routine',
                ),
                ProfileSectionItem(
                  icon: Icons.nightlife_outlined,
                  label: 'Social lifestyle',
                  value: 'Quiet evenings + meaningful outings',
                ),
                ProfileSectionItem(
                  icon: Icons.bolt_outlined,
                  label: 'Fitness',
                  value: 'Moderately active',
                ),
                ProfileSectionItem(
                  icon: Icons.pets_outlined,
                  label: 'Pets',
                  value: 'Open to pets',
                ),
              ],
            ),
            const SizedBox(height: 14),
            const ProfileSectionCard(
              title: 'Dealbreaker Alignment',
              headerIcon: Icons.shield_outlined,
              items: [
                ProfileSectionItem(
                  showCheck: true,
                  label: 'Relationship intentions',
                  badge: 'Aligned',
                ),
                ProfileSectionItem(
                  showCheck: true,
                  label: 'Religion / beliefs',
                  badge: 'Compatible',
                ),
                ProfileSectionItem(
                  showCheck: true,
                  label: 'Children / family goals',
                  badge: 'Matched ✓',
                ),
                ProfileSectionItem(
                  showCheck: true,
                  label: 'Lifestyle dealbreakers',
                  badge: 'No conflicts',
                ),
              ],
            ),
            const SizedBox(height: 14),
            const ProfilePhotoPrivacyBanner(),
            const SizedBox(height: 18),
            DiscoverActionButton(
              label: 'Send Intent',
              icon: Icons.favorite_border,
              showChevron: false,
              onPressed: () {},
            ),
            const SizedBox(height: 10),
            DiscoverActionButton(
              label: 'Safety Center',
              icon: Icons.verified_user_outlined,
              showChevron: true,
              onPressed: () => context.push(AppRoutes.safetyCenter),
            ),
            const SizedBox(height: 10),
            DiscoverActionButton(
              label: 'Not for me',
              icon: Icons.cancel_outlined,
              style: DiscoverActionStyle.outlined,
              showChevron: false,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
