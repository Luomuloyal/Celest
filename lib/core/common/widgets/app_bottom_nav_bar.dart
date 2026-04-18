import 'package:flutter/material.dart';

import '../../theme/app_radius.dart';
import '../../theme/app_sizes.dart';
import '../../theme/app_spacing.dart';
import '../../theme/theme_context_extension.dart';

class AppBottomNavItem {
  const AppBottomNavItem({
    required this.icon,
    required this.label,
    this.activeIcon,
  });

  final IconData icon;
  final String label;
  final IconData? activeIcon;
}

class AppBottomNavBar extends StatelessWidget {
  const AppBottomNavBar({
    super.key,
    required this.items,
    required this.currentIndex,
    this.onTap,
    this.prominentIndex = 2,
  });

  final List<AppBottomNavItem> items;
  final int currentIndex;
  final ValueChanged<int>? onTap;
  final int prominentIndex;

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    final centerItem = items[prominentIndex];

    return SizedBox(
      height: 112,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            left: AppSpacing.md,
            right: AppSpacing.md,
            bottom: AppSpacing.sm,
            top: 22,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: AppSpacing.sm,
              ),
              decoration: BoxDecoration(
                color: appTheme.sectionBackground,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                  bottomLeft: Radius.circular(AppRadius.xl),
                  bottomRight: Radius.circular(AppRadius.xl),
                ),
                border: Border.all(color: appTheme.sectionBorder),
                boxShadow: [
                  BoxShadow(
                    color: appTheme.sectionShadow,
                    blurRadius: 20,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                children: [
                  for (var index = 0; index < items.length; index++) ...[
                    if (index == prominentIndex)
                      const SizedBox(width: 86)
                    else
                      Expanded(
                        child: _NavItem(
                          item: items[index],
                          selected: currentIndex == index,
                          onTap: () => onTap?.call(index),
                        ),
                      ),
                  ],
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            child: GestureDetector(
              onTap: () => onTap?.call(prominentIndex),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                curve: Curves.easeOutCubic,
                width: 84,
                height: 84,
                decoration: BoxDecoration(
                  color: currentIndex == prominentIndex
                      ? context.colors.primary
                      : context.appTheme.pillBackground,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: appTheme.sectionBackground,
                    width: 6,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: appTheme.sectionShadow,
                      blurRadius: 18,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      currentIndex == prominentIndex
                          ? (centerItem.activeIcon ?? centerItem.icon)
                          : centerItem.icon,
                      size: 26,
                      color: currentIndex == prominentIndex
                          ? context.colors.onPrimary
                          : context.colors.primary,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      centerItem.label,
                      style: context.textStyles.bodySmall?.copyWith(
                        color: currentIndex == prominentIndex
                            ? context.colors.onPrimary
                            : context.colors.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.item,
    required this.selected,
    required this.onTap,
  });

  final AppBottomNavItem item;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final foreground = selected
        ? context.colors.primary
        : context.colors.onSurfaceVariant;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.xs,
          vertical: AppSpacing.sm,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              selected ? (item.activeIcon ?? item.icon) : item.icon,
              size: AppSizes.iconLg,
              color: foreground,
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              item.label,
              style: context.textStyles.bodySmall?.copyWith(
                color: foreground,
                fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
