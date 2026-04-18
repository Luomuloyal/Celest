import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class RouteGuard {
  const RouteGuard._();

  static String? redirect(BuildContext context, GoRouterState state) {
    final path = state.uri.path;

    if (path == '/') {
      return '/workspace';
    }

    if (path == '/dashboard') {
      return '/workspace';
    }

    if (path == '/team') {
      return '/resources';
    }

    return null;
  }
}
