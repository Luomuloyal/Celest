import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_radius.dart';
import '../../theme/app_sizes.dart';
import '../../theme/app_spacing.dart';

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
    final bottomInset = MediaQuery.paddingOf(context).bottom;
    final hasProminent = prominentIndex >= 0 && prominentIndex < items.length;

    return Material(
      color: Colors.transparent,
      child: SizedBox(
        height:
            AppSizes.bottomNavHeight +
            bottomInset +
            AppSizes.bottomNavBumpHeight,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: PhysicalShape(
                color: AppColors.surfaceContainerLowest,
                elevation: 8,
                shadowColor: AppColors.shadow,
                clipBehavior: Clip.antiAlias,
                clipper: _BottomNavBarClipper(showCenterBump: hasProminent),
                child: SizedBox(
                  height: AppSizes.bottomNavHeight + bottomInset,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      AppSpacing.sm,
                      hasProminent
                          ? AppSizes.bottomNavBumpHeight + AppSpacing.xs
                          : AppSpacing.smPlus,
                      AppSpacing.sm,
                      bottomInset > 0 ? bottomInset : AppSpacing.smPlus,
                    ),
                    child: Row(
                      children: List<Widget>.generate(items.length, (index) {
                        if (index == prominentIndex) {
                          return const Expanded(child: SizedBox.shrink());
                        }

                        final item = items[index];
                        return Expanded(
                          child: _BottomTabItem(
                            item: item,
                            selected: currentIndex == index,
                            onTap: () => onTap?.call(index),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ),
            ),
            if (hasProminent)
              Positioned(
                left: 0,
                right: 0,
                bottom: bottomInset + AppSizes.bottomNavProminentLift,
                child: Center(
                  child: _ProminentTabItem(
                    item: items[prominentIndex],
                    selected: currentIndex == prominentIndex,
                    size: AppSizes.bottomNavProminentSize,
                    onTap: () => onTap?.call(prominentIndex),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _BottomTabItem extends StatelessWidget {
  const _BottomTabItem({
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
        ? AppColors.primaryFixedDim
        : AppColors.onSurfaceVariant;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.xxl),
        splashColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        focusColor: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                selected ? (item.activeIcon ?? item.icon) : item.icon,
                size: AppSizes.iconLg,
                color: foreground,
              ),
              const SizedBox(height: 3),
              SizedBox(
                width: 64,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    item.label,
                    maxLines: 1,
                    softWrap: false,
                    style: TextStyle(
                      fontSize: 10.5,
                      color: foreground,
                      fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                      letterSpacing: 0.12,
                      height: 1.1,
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

class _ProminentTabItem extends StatelessWidget {
  const _ProminentTabItem({
    required this.item,
    required this.selected,
    required this.size,
    required this.onTap,
  });

  final AppBottomNavItem item;
  final bool selected;
  final double size;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    const iconColor = AppColors.onPrimaryContainer;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        splashColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        focusColor: Colors.transparent,
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primaryFixed,
            border: Border.all(
              color: AppColors.surfaceContainerLowest,
              width: 3,
            ),
            boxShadow: const [
              BoxShadow(
                color: AppColors.shadow,
                blurRadius: 18,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                selected ? (item.activeIcon ?? item.icon) : item.icon,
                size: AppSizes.iconLg,
                color: iconColor,
              ),
              const SizedBox(height: 2),
              SizedBox(
                width: 48,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    item.label,
                    maxLines: 1,
                    softWrap: false,
                    style: const TextStyle(
                      fontSize: 10.5,
                      color: iconColor,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.08,
                      height: 1.05,
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

class _BottomNavBarClipper extends CustomClipper<Path> {
  const _BottomNavBarClipper({required this.showCenterBump});

  final bool showCenterBump;

  @override
  Path getClip(Size size) {
    final top = showCenterBump ? AppSizes.bottomNavBumpHeight : 0.0;
    final path = Path()..moveTo(0, size.height);

    path.lineTo(0, top + AppRadius.xxl);
    path.quadraticBezierTo(0, top, AppRadius.xxl, top);

    if (showCenterBump) {
      final centerX = size.width / 2;

      path.lineTo(centerX - AppSizes.bottomNavCenterBumpHalfWidth, top);
      path.cubicTo(centerX - 40, top, centerX - 28, 2, centerX, 2);
      path.cubicTo(
        centerX + 28,
        2,
        centerX + 40,
        top,
        centerX + AppSizes.bottomNavCenterBumpHalfWidth,
        top,
      );
    }

    path.lineTo(size.width - AppRadius.xxl, top);
    path.quadraticBezierTo(size.width, top, size.width, top + AppRadius.xxl);
    path.lineTo(size.width, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant _BottomNavBarClipper oldClipper) {
    return oldClipper.showCenterBump != showCenterBump;
  }
}
