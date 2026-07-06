import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:intent_app/app/routes/app_routes.dart';
import 'package:intent_app/app/theme/theme.dart';
import 'package:intent_app/presentation/messages/data/messages_sample_conversations.dart';
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

  static const List<MessageConversation> _conversations =
      messageSampleConversations;

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
      topBar: MessagesHeader(
        onSearchTap: () => context.push(AppRoutes.search),
      ),
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
            const SizedBox(height: 8),
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
