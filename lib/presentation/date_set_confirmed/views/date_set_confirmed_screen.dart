import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:intent_app/app/routes/app_routes.dart';
import 'package:intent_app/presentation/auth/widgets/shared/fixed_background_auth_scaffold.dart';
import 'package:intent_app/presentation/date_set_confirmed/widgets/date_set_confirmed_header.dart';
import 'package:intent_app/presentation/date_set_confirmed/widgets/date_set_confirmed_sections.dart';

class DateSetConfirmedScreen extends StatelessWidget {
  const DateSetConfirmedScreen({super.key});

  void _onBack(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(AppRoutes.previewPhoto);
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
            DateSetConfirmedHeader(
              onBack: () => _onBack(context),
            ),
            const SizedBox(height: 12),
            const DateSetConfirmedIntroText(),
            const SizedBox(height: 14),
            const Center(child: DateSetConfirmedBadge()),
            const SizedBox(height: 16),
            const DateSetConfirmedProfileCard(),
            const SizedBox(height: 20),
            const DateSetConfirmedPlanCard(),
            const SizedBox(height: 20),
            const DateSetConfirmedReminderSection(),
            const SizedBox(height: 20),
            const DateSetConfirmedSafetyToolsSection(),
            const SizedBox(height: 14),
            const DateSetConfirmedSafetyTip(),
            const SizedBox(height: 20),
            DateSetConfirmedBackToChatButton(
              onPressed: () => context.push(AppRoutes.dateReminder),
            ),
            const SizedBox(height: 14),
            DateSetConfirmedViewDetailsLink(
              onTap: () => context.push(AppRoutes.dateProposed),
            ),
          ],
        ),
      ),
    );
  }
}
