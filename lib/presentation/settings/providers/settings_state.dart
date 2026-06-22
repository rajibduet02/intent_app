class SettingsState {
  const SettingsState({
    required this.pushNotifications,
    required this.emailUpdates,
    required this.matchAlerts,
    required this.compatibilityFirst,
    required this.isLoggingOut,
    required this.isDeletingAccount,
  });

  final bool pushNotifications;
  final bool emailUpdates;
  final bool matchAlerts;
  final bool compatibilityFirst;
  final bool isLoggingOut;
  final bool isDeletingAccount;

  factory SettingsState.initial() => const SettingsState(
        pushNotifications: true,
        emailUpdates: true,
        matchAlerts: true,
        compatibilityFirst: true,
        isLoggingOut: false,
        isDeletingAccount: false,
      );

  SettingsState copyWith({
    bool? pushNotifications,
    bool? emailUpdates,
    bool? matchAlerts,
    bool? compatibilityFirst,
    bool? isLoggingOut,
    bool? isDeletingAccount,
  }) {
    return SettingsState(
      pushNotifications: pushNotifications ?? this.pushNotifications,
      emailUpdates: emailUpdates ?? this.emailUpdates,
      matchAlerts: matchAlerts ?? this.matchAlerts,
      compatibilityFirst: compatibilityFirst ?? this.compatibilityFirst,
      isLoggingOut: isLoggingOut ?? this.isLoggingOut,
      isDeletingAccount: isDeletingAccount ?? this.isDeletingAccount,
    );
  }
}
