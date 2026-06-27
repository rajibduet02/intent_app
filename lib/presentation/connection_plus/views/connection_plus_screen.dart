import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:intent_app/app/routes/app_routes.dart';
import 'package:intent_app/presentation/auth/widgets/shared/fixed_background_auth_scaffold.dart';
import 'package:intent_app/presentation/connection_plus/widgets/connection_plus_header.dart';
import 'package:intent_app/presentation/connection_plus/widgets/connection_plus_sections.dart';

class ConnectionPlusScreen extends StatelessWidget {
  const ConnectionPlusScreen({super.key});

  void _onBack(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(AppRoutes.reportUser);
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
            ConnectionPlusHeader(
              onBack: () => _onBack(context),
            ),
            const SizedBox(height: 16),
            const ConnectionPlusHeroSection(),
            const SizedBox(height: 20),
            const ConnectionPlusPricingCard(),
            const SizedBox(height: 20),
            const ConnectionPlusUnlockSection(),
            const SizedBox(height: 16),
            const ConnectionPlusComparisonRow(),
            const SizedBox(height: 14),
            const ConnectionPlusPrivacyCard(),
            const SizedBox(height: 20),
            ConnectionPlusUpgradeButton(
              onPressed: () => context.push(AppRoutes.premiumIcon),
            ),
            const SizedBox(height: 14),
            ConnectionPlusMaybeLaterLink(
              onTap: () => _onBack(context),
            ),
          ],
        ),
      ),
    );
  }
}
