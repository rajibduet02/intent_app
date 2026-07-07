import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';
import 'package:intent_app/presentation/dates/models/date_hub_entry.dart';

class DatesFilterChips extends StatelessWidget {
  const DatesFilterChips({
    super.key,
    required this.selectedSection,
    required this.onSectionSelected,
    required this.pendingCount,
    required this.upcomingCount,
    required this.pastCount,
  });

  final DateHubSection selectedSection;
  final ValueChanged<DateHubSection> onSectionSelected;
  final int pendingCount;
  final int upcomingCount;
  final int pastCount;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _FilterChip(
            label: 'Pending',
            isSelected: selectedSection == DateHubSection.pending,
            onTap: () => onSectionSelected(DateHubSection.pending),
            badgeCount: pendingCount > 0 ? pendingCount : null,
          ),
          const SizedBox(width: 8),
          _FilterChip(
            label: 'Upcoming',
            isSelected: selectedSection == DateHubSection.upcoming,
            onTap: () => onSectionSelected(DateHubSection.upcoming),
            badgeCount: upcomingCount > 0 ? upcomingCount : null,
          ),
          const SizedBox(width: 8),
          _FilterChip(
            label: 'Past',
            isSelected: selectedSection == DateHubSection.past,
            onTap: () => onSectionSelected(DateHubSection.past),
          ),
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
    this.badgeCount,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final int? badgeCount;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.intentForest
                : AppColors.intentCreamDeep.withValues(alpha: 0.85),
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
                  color: isSelected ? AppColors.white : AppColors.intentText,
                ),
              ),
              if (badgeCount != null) ...[
                const SizedBox(width: 6),
                Container(
                  constraints: const BoxConstraints(minWidth: 18),
                  height: 18,
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.white.withValues(alpha: 0.22)
                        : AppColors.accentBlue,
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
