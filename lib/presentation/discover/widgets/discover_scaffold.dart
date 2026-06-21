import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';
import 'package:intent_app/core/widgets/custom_bottom_nav.dart';
import 'package:intent_app/presentation/auth/widgets/login/login_background_decor.dart';

/// Discover shell with fixed cream background and pinned bottom navigation.
class DiscoverScaffold extends StatelessWidget {
  const DiscoverScaffold({
    super.key,
    required this.child,
    required this.bottomNavigationBar,
  });

  final Widget child;
  final Widget bottomNavigationBar;

  @override
  Widget build(BuildContext context) {
    final navHeight = DiscoverBottomNav.totalHeight(context);

    return Scaffold(
      backgroundColor: AppColors.intentCream,
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        children: [
          const Positioned.fill(child: LoginBackgroundDecor()),
          SafeArea(
            bottom: false,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: navHeight),
                    child: child,
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: bottomNavigationBar,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
