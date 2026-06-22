import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intent_app/app/theme/theme.dart';
import 'package:intent_app/presentation/auth/widgets/shared/fixed_background_auth_scaffold.dart';
import 'package:intent_app/presentation/notifications/providers/notification_provider.dart';
import 'package:intent_app/presentation/notifications/providers/notification_state.dart';
import 'package:intent_app/presentation/notifications/widgets/notification_sections.dart';
import 'package:intent_app/presentation/profile/widgets/profile_screen_header.dart';

class NotificationScreen extends ConsumerWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(notificationProvider.notifier);
    final state = ref.watch(notificationProvider);
    final items = state.filteredItems;

    final sections = <String, List<AppNotificationItem>>{};
    for (final item in items) {
      sections.putIfAbsent(item.section, () => []).add(item);
    }

    return FixedBackgroundAuthScaffold(
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ProfileScreenHeader(
              title: 'Notifications',
              onBack: () => notifier.onBack(context),
            ),
            const SizedBox(height: 16),
            NotificationSummaryBanner(
              unreadCount: state.unreadCount,
              totalCount: state.items.length,
              onMarkAllRead: notifier.markAllRead,
              onClearAll: () => unawaited(notifier.deleteAll(context)),
            ),
            const SizedBox(height: 14),
            NotificationFilterChips(
              selected: state.selectedFilter,
              onSelected: notifier.setFilter,
            ),
            const SizedBox(height: 16),
            if (items.isEmpty)
              const NotificationEmptyState()
            else
              for (final section in sections.entries) ...[
                NotificationSectionLabel(label: section.key.toUpperCase()),
                for (var i = 0; i < section.value.length; i++) ...[
                  if (i > 0) const SizedBox(height: 10),
                  NotificationTile(
                    item: section.value[i],
                    onTap: () => notifier.markRead(section.value[i].id),
                    onDelete: () => notifier.deleteItem(section.value[i].id),
                  ),
                ],
                const SizedBox(height: 14),
              ],
            if (items.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(
                'Intent keeps notifications focused on meaningful updates — '
                'not noise.',
                textAlign: TextAlign.center,
                style: IntentLoginStyles.onboardingSubtitle.copyWith(
                  fontSize: 11,
                  height: 1.4,
                  color: AppColors.intentTextSoft,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
