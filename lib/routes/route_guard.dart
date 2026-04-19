import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import 'app_routes.dart';

class RouteGuard {
  const RouteGuard._();

  static String? redirect(BuildContext context, GoRouterState state) {
    final path = state.uri.path;

    if (path == '/') {
      return AppRoutes.workspace.path;
    }

    if (path == '/dashboard') {
      return AppRoutes.workspace.path;
    }

    if (path == '/team') {
      return AppRoutes.resources.path;
    }

    return null;
  }
}
