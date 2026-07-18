import 'package:flutter/material.dart';

import 'package:intent_app/app/theme/theme.dart';
import 'package:intent_app/core/widgets/custom_bottom_nav.dart';
import 'package:intent_app/presentation/auth/widgets/login/login_background_decor.dart';

/// Discover shell with cream background, scrollable body, and pinned bottom nav.
///
/// When [topBar] is set, it scrolls with [child] as part of one continuous page.
/// When [hideChromeOnScroll] is true, scrolling down hides the bottom navigation;
/// scrolling up reveals it again.
class DiscoverScaffold extends StatefulWidget {
  const DiscoverScaffold({
    super.key,
    required this.child,
    required this.bottomNavigationBar,
    this.topBar,
    this.hideChromeOnScroll = false,
    this.padding = const EdgeInsets.fromLTRB(16, 8, 16, 24),
  });

  final Widget child;
  final Widget bottomNavigationBar;
  final Widget? topBar;
  final bool hideChromeOnScroll;
  final EdgeInsetsGeometry padding;

  @override
  State<DiscoverScaffold> createState() => _DiscoverScaffoldState();
}

class _DiscoverScaffoldState extends State<DiscoverScaffold> {
  static const Duration _chromeAnimationDuration = Duration(milliseconds: 250);

  bool _chromeVisible = true;

  void _setChromeVisible(bool visible) {
    if (_chromeVisible == visible) {
      return;
    }
    setState(() => _chromeVisible = visible);
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (!widget.hideChromeOnScroll) {
      return false;
    }
    if (notification.metrics.axis != Axis.vertical) {
      return false;
    }

    if (notification is ScrollUpdateNotification) {
      final pixels = notification.metrics.pixels;
      final delta = notification.scrollDelta ?? 0;

      if (pixels <= 0) {
        _setChromeVisible(true);
      } else if (delta > 1.5) {
        _setChromeVisible(false);
      } else if (delta < -1.5) {
        _setChromeVisible(true);
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final navHeight = DiscoverBottomNav.totalHeight(context);
    final bottomPadding = _chromeVisible
        ? navHeight
        : MediaQuery.paddingOf(context).bottom;

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
                  child: NotificationListener<ScrollNotification>(
                    onNotification: _handleScrollNotification,
                    child: AnimatedPadding(
                      duration: _chromeAnimationDuration,
                      curve: Curves.easeOutCubic,
                      padding: EdgeInsets.only(bottom: bottomPadding),
                      child: SingleChildScrollView(
                        physics: const ClampingScrollPhysics(),
                        padding: widget.padding,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            if (widget.topBar != null) ...[
                              widget.topBar!,
                              const SizedBox(height: 8),
                            ],
                            widget.child,
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: AnimatedSlide(
                    duration: _chromeAnimationDuration,
                    curve: Curves.easeOutCubic,
                    offset: _chromeVisible
                        ? Offset.zero
                        : const Offset(0, 1),
                    child: widget.bottomNavigationBar,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
