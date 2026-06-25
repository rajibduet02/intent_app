import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:intent_app/app/routes/app_routes.dart';
import 'package:intent_app/presentation/auth/widgets/shared/fixed_background_auth_scaffold.dart';
import 'package:intent_app/presentation/preview_photo/widgets/preview_photo_header.dart';
import 'package:intent_app/presentation/preview_photo/widgets/preview_photo_sections.dart';

class PreviewPhotoScreen extends StatelessWidget {
  const PreviewPhotoScreen({super.key});

  void _onBack(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(AppRoutes.dateProposed);
    }
  }

  @override
  Widget build(BuildContext context) {
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
              onPressed: () => context.push(AppRoutes.dateSetConfirmed),
            ),
            const SizedBox(height: 14),
            PreviewPhotoViewProposalLink(
              onTap: () => context.push(AppRoutes.dateProposed),
            ),
          ],
        ),
      ),
    );
  }
}
