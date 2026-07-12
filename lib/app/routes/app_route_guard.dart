import 'package:go_router/go_router.dart';
import 'package:intent_app/app/routes/app_routes.dart';

/// Route classification and [GoRouter.redirect] rules.
abstract final class AppRouteGuard {
  AppRouteGuard._();

  static String _normalizePath(GoRouterState state) {
    final path = state.matchedLocation;
    return path.isEmpty ? '/' : path;
  }

  /// Returns a redirect path, or `null` to stay on the current location.
  static String? redirect(GoRouterState state) {
    final path = _normalizePath(state);
    if (path == AppRoutes.splash ||
        path == AppRoutes.welcome ||
        path == AppRoutes.auth ||
        path == AppRoutes.signup ||
        path == AppRoutes.verify ||
        path == AppRoutes.forgotPassword ||
        path == AppRoutes.resetPassword ||
        path == AppRoutes.onboarding1 ||
        path == AppRoutes.onboarding2 ||
        path == AppRoutes.onboarding3 ||
        path == AppRoutes.onboarding4 ||
        path == AppRoutes.mbtiAssessment ||
        path == AppRoutes.mbtiAssessPreview ||
        path == AppRoutes.intentReflectionsIntro ||
        path == AppRoutes.intentReflectionsAssessment ||
        path == AppRoutes.relationshipStyleIntro ||
        path == AppRoutes.relationshipStyleAssessment ||
        path == AppRoutes.enneagramAssessment ||
        path == AppRoutes.enneagramAssessPreview ||
        path == AppRoutes.attachmentStyle ||
        path == AppRoutes.attachmentStylePreview ||
        path == AppRoutes.loveLanguage ||
        path == AppRoutes.relationshipVibe ||
        path == AppRoutes.profileOverview ||
        path == AppRoutes.photoUnlockIntention ||
        path == AppRoutes.uploadPhotos ||
        path == AppRoutes.choosePreviewPhotos ||
        path == AppRoutes.uploadId ||
        path == AppRoutes.safetyStarts ||
        path == AppRoutes.faceVerification ||
        path == AppRoutes.communityCommitment ||
        path == AppRoutes.intentionSuccess ||
        path == AppRoutes.discover ||
        path == AppRoutes.filter ||
        path == AppRoutes.profile ||
        path == AppRoutes.editProfile ||
        path == AppRoutes.settings ||
        path == AppRoutes.notifications ||
        path == AppRoutes.profilePreview ||
        path == AppRoutes.compatibilityPreview ||
        path == AppRoutes.matches ||
        path == AppRoutes.dates ||
        path == AppRoutes.whyMatches ||
        path == AppRoutes.chooseIcon ||
        path == AppRoutes.proposeDate ||
        path == AppRoutes.dateProposed ||
        path == AppRoutes.previewPhoto ||
        path == AppRoutes.dateSetConfirmed ||
        path == AppRoutes.dateReminder ||
        path == AppRoutes.dateHappen ||
        path == AppRoutes.fullGalleryUnlocked ||
        path == AppRoutes.dateFeedback ||
        path == AppRoutes.peopleNotice ||
        path == AppRoutes.safetyCenter ||
        path == AppRoutes.reportUser ||
        path == AppRoutes.connectionPlus ||
        path == AppRoutes.premiumIcon ||
        path == AppRoutes.messages ||
        path == AppRoutes.search ||
        path == AppRoutes.chat) {
      return null;
    }
    return AppRoutes.auth;
  }
}
