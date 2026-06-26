import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:intent_app/app/routes/app_routes.dart';
import 'package:intent_app/presentation/auth/widgets/shared/fixed_background_auth_scaffold.dart';
import 'package:intent_app/presentation/full_gallery_unlocked/widgets/full_gallery_unlocked_header.dart';
import 'package:intent_app/presentation/full_gallery_unlocked/widgets/full_gallery_unlocked_sections.dart';

class FullGalleryUnlockedScreen extends StatelessWidget {
  const FullGalleryUnlockedScreen({super.key});

  void _onBack(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(AppRoutes.dateHappen);
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
            FullGalleryUnlockedHeader(
              onBack: () => _onBack(context),
            ),
            const SizedBox(height: 12),
            const FullGalleryUnlockedIntroSection(),
            const SizedBox(height: 16),
            const FullGalleryUnlockedProfileCard(),
            const SizedBox(height: 20),
            const FullGalleryUnlockedGallerySection(),
            const SizedBox(height: 18),
            const FullGalleryUnlockJourneyCard(),
            const SizedBox(height: 14),
            const FullGalleryUnlockedInfoCard(),
            const SizedBox(height: 4),
            const FullGalleryUnlockedReportRow(),
            const SizedBox(height: 20),
            FullGalleryUnlockedViewProfileButton(
              onPressed: () => context.push(AppRoutes.profilePreview),
            ),
            const SizedBox(height: 14),
            FullGalleryUnlockedContinueChatLink(
              onTap: () => context.push(AppRoutes.dateFeedback),
            ),
          ],
        ),
      ),
    );
  }
}
