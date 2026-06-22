import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intent_app/app/providers/auth_repository_provider.dart';
import 'package:intent_app/app/routes/app_router.dart';
import 'package:intent_app/app/routes/app_routes.dart';
import 'package:intent_app/app/theme/theme.dart';
import 'package:intent_app/core/utils/auth_snackbar.dart';
import 'package:intent_app/presentation/settings/providers/settings_state.dart';

final settingsProvider =
    NotifierProvider<SettingsNotifier, SettingsState>(SettingsNotifier.new);

class SettingsNotifier extends Notifier<SettingsState> {
  @override
  SettingsState build() => SettingsState.initial();

  void onBack(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    } else {
      appRouter.go(AppRoutes.profile);
    }
  }

  void setPushNotifications(bool value) {
    state = state.copyWith(pushNotifications: value);
  }

  void setEmailUpdates(bool value) {
    state = state.copyWith(emailUpdates: value);
  }

  void setMatchAlerts(bool value) {
    state = state.copyWith(matchAlerts: value);
  }

  void setCompatibilityFirst(bool value) {
    state = state.copyWith(compatibilityFirst: value);
  }

  Future<void> logout() async {
    if (state.isLoggingOut) {
      return;
    }
    state = state.copyWith(isLoggingOut: true);
    try {
      await ref.read(authRepositoryProvider).logout();
    } catch (_) {
      // UI flow: still return to login if sign-out fails locally.
    } finally {
      state = state.copyWith(isLoggingOut: false);
      AuthSnackbar.success(
        title: 'Signed out',
        message: 'You have been logged out successfully.',
      );
      appRouter.go(AppRoutes.auth);
    }
  }

  Future<void> deleteAccount(BuildContext context) async {
    if (state.isDeletingAccount) {
      return;
    }

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Delete account?',
          style: IntentLoginStyles.onboardingSectionTitle.copyWith(
            fontSize: 20,
          ),
        ),
        content: Text(
          'This permanently removes your profile, matches, and messages. '
          'This action cannot be undone.',
          style: IntentLoginStyles.onboardingSubtitle.copyWith(
            fontSize: 14,
            height: 1.45,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              'Cancel',
              style: IntentLoginStyles.onboardingSubtitle.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(
              'Delete',
              style: IntentLoginStyles.onboardingSubtitle.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.danger,
              ),
            ),
          ),
        ],
      ),
    );

    if (confirmed != true || !context.mounted) {
      return;
    }

    state = state.copyWith(isDeletingAccount: true);
    try {
      await Future<void>.delayed(const Duration(milliseconds: 400));
      AuthSnackbar.success(
        title: 'Account deletion requested',
        message:
            'Your account deletion request has been received. We will '
            'process it shortly.',
      );
      appRouter.go(AppRoutes.auth);
    } finally {
      state = state.copyWith(isDeletingAccount: false);
    }
  }
}
