import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:intent_app/app/routes/app_routes.dart';
import 'package:intent_app/presentation/auth/widgets/shared/fixed_background_auth_scaffold.dart';
import 'package:intent_app/presentation/date_reminder/widgets/date_reminder_header.dart';
import 'package:intent_app/presentation/date_reminder/widgets/date_reminder_sections.dart';

class DateReminderScreen extends StatelessWidget {
  const DateReminderScreen({super.key});

  void _onBack(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(AppRoutes.dateSetConfirmed);
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
            DateReminderHeader(
              onBack: () => _onBack(context),
            ),
            const SizedBox(height: 12),
            const DateReminderIntroSection(),
            const SizedBox(height: 20),
            const DateReminderDetailsCard(),
            const SizedBox(height: 14),
            const DateReminderActiveCard(),
            const SizedBox(height: 12),
            const DateReminderSafetyCard(),
            const SizedBox(height: 12),
            const DateReminderRefreshCard(),
            const SizedBox(height: 20),
            DateReminderOpenChatButton(
              onPressed: () => context.push(AppRoutes.dateHappen),
            ),
            const SizedBox(height: 12),
            const DateReminderViewSafetyTipsButton(),
          ],
        ),
      ),
    );
  }
}
