import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';

class ProfileSectionItem {
  const ProfileSectionItem({
    required this.label,
    this.value,
    this.badge,
    this.icon,
    this.showCheck = false,
  });

  final String label;
  final String? value;
  final String? badge;
  final IconData? icon;
  final bool showCheck;
}

class ProfileSectionCard extends StatelessWidget {
  const ProfileSectionCard({
    super.key,
    required this.title,
    required this.headerIcon,
    required this.items,
    this.headerBadge,
  });

  final String title;
  final IconData headerIcon;
  final List<ProfileSectionItem> items;
  final String? headerBadge;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: AppShadows.intentInput,
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                _SectionIcon(icon: headerIcon),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    title,
                    style: IntentLoginStyles.onboardingCardFieldLabel.copyWith(
                      fontSize: 15,
                    ),
                  ),
                ),
                if (headerBadge != null)
                  _StatusBadge(label: headerBadge!),
              ],
            ),
            const SizedBox(height: 14),
            for (var i = 0; i < items.length; i++) ...[
              if (i > 0)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Divider(
                    height: 1,
                    color: AppColors.intentInputBorder.withValues(alpha: 0.55),
                  ),
                ),
              _SectionRow(item: items[i]),
            ],
          ],
        ),
      ),
    );
  }
}

class _SectionIcon extends StatelessWidget {
  const _SectionIcon({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: AppColors.intentForest.withValues(alpha: 0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        size: 16,
        color: AppColors.intentForest,
      ),
    );
  }
}

class _SectionRow extends StatelessWidget {
  const _SectionRow({required this.item});

  final ProfileSectionItem item;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (item.showCheck)
          Padding(
            padding: const EdgeInsets.only(top: 2, right: 8),
            child: Icon(
              Icons.check_circle,
              size: 16,
              color: AppColors.intentForest,
            ),
          )
        else if (item.icon != null)
          Padding(
            padding: const EdgeInsets.only(top: 2, right: 8),
            child: Icon(
              item.icon,
              size: 16,
              color: AppColors.intentTextSoft,
            ),
          ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.label,
                style: IntentLoginStyles.onboardingSubtitle.copyWith(
                  fontSize: 12,
                  color: AppColors.intentTextSoft,
                ),
              ),
              if (item.value != null) ...[
                const SizedBox(height: 3),
                Text(
                  item.value!,
                  style: IntentLoginStyles.onboardingCardFieldLabel.copyWith(
                    fontSize: 13,
                  ),
                ),
              ],
            ],
          ),
        ),
        if (item.badge != null) ...[
          const SizedBox(width: 8),
          _StatusBadge(label: item.badge!),
        ],
      ],
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.intentSegmentFill,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.intentInputBorder.withValues(alpha: 0.55),
        ),
      ),
      child: Text(
        label,
        style: IntentLoginStyles.onboardingSubtitle.copyWith(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: AppColors.intentText,
        ),
      ),
    );
  }
}
