import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:intent_app/app/routes/app_routes.dart';
import 'package:intent_app/presentation/auth/widgets/shared/fixed_background_auth_scaffold.dart';
import 'package:intent_app/presentation/date_proposed/widgets/date_proposed_header.dart';
import 'package:intent_app/presentation/date_proposed/widgets/date_proposed_sections.dart';

class DateProposedScreen extends StatelessWidget {
  const DateProposedScreen({super.key});

  void _onBack(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(AppRoutes.proposeDate);
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
            DateProposedHeader(
              onBack: () => _onBack(context),
            ),
            const SizedBox(height: 12),
            const DateProposedIntroText(),
            const SizedBox(height: 18),
            const DateProposedMatchSummary(),
            const SizedBox(height: 20),
            const DateProposedPlanCard(),
            const SizedBox(height: 16),
            const DateProposedPhotoReleaseNote(),
            const SizedBox(height: 14),
            const DateProposedSafetyCard(),
            const SizedBox(height: 18),
            DateProposedAcceptButton(
              onPressed: () => context.push(AppRoutes.previewPhoto),
            ),
            const SizedBox(height: 12),
            DateProposedSuggestTimeButton(
              onPressed: () => context.push(AppRoutes.proposeDate),
            ),
            const SizedBox(height: 12),
            DateProposedDeclineButton(
              onPressed: () => _onBack(context),
            ),
            const SizedBox(height: 14),
            const DateProposedPrivacyFooter(),
          ],
        ),
      ),
    );
  }
}
