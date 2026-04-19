import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../l10n/l10n.dart';
import '../../../routes/app_routes.dart';
import '../responsive_layout.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import 'app_bottom_nav_bar.dart';
import 'app_wide_nav_bar.dart';

class AppShellDestination {
  const AppShellDestination({
    required this.section,
    required this.route,
    required this.icon,
    required this.activeIcon,
  });

  final AppShellSection section;
  final AppRouteSpec route;
  final IconData icon;
  final IconData activeIcon;
}

enum AppShellSection { home, competition, workspace, resources, profile }

const List<AppShellDestination> appShellDestinations = <AppShellDestination>[
  AppShellDestination(
    section: AppShellSection.home,
    route: AppRoutes.home,
    icon: Icons.home_outlined,
    activeIcon: Icons.home,
  ),
  AppShellDestination(
    section: AppShellSection.competition,
    route: AppRoutes.competition,
    icon: Icons.emoji_events_outlined,
    activeIcon: Icons.emoji_events,
  ),
  AppShellDestination(
    section: AppShellSection.workspace,
    route: AppRoutes.workspace,
    icon: Icons.dashboard_customize_outlined,
    activeIcon: Icons.dashboard_customize,
  ),
  AppShellDestination(
    section: AppShellSection.resources,
    route: AppRoutes.resources,
    icon: Icons.chat_bubble_outline_rounded,
    activeIcon: Icons.chat_bubble_rounded,
  ),
  AppShellDestination(
    section: AppShellSection.profile,
    route: AppRoutes.profile,
    icon: Icons.person_outline,
    activeIcon: Icons.person,
  ),
];

class AppShell extends StatefulWidget {
  const AppShell({super.key, required this.child});

  final Widget child;

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  bool? _wideNavExpandedOverride;

  @override
  Widget build(BuildContext context) {
    final currentState = GoRouterState.of(context);
    final currentIndex = _indexForLocation(
      routeName: currentState.topRoute?.name,
      path: currentState.uri.path,
    );
    final width = MediaQuery.sizeOf(context).width;
    final wideNavExpanded = _wideNavExpandedOverride ?? width >= 1180;
    final mobileItems = [
      for (final destination in appShellDestinations)
        AppBottomNavItem(
          icon: destination.icon,
          label: _labelFor(context, destination.section),
          activeIcon: destination.activeIcon,
        ),
    ];
    final wideItems = [
      for (final destination in appShellDestinations)
        AppWideNavItem(
          icon: destination.icon,
          activeIcon: destination.activeIcon,
          label: _labelFor(context, destination.section),
        ),
    ];
    final mobileShell = Scaffold(
      backgroundColor: AppColors.surface,
      extendBody: true,
      body: SafeArea(bottom: false, child: widget.child),
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: currentIndex,
        items: mobileItems,
        onTap: (index) => _goTo(context, index),
      ),
    );
    final wideShell = Scaffold(
      backgroundColor: AppColors.surfaceContainerLowest,
      body: SafeArea(
        child: Row(
          children: [
            AppWideNavBar(
              items: wideItems,
              currentIndex: currentIndex,
              expanded: wideNavExpanded,
              onToggle: () {
                setState(() {
                  _wideNavExpandedOverride = !wideNavExpanded;
                });
              },
              onTap: (index) => _goTo(context, index),
            ),
            const SizedBox(width: AppSpacing.xs),
            Expanded(
              child: ColoredBox(
                color: AppColors.surfaceContainerLowest,
                child: widget.child,
              ),
            ),
          ],
        ),
      ),
    );

    return ResponsiveLayout(
      mobile: mobileShell,
      tablet: wideShell,
      desktop: wideShell,
    );
  }

  void _goTo(BuildContext context, int index) {
    context.goNamed(appShellDestinations[index].route.name);
  }

  int _indexForLocation({String? routeName, required String path}) {
    final nameIndex = appShellDestinations.indexWhere(
      (destination) => destination.route.name == routeName,
    );
    if (nameIndex != -1) {
      return nameIndex;
    }

    final index = appShellDestinations.indexWhere(
      (destination) => path == destination.route.path,
    );
    if (index != -1) {
      return index;
    }

    if (path.startsWith(AppRoutes.competition.path)) {
      return 1;
    }
    if (path.startsWith(AppRoutes.workspace.path) || path.startsWith('/dashboard')) {
      return 2;
    }
    if (path.startsWith(AppRoutes.resources.path) || path.startsWith('/team')) {
      return 3;
    }
    if (path.startsWith(AppRoutes.profile.path)) {
      return 4;
    }

    return 0;
  }
}

String _labelFor(BuildContext context, AppShellSection section) {
  final l10n = context.l10n;

  return switch (section) {
    AppShellSection.home => l10n.navHome,
    AppShellSection.competition => l10n.navCompetition,
    AppShellSection.workspace => l10n.navWorkspace,
    AppShellSection.resources => l10n.navResources,
    AppShellSection.profile => l10n.navProfile,
  };
}
