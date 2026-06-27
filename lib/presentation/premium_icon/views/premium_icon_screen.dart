import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:intent_app/app/routes/app_routes.dart';
import 'package:intent_app/presentation/auth/widgets/shared/fixed_background_auth_scaffold.dart';
import 'package:intent_app/presentation/premium_icon/widgets/premium_icon_header.dart';
import 'package:intent_app/presentation/premium_icon/widgets/premium_icon_sections.dart';

class PremiumIconScreen extends StatefulWidget {
  const PremiumIconScreen({super.key});

  @override
  State<PremiumIconScreen> createState() => _PremiumIconScreenState();
}

class _PremiumIconScreenState extends State<PremiumIconScreen> {
  PremiumIconOption _selectedIcon = PremiumIconOption.moon;

  void _onBack(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(AppRoutes.connectionPlus);
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
            PremiumIconHeader(
              onBack: () => _onBack(context),
            ),
            const SizedBox(height: 16),
            const PremiumIconIntroSection(),
            const SizedBox(height: 20),
            PremiumIconPreviewCard(selected: _selectedIcon),
            const SizedBox(height: 16),
            PremiumIconSelectionSection(
              selected: _selectedIcon,
              onSelected: (icon) => setState(() => _selectedIcon = icon),
            ),
            const SizedBox(height: 16),
            const PremiumIconPricingCard(),
            const SizedBox(height: 14),
            const PremiumIconPrivacyCard(),
            const SizedBox(height: 20),
            PremiumIconUnlockButton(
              onPressed: () => _onBack(context),
            ),
            const SizedBox(height: 14),
            PremiumIconKeepDefaultLink(
              onTap: () => _onBack(context),
            ),
          ],
        ),
      ),
    );
  }
}
