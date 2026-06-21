import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:intent_app/app/routes/app_routes.dart';
import 'package:intent_app/app/theme/theme.dart';
import 'package:intent_app/core/utils/custom_tab_navigation.dart';
import 'package:intent_app/core/widgets/custom_bottom_nav.dart';
import 'package:intent_app/presentation/discover/widgets/discover_scaffold.dart';
import 'package:intent_app/presentation/messages/widgets/message_conversation_card.dart';
import 'package:intent_app/presentation/messages/widgets/messages_filter_chips.dart';
import 'package:intent_app/presentation/messages/widgets/messages_header.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  MessagesFilter _selectedFilter = MessagesFilter.all;

  static const List<MessageConversation> _conversations = [
    MessageConversation(
      name: 'Emma',
      initial: 'E',
      avatarColor: Color(0xFFD8E8D4),
      initialColor: AppColors.intentForest,
      compatibilityPercent: 92,
      lastMessage: 'You: That sounds really thoughtful.',
      timeLabel: '2M AGO',
      statusLabel: 'ACTIVE NOW',
      presenceStatus: MessagePresenceStatus.active,
      tagLabel: 'DATE PROPOSED',
      tagIcon: Icons.calendar_today_outlined,
      tagStyle: MessageConversationTagStyle.success,
    ),
    MessageConversation(
      name: 'Sophia',
      initial: 'S',
      avatarColor: Color(0xFFE8DFD4),
      initialColor: AppColors.intentTextSoft,
      compatibilityPercent: 88,
      lastMessage: 'I loved what you shared about family values.',
      timeLabel: '1H AGO',
      statusLabel: 'ACTIVE NOW',
      presenceStatus: MessagePresenceStatus.active,
      tagLabel: 'DEEP CONVERSATION',
      tagIcon: Icons.chat_bubble_outline,
      tagStyle: MessageConversationTagStyle.success,
    ),
    MessageConversation(
      name: 'Olivia',
      initial: 'O',
      avatarColor: Color(0xFFF0E4D8),
      initialColor: AppColors.intentTextSoft,
      compatibilityPercent: 79,
      lastMessage: 'Would you be open to coffee this weekend?',
      timeLabel: '3H AGO',
      statusLabel: 'AWAITING REPLY',
      presenceStatus: MessagePresenceStatus.actionNeeded,
      tagLabel: 'AWAITING',
      tagIcon: Icons.schedule,
      tagStyle: MessageConversationTagStyle.warning,
    ),
    MessageConversation(
      name: 'Isabella',
      initial: 'I',
      avatarColor: Color(0xFFE6DDD4),
      initialColor: AppColors.intentTextSoft,
      compatibilityPercent: 85,
      lastMessage: 'Saturday at 6 works perfectly for me.',
      timeLabel: '5H AGO',
      statusLabel: 'ACTION NEEDED',
      presenceStatus: MessagePresenceStatus.actionNeeded,
      tagLabel: 'CONFIRMED',
      tagIcon: Icons.check_circle_outline,
      tagStyle: MessageConversationTagStyle.warning,
    ),
    MessageConversation(
      name: 'Maya',
      initial: 'M',
      avatarColor: Color(0xFFE8E8E8),
      initialColor: AppColors.intentTextSoft,
      compatibilityPercent: 0,
      lastMessage: 'Thanks for the thoughtful message.',
      timeLabel: '1D AGO',
      statusLabel: 'READ',
      presenceStatus: MessagePresenceStatus.inactive,
      tagLabel: 'READ',
      tagIcon: Icons.done_all,
      tagStyle: MessageConversationTagStyle.read,
      showCompatibility: false,
    ),
  ];

  List<MessageConversation> get _filteredConversations {
    return switch (_selectedFilter) {
      MessagesFilter.all => _conversations,
      MessagesFilter.unread =>
        _conversations.where((c) => c.tagStyle != MessageConversationTagStyle.read).toList(),
      MessagesFilter.blocked => const [],
    };
  }

  @override
  Widget build(BuildContext context) {
    final conversations = _filteredConversations;

    return DiscoverScaffold(
      bottomNavigationBar: DiscoverBottomNav(
        selectedTab: CustomBottomNavTab.messages,
        onTabSelected: (tab) => navigateCustomBottomNavTab(context, tab),
        messagesBadgeCount: 5,
      ),
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const MessagesHeader(),
            const SizedBox(height: 16),
            MessagesFilterChips(
              selectedFilter: _selectedFilter,
              onFilterSelected: (filter) =>
                  setState(() => _selectedFilter = filter),
            ),
            const SizedBox(height: 16),
            if (conversations.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 32),
                child: Text(
                  'No conversations in this filter yet.',
                  textAlign: TextAlign.center,
                  style: IntentLoginStyles.onboardingSubtitle,
                ),
              )
            else
              for (var i = 0; i < conversations.length; i++) ...[
                if (i > 0) const SizedBox(height: 10),
                MessageConversationCard(
                  conversation: conversations[i],
                  onTap: () => context.push(AppRoutes.chat),
                ),
              ],
          ],
        ),
      ),
    );
  }
}
