import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:intent_app/app/routes/app_route_guard.dart';
import 'package:intent_app/app/routes/app_routes.dart';
import 'package:intent_app/app/routes/auth_refresh_listenable.dart';
import 'package:intent_app/app/theme/app_animations.dart';
import 'package:intent_app/presentation/auth/views/forgot_password_screen.dart';
import 'package:intent_app/presentation/auth/views/login_screen.dart';
import 'package:intent_app/presentation/auth/views/reset_password_screen.dart';
import 'package:intent_app/presentation/auth/views/signup_screen.dart';
import 'package:intent_app/presentation/auth/views/verify_screen.dart';
import 'package:intent_app/presentation/onboarding/views/onboarding_1_screen.dart';
import 'package:intent_app/presentation/onboarding/views/onboarding_2_screen.dart';
import 'package:intent_app/presentation/onboarding/views/onboarding_3_screen.dart';
import 'package:intent_app/presentation/onboarding/views/mbti_assessment_screen.dart';
import 'package:intent_app/presentation/onboarding/views/mbti_assess_preview_screen.dart';
import 'package:intent_app/presentation/onboarding/views/onboarding_4_screen.dart';
import 'package:intent_app/presentation/onboarding/views/enneagram_assessment_screen.dart';
import 'package:intent_app/presentation/onboarding/views/enneagram_assess_preview_screen.dart';
import 'package:intent_app/presentation/onboarding/views/attachment_style_screen.dart';
import 'package:intent_app/presentation/onboarding/views/attachment_style_preview_screen.dart';
import 'package:intent_app/presentation/onboarding/views/love_language_screen.dart';
import 'package:intent_app/presentation/onboarding/views/profile_overview_screen.dart';
import 'package:intent_app/presentation/onboarding/views/photo_unlock_intention_screen.dart';
import 'package:intent_app/presentation/onboarding/views/upload_photos_screen.dart';
import 'package:intent_app/presentation/onboarding/views/choose_preview_photos_screen.dart';
import 'package:intent_app/presentation/onboarding/views/upload_id_screen.dart';
import 'package:intent_app/presentation/onboarding/views/safety_starts_screen.dart';
import 'package:intent_app/presentation/onboarding/views/face_verification_screen.dart';
import 'package:intent_app/presentation/onboarding/views/community_commitment_screen.dart';
import 'package:intent_app/presentation/discover/views/discover_screen.dart';
import 'package:intent_app/presentation/chat/views/chat_screen.dart';
import 'package:intent_app/presentation/compatibility/views/compatibility_overview_screen.dart';
import 'package:intent_app/presentation/matches/views/matches_screen.dart';
import 'package:intent_app/presentation/messages/views/messages_screen.dart';
import 'package:intent_app/presentation/profile/views/edit_profile_screen.dart';
import 'package:intent_app/presentation/profile/views/profile_screen.dart';
import 'package:intent_app/presentation/date_proposed/views/date_proposed_screen.dart';
import 'package:intent_app/presentation/date_set_confirmed/views/date_set_confirmed_screen.dart';
import 'package:intent_app/presentation/date_reminder/views/date_reminder_screen.dart';
import 'package:intent_app/presentation/date_happen/views/date_happen_screen.dart';
import 'package:intent_app/presentation/full_gallery_unlocked/views/full_gallery_unlocked_screen.dart';
import 'package:intent_app/presentation/preview_photo/views/preview_photo_screen.dart';
import 'package:intent_app/presentation/propose_date/views/propose_date_screen.dart';
import 'package:intent_app/presentation/profile_preview/views/profile_preview_screen.dart';
import 'package:intent_app/presentation/onboarding/views/intention_success_screen.dart';
import 'package:intent_app/presentation/notifications/views/notification_screen.dart';
import 'package:intent_app/presentation/settings/views/settings_screen.dart';
import 'package:intent_app/presentation/splash/views/splash_screen.dart';
import 'package:intent_app/presentation/choose_icon/views/choose_icon_screen.dart';
import 'package:intent_app/presentation/why_matches/views/why_matches_screen.dart';
import 'package:intent_app/presentation/welcome/views/welcome_screen.dart';

CustomTransitionPage<void> _fadePage({
  required LocalKey key,
  required Widget child,
}) {
  return CustomTransitionPage<void>(
    key: key,
    child: child,
    transitionDuration: AppAnimations.routeFade,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(opacity: animation, child: child);
    },
  );
}

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'root',
);

final GoRouter appRouter = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: AppRoutes.splash,
  refreshListenable: authRefreshListenable,
  redirect: (context, state) => AppRouteGuard.redirect(state),
  errorBuilder: (context, state) => const SplashScreen(),
  routes: [
    GoRoute(
      path: AppRoutes.splash,
      pageBuilder: (context, state) =>
          const NoTransitionPage(child: SplashScreen()),
    ),
    GoRoute(
      path: AppRoutes.welcome,
      pageBuilder: (context, state) =>
          _fadePage(key: state.pageKey, child: const WelcomeScreen()),
    ),
    GoRoute(
      path: AppRoutes.auth,
      pageBuilder: (context, state) =>
          _fadePage(key: state.pageKey, child: const LoginScreen()),
    ),
    GoRoute(
      path: AppRoutes.signup,
      pageBuilder: (context, state) =>
          _fadePage(key: state.pageKey, child: const SignupScreen()),
    ),
    GoRoute(
      path: AppRoutes.verify,
      pageBuilder: (context, state) =>
          _fadePage(key: state.pageKey, child: const VerifyScreen()),
    ),
    GoRoute(
      path: AppRoutes.forgotPassword,
      pageBuilder: (context, state) => _fadePage(
        key: state.pageKey,
        child: const ForgotPasswordScreen(),
      ),
    ),
    GoRoute(
      path: AppRoutes.resetPassword,
      pageBuilder: (context, state) => _fadePage(
        key: state.pageKey,
        child: const ResetPasswordScreen(),
      ),
    ),
    GoRoute(
      path: AppRoutes.onboarding1,
      pageBuilder: (context, state) =>
          _fadePage(key: state.pageKey, child: const Onboarding1Screen()),
    ),
    GoRoute(
      path: AppRoutes.onboarding2,
      pageBuilder: (context, state) =>
          _fadePage(key: state.pageKey, child: const Onboarding2Screen()),
    ),
    GoRoute(
      path: AppRoutes.onboarding3,
      pageBuilder: (context, state) =>
          _fadePage(key: state.pageKey, child: const Onboarding3Screen()),
    ),
    GoRoute(
      path: AppRoutes.onboarding4,
      pageBuilder: (context, state) =>
          _fadePage(key: state.pageKey, child: const Onboarding4Screen()),
    ),
    GoRoute(
      path: AppRoutes.mbtiAssessment,
      pageBuilder: (context, state) =>
          _fadePage(key: state.pageKey, child: const MbtiAssessmentScreen()),
    ),
    GoRoute(
      path: AppRoutes.enneagramAssessment,
      pageBuilder: (context, state) => _fadePage(
        key: state.pageKey,
        child: const EnneagramAssessmentScreen(),
      ),
    ),
    GoRoute(
      path: AppRoutes.enneagramAssessPreview,
      pageBuilder: (context, state) => _fadePage(
        key: state.pageKey,
        child: const EnneagramAssessPreviewScreen(),
      ),
    ),
    GoRoute(
      path: AppRoutes.attachmentStyle,
      pageBuilder: (context, state) => _fadePage(
        key: state.pageKey,
        child: const AttachmentStyleScreen(),
      ),
    ),
    GoRoute(
      path: AppRoutes.attachmentStylePreview,
      pageBuilder: (context, state) => _fadePage(
        key: state.pageKey,
        child: const AttachmentStylePreviewScreen(),
      ),
    ),
    GoRoute(
      path: AppRoutes.loveLanguage,
      pageBuilder: (context, state) => _fadePage(
        key: state.pageKey,
        child: const LoveLanguageScreen(),
      ),
    ),
    GoRoute(
      path: AppRoutes.profileOverview,
      pageBuilder: (context, state) => _fadePage(
        key: state.pageKey,
        child: const ProfileOverviewScreen(),
      ),
    ),
    GoRoute(
      path: AppRoutes.photoUnlockIntention,
      pageBuilder: (context, state) => _fadePage(
        key: state.pageKey,
        child: const PhotoUnlockIntentionScreen(),
      ),
    ),
    GoRoute(
      path: AppRoutes.uploadPhotos,
      pageBuilder: (context, state) => _fadePage(
        key: state.pageKey,
        child: const UploadPhotosScreen(),
      ),
    ),
    GoRoute(
      path: AppRoutes.choosePreviewPhotos,
      pageBuilder: (context, state) => _fadePage(
        key: state.pageKey,
        child: const ChoosePreviewPhotosScreen(),
      ),
    ),
    GoRoute(
      path: AppRoutes.uploadId,
      pageBuilder: (context, state) => _fadePage(
        key: state.pageKey,
        child: const UploadIdScreen(),
      ),
    ),
    GoRoute(
      path: AppRoutes.safetyStarts,
      pageBuilder: (context, state) => _fadePage(
        key: state.pageKey,
        child: const SafetyStartsScreen(),
      ),
    ),
    GoRoute(
      path: AppRoutes.faceVerification,
      pageBuilder: (context, state) => _fadePage(
        key: state.pageKey,
        child: const FaceVerificationScreen(),
      ),
    ),
    GoRoute(
      path: AppRoutes.communityCommitment,
      pageBuilder: (context, state) => _fadePage(
        key: state.pageKey,
        child: const CommunityCommitmentScreen(),
      ),
    ),
    GoRoute(
      path: AppRoutes.intentionSuccess,
      pageBuilder: (context, state) => _fadePage(
        key: state.pageKey,
        child: const IntentionSuccessScreen(),
      ),
    ),
    GoRoute(
      path: AppRoutes.discover,
      pageBuilder: (context, state) => _fadePage(
        key: state.pageKey,
        child: const DiscoverScreen(),
      ),
    ),
    GoRoute(
      path: AppRoutes.profile,
      pageBuilder: (context, state) => _fadePage(
        key: state.pageKey,
        child: const ProfileScreen(),
      ),
      routes: [
        GoRoute(
          path: 'edit',
          pageBuilder: (context, state) => _fadePage(
            key: state.pageKey,
            child: const EditProfileScreen(),
          ),
        ),
      ],
    ),
    GoRoute(
      path: AppRoutes.notifications,
      pageBuilder: (context, state) => _fadePage(
        key: state.pageKey,
        child: const NotificationScreen(),
      ),
    ),
    GoRoute(
      path: AppRoutes.settings,
      pageBuilder: (context, state) => _fadePage(
        key: state.pageKey,
        child: const SettingsScreen(),
      ),
    ),
    GoRoute(
      path: AppRoutes.profilePreview,
      pageBuilder: (context, state) => _fadePage(
        key: state.pageKey,
        child: const ProfilePreviewScreen(),
      ),
    ),
    GoRoute(
      path: AppRoutes.compatibilityPreview,
      pageBuilder: (context, state) => _fadePage(
        key: state.pageKey,
        child: const CompatibilityPreviewScreen(),
      ),
    ),
    GoRoute(
      path: AppRoutes.matches,
      pageBuilder: (context, state) => _fadePage(
        key: state.pageKey,
        child: const MatchesScreen(),
      ),
    ),
    GoRoute(
      path: AppRoutes.messages,
      pageBuilder: (context, state) => _fadePage(
        key: state.pageKey,
        child: const MessagesScreen(),
      ),
    ),
    GoRoute(
      path: AppRoutes.chat,
      pageBuilder: (context, state) => _fadePage(
        key: state.pageKey,
        child: const ChatScreen(),
      ),
    ),
    GoRoute(
      path: AppRoutes.proposeDate,
      pageBuilder: (context, state) => _fadePage(
        key: state.pageKey,
        child: const ProposeDateScreen(),
      ),
    ),
    GoRoute(
      path: AppRoutes.dateProposed,
      pageBuilder: (context, state) => _fadePage(
        key: state.pageKey,
        child: const DateProposedScreen(),
      ),
    ),
    GoRoute(
      path: AppRoutes.previewPhoto,
      pageBuilder: (context, state) => _fadePage(
        key: state.pageKey,
        child: const PreviewPhotoScreen(),
      ),
    ),
    GoRoute(
      path: AppRoutes.dateSetConfirmed,
      pageBuilder: (context, state) => _fadePage(
        key: state.pageKey,
        child: const DateSetConfirmedScreen(),
      ),
    ),
    GoRoute(
      path: AppRoutes.dateReminder,
      pageBuilder: (context, state) => _fadePage(
        key: state.pageKey,
        child: const DateReminderScreen(),
      ),
    ),
    GoRoute(
      path: AppRoutes.dateHappen,
      pageBuilder: (context, state) => _fadePage(
        key: state.pageKey,
        child: const DateHappenScreen(),
      ),
    ),
    GoRoute(
      path: AppRoutes.fullGalleryUnlocked,
      pageBuilder: (context, state) => _fadePage(
        key: state.pageKey,
        child: const FullGalleryUnlockedScreen(),
      ),
    ),
    GoRoute(
      path: AppRoutes.chooseIcon,
      pageBuilder: (context, state) => _fadePage(
        key: state.pageKey,
        child: const ChooseIconScreen(),
      ),
    ),
    GoRoute(
      path: AppRoutes.whyMatches,
      pageBuilder: (context, state) => _fadePage(
        key: state.pageKey,
        child: const WhyMatchesScreen(),
      ),
    ),
    GoRoute(
      path: AppRoutes.mbtiAssessPreview,
      pageBuilder: (context, state) => _fadePage(
        key: state.pageKey,
        child: const MbtiAssessPreviewScreen(),
      ),
    ),
  ],
);
