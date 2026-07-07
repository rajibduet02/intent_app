import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:intent_app/core/utils/chat_navigation.dart';
import 'package:intent_app/presentation/auth/widgets/shared/fixed_background_auth_scaffold.dart';
import 'package:intent_app/presentation/report_user/widgets/report_user_header.dart';
import 'package:intent_app/presentation/report_user/widgets/report_user_sections.dart';

class ReportUserScreen extends StatefulWidget {
  const ReportUserScreen({super.key});

  @override
  State<ReportUserScreen> createState() => _ReportUserScreenState();
}

class _ReportUserScreenState extends State<ReportUserScreen> {
  ReportUserReason _selectedReason = ReportUserReason.harassment;
  bool _blockUser = true;
  bool _showScreenshot = true;
  final TextEditingController _detailsController = TextEditingController();

  @override
  void dispose() {
    _detailsController.dispose();
    super.dispose();
  }

  void _onBack(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    }
  }

  Future<void> _submitReport(BuildContext context) async {
    await showReportSubmittedDialog(context);
    if (!context.mounted) {
      return;
    }
    _onBack(context);
  }

  @override
  Widget build(BuildContext context) {
    return FixedBackgroundAuthScaffold(
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ReportUserHeader(
              onBack: () => _onBack(context),
            ),
            const SizedBox(height: 12),
            const ReportUserIntroSection(),
            const SizedBox(height: 16),
            const ReportUserProfileCard(),
            const SizedBox(height: 20),
            ReportUserReasonSection(
              selected: _selectedReason,
              onSelected: (reason) => setState(() => _selectedReason = reason),
            ),
            const SizedBox(height: 20),
            ReportUserDetailsSection(controller: _detailsController),
            const SizedBox(height: 20),
            ReportUserScreenshotSection(
              showThumbnail: _showScreenshot,
              onRemoveScreenshot: () => setState(() => _showScreenshot = false),
            ),
            const SizedBox(height: 14),
            ReportUserBlockSection(
              blockUser: _blockUser,
              onChanged: (value) => setState(() => _blockUser = value),
            ),
            const SizedBox(height: 14),
            const ReportUserPrivacyCard(),
            const SizedBox(height: 20),
            ReportUserSubmitButton(
              onPressed: () => _submitReport(context),
            ),
            const SizedBox(height: 14),
            ReportUserCancelLink(
              onTap: () => _onBack(context),
            ),
          ],
        ),
      ),
    );
  }
}
