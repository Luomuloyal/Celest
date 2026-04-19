import 'package:go_router/go_router.dart';

import '../core/common/widgets/app_placeholder_page.dart';
import '../core/common/widgets/app_shell.dart';
import '../features/auth/presentation/pages/auth_page.dart';
import '../features/competition/presentation/pages/competition_page.dart';
import '../features/dashboard/presentation/pages/dashboard_page.dart';
import '../l10n/l10n.dart';
import 'route_guard.dart';

class AppRouter {
  const AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: '/workspace',
    redirect: RouteGuard.redirect,
    routes: <RouteBase>[
      GoRoute(path: '/auth', builder: (context, state) => const AuthPage()),
      ShellRoute(
        builder: (context, state, child) => AppShell(child: child),
        routes: <RouteBase>[
          GoRoute(
            path: '/home',
            pageBuilder: (context, state) => NoTransitionPage<void>(
              child: AppPlaceholderPage(title: context.l10n.navHome),
            ),
          ),
          GoRoute(
            path: '/competition',
            pageBuilder: (context, state) =>
                NoTransitionPage<void>(child: const CompetitionPage()),
          ),
          GoRoute(
            path: '/workspace',
            pageBuilder: (context, state) =>
                NoTransitionPage<void>(child: const DashboardPage()),
          ),
          GoRoute(
            path: '/resources',
            pageBuilder: (context, state) => NoTransitionPage<void>(
              child: AppPlaceholderPage(title: context.l10n.navResources),
            ),
          ),
          GoRoute(
            path: '/profile',
            pageBuilder: (context, state) => NoTransitionPage<void>(
              child: AppPlaceholderPage(title: context.l10n.navProfile),
            ),
          ),
        ],
      ),
    ],
  );
}
