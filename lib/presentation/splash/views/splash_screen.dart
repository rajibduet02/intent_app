import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intent_app/app/routes/app_routes.dart';
import 'package:intent_app/app/theme/theme.dart';
import 'package:intent_app/core/constants/splash_branding.dart';
import 'package:intent_app/presentation/auth/widgets/login/login_background_decor.dart';
import 'package:intent_app/presentation/auth/widgets/login/login_brand_header.dart';
import 'package:intent_app/presentation/onboarding/widgets/silhouette_pair_graphic.dart';

/// Symbolic splash: separated pair → barrier slides away → connect → logo.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  static const _dividerSlideDistance = 240.0;

  /// Last 15% of divider travel — optional subtle fade near exit.
  static const _dividerSlideEnd = 0.48;
  static const _dividerEndFadeStart = 0.45;

  /// Icons converge as the divider drops (28% → 48%).
  static const _closenessStart = 0.28;
  static const _closenessEnd = 0.48;
  static const _closenessTarget = 1.12;

  late final AnimationController _controller;

  late final Animation<double> _silhouetteOpacity;
  late final Animation<double> _dividerRevealOpacity;
  late final Animation<double> _dividerSlideY;
  late final Animation<double> _dividerEndFade;
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

    // Scene 1 — silhouettes and divider fade in (0% → 18%).
    _silhouetteOpacity = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.18, curve: Curves.easeOutCubic),
    );

    _dividerRevealOpacity = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.18, curve: Curves.easeOutCubic),
    );

    // Scene 3 — divider slides downward; icons move closer in sync (28% → 48%).
    _dividerSlideY = Tween<double>(
      begin: 0,
      end: _dividerSlideDistance,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.28, 0.48, curve: Curves.easeInOutCubic),
      ),
    );

    // Subtle fade only during the last 15% of divider travel.
    _dividerEndFade = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          _dividerEndFadeStart,
          _dividerSlideEnd,
          curve: Curves.easeInOutCubic,
        ),
      ),
    );

    // Scene 6 — connection particles fade in gently (64% → 80%).
    _particlesOpacity = TweenSequence<double>([
      TweenSequenceItem(tween: ConstantTween(0.0), weight: 64),
      TweenSequenceItem(
        tween: Tween(begin: 0.0, end: 1.0)
            .chain(CurveTween(curve: Curves.easeOutCubic)),
        weight: 16,
      ),
      TweenSequenceItem(tween: ConstantTween(1.0), weight: 8),
      TweenSequenceItem(
        tween: Tween(begin: 1.0, end: 0.0)
            .chain(CurveTween(curve: Curves.easeInOutCubic)),
        weight: 7,
      ),
      TweenSequenceItem(tween: ConstantTween(0.0), weight: 5),
    ]).animate(_controller);

    // Icons close the gap while the divider exits.
    _closeness = Tween<double>(begin: 0, end: _closenessTarget).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          _closenessStart,
          _closenessEnd,
          curve: Curves.easeInOutCubic,
        ),
      ),
    );

    // Scene 9 — brand reveal after the story concludes (92% → 100%).
    _logoOpacity = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.92, 1.0, curve: Curves.easeOutCubic),
    );

    // Scene 8 — silhouettes and particles fade out (88% → 95%).
    _graphicFadeOut = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.88, 0.95, curve: Curves.easeInOutCubic),
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
              final dividerOpacity = _controller.value >= _dividerSlideEnd
                  ? 0.0
                  : _dividerRevealOpacity.value *
                      (_controller.value >= _dividerEndFadeStart
                          ? _dividerEndFade.value
                          : 1.0);

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
                          dividerOpacity: dividerOpacity,
                          dividerSlideY: _dividerSlideY.value,
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
