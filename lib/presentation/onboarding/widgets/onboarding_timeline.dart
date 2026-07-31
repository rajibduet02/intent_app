import 'package:flutter/material.dart';
import 'package:intent_app/app/theme/theme.dart';

class OnboardingTimelineItem {
  const OnboardingTimelineItem({
    required this.title,
    this.body,
    this.icon,
  });

  final String title;
  final String? body;
  final IconData? icon;
}

/// Vertical timeline matching Intent card + node language.
class OnboardingTimeline extends StatelessWidget {
  const OnboardingTimeline({
    super.key,
    required this.items,
  });

  final List<OnboardingTimelineItem> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var i = 0; i < items.length; i++)
          _TimelineStep(
            item: items[i],
            showLineBelow: i < items.length - 1,
            isFinalNode: i == items.length - 1,
          ),
      ],
    );
  }
}

class _TimelineStep extends StatelessWidget {
  const _TimelineStep({
    required this.item,
    required this.showLineBelow,
    required this.isFinalNode,
  });

  final OnboardingTimelineItem item;
  final bool showLineBelow;
  final bool isFinalNode;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 44,
            child: Column(
              children: [
                _TimelineNode(
                  icon: item.icon,
                  isFinalNode: isFinalNode,
                ),
                if (showLineBelow)
                  Expanded(
                    child: Container(
                      width: 2,
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      color:
                          AppColors.intentInputBorder.withValues(alpha: 0.7),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: showLineBelow ? 14 : 0),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: AppShadows.intentInput,
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: IntentLoginStyles.onboardingAssessmentTitle
                            .copyWith(fontWeight: FontWeight.w700),
                      ),
                      if (item.body != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          item.body!,
                          style: IntentLoginStyles.onboardingSubtitle.copyWith(
                            fontSize: 12,
                            height: 1.4,
                            color: AppColors.intentText,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TimelineNode extends StatelessWidget {
  const _TimelineNode({
    required this.icon,
    required this.isFinalNode,
  });

  final IconData? icon;
  final bool isFinalNode;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isFinalNode ? AppColors.intentForest : AppColors.white,
        border: isFinalNode
            ? null
            : Border.all(
                color: AppColors.intentInputBorder.withValues(alpha: 0.7),
              ),
        boxShadow: isFinalNode ? null : AppShadows.intentInput,
      ),
      child: icon == null
          ? (isFinalNode
              ? const Icon(Icons.check, size: 18, color: AppColors.white)
              : null)
          : Icon(
              icon,
              size: 20,
              color: isFinalNode ? AppColors.white : AppColors.intentText,
            ),
    );
  }
}
