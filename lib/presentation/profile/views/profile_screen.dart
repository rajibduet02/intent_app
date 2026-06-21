import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:intent_app/app/routes/app_routes.dart';
import 'package:intent_app/app/theme/theme.dart';
import 'package:intent_app/core/utils/custom_tab_navigation.dart';
import 'package:intent_app/core/widgets/custom_bottom_nav.dart';
import 'package:intent_app/presentation/discover/widgets/discover_scaffold.dart';
import 'package:intent_app/presentation/profile/widgets/profile_hero_card.dart';
import 'package:intent_app/presentation/profile/widgets/profile_screen_header.dart';
import 'package:intent_app/presentation/profile/widgets/profile_screen_sections.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DiscoverScaffold(
      bottomNavigationBar: DiscoverBottomNav(
        selectedTab: CustomBottomNavTab.profile,
        onTabSelected: (tab) => navigateCustomBottomNavTab(context, tab),
        messagesBadgeCount: 5,
      ),
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ProfileScreenHeader(
              onBack: () => context.go(AppRoutes.discover),
            ),
            const SizedBox(height: 16),
            const ProfileHeroCard(),
            const SizedBox(height: 14),
            ProfileScreenSection(
              title: 'Basic Info',
              child: Column(
                children: const [
                  ProfileKeyValueRow(
                    icon: Icons.cake_outlined,
                    label: 'Age',
                    value: '31',
                  ),
                  ProfileSectionDivider(),
                  ProfileKeyValueRow(
                    icon: Icons.location_on_outlined,
                    label: 'Location',
                    value: 'Nearby',
                  ),
                  ProfileSectionDivider(),
                  ProfileKeyValueRow(
                    icon: Icons.work_outline,
                    label: 'Occupation',
                    value: 'Product Designer',
                  ),
                  ProfileSectionDivider(),
                  ProfileKeyValueRow(
                    icon: Icons.school_outlined,
                    label: 'Education',
                    value: 'University graduate',
                  ),
                  ProfileSectionDivider(),
                  ProfileKeyValueRow(
                    icon: Icons.favorite_border,
                    label: 'Looking for',
                    value: 'Intentional connection',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            const ProfileRelationshipIntentionCard(),
            const SizedBox(height: 14),
            const ProfileValuesCard(),
            const SizedBox(height: 14),
            ProfileScreenSection(
              title: 'Lifestyle',
              child: Column(
                children: const [
                  ProfileKeyValueRow(
                    icon: Icons.schedule_outlined,
                    label: 'Routine style',
                    value: 'Balanced routine',
                  ),
                  ProfileSectionDivider(),
                  ProfileKeyValueRow(
                    icon: Icons.nightlife_outlined,
                    label: 'Social lifestyle',
                    value: 'Quiet evenings + meaningful outings',
                  ),
                  ProfileSectionDivider(),
                  ProfileKeyValueRow(
                    icon: Icons.fitness_center_outlined,
                    label: 'Fitness',
                    value: 'Moderately active',
                  ),
                  ProfileSectionDivider(),
                  ProfileKeyValueRow(
                    icon: Icons.flight_outlined,
                    label: 'Travel',
                    value: 'Occasional trips',
                  ),
                  ProfileSectionDivider(),
                  ProfileKeyValueRow(
                    icon: Icons.pets_outlined,
                    label: 'Pets',
                    value: 'Open to pets',
                  ),
                  ProfileSectionDivider(),
                  ProfileKeyValueRow(
                    icon: Icons.chat_bubble_outline,
                    label: 'Communication',
                    value: 'Thoughtful and direct',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            const ProfilePersonalityCard(),
            const SizedBox(height: 14),
            const ProfileHiddenGalleryCard(),
            const SizedBox(height: 14),
            const ProfilePreviewPhotoCard(),
            const SizedBox(height: 14),
            const ProfileVerificationCard(),
            const SizedBox(height: 14),
            const ProfileDealbreakersCard(),
            const SizedBox(height: 18),
            const ProfileUnlockBanner(),
            const SizedBox(height: 18),
            SizedBox(
              width: double.infinity,
              height: AppSpacing.primaryButtonHeight,
              child: ElevatedButton(
                onPressed: () => context.push(AppRoutes.editProfile),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.intentForest,
                  elevation: 0,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      AppSpacing.primaryButtonBorderRadius,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.edit_outlined,
                      size: 18,
                      color: AppColors.white,
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    Text(
                      'Edit Profile',
                      style: IntentLoginStyles.onboardingContinue,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 14),
            Center(
              child: GestureDetector(
                onTap: () => context.push(AppRoutes.profilePreview),
                child: Text(
                  'Preview as others see it',
                  style: IntentLoginStyles.onboardingSectionTitle.copyWith(
                    fontSize: 16,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.intentText,
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
