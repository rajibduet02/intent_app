/// Optional Web OAuth client ID so Google returns an **ID token** for Firebase
/// (`GoogleAuthProvider.credential` needs `idToken`).
///
/// Find it in Firebase Console → Project settings → Your apps → **Web** app
/// (or download `google-services.json` after enabling Google Sign-In — look for
/// `client_type` **3** / `oauth_client` with `client_id` ending in
/// `.apps.googleusercontent.com`).
///
/// Leave empty to try platform defaults (often works on Android when SHA-1 is set).
abstract final class GoogleSignInConstants {
  GoogleSignInConstants._();

  /// Set after running `flutterfire configure` for this app's Firebase project.
  static const String serverClientId = '';
}
