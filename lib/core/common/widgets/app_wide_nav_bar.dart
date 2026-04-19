import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_radius.dart';
import '../../theme/app_sizes.dart';
import '../../theme/app_spacing.dart';

class AppWideNavItem {
  const AppWideNavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });

  final IconData icon;
  final IconData activeIcon;
  final String label;
}

const double _leadingLaneWidth =
    AppSizes.desktopSidebarCollapsedWidth -
    (AppSpacing.sm * 2) -
    (AppSpacing.xs * 2);
const double _leadingInset =
    (_leadingLaneWidth - AppSizes.desktopSidebarButtonSize) / 2;

class AppWideNavBar extends StatelessWidget {
  const AppWideNavBar({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.expanded,
    required this.onToggle,
    required this.onTap,
  });

  final List<AppWideNavItem> items;
  final int currentIndex;
  final bool expanded;
  final VoidCallback onToggle;
  final ValueChanged<int> onTap;

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
            _WideNavMenuButton(onTap: onToggle),
            const SizedBox(height: AppSpacing.smPlus),
            for (var index = 0; index < items.length; index++)
              _WideNavItemButton(
                expanded: expanded,
                item: items[index],
                selected: currentIndex == index,
                onTap: () => onTap(index),
              ),
          ],
        ),
      ),
    );
  }
}

class _WideNavMenuButton extends StatefulWidget {
  const _WideNavMenuButton({required this.onTap});

  final VoidCallback onTap;

  @override
  State<_WideNavMenuButton> createState() => _WideNavMenuButtonState();
}

class _WideNavMenuButtonState extends State<_WideNavMenuButton> {
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
            width: _leadingLaneWidth,
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

class _WideNavItemButton extends StatefulWidget {
  const _WideNavItemButton({
    required this.expanded,
    required this.item,
    required this.selected,
    required this.onTap,
  });

  final bool expanded;
  final AppWideNavItem item;
  final bool selected;
  final VoidCallback onTap;

  @override
  State<_WideNavItemButton> createState() => _WideNavItemButtonState();
}

class _WideNavItemButtonState extends State<_WideNavItemButton> {
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
                      (constraints.maxWidth - _leadingLaneWidth - _leadingInset)
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
                              _leadingInset -
                              AppSizes.desktopSidebarButtonSize) *
                          expandValue);

                  return SizedBox(
                    height: AppSizes.desktopSidebarItemHeight,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          left: _leadingInset,
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
                              width: _leadingLaneWidth,
                              child: Center(
                                child: SizedBox(
                                  width: AppSizes.desktopSidebarButtonSize,
                                  height: AppSizes.desktopSidebarButtonSize,
                                  child: Center(
                                    child: Icon(
                                      widget.selected
                                          ? widget.item.activeIcon
                                          : widget.item.icon,
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
                  widget.item.label,
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
