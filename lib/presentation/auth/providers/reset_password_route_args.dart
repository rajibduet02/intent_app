class ResetPasswordRouteArgs {
  const ResetPasswordRouteArgs({
    this.email,
    this.code,
  });

  final String? email;
  final String? code;

  static ResetPasswordRouteArgs? parse(Object? extra) {
    if (extra is ResetPasswordRouteArgs) {
      return extra;
    }
    return null;
  }
}
