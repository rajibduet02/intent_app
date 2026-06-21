import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';

enum ChatMessageType {
  received,
  sent,
}

class ChatMessage {
  const ChatMessage({
    required this.type,
    required this.text,
    required this.time,
    this.showReadReceipt = false,
    this.senderInitial = 'J',
  });

  final ChatMessageType type;
  final String text;
  final String time;
  final bool showReadReceipt;
  final String senderInitial;
}

class ChatMessageList extends StatelessWidget {
  const ChatMessageList({
    super.key,
    required this.messages,
    this.dateLabel = 'Today',
  });

  final List<ChatMessage> messages;
  final String dateLabel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Column(
        children: [
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              decoration: BoxDecoration(
                color: AppColors.intentCreamDeep.withValues(alpha: 0.85),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Text(
                dateLabel,
                style: IntentLoginStyles.onboardingSubtitle.copyWith(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          for (final message in messages) ...[
            if (message.type == ChatMessageType.received)
              _ReceivedBubble(message: message)
            else
              _SentBubble(message: message),
            const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }
}

class _ReceivedBubble extends StatelessWidget {
  const _ReceivedBubble({required this.message});

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: const BoxDecoration(
            color: AppColors.intentForest,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text(
            message.senderInitial,
            style: IntentLoginStyles.onboardingSubtitle.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: AppColors.white,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.intentCreamDeep.withValues(alpha: 0.9),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                    bottomLeft: Radius.circular(4),
                  ),
                  border: Border.all(
                    color: AppColors.intentInputBorder.withValues(alpha: 0.45),
                  ),
                ),
                child: Text(
                  message.text,
                  style: IntentLoginStyles.onboardingSubtitle.copyWith(
                    fontSize: 13,
                    height: 1.45,
                    color: AppColors.intentText,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Text(
                  message.time,
                  style: IntentLoginStyles.onboardingSubtitle.copyWith(
                    fontSize: 10,
                    color: AppColors.intentTextSoft,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SentBubble extends StatelessWidget {
  const _SentBubble({required this.message});

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.sizeOf(context).width * 0.72,
        ),
        child: Container(
          padding: const EdgeInsets.fromLTRB(14, 12, 14, 10),
          decoration: BoxDecoration(
            color: AppColors.intentForest,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(4),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                message.text,
                style: IntentLoginStyles.onboardingSubtitle.copyWith(
                  fontSize: 13,
                  height: 1.45,
                  color: AppColors.white,
                ),
              ),
              const SizedBox(height: 6),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    message.time,
                    style: IntentLoginStyles.onboardingSubtitle.copyWith(
                      fontSize: 10,
                      color: AppColors.white.withValues(alpha: 0.75),
                    ),
                  ),
                  if (message.showReadReceipt) ...[
                    const SizedBox(width: 4),
                    Icon(
                      Icons.done_all,
                      size: 14,
                      color: AppColors.white.withValues(alpha: 0.85),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
