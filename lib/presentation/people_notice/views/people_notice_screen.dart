import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:intent_app/app/routes/app_routes.dart';
import 'package:intent_app/presentation/auth/widgets/shared/fixed_background_auth_scaffold.dart';
import 'package:intent_app/presentation/people_notice/widgets/people_notice_header.dart';
import 'package:intent_app/presentation/people_notice/widgets/people_notice_sections.dart';

class PeopleNoticeScreen extends StatelessWidget {
  const PeopleNoticeScreen({super.key});

  void _onBack(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(AppRoutes.dateFeedback);
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
            PeopleNoticeHeader(
              onBack: () => _onBack(context),
            ),
            const SizedBox(height: 12),
            const PeopleNoticeIntroSection(),
            const SizedBox(height: 16),
            const PeopleNoticeProfileCard(),
            const SizedBox(height: 14),
            const PeopleNoticeQualitiesCard(),
            const SizedBox(height: 14),
            const PeopleNoticeMostNoticedCard(),
            const SizedBox(height: 14),
            const PeopleNoticePrivateCard(),
            const SizedBox(height: 12),
            const PeopleNoticeCharacterCard(),
            const SizedBox(height: 20),
            PeopleNoticeContinueButton(
              onPressed: () => context.push(AppRoutes.safetyCenter),
            ),
            const SizedBox(height: 14),
            PeopleNoticeBackToProfileLink(
              onTap: () => context.push(AppRoutes.profilePreview),
            ),
          ],
        ),
      ),
    );
  }
}
