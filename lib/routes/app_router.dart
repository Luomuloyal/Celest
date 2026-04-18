import 'package:go_router/go_router.dart';

import '../features/auth/presentation/pages/auth_page.dart';
import '../features/competition/presentation/pages/competition_page.dart';
import '../features/dashboard/presentation/pages/dashboard_page.dart';
import '../features/team/presentation/pages/team_page.dart';
import 'route_guard.dart';

class AppRouter {
  const AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: '/dashboard',
    redirect: RouteGuard.redirect,
    routes: <RouteBase>[
      GoRoute(
        path: '/auth',
        builder: (context, state) => const AuthPage(),
      ),
      GoRoute(
        path: '/dashboard',
        builder: (context, state) => const DashboardPage(),
      ),
      GoRoute(
        path: '/competition',
        builder: (context, state) => const CompetitionPage(),
      ),
      GoRoute(
        path: '/team',
        builder: (context, state) => const TeamPage(),
      ),
    ],
  );
}
