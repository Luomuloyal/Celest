import 'package:dio/dio.dart';

import '../../constants/api_endpoints.dart';
import '../../constants/app_timeouts.dart';
import 'api_error_handler.dart';
import 'interceptors/api_logging_interceptor.dart';
import 'interceptors/auth_interceptor.dart';

class ApiClient {
  ApiClient({
    Dio? dio,
    required ApiErrorHandler errorHandler,
    required AuthInterceptor authInterceptor,
    required ApiLoggingInterceptor loggingInterceptor,
  })  : _errorHandler = errorHandler,
        _dio = dio ?? Dio() {
    _dio.options = BaseOptions(
      baseUrl: ApiEndpoints.baseUrl,
      connectTimeout: AppTimeouts.connect,
      sendTimeout: AppTimeouts.send,
      receiveTimeout: AppTimeouts.receive,
      responseType: ResponseType.json,
      headers: const <String, dynamic>{
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );

    _dio.interceptors.addAll(<Interceptor>[
      authInterceptor,
      loggingInterceptor,
    ]);
  }

  final Dio _dio;
  final ApiErrorHandler _errorHandler;

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return _guardRequest(
      () => _dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      ),
    );
  }

  Future<Response<T>> post<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return _guardRequest(
      () => _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      ),
    );
  }

  Future<Response<T>> put<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return _guardRequest(
      () => _dio.put<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      ),
    );
  }

  Future<Response<T>> patch<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return _guardRequest(
      () => _dio.patch<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      ),
    );
  }

  Future<Response<T>> delete<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return _guardRequest(
      () => _dio.delete<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      ),
    );
  }

  Future<Response<T>> _guardRequest<T>(
    Future<Response<T>> Function() request,
  ) async {
    try {
      return await request();
    } on DioException catch (error) {
      throw _errorHandler.handle(error);
    } catch (_) {
      throw _errorHandler.handleUnknown();
    }
  }
}
