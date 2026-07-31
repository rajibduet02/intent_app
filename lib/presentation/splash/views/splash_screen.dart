import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intent_app/app/routes/app_routes.dart';
import 'package:intent_app/app/theme/theme.dart';
import 'package:intent_app/core/constants/splash_branding.dart';
import 'package:intent_app/presentation/auth/widgets/login/login_background_decor.dart';
import 'package:intent_app/presentation/auth/widgets/login/login_brand_header.dart';
import 'package:intent_app/presentation/onboarding/widgets/silhouette_pair_graphic.dart';

/// Symbolic splash: silhouettes → divider → particles → closer → logo → welcome.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  late final Animation<double> _silhouetteOpacity;
  late final Animation<double> _dividerOpacity;
  late final Animation<double> _particlesOpacity;
  late final Animation<double> _closeness;
  late final Animation<double> _logoOpacity;
  late final Animation<double> _graphicFadeOut;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: AppAnimations.splashStory,
      vsync: this,
    );

    _silhouetteOpacity = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.18, curve: Curves.easeOutCubic),
    );

    _dividerOpacity = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(begin: 0.0, end: 1.0)
            .chain(CurveTween(curve: Curves.easeOutCubic)),
        weight: 28,
      ),
      TweenSequenceItem(
        tween: ConstantTween(1.0),
        weight: 22,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 1.0, end: 0.0)
            .chain(CurveTween(curve: Curves.easeInOutCubic)),
        weight: 30,
      ),
      TweenSequenceItem(
        tween: ConstantTween(0.0),
        weight: 20,
      ),
    ]).animate(_controller);

    _particlesOpacity = TweenSequence<double>([
      TweenSequenceItem(tween: ConstantTween(0.0), weight: 22),
      TweenSequenceItem(
        tween: Tween(begin: 0.0, end: 1.0)
            .chain(CurveTween(curve: Curves.easeOutCubic)),
        weight: 18,
      ),
      TweenSequenceItem(tween: ConstantTween(1.0), weight: 30),
      TweenSequenceItem(
        tween: Tween(begin: 1.0, end: 0.35)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 30,
      ),
    ]).animate(_controller);

    _closeness = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.52, 0.78, curve: Curves.easeInOutCubic),
    );

    _logoOpacity = CurvedAnimation(
      parent: _controller,
      // The pair finishes moving together at 0.78. Reveal the brand only
      // after that moment so the animation reads as one clear sequence.
      curve: const Interval(0.82, 0.96, curve: Curves.easeOutCubic),
    );

    _graphicFadeOut = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.78, 0.9, curve: Curves.easeInOutCubic),
    );

    unawaited(_runSplashSequence());
  }

  Future<void> _runSplashSequence() async {
    await _controller.forward();
    await Future<void>.delayed(AppAnimations.splashExitHold);
    if (!mounted) return;
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
          AnimatedBuilder(
            animation: _controller,
            builder: (context, _) {
              final silhouetteFade =
                  _silhouetteOpacity.value * (1 - _graphicFadeOut.value);
              final logoOnly = _logoOpacity.value;

              return Center(
                child: SizedBox(
                  height: 260,
                  width: double.infinity,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Opacity(
                        opacity: silhouetteFade.clamp(0.0, 1.0),
                        child: SilhouettePairGraphic(
                          height: 220,
                          dividerOpacity: _dividerOpacity.value,
                          closeness: _closeness.value,
                          particlesOpacity: _particlesOpacity.value,
                          particleProgress: _controller.value,
                        ),
                      ),
                      Opacity(
                        opacity: logoOnly,
                        child: Transform.translate(
                          offset: Offset(0, (1 - logoOnly) * 8),
                          child: IntentBrandMark(
                            logoSize: SplashBranding.logoSize * 0.85,
                            title: 'Intent',
                            spacing: 0,
                            titleStyle: IntentLoginStyles.brandTitle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
