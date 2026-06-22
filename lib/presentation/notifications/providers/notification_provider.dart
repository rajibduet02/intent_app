import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intent_app/app/routes/app_router.dart';
import 'package:intent_app/app/routes/app_routes.dart';
import 'package:intent_app/app/theme/theme.dart';
import 'package:intent_app/presentation/notifications/providers/notification_state.dart';

final notificationProvider =
    NotifierProvider<NotificationNotifier, NotificationState>(
  NotificationNotifier.new,
);

class NotificationNotifier extends Notifier<NotificationState> {
  @override
  NotificationState build() => NotificationState.initial();

  void onBack(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    } else {
      appRouter.go(AppRoutes.discover);
    }
  }

  void setFilter(NotificationFilter filter) {
    state = state.copyWith(selectedFilter: filter);
  }

  void markAllRead() {
    state = state.copyWith(
      items: [
        for (final item in state.items)
          AppNotificationItem(
            id: item.id,
            category: item.category,
            title: item.title,
            body: item.body,
            timeLabel: item.timeLabel,
            isUnread: false,
            section: item.section,
          ),
      ],
    );
  }

  void markRead(String id) {
    state = state.copyWith(
      items: [
        for (final item in state.items)
          if (item.id == id)
            AppNotificationItem(
              id: item.id,
              category: item.category,
              title: item.title,
              body: item.body,
              timeLabel: item.timeLabel,
              isUnread: false,
              section: item.section,
            )
          else
            item,
      ],
    );
  }

  void deleteItem(String id) {
    state = state.copyWith(
      items: state.items.where((item) => item.id != id).toList(),
    );
  }

  Future<void> deleteAll(BuildContext context) async {
    if (state.items.isEmpty) {
      return;
    }

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Clear all notifications?',
          style: IntentLoginStyles.onboardingSectionTitle.copyWith(
            fontSize: 20,
          ),
        ),
        content: Text(
          'This removes every notification from your inbox. This action '
          'cannot be undone.',
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
              'Clear all',
              style: IntentLoginStyles.onboardingSubtitle.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.danger,
              ),
            ),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      state = state.copyWith(items: []);
    }
  }
}
