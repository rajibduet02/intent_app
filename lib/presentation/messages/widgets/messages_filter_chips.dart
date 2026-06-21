import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';

enum MessagesFilter {
  all,
  unread,
  blocked,
}

class MessagesFilterChips extends StatelessWidget {
  const MessagesFilterChips({
    super.key,
    required this.selectedFilter,
    required this.onFilterSelected,
    this.unreadCount = 5,
  });

  final MessagesFilter selectedFilter;
  final ValueChanged<MessagesFilter> onFilterSelected;
  final int unreadCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _FilterChip(
          label: 'All',
          isSelected: selectedFilter == MessagesFilter.all,
          onTap: () => onFilterSelected(MessagesFilter.all),
        ),
        const SizedBox(width: 8),
        _FilterChip(
          label: 'Unread',
          isSelected: selectedFilter == MessagesFilter.unread,
          onTap: () => onFilterSelected(MessagesFilter.unread),
          badgeCount: unreadCount,
        ),
        const SizedBox(width: 8),
        _FilterChip(
          label: 'Blocked',
          isSelected: selectedFilter == MessagesFilter.blocked,
          onTap: () => onFilterSelected(MessagesFilter.blocked),
          isMuted: true,
        ),
      ],
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.badgeCount,
    this.isMuted = false,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final int? badgeCount;
  final bool isMuted;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = isSelected
        ? AppColors.intentForest
        : AppColors.intentCreamDeep.withValues(alpha: 0.85);
    final textColor = isSelected
        ? AppColors.white
        : isMuted
            ? AppColors.intentTextSoft
            : AppColors.intentText;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(20),
            border: isSelected
                ? null
                : Border.all(
                    color: AppColors.intentInputBorder.withValues(alpha: 0.55),
                  ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: IntentLoginStyles.onboardingSubtitle.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
              ),
              if (badgeCount != null) ...[
                const SizedBox(width: 6),
                Container(
                  constraints: const BoxConstraints(minWidth: 18),
                  height: 18,
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: const BoxDecoration(
                    color: AppColors.accentBlue,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '$badgeCount',
                    style: IntentLoginStyles.onboardingSubtitle.copyWith(
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                      color: AppColors.white,
                      height: 1,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
