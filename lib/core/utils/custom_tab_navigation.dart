import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:intent_app/app/routes/app_routes.dart';
import 'package:intent_app/core/widgets/custom_bottom_nav.dart';

void navigateCustomBottomNavTab(BuildContext context, CustomBottomNavTab tab) {
  switch (tab) {
    case CustomBottomNavTab.discover:
      context.go(AppRoutes.discover);
    case CustomBottomNavTab.profile:
      context.go(AppRoutes.profile);
    case CustomBottomNavTab.compatibility:
      context.go(AppRoutes.matches);
    case CustomBottomNavTab.dates:
      context.go(AppRoutes.dates);
    case CustomBottomNavTab.messages:
      context.go(AppRoutes.messages);
  }
}
