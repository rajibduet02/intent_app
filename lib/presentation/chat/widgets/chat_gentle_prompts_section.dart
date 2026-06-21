import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';

class ChatGentlePrompt {
  const ChatGentlePrompt({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  final String title;
  final String subtitle;
  final IconData icon;
}

class ChatGentlePromptsSection extends StatelessWidget {
  const ChatGentlePromptsSection({
    super.key,
    required this.prompts,
  });

  final List<ChatGentlePrompt> prompts;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.intentCreamDeep.withValues(alpha: 0.75),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.intentInputBorder.withValues(alpha: 0.5),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.auto_awesome,
                  size: 14,
                  color: AppColors.intentGold,
                ),
                const SizedBox(width: 6),
                Text(
                  'Gentle prompts',
                  style: IntentLoginStyles.onboardingCardFieldLabel.copyWith(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 132,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: prompts.length,
                separatorBuilder: (context, index) => const SizedBox(width: 10),
                itemBuilder: (context, index) {
                  return _PromptCard(prompt: prompts[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PromptCard extends StatelessWidget {
  const _PromptCard({required this.prompt});

  final ChatGentlePrompt prompt;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.intentCream.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppColors.intentInputBorder.withValues(alpha: 0.45),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(prompt.icon, size: 16, color: AppColors.intentForest),
              const Spacer(),
              Icon(Icons.star, size: 12, color: AppColors.intentGold),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            prompt.title,
            style: IntentLoginStyles.onboardingCardFieldLabel.copyWith(
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 4),
          Expanded(
            child: Text(
              prompt.subtitle,
              style: IntentLoginStyles.onboardingSubtitle.copyWith(
                fontSize: 11,
                height: 1.35,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Icon(
              Icons.chevron_right,
              size: 18,
              color: AppColors.intentTextSoft,
            ),
          ),
        ],
      ),
    );
  }
}
