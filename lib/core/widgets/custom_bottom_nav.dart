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

  static const double bottomNavHeight = 84;

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
        color: AppColors.white.withValues(alpha: 0.98),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        border: Border(
          top: BorderSide(
            color: AppColors.intentGoldMuted.withValues(alpha: 0.35),
            width: 1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.intentForest.withValues(alpha: 0.08),
            blurRadius: 24,
            offset: const Offset(0, -8),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 6),
            width: 36,
            height: 3,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.intentGoldMuted.withValues(alpha: 0.2),
                  AppColors.intentGold.withValues(alpha: 0.85),
                  AppColors.intentGoldMuted.withValues(alpha: 0.2),
                ],
              ),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(6, 4, 6, 8 + bottomInset),
              child: Row(
                children: [
                  _NavItem(
                    label: 'Discover',
                    isSelected: selectedTab == CustomBottomNavTab.discover,
                    onTap: () => onTabSelected(CustomBottomNavTab.discover),
                    iconBuilder: (color, size) =>
                        _DiscoverNavIcon(color: color, barWidth: size * 0.15),
                  ),
                  _NavItem(
                    label: 'Matches',
                    isSelected: selectedTab == CustomBottomNavTab.compatibility,
                    onTap: () => onTabSelected(CustomBottomNavTab.compatibility),
                    iconBuilder: (color, size) => Icon(
                      selectedTab == CustomBottomNavTab.compatibility
                          ? Icons.favorite_rounded
                          : Icons.favorite_border_rounded,
                      size: size,
                      color: color,
                    ),
                  ),
                  _NavItem(
                    label: 'Dates',
                    isSelected: selectedTab == CustomBottomNavTab.dates,
                    onTap: () => onTabSelected(CustomBottomNavTab.dates),
                    iconBuilder: (color, size) => Icon(
                      Icons.calendar_today_rounded,
                      size: size,
                      color: color,
                    ),
                  ),
                  _NavItem(
                    label: 'Messages',
                    isSelected: selectedTab == CustomBottomNavTab.messages,
                    onTap: () => onTabSelected(CustomBottomNavTab.messages),
                    iconBuilder: (color, size) => Icon(
                      Icons.chat_bubble_rounded,
                      size: size,
                      color: color,
                    ),
                    badgeCount: messagesBadgeCount,
                  ),
                  _NavItem(
                    label: 'Profile',
                    isSelected: selectedTab == CustomBottomNavTab.profile,
                    onTap: () => onTabSelected(CustomBottomNavTab.profile),
                    iconBuilder: (color, size) => Icon(
                      Icons.person_rounded,
                      size: size,
                      color: color,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

typedef _NavIconBuilder = Widget Function(Color color, double size);

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.label,
    required this.isSelected,
    required this.onTap,
    required this.iconBuilder,
    this.badgeCount,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final _NavIconBuilder iconBuilder;
  final int? badgeCount;

  @override
  Widget build(BuildContext context) {
    final iconColor =
        isSelected ? AppColors.white : AppColors.intentTextSoft;
    final labelColor =
        isSelected ? AppColors.intentForest : AppColors.intentTextSoft;

    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          splashColor: AppColors.intentForest.withValues(alpha: 0.08),
          highlightColor: AppColors.intentCreamDeep.withValues(alpha: 0.5),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 220),
                      curve: Curves.easeOutCubic,
                      width: isSelected ? 46 : 36,
                      height: isSelected ? 34 : 30,
                      decoration: BoxDecoration(
                        gradient: isSelected
                            ? const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  AppColors.intentForest,
                                  AppColors.intentForestDark,
                                ],
                              )
                            : null,
                        color: isSelected
                            ? null
                            : AppColors.intentSegmentFill.withValues(alpha: 0.7),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected
                              ? AppColors.intentForestDark
                                  .withValues(alpha: 0.25)
                              : AppColors.intentInputBorder
                                  .withValues(alpha: 0.45),
                        ),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: AppColors.intentForest
                                      .withValues(alpha: 0.28),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ]
                            : null,
                      ),
                      alignment: Alignment.center,
                      child: iconBuilder(iconColor, isSelected ? 20 : 19),
                    ),
                    if (badgeCount != null)
                      Positioned(
                        top: -4,
                        right: -2,
                        child: Container(
                          constraints: const BoxConstraints(minWidth: 17),
                          height: 17,
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                AppColors.intentNotificationDot,
                                Color(0xFFD9893A),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(9),
                            border: Border.all(
                              color: AppColors.white,
                              width: 1.5,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.intentNotificationDot
                                    .withValues(alpha: 0.45),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ],
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
                const SizedBox(height: 5),
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 220),
                  curve: Curves.easeOutCubic,
                  style: IntentLoginStyles.onboardingSubtitle.copyWith(
                    fontSize: isSelected ? 11 : 10,
                    fontWeight:
                        isSelected ? FontWeight.w700 : FontWeight.w500,
                    color: labelColor,
                    letterSpacing: isSelected ? 0.15 : 0,
                  ),
                  child: Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 2),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 220),
                  curve: Curves.easeOutCubic,
                  width: isSelected ? 14 : 0,
                  height: 2,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.intentGoldMuted.withValues(alpha: 0.4),
                        AppColors.intentGold,
                        AppColors.intentGoldMuted.withValues(alpha: 0.4),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(1),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DiscoverNavIcon extends StatelessWidget {
  const _DiscoverNavIcon({
    required this.color,
    this.barWidth = 3,
  });

  final Color color;
  final double barWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: barWidth * 6,
      height: barWidth * 5,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            width: barWidth,
            height: barWidth * 4.5,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(barWidth * 0.6),
            ),
          ),
          SizedBox(width: barWidth),
          Container(
            width: barWidth,
            height: barWidth * 3.2,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(barWidth * 0.6),
            ),
          ),
        ],
      ),
    );
  }
}
