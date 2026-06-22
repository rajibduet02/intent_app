enum NotificationCategory {
  match,
  message,
  dateFlow,
  compatibility,
  verification,
  system,
}

class AppNotificationItem {
  const AppNotificationItem({
    required this.id,
    required this.category,
    required this.title,
    required this.body,
    required this.timeLabel,
    required this.isUnread,
    this.section = 'Today',
  });

  final String id;
  final NotificationCategory category;
  final String title;
  final String body;
  final String timeLabel;
  final bool isUnread;
  final String section;
}

class NotificationState {
  const NotificationState({
    required this.items,
    required this.selectedFilter,
  });

  final List<AppNotificationItem> items;
  final NotificationFilter selectedFilter;

  factory NotificationState.initial() => NotificationState(
        items: _seedItems,
        selectedFilter: NotificationFilter.all,
      );

  List<AppNotificationItem> get filteredItems {
    if (selectedFilter == NotificationFilter.all) {
      return items;
    }
    return items.where((item) {
      switch (selectedFilter) {
        case NotificationFilter.matches:
          return item.category == NotificationCategory.match;
        case NotificationFilter.messages:
          return item.category == NotificationCategory.message;
        case NotificationFilter.dates:
          return item.category == NotificationCategory.dateFlow;
        case NotificationFilter.system:
          return item.category == NotificationCategory.system ||
              item.category == NotificationCategory.verification ||
              item.category == NotificationCategory.compatibility;
        case NotificationFilter.all:
          return true;
      }
    }).toList();
  }

  int get unreadCount => items.where((item) => item.isUnread).length;

  NotificationState copyWith({
    List<AppNotificationItem>? items,
    NotificationFilter? selectedFilter,
  }) {
    return NotificationState(
      items: items ?? this.items,
      selectedFilter: selectedFilter ?? this.selectedFilter,
    );
  }
}

enum NotificationFilter { all, matches, messages, dates, system }

const _seedItems = [
  AppNotificationItem(
    id: '1',
    category: NotificationCategory.match,
    title: 'New intentional match',
    body: 'Julian aligns with your values and relationship goals.',
    timeLabel: '2m ago',
    isUnread: true,
    section: 'Today',
  ),
  AppNotificationItem(
    id: '2',
    category: NotificationCategory.message,
    title: 'Message from Sofia',
    body: '“I appreciated how thoughtful your profile feels.”',
    timeLabel: '1h ago',
    isUnread: true,
    section: 'Today',
  ),
  AppNotificationItem(
    id: '3',
    category: NotificationCategory.dateFlow,
    title: 'Date flow update',
    body: 'A preview photo can unlock after a date is proposed.',
    timeLabel: '3h ago',
    isUnread: true,
    section: 'Today',
  ),
  AppNotificationItem(
    id: '4',
    category: NotificationCategory.compatibility,
    title: 'Compatibility insight',
    body: 'Strong alignment on family goals and communication style.',
    timeLabel: 'Yesterday',
    isUnread: false,
    section: 'Earlier',
  ),
  AppNotificationItem(
    id: '5',
    category: NotificationCategory.verification,
    title: 'Verification complete',
    body: 'Your ID verification and safety acknowledgement are active.',
    timeLabel: '2 days ago',
    isUnread: false,
    section: 'Earlier',
  ),
  AppNotificationItem(
    id: '6',
    category: NotificationCategory.system,
    title: 'Welcome to Intent',
    body: 'Finish your profile to unlock more meaningful matches.',
    timeLabel: '3 days ago',
    isUnread: false,
    section: 'Earlier',
  ),
];
