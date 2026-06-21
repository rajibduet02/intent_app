import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intent_app/app/routes/app_routes.dart';
import 'package:intent_app/app/theme/theme.dart';
import 'package:intent_app/presentation/auth/widgets/login/login_background_decor.dart';
import 'package:intent_app/presentation/auth/widgets/login/login_brand_header.dart';
import 'package:intent_app/presentation/welcome/widgets/welcome_values_graphic.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.intentCream,
      body: Stack(
        fit: StackFit.expand,
        children: [
          const Positioned.fill(child: LoginBackgroundDecor()),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: Column(
                children: [
                  const SizedBox(height: AppSpacing.lg),
                  const IntentLogo(size: 64),
                  const SizedBox(height: AppSpacing.sm),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: IntentLoginStyles.welcomeHeadline,
                      children: [
                        const TextSpan(text: 'More '),
                        TextSpan(
                          text: 'chemistry',
                          style: IntentLoginStyles.welcomeHeadlineItalic,
                        ),
                        const TextSpan(text: '.\nLess guessing.'),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    'Meet through values, personality, and intention before photos are revealed.',
                    textAlign: TextAlign.center,
                    style: IntentLoginStyles.welcomeSubtext,
                  ),
                  const SizedBox(height: 24),
                  const WelcomeValuesGraphic(),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    height: AppSpacing.primaryButtonHeight,
                    child: ElevatedButton(
                      onPressed: () => context.go(AppRoutes.signup),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.intentForest,
                        elevation: 0,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            AppSpacing.primaryButtonBorderRadius,
                          ),
                        ),
                      ),
                      child: Text(
                        'Get Started',
                        style: IntentLoginStyles.welcomeGetStarted,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'PHOTOS UNLOCK ONLY WHEN REAL INTENTION IS SHOWN.',
                    textAlign: TextAlign.center,
                    style: IntentLoginStyles.welcomeFooter,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
