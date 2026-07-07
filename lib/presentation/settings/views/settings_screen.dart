import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intent_app/app/routes/app_routes.dart';
import 'package:intent_app/app/theme/theme.dart';
import 'package:intent_app/presentation/auth/widgets/shared/fixed_background_auth_scaffold.dart';
import 'package:intent_app/presentation/profile/widgets/profile_screen_header.dart';
import 'package:intent_app/presentation/settings/providers/settings_provider.dart';
import 'package:intent_app/presentation/settings/widgets/settings_sections.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(settingsProvider.notifier);
    final state = ref.watch(settingsProvider);

    return FixedBackgroundAuthScaffold(
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ProfileScreenHeader(
              title: 'Settings',
              onBack: () => notifier.onBack(context),
              trailingIcon: Icons.settings_outlined,
              onSettings: null,
            ),
            const SizedBox(height: 16),
            const SettingsInfoBanner(),
            const SizedBox(height: 14),
            SettingsSectionCard(
              title: 'Account',
              children: [
                SettingsNavRow(
                  icon: Icons.person_outline,
                  label: 'Edit profile',
                  subtitle: 'Update photos, intentions, and preferences',
                  onTap: () => context.push(AppRoutes.editProfile),
                ),
                SettingsNavRow(
                  icon: Icons.mail_outline,
                  label: 'Email & phone',
                  subtitle: 'name@example.com',
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 14),
            SettingsSectionCard(
              title: 'Privacy & Safety',
              children: [
                SettingsNavRow(
                  icon: Icons.photo_library_outlined,
                  label: 'Photo privacy',
                  subtitle: 'Control gallery and preview visibility',
                  onTap: () {},
                ),
                SettingsNavRow(
                  icon: Icons.block_outlined,
                  label: 'Blocked users',
                  onTap: () {},
                ),
                SettingsNavRow(
                  icon: Icons.verified_user_outlined,
                  label: 'Safety Center',
                  subtitle: 'Tools, reporting, and community standards',
                  onTap: () => context.push(AppRoutes.safetyCenter),
                  showDivider: false,
                ),
              ],
            ),
            const SizedBox(height: 14),
            SettingsSectionCard(
              title: 'Notifications',
              children: [
                SettingsToggleRow(
                  icon: Icons.notifications_none_outlined,
                  label: 'Push notifications',
                  value: state.pushNotifications,
                  onChanged: notifier.setPushNotifications,
                ),
                SettingsToggleRow(
                  icon: Icons.mark_email_unread_outlined,
                  label: 'Email updates',
                  value: state.emailUpdates,
                  onChanged: notifier.setEmailUpdates,
                ),
                SettingsToggleRow(
                  icon: Icons.favorite_border,
                  label: 'Match alerts',
                  value: state.matchAlerts,
                  onChanged: notifier.setMatchAlerts,
                  showDivider: false,
                ),
              ],
            ),
            const SizedBox(height: 14),
            SettingsSectionCard(
              title: 'Discovery',
              children: [
                SettingsNavRow(
                  icon: Icons.tune,
                  label: 'Discovery preferences',
                  subtitle: 'Distance, intentions, and dealbreakers',
                  onTap: () => context.push(AppRoutes.filter),
                ),
                SettingsToggleRow(
                  icon: Icons.visibility_outlined,
                  label: 'Show compatibility first',
                  value: state.compatibilityFirst,
                  onChanged: notifier.setCompatibilityFirst,
                  showDivider: false,
                ),
              ],
            ),
            const SizedBox(height: 14),
            SettingsSectionCard(
              title: 'Support & Legal',
              children: [
                SettingsNavRow(
                  icon: Icons.help_outline,
                  label: 'Help center',
                  onTap: () {},
                ),
                SettingsNavRow(
                  icon: Icons.groups_outlined,
                  label: 'Community guidelines',
                  onTap: () {},
                ),
                SettingsNavRow(
                  icon: Icons.description_outlined,
                  label: 'Terms & privacy policy',
                  onTap: () {},
                  showDivider: false,
                ),
              ],
            ),
            const SizedBox(height: 14),
            SettingsSectionCard(
              title: 'About',
              children: [
                SettingsNavRow(
                  icon: Icons.info_outline,
                  label: 'App version',
                  subtitle: '1.0.0',
                  showDivider: false,
                ),
              ],
            ),
            const SizedBox(height: 18),
            SettingsActionButton(
              label: 'LOG OUT',
              isLoading: state.isLoggingOut,
              onPressed: () => unawaited(notifier.logout()),
            ),
            const SizedBox(height: 12),
            SettingsActionButton(
              label: 'Delete account',
              style: SettingsActionStyle.danger,
              isLoading: state.isDeletingAccount,
              onPressed: () => unawaited(notifier.deleteAccount(context)),
            ),
            const SizedBox(height: 16),
            Text(
              'Deleting your account permanently removes your profile and '
              'conversation history from Intent.',
              textAlign: TextAlign.center,
              style: IntentLoginStyles.onboardingSubtitle.copyWith(
                fontSize: 11,
                height: 1.4,
                color: AppColors.intentTextSoft,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
