class VerifyRouteArgs {
  const VerifyRouteArgs({
    required this.email,
    required this.password,
    this.phone,
  });

  final String email;
  final String password;
  final String? phone;

  String get displayDestination {
    final trimmedPhone = phone?.trim();
    if (trimmedPhone != null && trimmedPhone.isNotEmpty) {
      return trimmedPhone;
    }
    return email;
  }

  static VerifyRouteArgs? parse(Object? extra) {
    if (extra is VerifyRouteArgs) {
      return extra;
    }
    return null;
  }
}
