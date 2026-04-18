import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ApiLoggingInterceptor extends Interceptor {
  const ApiLoggingInterceptor();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (kDebugMode) {
      debugPrint(
        '[DIO][${options.method}] ${options.baseUrl}${options.path} '
        'query=${options.queryParameters} body=${options.data}',
      );
    }

    handler.next(options);
  }

  @override
  void onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      debugPrint(
        '[DIO][${response.statusCode}] ${response.requestOptions.method} '
        '${response.requestOptions.baseUrl}${response.requestOptions.path}',
      );
    }

    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      debugPrint(
        '[DIO][ERROR] ${err.requestOptions.method} '
        '${err.requestOptions.baseUrl}${err.requestOptions.path} '
        'status=${err.response?.statusCode} message=${err.message}',
      );
    }

    handler.next(err);
  }
}
