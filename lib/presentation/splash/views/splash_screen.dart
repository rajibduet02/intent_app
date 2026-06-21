import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intent_app/app/routes/app_routes.dart';
import 'package:intent_app/app/theme/theme.dart';
import 'package:intent_app/presentation/auth/widgets/login/login_background_decor.dart';
import 'package:intent_app/presentation/auth/widgets/login/login_brand_header.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: AppAnimations.splashIntro,
      vsync: this,
    );
    final curved = CurvedAnimation(
      parent: _controller,
      curve: AppAnimations.enter,
    );
    _fade = Tween<double>(
      begin: AppAnimations.splashFadeBegin,
      end: AppAnimations.splashFadeEnd,
    ).animate(curved);
    _scale = Tween<double>(
      begin: AppAnimations.splashScaleBegin,
      end: AppAnimations.splashScaleEnd,
    ).animate(curved);

    unawaited(_runSplashSequence());
  }

  Future<void> _runSplashSequence() async {
    await _controller.forward();
    await Future<void>.delayed(AppAnimations.splashMinBranding);
    if (!mounted) {
      return;
    }
    context.go(AppRoutes.welcome);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.intentCream,
      body: Stack(
        fit: StackFit.expand,
        children: [
          const LoginBackgroundDecor(),
          Center(
            child: FadeTransition(
              opacity: _fade,
              child: ScaleTransition(
                scale: _scale,
                child: IntentBrandMark(
                  logoSize: 80,
                  title: 'Intent',
                  spacing: 0,
                  // titleStyle: IntentLoginStyles.brandTitle.copyWith(fontSize: 42),
                  titleStyle: IntentLoginStyles.brandTitle,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
