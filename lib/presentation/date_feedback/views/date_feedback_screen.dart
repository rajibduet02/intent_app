import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:intent_app/app/routes/app_routes.dart';
import 'package:intent_app/presentation/auth/widgets/shared/fixed_background_auth_scaffold.dart';
import 'package:intent_app/presentation/date_feedback/widgets/date_feedback_header.dart';
import 'package:intent_app/presentation/date_feedback/widgets/date_feedback_sections.dart';

class DateFeedbackScreen extends StatefulWidget {
  const DateFeedbackScreen({super.key});

  @override
  State<DateFeedbackScreen> createState() => _DateFeedbackScreenState();
}

class _DateFeedbackScreenState extends State<DateFeedbackScreen> {
  DateFeedbackFeeling? _selectedFeeling;
  final Set<String> _selectedQualities = {};

  void _onBack(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(AppRoutes.fullGalleryUnlocked);
    }
  }

  void _toggleQuality(String quality) {
    setState(() {
      if (_selectedQualities.contains(quality)) {
        _selectedQualities.remove(quality);
      } else {
        _selectedQualities.add(quality);
      }
    });
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
            DateFeedbackHeader(
              onBack: () => _onBack(context),
            ),
            const SizedBox(height: 12),
            const DateFeedbackIntroSection(),
            const SizedBox(height: 18),
            const DateFeedbackSummaryCard(),
            const SizedBox(height: 20),
            DateFeedbackFeelingSection(
              selected: _selectedFeeling,
              onSelected: (feeling) =>
                  setState(() => _selectedFeeling = feeling),
            ),
            const SizedBox(height: 20),
            DateFeedbackQualitiesSection(
              selectedQualities: _selectedQualities,
              onToggle: _toggleQuality,
            ),
            const SizedBox(height: 16),
            const DateFeedbackPrivacyNote(),
            const SizedBox(height: 12),
            const DateFeedbackSafetyCard(),
            const SizedBox(height: 20),
            DateFeedbackSubmitButton(
              onPressed: () => context.push(AppRoutes.peopleNotice),
            ),
            const SizedBox(height: 14),
            DateFeedbackSkipLink(
              onTap: () => context.push(AppRoutes.chat),
            ),
          ],
        ),
      ),
    );
  }
}
