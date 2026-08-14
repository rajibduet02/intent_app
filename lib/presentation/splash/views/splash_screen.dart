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
  static const _dividerSlideDistance = 260.0;

  static const _dividerSlideStart = 0.24;
  static const _dividerSlideEnd = 0.50;
  static const _dividerEndFadeStart = 0.44;

  static const _closenessStart = 0.24;
  static const _closenessEnd = 0.50;
  static const _closenessTarget = 1.12;

  late final AnimationController _controller;

  late final Animation<double> _silhouetteOpacity;
  late final Animation<double> _iconIntroScale;
  late final Animation<double> _dividerRevealOpacity;
  late final Animation<double> _dividerSlideY;
  late final Animation<double> _dividerEndFade;
  late final Animation<double> _particlesOpacity;
  late final Animation<double> _closeness;
  late final Animation<double> _connectionGlow;
  late final Animation<double> _logoOpacity;
  late final Animation<double> _logoScale;
  late final Animation<double> _graphicFadeOut;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: AppAnimations.splashStory,
      vsync: this,
    );

    // Scene 1 — pair and divider fade in with a soft pop (0% → 20%).
    _silhouetteOpacity = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.20, curve: Curves.easeOutCubic),
    );

    _iconIntroScale = Tween<double>(begin: 0.88, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.22, curve: Curves.easeOutBack),
      ),
    );

    _dividerRevealOpacity = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.04, 0.20, curve: Curves.easeOutCubic),
    );

    // Scene 2 — divider drops; icons glide inward in sync (24% → 50%).
    _dividerSlideY = Tween<double>(
      begin: 0,
      end: _dividerSlideDistance,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          _dividerSlideStart,
          _dividerSlideEnd,
          curve: Curves.easeInOutCubic,
        ),
      ),
    );

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

    _closeness = Tween<double>(begin: 0, end: _closenessTarget).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          _closenessStart,
          _closenessEnd,
          curve: Curves.easeOutCubic,
        ),
      ),
    );

    // Scene 3 — golden connection pulse and sparkles (48% → 76%).
    _connectionGlow = TweenSequence<double>([
      TweenSequenceItem(tween: ConstantTween(0.0), weight: 48),
      TweenSequenceItem(
        tween: Tween(begin: 0.0, end: 1.0)
            .chain(CurveTween(curve: Curves.easeOutCubic)),
        weight: 8,
      ),
      TweenSequenceItem(tween: ConstantTween(1.0), weight: 6),
      TweenSequenceItem(
        tween: Tween(begin: 1.0, end: 0.35)
            .chain(CurveTween(curve: Curves.easeInOutCubic)),
        weight: 8,
      ),
      TweenSequenceItem(tween: ConstantTween(0.35), weight: 6),
      TweenSequenceItem(
        tween: Tween(begin: 0.35, end: 0.0)
            .chain(CurveTween(curve: Curves.easeInOutCubic)),
        weight: 8,
      ),
      TweenSequenceItem(tween: ConstantTween(0.0), weight: 16),
    ]).animate(_controller);

    _particlesOpacity = TweenSequence<double>([
      TweenSequenceItem(tween: ConstantTween(0.0), weight: 50),
      TweenSequenceItem(
        tween: Tween(begin: 0.0, end: 1.0)
            .chain(CurveTween(curve: Curves.easeOutCubic)),
        weight: 10,
      ),
      TweenSequenceItem(tween: ConstantTween(1.0), weight: 10),
      TweenSequenceItem(
        tween: Tween(begin: 1.0, end: 0.0)
            .chain(CurveTween(curve: Curves.easeInOutCubic)),
        weight: 12,
      ),
      TweenSequenceItem(tween: ConstantTween(0.0), weight: 18),
    ]).animate(_controller);

    // Scene 4 — brand reveal with a gentle rise (82% → 100%).
    _logoOpacity = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.82, 1.0, curve: Curves.easeOutCubic),
    );

    _logoScale = Tween<double>(begin: 0.90, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.82, 1.0, curve: Curves.easeOutBack),
      ),
    );

    // Pair fades as logo takes focus (76% → 88%).
    _graphicFadeOut = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.76, 0.88, curve: Curves.easeInOutCubic),
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
                          iconScale: _iconIntroScale.value,
                          connectionGlow: _connectionGlow.value,
                        ),
                      ),
                      Opacity(
                        opacity: logoOnly,
                        child: Transform.translate(
                          offset: Offset(0, (1 - logoOnly) * 14),
                          child: Transform.scale(
                            scale: _logoScale.value,
                            child: IntentBrandMark(
                              logoSize: SplashBranding.logoSize * 0.85,
                              title: 'Intent',
                              spacing: 0,
                              titleStyle: IntentLoginStyles.brandTitle,
                            ),
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
