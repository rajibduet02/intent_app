import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:intent_app/app/routes/app_routes.dart';
import 'package:intent_app/presentation/auth/widgets/shared/fixed_background_auth_scaffold.dart';
import 'package:intent_app/presentation/safety_center/widgets/safety_center_header.dart';
import 'package:intent_app/presentation/safety_center/widgets/safety_center_sections.dart';

class SafetyCenterScreen extends StatelessWidget {
  const SafetyCenterScreen({super.key});

  void _onBack(BuildContext context) {
    if (context.canPop()) {
      context.pop();
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
            SafetyCenterHeader(
              onBack: () => _onBack(context),
            ),
            const SizedBox(height: 12),
            const SafetyCenterIntroSection(),
            const SizedBox(height: 20),
            const SafetyCenterToolsSection(),
            const SizedBox(height: 20),
            const SafetyCenterDatingTipsSection(),
            const SizedBox(height: 16),
            const SafetyCenterOffPlatformWarningCard(),
            const SizedBox(height: 20),
            const SafetyCenterRestrictedPolicySection(),
            const SizedBox(height: 14),
            const SafetyCenterPrivacyNoteCard(),
            const SizedBox(height: 12),
            const SafetyCenterEmergencyNoteCard(),
            const SizedBox(height: 20),
            SafetyCenterBackButton(
              onPressed: () => context.push(AppRoutes.reportUser),
            ),
          ],
        ),
      ),
    );
  }
}
