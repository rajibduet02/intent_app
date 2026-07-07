import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:intent_app/app/routes/app_routes.dart';
import 'package:intent_app/core/utils/chat_navigation.dart';
import 'package:intent_app/presentation/auth/widgets/shared/fixed_background_auth_scaffold.dart';
import 'package:intent_app/presentation/chat/models/date_proposal.dart';
import 'package:intent_app/presentation/chat/providers/date_proposal_provider.dart';
import 'package:intent_app/presentation/chat/widgets/chat_countdown_bar.dart';
import 'package:intent_app/presentation/chat/widgets/chat_gentle_prompts_section.dart';
import 'package:intent_app/presentation/chat/widgets/chat_header.dart';
import 'package:intent_app/presentation/chat/widgets/chat_input_bar.dart';
import 'package:intent_app/presentation/chat/widgets/chat_message_list.dart';
import 'package:intent_app/presentation/chat/widgets/chat_propose_date_card.dart';
import 'package:intent_app/presentation/chat/widgets/chat_safety_card.dart';
import 'package:intent_app/presentation/chat/widgets/date_proposal_card.dart';

class ChatScreen extends ConsumerWidget {
  const ChatScreen({super.key});

  static const List<ChatMessage> _messages = [
    ChatMessage(
      type: ChatMessageType.received,
      text:
          'I really appreciated how thoughtfully you answered the values '
          'questions. It feels like we are aligned on what matters.',
      time: '10:14 AM',
      senderInitial: 'J',
    ),
    ChatMessage(
      type: ChatMessageType.sent,
      text:
          'That means a lot. I am looking for something intentional too, and '
          'I liked hearing about your approach to family and faith.',
      time: '10:18 AM',
      showReadReceipt: true,
    ),
    ChatMessage(
      type: ChatMessageType.received,
      text:
          'Would you be open to continuing the conversation here for a little '
          'while before we think about meeting?',
      time: '10:22 AM',
      senderInitial: 'J',
    ),
  ];

  static const List<ChatGentlePrompt> _prompts = [
    ChatGentlePrompt(
      icon: Icons.chat_bubble_outline,
      title: 'Ask about shared values',
      subtitle: 'What does a meaningful relationship look like to you?',
    ),
    ChatGentlePrompt(
      icon: Icons.favorite_border,
      title: 'Explore intentions',
      subtitle: 'What helped you choose a slower, intentional pace?',
    ),
    ChatGentlePrompt(
      icon: Icons.home_outlined,
      title: 'Talk about family',
      subtitle: 'How does family shape the kind of partner you hope to build with?',
    ),
  ];

  Future<void> _handleDecline(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final confirmed = await showDeclineProposalDialog(context);
    if (!confirmed || !context.mounted) {
      return;
    }
    ref.read(dateProposalProvider.notifier).declineProposal();
    popToChat(context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final proposal = ref.watch(dateProposalProvider).proposal;
    final showProposeCta = proposal == null ||
        proposal.status == DateProposalStatus.declined;

    return FixedBackgroundAuthScaffold(
      extendPinnedFooterToBottom: true,
      pinnedFooterExtent: ChatInputBar.totalHeight(context),
      pinnedFooter: const ChatInputBar(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ChatHeader(
            onBack: () => context.pop(),
          ),
          const ChatCountdownBar(),
          Expanded(
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const ChatMessageList(messages: _messages),
                  if (proposal != null)
                    DateProposalCard(
                      proposal: proposal,
                      onTap: !proposal.isSentByMe &&
                              proposal.status == DateProposalStatus.pending
                          ? () => context.push(AppRoutes.dateProposed)
                          : null,
                      onAccept: !proposal.isSentByMe &&
                              proposal.status == DateProposalStatus.pending
                          ? () {
                              ref
                                  .read(dateProposalProvider.notifier)
                                  .acceptProposal();
                              context.push(AppRoutes.previewPhoto);
                            }
                          : null,
                      onSuggestNewTime: !proposal.isSentByMe &&
                              proposal.status == DateProposalStatus.pending
                          ? () => context.push(AppRoutes.proposeDate)
                          : null,
                      onDecline: !proposal.isSentByMe &&
                              proposal.status == DateProposalStatus.pending
                          ? () => _handleDecline(context, ref)
                          : null,
                    ),
                  const ChatGentlePromptsSection(prompts: _prompts),
                  ChatSafetyCard(
                    onTap: () => context.push(AppRoutes.safetyCenter),
                  ),
                  if (showProposeCta)
                    ChatProposeDateCard(
                      onTap: () => context.push(AppRoutes.proposeDate),
                    ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
