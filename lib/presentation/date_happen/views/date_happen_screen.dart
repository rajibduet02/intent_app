import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:intent_app/app/routes/app_routes.dart';
import 'package:intent_app/presentation/auth/widgets/shared/fixed_background_auth_scaffold.dart';
import 'package:intent_app/presentation/date_happen/widgets/date_happen_header.dart';
import 'package:intent_app/presentation/date_happen/widgets/date_happen_sections.dart';

class DateHappenScreen extends StatefulWidget {
  const DateHappenScreen({super.key});

  @override
  State<DateHappenScreen> createState() => _DateHappenScreenState();
}

class _DateHappenScreenState extends State<DateHappenScreen> {
  DateHappenedChoice _selected = DateHappenedChoice.yesMet;

  void _onBack(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(AppRoutes.dateReminder);
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
            DateHappenHeader(
              onBack: () => _onBack(context),
            ),
            const SizedBox(height: 12),
            const DateHappenIntroSection(),
            const SizedBox(height: 18),
            const DateHappenSummaryCard(),
            const SizedBox(height: 14),
            DateHappenChoiceCard(
              selected: _selected,
              onSelected: (choice) => setState(() => _selected = choice),
            ),
            const SizedBox(height: 14),
            const DateHappenSafetyNote(),
            const SizedBox(height: 20),
            DateHappenContinueButton(
              onPressed: () => context.push(AppRoutes.fullGalleryUnlocked),
            ),
            const SizedBox(height: 14),
            const DateHappenSafetyCenterLink(),
          ],
        ),
      ),
    );
  }
}
