import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:intent_app/app/routes/app_routes.dart';
import 'package:intent_app/app/theme/theme.dart';
import 'package:intent_app/presentation/auth/widgets/shared/fixed_background_auth_scaffold.dart';
import 'package:intent_app/presentation/messages/data/messages_sample_conversations.dart';
import 'package:intent_app/presentation/messages/widgets/message_conversation_card.dart';
import 'package:intent_app/presentation/profile/widgets/profile_screen_header.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  List<MessageConversation> get _results {
    final query = _controller.text.trim().toLowerCase();
    if (query.isEmpty) return const [];

    return messageSampleConversations.where((conversation) {
      return conversation.name.toLowerCase().contains(query) ||
          conversation.lastMessage.toLowerCase().contains(query);
    }).toList();
  }

  void _onBack() {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(AppRoutes.messages);
    }
  }

  @override
  Widget build(BuildContext context) {
    final results = _results;
    final query = _controller.text.trim();

    return FixedBackgroundAuthScaffold(
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ProfileScreenHeader(
              title: 'Search',
              onBack: _onBack,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _controller,
              focusNode: _focusNode,
              onChanged: (_) => setState(() {}),
              textInputAction: TextInputAction.search,
              style: IntentLoginStyles.onboardingSubtitle.copyWith(
                fontSize: 15,
                color: AppColors.intentText,
              ),
              decoration: InputDecoration(
                hintText: 'Search conversations',
                hintStyle: IntentLoginStyles.onboardingSubtitle.copyWith(
                  fontSize: 15,
                  color: AppColors.intentTextSoft,
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  color: AppColors.intentTextSoft,
                ),
                suffixIcon: query.isEmpty
                    ? null
                    : IconButton(
                        onPressed: () {
                          _controller.clear();
                          setState(() {});
                        },
                        icon: const Icon(
                          Icons.close,
                          color: AppColors.intentTextSoft,
                        ),
                      ),
                filled: true,
                fillColor: AppColors.white,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide(color: AppColors.intentInputBorder),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide(color: AppColors.intentInputBorder),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(
                    color: AppColors.intentForest,
                    width: 1.5,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (query.isNotEmpty && results.isEmpty)
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'No conversations found for "$query".',
                  style: IntentLoginStyles.onboardingSubtitle,
                ),
              )
            else if (query.isNotEmpty)
              for (var i = 0; i < results.length; i++) ...[
                if (i > 0) const SizedBox(height: 10),
                MessageConversationCard(
                  conversation: results[i],
                  onTap: () => context.push(AppRoutes.chat),
                ),
              ],
          ],
        ),
      ),
    );
  }
}
