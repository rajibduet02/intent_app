import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:intent_app/app/routes/app_routes.dart';
import 'package:intent_app/core/utils/chat_navigation.dart';
import 'package:intent_app/presentation/auth/widgets/shared/fixed_background_auth_scaffold.dart';
import 'package:intent_app/presentation/chat/providers/date_proposal_provider.dart';
import 'package:intent_app/presentation/date_proposed/widgets/date_proposed_header.dart';
import 'package:intent_app/presentation/date_proposed/widgets/date_proposed_sections.dart';

class DateProposedScreen extends ConsumerWidget {
  const DateProposedScreen({super.key});

  void _onBack(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    }
  }

  Future<void> _handleDecline(BuildContext context, WidgetRef ref) async {
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

    return FixedBackgroundAuthScaffold(
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DateProposedHeader(
              onBack: () => _onBack(context),
            ),
            const SizedBox(height: 12),
            const DateProposedIntroText(),
            const SizedBox(height: 18),
            const DateProposedMatchSummary(),
            const SizedBox(height: 20),
            DateProposedPlanCard(proposal: proposal),
            const SizedBox(height: 16),
            const DateProposedPhotoReleaseNote(),
            const SizedBox(height: 14),
            const DateProposedSafetyCard(),
            const SizedBox(height: 18),
            DateProposedAcceptButton(
              onPressed: () {
                ref.read(dateProposalProvider.notifier).acceptProposal();
                context.push(AppRoutes.previewPhoto);
              },
            ),
            const SizedBox(height: 12),
            DateProposedSuggestTimeButton(
              onPressed: () => context.push(AppRoutes.proposeDate),
            ),
            const SizedBox(height: 12),
            DateProposedDeclineButton(
              onPressed: () => _handleDecline(context, ref),
            ),
            const SizedBox(height: 14),
            const DateProposedPrivacyFooter(),
          ],
        ),
      ),
    );
  }
}
