import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../constants/app_breakpoints.dart';
import '../../theme/app_radius.dart';
import '../../theme/app_spacing.dart';
import '../../theme/theme_context_extension.dart';
import 'app_bottom_nav_bar.dart';

class AppShellDestination {
  const AppShellDestination({
    required this.label,
    required this.path,
    required this.icon,
    required this.activeIcon,
  });

  final String label;
  final String path;
  final IconData icon;
  final IconData activeIcon;
}

const List<AppShellDestination> appShellDestinations = <AppShellDestination>[
  AppShellDestination(
    label: '首页',
    path: '/home',
    icon: Icons.home_outlined,
    activeIcon: Icons.home,
  ),
  AppShellDestination(
    label: '赛事',
    path: '/competition',
    icon: Icons.emoji_events_outlined,
    activeIcon: Icons.emoji_events,
  ),
  AppShellDestination(
    label: '工作区',
    path: '/workspace',
    icon: Icons.dashboard_customize_outlined,
    activeIcon: Icons.dashboard_customize,
  ),
  AppShellDestination(
    label: '资源库',
    path: '/resources',
    icon: Icons.folder_open_outlined,
    activeIcon: Icons.folder_open,
  ),
  AppShellDestination(
    label: '我的',
    path: '/profile',
    icon: Icons.person_outline,
    activeIcon: Icons.person,
  ),
];

class AppShell extends StatefulWidget {
  const AppShell({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  bool _desktopExpanded = false;

  @override
  Widget build(BuildContext context) {
    final currentPath = GoRouterState.of(context).uri.path;
    final currentIndex = _indexForPath(currentPath);
    final isDesktop =
        MediaQuery.sizeOf(context).width >= AppBreakpoints.desktop;

    if (isDesktop) {
      return Scaffold(
        body: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                context.appTheme.pageGradientStart,
                context.appTheme.pageGradientEnd,
              ],
            ),
          ),
          child: SafeArea(
            child: Row(
              children: [
                _DesktopSidebar(
                  expanded: _desktopExpanded,
                  currentIndex: currentIndex,
                  onToggle: () {
                    setState(() {
                      _desktopExpanded = !_desktopExpanded;
                    });
                  },
                  onSelect: (index) => _goTo(context, index),
                ),
                Expanded(child: widget.child),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              context.appTheme.pageGradientStart,
              context.appTheme.pageGradientEnd,
            ],
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: widget.child,
        ),
      ),
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: currentIndex,
        items: [
          for (final destination in appShellDestinations)
            AppBottomNavItem(
              icon: destination.icon,
              label: destination.label,
              activeIcon: destination.activeIcon,
            ),
        ],
        onTap: (index) => _goTo(context, index),
      ),
    );
  }

  void _goTo(BuildContext context, int index) {
    context.go(appShellDestinations[index].path);
  }

  int _indexForPath(String path) {
    final index = appShellDestinations.indexWhere(
      (destination) => path == destination.path,
    );
    if (index != -1) {
      return index;
    }

    if (path.startsWith('/competition')) {
      return 1;
    }
    if (path.startsWith('/workspace') || path.startsWith('/dashboard')) {
      return 2;
    }
    if (path.startsWith('/resources') || path.startsWith('/team')) {
      return 3;
    }
    if (path.startsWith('/profile')) {
      return 4;
    }

    return 0;
  }
}

class _DesktopSidebar extends StatelessWidget {
  const _DesktopSidebar({
    required this.expanded,
    required this.currentIndex,
    required this.onToggle,
    required this.onSelect,
  });

  final bool expanded;
  final int currentIndex;
  final VoidCallback onToggle;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOutCubic,
      width: expanded ? 256 : 84,
      margin: const EdgeInsets.all(AppSpacing.md),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: appTheme.sectionBackground,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(color: appTheme.sectionBorder),
        boxShadow: [
          BoxShadow(
            color: appTheme.sectionShadow,
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: onToggle,
                icon: const Icon(Icons.menu_rounded),
                color: context.colors.onSurface,
              ),
              if (expanded)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: AppSpacing.xs),
                    child: Text(
                      '赛育通',
                      style: context.textStyles.headlineMedium?.copyWith(
                        fontSize: 18,
                        color: context.colors.onSurface,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Expanded(
            child: ListView.separated(
              itemCount: appShellDestinations.length,
              separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.xs),
              itemBuilder: (context, index) {
                final destination = appShellDestinations[index];
                final selected = index == currentIndex;
                final foreground = selected
                    ? context.colors.primary
                    : context.colors.onSurfaceVariant;

                return InkWell(
                  onTap: () => onSelect(index),
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    curve: Curves.easeOutCubic,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.smPlus,
                    ),
                    decoration: BoxDecoration(
                      color: selected
                          ? context.appTheme.pillBackground
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(AppRadius.lg),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          selected
                              ? destination.activeIcon
                              : destination.icon,
                          color: foreground,
                        ),
                        if (expanded) ...[
                          const SizedBox(width: AppSpacing.md),
                          Expanded(
                            child: Text(
                              destination.label,
                              style: context.textStyles.bodyLarge?.copyWith(
                                color: foreground,
                                fontWeight: selected
                                    ? FontWeight.w600
                                    : FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
