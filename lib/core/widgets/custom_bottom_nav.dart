import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';

enum CustomBottomNavTab {
  discover,
  compatibility,
  dates,
  messages,
  profile,
}

class DiscoverBottomNav extends StatelessWidget {
  const DiscoverBottomNav({
    super.key,
    required this.selectedTab,
    required this.onTabSelected,
    this.messagesBadgeCount,
  });

  static const double bottomNavHeight = 78;

  static double totalHeight(BuildContext context) {
    return bottomNavHeight + MediaQuery.paddingOf(context).bottom;
  }

  final CustomBottomNavTab selectedTab;
  final ValueChanged<CustomBottomNavTab> onTabSelected;
  final int? messagesBadgeCount;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    return Container(
      height: bottomNavHeight + bottomInset,
      decoration: BoxDecoration(
        color: AppColors.white.withValues(alpha: 0.96),
        border: Border(
          top: BorderSide(
            color: AppColors.intentInputBorder.withValues(alpha: 0.65),
          ),
        ),
      ),
      padding: EdgeInsets.fromLTRB(8, 8, 8, 10 + bottomInset),
      child: Row(
        children: [
          _NavItem(
            label: 'Discover',
            isSelected: selectedTab == CustomBottomNavTab.discover,
            onTap: () => onTabSelected(CustomBottomNavTab.discover),
            icon: _DiscoverNavIcon(
              color: selectedTab == CustomBottomNavTab.discover
                  ? AppColors.intentText
                  : AppColors.intentTextSoft,
            ),
          ),
          _NavItem(
            label: 'Matches',
            isSelected: selectedTab == CustomBottomNavTab.compatibility,
            onTap: () => onTabSelected(CustomBottomNavTab.compatibility),
            icon: const Icon(Icons.favorite_border, size: 20),
          ),
          _NavItem(
            label: 'Dates',
            isSelected: selectedTab == CustomBottomNavTab.dates,
            onTap: () => onTabSelected(CustomBottomNavTab.dates),
            icon: const Icon(Icons.calendar_today_outlined, size: 20),
          ),
          _NavItem(
            label: 'Messages',
            isSelected: selectedTab == CustomBottomNavTab.messages,
            onTap: () => onTabSelected(CustomBottomNavTab.messages),
            icon: const Icon(Icons.chat_bubble_outline, size: 20),
            badgeCount: messagesBadgeCount,
          ),
          _NavItem(
            label: 'Profile',
            isSelected: selectedTab == CustomBottomNavTab.profile,
            onTap: () => onTabSelected(CustomBottomNavTab.profile),
            icon: const Icon(Icons.person_outline, size: 20),
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.label,
    required this.isSelected,
    required this.onTap,
    required this.icon,
    this.badgeCount,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final Widget icon;
  final int? badgeCount;

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? AppColors.intentText : AppColors.intentTextSoft;

    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                if (isSelected)
                  Container(
                    width: 42,
                    height: 30,
                    decoration: BoxDecoration(
                      color: AppColors.intentCreamDeep.withValues(alpha: 0.85),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.center,
                    child: IconTheme(
                      data: IconThemeData(color: color, size: 20),
                      child: icon,
                    ),
                  )
                else
                  SizedBox(
                    height: 30,
                    child: IconTheme(
                      data: IconThemeData(color: color, size: 22),
                      child: icon,
                    ),
                  ),
                if (badgeCount != null)
                  Positioned(
                    top: -2,
                    right: -4,
                    child: Container(
                      constraints: const BoxConstraints(minWidth: 16),
                      height: 16,
                      padding: const EdgeInsets.symmetric(horizontal: 3),
                      decoration: BoxDecoration(
                        color: AppColors.intentNotificationDot,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppColors.white, width: 1.5),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '$badgeCount',
                        style: IntentLoginStyles.onboardingSubtitle.copyWith(
                          fontSize: 8,
                          fontWeight: FontWeight.w700,
                          color: AppColors.white,
                          height: 1,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: IntentLoginStyles.onboardingSubtitle.copyWith(
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DiscoverNavIcon extends StatelessWidget {
  const _DiscoverNavIcon({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 18,
      height: 16,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            width: 3,
            height: 14,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 3),
          Container(
            width: 3,
            height: 10,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }
}
