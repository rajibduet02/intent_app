import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';
import 'package:intent_app/presentation/notifications/providers/notification_state.dart';

class NotificationFilterChips extends StatelessWidget {
  const NotificationFilterChips({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  final NotificationFilter selected;
  final ValueChanged<NotificationFilter> onSelected;

  static const _filters = [
    (NotificationFilter.all, 'All'),
    (NotificationFilter.matches, 'Matches'),
    (NotificationFilter.messages, 'Messages'),
    (NotificationFilter.dates, 'Dates'),
    (NotificationFilter.system, 'System'),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (var i = 0; i < _filters.length; i++) ...[
            if (i > 0) const SizedBox(width: 8),
            _FilterChip(
              label: _filters[i].$2,
              isSelected: selected == _filters[i].$1,
              onTap: () => onSelected(_filters[i].$1),
            ),
          ],
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.intentForest : AppColors.intentSegmentFill,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? AppColors.intentForest
                : AppColors.intentInputBorder.withValues(alpha: 0.55),
          ),
        ),
        child: Text(
          label,
          style: IntentLoginStyles.onboardingSubtitle.copyWith(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: isSelected ? AppColors.white : AppColors.intentText,
          ),
        ),
      ),
    );
  }
}

class NotificationSummaryBanner extends StatelessWidget {
  const NotificationSummaryBanner({
    super.key,
    required this.unreadCount,
    required this.totalCount,
    required this.onMarkAllRead,
    required this.onClearAll,
  });

  final int unreadCount;
  final int totalCount;
  final VoidCallback onMarkAllRead;
  final VoidCallback onClearAll;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFFBF6E8),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.intentGoldMuted.withValues(alpha: 0.4),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.notifications_none_outlined,
                  size: 20,
                  color: AppColors.intentGold.withValues(alpha: 0.95),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  unreadCount > 0
                      ? 'You have $unreadCount unread notification'
                          '${unreadCount == 1 ? '' : 's'}.'
                      : totalCount > 0
                          ? 'You are all caught up.'
                          : 'Your notification inbox is empty.',
                  style: IntentLoginStyles.onboardingSubtitle.copyWith(
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
          if (totalCount > 0) ...[
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (unreadCount > 0) ...[
                  GestureDetector(
                    onTap: onMarkAllRead,
                    child: Text(
                      'Mark all read',
                      style: IntentLoginStyles.footerLink.copyWith(
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                ],
                GestureDetector(
                  onTap: onClearAll,
                  child: Text(
                    'Clear all',
                    style: IntentLoginStyles.onboardingSubtitle.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.danger,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class NotificationTile extends StatelessWidget {
  const NotificationTile({
    super.key,
    required this.item,
    required this.onTap,
    required this.onDelete,
  });

  final AppNotificationItem item;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(14, 14, 8, 14),
          decoration: BoxDecoration(
            color: item.isUnread
                ? AppColors.white
                : AppColors.white.withValues(alpha: 0.92),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: item.isUnread
                  ? AppColors.intentForest.withValues(alpha: 0.18)
                  : AppColors.intentInputBorder.withValues(alpha: 0.55),
            ),
            boxShadow: item.isUnread ? AppShadows.intentInput : null,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _NotificationIcon(category: item.category),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            item.title,
                            style: IntentLoginStyles.onboardingCardFieldLabel
                                .copyWith(
                              fontSize: 14,
                              fontWeight: item.isUnread
                                  ? FontWeight.w600
                                  : FontWeight.w500,
                            ),
                          ),
                        ),
                        Text(
                          item.timeLabel,
                          style: IntentLoginStyles.onboardingSubtitle.copyWith(
                            fontSize: 11,
                            color: AppColors.intentTextSoft,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.body,
                      style: IntentLoginStyles.onboardingSubtitle.copyWith(
                        fontSize: 12,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  if (item.isUnread)
                    Container(
                      width: 8,
                      height: 8,
                      margin: const EdgeInsets.only(top: 4, right: 4),
                      decoration: const BoxDecoration(
                        color: AppColors.intentNotificationDot,
                        shape: BoxShape.circle,
                      ),
                    ),
                  IconButton(
                    onPressed: onDelete,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(
                      minWidth: 32,
                      minHeight: 32,
                    ),
                    style: IconButton.styleFrom(
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    icon: Icon(
                      Icons.close,
                      size: 18,
                      color: AppColors.intentTextSoft.withValues(alpha: 0.75),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NotificationIcon extends StatelessWidget {
  const _NotificationIcon({required this.category});

  final NotificationCategory category;

  @override
  Widget build(BuildContext context) {
    final (icon, color) = switch (category) {
      NotificationCategory.match => (
          Icons.favorite_border,
          AppColors.intentForest,
        ),
      NotificationCategory.message => (
          Icons.chat_bubble_outline,
          AppColors.intentGold,
        ),
      NotificationCategory.dateFlow => (
          Icons.lock_open_outlined,
          AppColors.intentForest,
        ),
      NotificationCategory.compatibility => (
          Icons.auto_awesome_outlined,
          AppColors.intentGold,
        ),
      NotificationCategory.verification => (
          Icons.verified_outlined,
          AppColors.intentForest,
        ),
      NotificationCategory.system => (
          Icons.info_outline,
          AppColors.intentTextSoft,
        ),
    };

    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, size: 18, color: color),
    );
  }
}

class NotificationEmptyState extends StatelessWidget {
  const NotificationEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: AppColors.intentSegmentFill,
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.intentInputBorder.withValues(alpha: 0.55),
              ),
            ),
            child: Icon(
              Icons.notifications_off_outlined,
              size: 28,
              color: AppColors.intentTextSoft.withValues(alpha: 0.8),
            ),
          ),
          const SizedBox(height: 14),
          Text(
            'No notifications here',
            style: IntentLoginStyles.onboardingCardFieldLabel.copyWith(
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Updates about matches, messages, and your date flow '
            'will appear here.',
            textAlign: TextAlign.center,
            style: IntentLoginStyles.onboardingSubtitle.copyWith(
              fontSize: 13,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}

class NotificationSectionLabel extends StatelessWidget {
  const NotificationSectionLabel({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, top: 4),
      child: Text(
        label,
        style: IntentLoginStyles.onboardingAssessmentCategory.copyWith(
          fontSize: 10,
          letterSpacing: 0.8,
          fontWeight: FontWeight.w700,
          color: AppColors.intentTextSoft,
        ),
      ),
    );
  }
}
