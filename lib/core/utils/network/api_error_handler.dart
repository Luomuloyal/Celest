import 'package:dio/dio.dart';

import '../../error/exceptions.dart';
import '../../error/failures.dart';

class ApiErrorHandler {
  const ApiErrorHandler();

  AppException handle(DioException error) {
    final statusCode = error.response?.statusCode;
    final message = _extractMessage(error);

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return TimeoutException(
          message: message ?? 'Request timeout',
          statusCode: statusCode,
        );
      case DioExceptionType.connectionError:
      case DioExceptionType.badCertificate:
        return NetworkException(
          message: message ?? 'Network unavailable',
          statusCode: statusCode,
        );
      case DioExceptionType.badResponse:
        if (statusCode == 401) {
          return UnauthorizedException(
            message: message ?? 'Unauthorized request',
            statusCode: statusCode,
          );
        }

        return ServerException(
          message: message ?? 'Server exception',
          statusCode: statusCode,
        );
      case DioExceptionType.cancel:
      case DioExceptionType.unknown:
        return UnexpectedException(
          message: message ?? 'Unexpected exception',
          statusCode: statusCode,
        );
    }
  }

  AppException handleUnknown() {
    return const UnexpectedException();
  }

  Failure mapToFailure(Object error) {
    if (error is UnauthorizedException) {
      return UnauthorizedFailure(error.message, error.statusCode);
    }

    if (error is TimeoutException) {
      return TimeoutFailure(error.message, error.statusCode);
    }

    if (error is NetworkException) {
      return NetworkFailure(error.message, error.statusCode);
    }

    if (error is ServerException) {
      return ServerFailure(error.message, error.statusCode);
    }

    return const UnexpectedFailure();
  }

  String? _extractMessage(DioException error) {
    final data = error.response?.data;

    if (data is Map<String, dynamic>) {
      return data['message'] as String? ?? data['error'] as String?;
    }

    if (data is String && data.isNotEmpty) {
      return data;
    }

    return error.message;
  }
}
