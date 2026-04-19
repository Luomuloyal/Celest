import 'package:go_router/go_router.dart';

import '../core/common/widgets/app_shell.dart';
import '../features/auth/presentation/pages/auth_page.dart';
import '../features/competition/presentation/pages/competition_page.dart';
import '../features/home/presentation/pages/home_page.dart';
import '../features/profile/presentation/pages/profile_page.dart';
import '../features/resources/presentation/pages/resources_page.dart';
import '../features/workspace/presentation/pages/workspace_page.dart';
import 'app_routes.dart';
import 'route_guard.dart';

class AppRouter {
  const AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.workspace.path,
    redirect: RouteGuard.redirect,
    routes: <RouteBase>[
      GoRoute(
        path: AppRoutes.auth.path,
        name: AppRoutes.auth.name,
        builder: (context, state) => const AuthPage(),
      ),
      ShellRoute(
        builder: (context, state, child) => AppShell(child: child),
        routes: <RouteBase>[
          GoRoute(
            path: AppRoutes.home.path,
            name: AppRoutes.home.name,
            pageBuilder: (context, state) =>
                NoTransitionPage<void>(child: const HomePage()),
          ),
          GoRoute(
            path: AppRoutes.competition.path,
            name: AppRoutes.competition.name,
            pageBuilder: (context, state) =>
                NoTransitionPage<void>(child: const CompetitionPage()),
          ),
          GoRoute(
            path: AppRoutes.workspace.path,
            name: AppRoutes.workspace.name,
            pageBuilder: (context, state) =>
                NoTransitionPage<void>(child: const WorkspacePage()),
          ),
          GoRoute(
            path: AppRoutes.resources.path,
            name: AppRoutes.resources.name,
            pageBuilder: (context, state) =>
                NoTransitionPage<void>(child: const ResourcesPage()),
          ),
          GoRoute(
            path: AppRoutes.profile.path,
            name: AppRoutes.profile.name,
            pageBuilder: (context, state) =>
                NoTransitionPage<void>(child: const ProfilePage()),
          ),
        ],
      ),
    ],
  );
}
