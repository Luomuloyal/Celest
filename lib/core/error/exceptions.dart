abstract class AppException implements Exception {
  const AppException({
    required this.message,
    this.statusCode,
  });

  final String message;
  final int? statusCode;

  @override
  String toString() => '$runtimeType(message: $message, statusCode: $statusCode)';
}

class ServerException extends AppException {
  const ServerException({
    super.message = 'Server exception',
    super.statusCode,
  });
}

class NetworkException extends AppException {
  const NetworkException({
    super.message = 'Network exception',
    super.statusCode,
  });
}

class TimeoutException extends AppException {
  const TimeoutException({
    super.message = 'Request timeout',
    super.statusCode,
  });
}

class UnauthorizedException extends AppException {
  const UnauthorizedException({
    super.message = 'Unauthorized request',
    super.statusCode,
  });
}

class UnexpectedException extends AppException {
  const UnexpectedException({
    super.message = 'Unexpected exception',
    super.statusCode,
  });
}
