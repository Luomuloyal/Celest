abstract class Failure {
  const Failure(this.message, {this.statusCode});

  final String message;
  final int? statusCode;
}

class ServerFailure extends Failure {
  const ServerFailure([
    super.message = 'Server failure',
    int? statusCode,
  ]) : super(statusCode: statusCode);
}

class NetworkFailure extends Failure {
  const NetworkFailure([
    super.message = 'Network failure',
    int? statusCode,
  ]) : super(statusCode: statusCode);
}

class TimeoutFailure extends Failure {
  const TimeoutFailure([
    super.message = 'Request timeout',
    int? statusCode,
  ]) : super(statusCode: statusCode);
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure([
    super.message = 'Unauthorized request',
    int? statusCode,
  ]) : super(statusCode: statusCode);
}

class UnexpectedFailure extends Failure {
  const UnexpectedFailure([
    super.message = 'Unexpected failure',
    int? statusCode,
  ]) : super(statusCode: statusCode);
}
