import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';

enum MessagePresenceStatus {
  active,
  actionNeeded,
  inactive,
}

enum MessageConversationTagStyle {
  success,
  warning,
  read,
}

class MessageConversation {
  const MessageConversation({
    required this.name,
    required this.initial,
    required this.avatarColor,
    required this.initialColor,
    required this.compatibilityPercent,
    required this.lastMessage,
    required this.timeLabel,
    required this.statusLabel,
    required this.presenceStatus,
    required this.tagLabel,
    required this.tagIcon,
    required this.tagStyle,
    this.showCompatibility = true,
  });

  final String name;
  final String initial;
  final Color avatarColor;
  final Color initialColor;
  final int compatibilityPercent;
  final String lastMessage;
  final String timeLabel;
  final String statusLabel;
  final MessagePresenceStatus presenceStatus;
  final String tagLabel;
  final IconData tagIcon;
  final MessageConversationTagStyle tagStyle;
  final bool showCompatibility;
}

class MessageConversationCard extends StatelessWidget {
  const MessageConversationCard({
    super.key,
    required this.conversation,
    this.onTap,
  });

  final MessageConversation conversation;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final presenceColor = switch (conversation.presenceStatus) {
      MessagePresenceStatus.active => AppColors.success,
      MessagePresenceStatus.actionNeeded => AppColors.intentNotificationDot,
      MessagePresenceStatus.inactive => AppColors.intentTextSoft,
    };

    final compatibilityColor = conversation.presenceStatus ==
            MessagePresenceStatus.actionNeeded
        ? AppColors.intentNotificationDot
        : conversation.presenceStatus == MessagePresenceStatus.active
            ? AppColors.success
            : AppColors.intentTextSoft;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.intentCreamDeep.withValues(alpha: 0.65),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppColors.intentInputBorder.withValues(alpha: 0.45),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _ConversationAvatar(
                initial: conversation.initial,
                backgroundColor: conversation.avatarColor,
                foregroundColor: conversation.initialColor,
                presenceColor: presenceColor,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          conversation.name,
                          style: IntentLoginStyles.onboardingCardFieldLabel
                              .copyWith(fontSize: 14),
                        ),
                        if (conversation.showCompatibility) ...[
                          const SizedBox(width: 4),
                          Text(
                            '• ${conversation.compatibilityPercent}%',
                            style: IntentLoginStyles.onboardingSubtitle.copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: compatibilityColor,
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      conversation.lastMessage,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: IntentLoginStyles.onboardingSubtitle.copyWith(
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${conversation.timeLabel} • ${conversation.statusLabel}',
                      style: IntentLoginStyles.onboardingAssessmentCategory
                          .copyWith(
                        fontSize: 8,
                        letterSpacing: 0.8,
                        color: presenceColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _ConversationTag(
                    label: conversation.tagLabel,
                    icon: conversation.tagIcon,
                    style: conversation.tagStyle,
                  ),
                  const SizedBox(height: 12),
                  Icon(
                    Icons.chevron_right,
                    size: 18,
                    color: AppColors.intentTextSoft.withValues(alpha: 0.7),
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

class _ConversationAvatar extends StatelessWidget {
  const _ConversationAvatar({
    required this.initial,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.presenceColor,
  });

  final String initial;
  final Color backgroundColor;
  final Color foregroundColor;
  final Color presenceColor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: backgroundColor,
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.intentInputBorder.withValues(alpha: 0.4),
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            initial,
            style: IntentLoginStyles.onboardingCardFieldLabel.copyWith(
              fontSize: 18,
              color: foregroundColor,
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: presenceColor,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.white, width: 2),
            ),
          ),
        ),
      ],
    );
  }
}

class _ConversationTag extends StatelessWidget {
  const _ConversationTag({
    required this.label,
    required this.icon,
    required this.style,
  });

  final String label;
  final IconData icon;
  final MessageConversationTagStyle style;

  @override
  Widget build(BuildContext context) {
    if (style == MessageConversationTagStyle.read) {
      return Text(
        label,
        style: IntentLoginStyles.onboardingSubtitle.copyWith(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: AppColors.accentBlue,
          letterSpacing: 0.5,
        ),
      );
    }

    final isSuccess = style == MessageConversationTagStyle.success;
    final backgroundColor = isSuccess
        ? const Color(0xFFE4F0E6)
        : const Color(0xFFF8E8DF);
    final foregroundColor =
        isSuccess ? AppColors.intentForest : const Color(0xFFB07A62);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: foregroundColor),
          const SizedBox(width: 4),
          Text(
            label,
            style: IntentLoginStyles.onboardingAssessmentCategory.copyWith(
              fontSize: 7,
              letterSpacing: 0.6,
              color: foregroundColor,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
