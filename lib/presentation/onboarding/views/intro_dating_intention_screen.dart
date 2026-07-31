import 'package:flutter/material.dart';
import 'package:intent_app/app/routes/app_router.dart';
import 'package:intent_app/app/routes/app_routes.dart';
import 'package:intent_app/presentation/onboarding/widgets/section_intro_page.dart';
import 'package:intent_app/presentation/onboarding/widgets/silhouette_pair_graphic.dart';

class IntroDatingIntentionScreen extends StatelessWidget {
  const IntroDatingIntentionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionIntroPage(
      title: 'What Intent is',
      subtitle:
          'Intent is a dating experience built around compatibility, values, '
          'and intention — so meaningful connection comes before appearance.',
      illustration: const SilhouettePairGraphic(
        height: 160,
        dividerOpacity: 0.7,
        particlesOpacity: 0.45,
        particleProgress: 0.4,
      ),
      onContinue: () => appRouter.go(AppRoutes.introConnectionBeforeAttraction),
    );
  }
}
