import 'package:dio/dio.dart';

typedef AccessTokenProvider = Future<String?> Function();

class AuthInterceptor extends Interceptor {
  AuthInterceptor({
    AccessTokenProvider? accessTokenProvider,
  }) : _accessTokenProvider = accessTokenProvider;

  final AccessTokenProvider? _accessTokenProvider;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.headers.putIfAbsent('Accept', () => 'application/json');
    options.headers.putIfAbsent('Content-Type', () => 'application/json');

    final token = await _accessTokenProvider?.call();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    handler.next(options);
  }
}
