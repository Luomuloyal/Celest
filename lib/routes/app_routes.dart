class AppRouteSpec {
  const AppRouteSpec(this.name, this.path);

  final String name;
  final String path;
}

abstract final class AppRoutes {
  static const auth = AppRouteSpec('auth', '/auth');
  static const home = AppRouteSpec('home', '/home');
  static const competition = AppRouteSpec('competition', '/competition');
  static const workspace = AppRouteSpec('workspace', '/workspace');
  static const resources = AppRouteSpec('resources', '/resources');
  static const profile = AppRouteSpec('profile', '/profile');
}
