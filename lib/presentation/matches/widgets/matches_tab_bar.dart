import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';

enum MatchesScreenTab {
  matches,
  conversations,
}

class MatchesTabBar extends StatelessWidget {
  const MatchesTabBar({
    super.key,
    required this.selectedTab,
    required this.matchesCount,
    required this.conversationsCount,
    required this.onTabSelected,
  });

  final MatchesScreenTab selectedTab;
  final int matchesCount;
  final int conversationsCount;
  final ValueChanged<MatchesScreenTab> onTabSelected;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _MatchesTabItem(
            label: 'MATCHES',
            count: matchesCount,
            isSelected: selectedTab == MatchesScreenTab.matches,
            onTap: () => onTabSelected(MatchesScreenTab.matches),
          ),
        ),
        Expanded(
          child: _MatchesTabItem(
            label: 'CONVERSATIONS',
            count: conversationsCount,
            isSelected: selectedTab == MatchesScreenTab.conversations,
            onTap: () => onTabSelected(MatchesScreenTab.conversations),
          ),
        ),
      ],
    );
  }
}

class _MatchesTabItem extends StatelessWidget {
  const _MatchesTabItem({
    required this.label,
    required this.count,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final int count;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color =
        isSelected ? AppColors.intentForest : AppColors.intentTextSoft;

    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              '$label $count',
              textAlign: TextAlign.center,
              style: IntentLoginStyles.onboardingSubtitle.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.6,
                color: color,
              ),
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            height: 2,
            decoration: BoxDecoration(
              color: isSelected ? AppColors.intentForest : Colors.transparent,
              borderRadius: BorderRadius.circular(1),
            ),
          ),
        ],
      ),
    );
  }
}
