/// Generic API-style result for repositories.
class ResponseModel<T> {
  const ResponseModel._({
    required this.success,
    this.data,
    this.message,
    this.statusCode,
    this.authStatus,
  });

  final bool success;
  final T? data;
  final String? message;
  final int? statusCode;

  /// Machine-readable status from Firebase callable auth flows (optional).
  final String? authStatus;

  factory ResponseModel.success(T data, {int? statusCode, String? authStatus}) {
    return ResponseModel._(
      success: true,
      data: data,
      statusCode: statusCode,
      authStatus: authStatus,
    );
  }

  factory ResponseModel.failure(
    String message, {
    int? statusCode,
    String? authStatus,
  }) {
    return ResponseModel._(
      success: false,
      message: message,
      statusCode: statusCode,
      authStatus: authStatus,
    );
  }
}
