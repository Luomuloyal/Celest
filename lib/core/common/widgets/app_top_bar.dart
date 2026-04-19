import 'package:flutter/material.dart';

import '../../theme/app_sizes.dart';
import '../../theme/app_spacing.dart';
import '../../theme/theme_context_extension.dart';

class AppTopBar extends StatelessWidget {
  const AppTopBar({
    super.key,
    this.leading,
    required this.title,
    this.trailing,
    this.centerTitle = true,
    this.sideWidth = 72,
    this.height = AppSizes.appBarHeight + AppSpacing.md,
    this.padding = const EdgeInsets.symmetric(
      horizontal: AppSpacing.md,
      vertical: AppSpacing.sm,
    ),
  });

  final Widget? leading;
  final String title;
  final Widget? trailing;
  final bool centerTitle;
  final double sideWidth;
  final double height;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Padding(
        padding: padding,
        child: Row(
          children: [
            SizedBox(
              width: sideWidth,
              child: Align(
                alignment: Alignment.centerLeft,
                child: leading ?? const SizedBox.shrink(),
              ),
            ),
            Expanded(
              child: Align(
                alignment: centerTitle
                    ? Alignment.center
                    : Alignment.centerLeft,
                child: Text(
                  title,
                  style: context.textStyles.headlineMedium?.copyWith(
                    fontSize: 18,
                    color: context.colors.onSurface,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: sideWidth,
              child: Align(
                alignment: Alignment.centerRight,
                child: trailing ?? const SizedBox.shrink(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
