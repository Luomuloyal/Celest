import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../l10n/l10n.dart';
import '../../constants/app_breakpoints.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import 'app_bottom_nav_bar.dart';

class AppShellDestination {
  const AppShellDestination({
    required this.section,
    required this.path,
    required this.icon,
    required this.activeIcon,
  });

  final AppShellSection section;
  final String path;
  final IconData icon;
  final IconData activeIcon;
}

enum AppShellSection { home, competition, workspace, resources, profile }

const List<AppShellDestination> appShellDestinations = <AppShellDestination>[
  AppShellDestination(
    section: AppShellSection.home,
    path: '/home',
    icon: Icons.home_outlined,
    activeIcon: Icons.home,
  ),
  AppShellDestination(
    section: AppShellSection.competition,
    path: '/competition',
    icon: Icons.emoji_events_outlined,
    activeIcon: Icons.emoji_events,
  ),
  AppShellDestination(
    section: AppShellSection.workspace,
    path: '/workspace',
    icon: Icons.dashboard_customize_outlined,
    activeIcon: Icons.dashboard_customize,
  ),
  AppShellDestination(
    section: AppShellSection.resources,
    path: '/resources',
    icon: Icons.chat_bubble_outline_rounded,
    activeIcon: Icons.chat_bubble_rounded,
  ),
  AppShellDestination(
    section: AppShellSection.profile,
    path: '/profile',
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
  bool? _desktopExpandedOverride;

  @override
  Widget build(BuildContext context) {
    final currentPath = GoRouterState.of(context).uri.path;
    final currentIndex = _indexForPath(currentPath);
    final width = MediaQuery.sizeOf(context).width;
    final isMobile = width < AppBreakpoints.mobile;
    final desktopExpanded = _desktopExpandedOverride ?? width >= 1180;

    if (isMobile) {
      return Scaffold(
        backgroundColor: AppColors.surface,
        extendBody: true,
        body: SafeArea(bottom: false, child: widget.child),
        bottomNavigationBar: AppBottomNavBar(
          currentIndex: currentIndex,
          items: [
            for (final destination in appShellDestinations)
              AppBottomNavItem(
                icon: destination.icon,
                label: _labelFor(context, destination.section),
                activeIcon: destination.activeIcon,
              ),
          ],
          onTap: (index) => _goTo(context, index),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Row(
          children: [
            _DesktopGeminiSidebar(
              expanded: desktopExpanded,
              currentIndex: currentIndex,
              onToggle: () {
                setState(() {
                  _desktopExpandedOverride = !desktopExpanded;
                });
              },
              onSelect: (index) => _goTo(context, index),
            ),
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

class _DesktopGeminiSidebar extends StatelessWidget {
  const _DesktopGeminiSidebar({
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
    const railWidth = 76.0;
    const expandedWidth = 220.0;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOutCubic,
      width: expanded ? expandedWidth : railWidth,
      color: AppColors.surfaceContainerLow,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppSpacing.smPlus),
          _DesktopSidebarButtonRow(
            expanded: expanded,
            railWidth: railWidth,
            icon: Icons.menu_rounded,
            label: '',
            selected: false,
            onTap: onToggle,
          ),
          const SizedBox(height: AppSpacing.smPlus),
          for (var index = 0; index < appShellDestinations.length; index++)
            _DesktopSidebarButtonRow(
              expanded: expanded,
              railWidth: railWidth,
              icon: _iconFor(index, currentIndex),
              label: _labelFor(context, appShellDestinations[index].section),
              selected: currentIndex == index,
              onTap: () => onSelect(index),
            ),
        ],
      ),
    );
  }
}

class _DesktopSidebarButtonRow extends StatelessWidget {
  const _DesktopSidebarButtonRow({
    required this.expanded,
    required this.railWidth,
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final bool expanded;
  final double railWidth;
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final foreground = selected
        ? AppColors.primaryFixedDim
        : AppColors.onSurfaceVariant;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        splashColor: Colors.transparent,
        hoverColor: AppColors.primaryFixed.withValues(alpha: 0.16),
        highlightColor: Colors.transparent,
        focusColor: Colors.transparent,
        child: SizedBox(
          height: 56,
          child: Row(
            children: [
              SizedBox(
                width: railWidth,
                child: Center(child: Icon(icon, size: 24, color: foreground)),
              ),
              Expanded(
                child: ClipRect(
                  child: AnimatedAlign(
                    duration: const Duration(milliseconds: 220),
                    curve: Curves.easeOutCubic,
                    alignment: Alignment.centerLeft,
                    widthFactor: expanded ? 1 : 0,
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 150),
                      opacity: expanded && label.isNotEmpty ? 1 : 0,
                      child: Padding(
                        padding: const EdgeInsets.only(right: AppSpacing.md),
                        child: Text(
                          label,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: selected
                                ? FontWeight.w600
                                : FontWeight.w500,
                            color: foreground,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

IconData _iconFor(int index, int currentIndex) {
  final destination = appShellDestinations[index];
  return currentIndex == index ? destination.activeIcon : destination.icon;
}
