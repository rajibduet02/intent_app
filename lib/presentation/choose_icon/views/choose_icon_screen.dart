import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:intent_app/app/routes/app_routes.dart';
import 'package:intent_app/presentation/auth/widgets/shared/fixed_background_auth_scaffold.dart';
import 'package:intent_app/presentation/choose_icon/models/choose_icon_option.dart';
import 'package:intent_app/presentation/choose_icon/widgets/choose_icon_header.dart';
import 'package:intent_app/presentation/choose_icon/widgets/choose_icon_sections.dart';

class ChooseIconScreen extends StatefulWidget {
  const ChooseIconScreen({super.key});

  static const int maxSelections = 5;

  @override
  State<ChooseIconScreen> createState() => _ChooseIconScreenState();
}

class _ChooseIconScreenState extends State<ChooseIconScreen> {
  ChooseIconTab _selectedTab = ChooseIconTab.free;
  final Set<String> _selectedIds = {'mountain', 'music', 'travel'};

  void _onClose() {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(AppRoutes.matches);
    }
  }

  void _onIconTap(ChooseIconOption option) {
    if (option.isLocked || option.isPremium) {
      return;
    }

    setState(() {
      if (_selectedIds.contains(option.id)) {
        _selectedIds.remove(option.id);
      } else if (_selectedIds.length < ChooseIconScreen.maxSelections) {
        _selectedIds.add(option.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final showFreeGrid = _selectedTab == ChooseIconTab.free;

    return FixedBackgroundAuthScaffold(
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ChooseIconHeader(onClose: _onClose),
            const SizedBox(height: 12),
            const ChooseIconNewMatchHeader(),
            const SizedBox(height: 24),
            const ChooseIconInstructions(),
            const SizedBox(height: 16),
            ChooseIconTabBar(
              selectedTab: _selectedTab,
              onTabSelected: (tab) => setState(() => _selectedTab = tab),
            ),
            // const SizedBox(height: 8),
            const SizedBox(height: 16),
            if (showFreeGrid)
              ChooseIconGrid(
                icons: ChooseIconOption.freeIcons,
                selectedIds: _selectedIds,
                onIconTap: _onIconTap,
              )
            else
              ChooseIconGrid(
                icons: ChooseIconOption.premiumTabIcons,
                selectedIds: _selectedIds,
                onIconTap: _onIconTap,
              ),
            // const SizedBox(height: 16),
            const SizedBox(height: 0),
            Center(
              child: ChooseIconSelectionPill(
                selectedCount: _selectedIds.length,
                maxCount: ChooseIconScreen.maxSelections,
              ),
            ),
            const SizedBox(height: 24),
            const ChooseIconProfileSummary(),
            const SizedBox(height: 18),
            const ChooseIconWhyMatchedCard(),
            const SizedBox(height: 16),
            const ChooseIconIcebreakerSection(),
            const SizedBox(height: 14),
            const ChooseIconPhotoUnlockBanner(),
            const SizedBox(height: 20),
            ChooseIconActionButtons(
              onStartChat: () => context.push(AppRoutes.chat),
              onProposeDate: () => context.push(AppRoutes.proposeDate),
              onSaveForLater: _onClose,
            ),
          ],
        ),
      ),
    );
  }
}
