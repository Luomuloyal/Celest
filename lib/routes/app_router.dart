import 'package:go_router/go_router.dart';

import '../core/common/widgets/app_placeholder_page.dart';
import '../core/common/widgets/app_shell.dart';
import '../features/auth/presentation/pages/auth_page.dart';
import 'route_guard.dart';

class AppRouter {
  const AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: '/workspace',
    redirect: RouteGuard.redirect,
    routes: <RouteBase>[
      GoRoute(
        path: '/auth',
        builder: (context, state) => const AuthPage(),
      ),
      ShellRoute(
        builder: (context, state, child) => AppShell(child: child),
        routes: <RouteBase>[
          GoRoute(
            path: '/home',
            pageBuilder: (context, state) => const NoTransitionPage<void>(
              child: AppPlaceholderPage(title: '首页'),
            ),
          ),
          GoRoute(
            path: '/competition',
            pageBuilder: (context, state) => const NoTransitionPage<void>(
              child: AppPlaceholderPage(title: '赛事'),
            ),
          ),
          GoRoute(
            path: '/workspace',
            pageBuilder: (context, state) => const NoTransitionPage<void>(
              child: AppPlaceholderPage(title: '工作区'),
            ),
          ),
          GoRoute(
            path: '/resources',
            pageBuilder: (context, state) => const NoTransitionPage<void>(
              child: AppPlaceholderPage(title: '资源库'),
            ),
          ),
          GoRoute(
            path: '/profile',
            pageBuilder: (context, state) => const NoTransitionPage<void>(
              child: AppPlaceholderPage(title: '我的'),
            ),
          ),
        ],
      ),
    ],
  );
}
