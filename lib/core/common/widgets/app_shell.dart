import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../l10n/l10n.dart';
import '../../../routes/app_routes.dart';
import '../responsive_layout.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_radius.dart';
import '../../theme/app_sizes.dart';
import '../../theme/app_spacing.dart';
import 'app_bottom_nav_bar.dart';

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

const double _desktopSidebarLeadingLaneWidth =
    AppSizes.desktopSidebarCollapsedWidth -
    (AppSpacing.sm * 2) -
    (AppSpacing.xs * 2);
const double _desktopSidebarLeadingInset =
    (_desktopSidebarLeadingLaneWidth - AppSizes.desktopSidebarButtonSize) / 2;

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
  bool? _desktopExpandedOverride;

  @override
  Widget build(BuildContext context) {
    final currentState = GoRouterState.of(context);
    final currentIndex = _indexForLocation(
      routeName: currentState.topRoute?.name,
      path: currentState.uri.path,
    );
    final width = MediaQuery.sizeOf(context).width;
    final desktopExpanded = _desktopExpandedOverride ?? width >= 1180;

    return ResponsiveLayout(
      mobile: Scaffold(
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
      ),
      tablet: Scaffold(
        backgroundColor: AppColors.surfaceContainerLowest,
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
      ),
      desktop: Scaffold(
        backgroundColor: AppColors.surfaceContainerLowest,
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
      ),
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
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.smPlus,
        AppSpacing.smPlus,
        AppSpacing.sm,
        AppSpacing.smPlus,
      ),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 240),
        curve: Curves.easeOutCubic,
        width: expanded
            ? AppSizes.desktopSidebarExpandedWidth
            : AppSizes.desktopSidebarCollapsedWidth,
        height: double.infinity,
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.sm,
          AppSpacing.smPlus,
          AppSpacing.sm,
          AppSpacing.smPlus,
        ),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(AppRadius.xxxl),
          boxShadow: [
            BoxShadow(
              color: AppColors.surfaceContainerLowest.withValues(alpha: 0.96),
              blurRadius: 20,
              spreadRadius: 6,
            ),
            BoxShadow(
              color: AppColors.scrim.withValues(alpha: 0.08),
              blurRadius: 22,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppSpacing.xs),
            _DesktopSidebarMenuRow(expanded: expanded, onTap: onToggle),
            const SizedBox(height: AppSpacing.smPlus),
            for (var index = 0; index < appShellDestinations.length; index++)
              _DesktopSidebarNavRow(
                expanded: expanded,
                icon: _iconFor(index, currentIndex),
                label: _labelFor(context, appShellDestinations[index].section),
                selected: currentIndex == index,
                onTap: () => onSelect(index),
              ),
          ],
        ),
      ),
    );
  }
}

class _DesktopSidebarMenuRow extends StatefulWidget {
  const _DesktopSidebarMenuRow({required this.expanded, required this.onTap});

  final bool expanded;
  final VoidCallback onTap;

  @override
  State<_DesktopSidebarMenuRow> createState() => _DesktopSidebarMenuRowState();
}

class _DesktopSidebarMenuRowState extends State<_DesktopSidebarMenuRow> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
      child: SizedBox(
        height: AppSizes.desktopSidebarItemHeight,
        child: Align(
          alignment: Alignment.centerLeft,
          child: SizedBox(
            width: _desktopSidebarLeadingLaneWidth,
            child: Center(
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                onEnter: (_) => setState(() => _hovered = true),
                onExit: (_) => setState(() => _hovered = false),
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: widget.onTap,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      AnimatedOpacity(
                        duration: const Duration(milliseconds: 110),
                        curve: Curves.easeOut,
                        opacity: _hovered ? 1 : 0,
                        child: Container(
                          width: AppSizes.desktopSidebarButtonSize,
                          height: AppSizes.desktopSidebarButtonSize,
                          decoration: BoxDecoration(
                            color: AppColors.surfaceContainerLow,
                            borderRadius: BorderRadius.circular(AppRadius.full),
                            boxShadow: const [
                              BoxShadow(
                                color: AppColors.shadow,
                                blurRadius: 8,
                                spreadRadius: -4,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: AppSizes.desktopSidebarButtonSize,
                        height: AppSizes.desktopSidebarButtonSize,
                        child: const Center(
                          child: Icon(
                            Icons.menu_rounded,
                            size: AppSizes.iconLg,
                            color: AppColors.onSurfaceVariant,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DesktopSidebarNavRow extends StatefulWidget {
  const _DesktopSidebarNavRow({
    required this.expanded,
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final bool expanded;
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  State<_DesktopSidebarNavRow> createState() => _DesktopSidebarNavRowState();
}

class _DesktopSidebarNavRowState extends State<_DesktopSidebarNavRow> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final iconColor = widget.selected
        ? AppColors.onPrimaryContainer
        : AppColors.onSurfaceVariant;
    final labelColor = widget.selected
        ? AppColors.onPrimaryContainer
        : AppColors.onSurface;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: widget.onTap,
          child: TweenAnimationBuilder<double>(
            tween: Tween<double>(end: widget.expanded ? 1 : 0),
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOutCubic,
            builder: (context, expandValue, child) {
              return LayoutBuilder(
                builder: (context, constraints) {
                  final trailingWidth =
                      (constraints.maxWidth -
                              _desktopSidebarLeadingLaneWidth -
                              _desktopSidebarLeadingInset)
                          .clamp(0.0, double.infinity);
                  final backgroundColor = widget.selected
                      ? AppColors.primaryFixed
                      : AppColors.surfaceContainerLow;
                  final stateOpacity = (widget.selected || _hovered)
                      ? 1.0
                      : 0.0;
                  final backgroundWidth =
                      AppSizes.desktopSidebarButtonSize +
                      ((constraints.maxWidth -
                              _desktopSidebarLeadingInset -
                              AppSizes.desktopSidebarButtonSize) *
                          expandValue);

                  return SizedBox(
                    height: AppSizes.desktopSidebarItemHeight,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          left: _desktopSidebarLeadingInset,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Opacity(
                              opacity: stateOpacity,
                              child: Container(
                                width: backgroundWidth,
                                height: AppSizes.desktopSidebarButtonSize,
                                decoration: BoxDecoration(
                                  color: backgroundColor,
                                  borderRadius: BorderRadius.circular(
                                    AppRadius.full,
                                  ),
                                  boxShadow: widget.selected
                                      ? const [
                                          BoxShadow(
                                            color: AppColors.shadow,
                                            blurRadius: 8,
                                            spreadRadius: -6,
                                            offset: Offset(0, 2),
                                          ),
                                        ]
                                      : null,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: _desktopSidebarLeadingLaneWidth,
                              child: Center(
                                child: SizedBox(
                                  width: AppSizes.desktopSidebarButtonSize,
                                  height: AppSizes.desktopSidebarButtonSize,
                                  child: Center(
                                    child: Icon(
                                      widget.icon,
                                      size: AppSizes.iconLg,
                                      color: iconColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            ClipRect(
                              child: SizedBox(
                                width: trailingWidth * expandValue,
                                child: Opacity(
                                  opacity: expandValue,
                                  child: child,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(left: AppSpacing.md),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: widget.selected
                        ? FontWeight.w600
                        : FontWeight.w500,
                    color: labelColor,
                  ),
                ),
              ),
            ),
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
