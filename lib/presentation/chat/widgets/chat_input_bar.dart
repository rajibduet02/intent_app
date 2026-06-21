import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';

class ChatInputBar extends StatelessWidget {
  const ChatInputBar({super.key});

  static const double contentHeight = 70;

  static double totalHeight(BuildContext context) {
    return contentHeight + MediaQuery.paddingOf(context).bottom;
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    return Container(
      padding: EdgeInsets.fromLTRB(16, 10, 16, 16 + bottomInset),
      decoration: BoxDecoration(
        color: AppColors.white.withValues(alpha: 0.96),
        border: Border(
          top: BorderSide(
            color: AppColors.intentInputBorder.withValues(alpha: 0.65),
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.intentCreamDeep.withValues(alpha: 0.9),
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.intentInputBorder.withValues(alpha: 0.55),
              ),
            ),
            child: const Icon(
              Icons.add,
              size: 22,
              color: AppColors.intentText,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              height: 44,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: AppColors.intentCreamDeep.withValues(alpha: 0.85),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: AppColors.intentInputBorder.withValues(alpha: 0.45),
                ),
              ),
              alignment: Alignment.centerLeft,
              child: Text(
                'Write a thoughtful message...',
                style: IntentLoginStyles.onboardingSubtitle.copyWith(
                  fontSize: 13,
                  color: AppColors.intentTextSoft,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            width: 44,
            height: 44,
            decoration: const BoxDecoration(
              color: AppColors.intentForest,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.send_rounded,
              size: 20,
              color: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }
}
