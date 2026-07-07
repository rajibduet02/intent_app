import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:intent_app/core/utils/chat_navigation.dart';
import 'package:intent_app/presentation/auth/widgets/shared/fixed_background_auth_scaffold.dart';
import 'package:intent_app/presentation/chat/providers/date_proposal_provider.dart';
import 'package:intent_app/presentation/preview_photo/widgets/preview_photo_header.dart';
import 'package:intent_app/presentation/preview_photo/widgets/preview_photo_sections.dart';

class PreviewPhotoScreen extends ConsumerWidget {
  const PreviewPhotoScreen({super.key});

  void _onBack(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    }
  }

  void _continueToChat(BuildContext context, WidgetRef ref) {
    ref.read(dateProposalProvider.notifier).confirmProposal();
    popToChat(context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FixedBackgroundAuthScaffold(
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            PreviewPhotoHeader(
              onBack: () => _onBack(context),
            ),
            const SizedBox(height: 12),
            const PreviewPhotoIntroSection(),
            const SizedBox(height: 18),
            const PreviewPhotoMainCard(),
            const SizedBox(height: 16),
            const PreviewPhotoGalleryPrivateCard(),
            const SizedBox(height: 14),
            const PreviewPhotoDateFlowProgressCard(),
            const SizedBox(height: 14),
            const PreviewPhotoSafetyTip(),
            const SizedBox(height: 20),
            PreviewPhotoContinueChatButton(
              onPressed: () => _continueToChat(context, ref),
            ),
          ],
        ),
      ),
    );
  }
}
