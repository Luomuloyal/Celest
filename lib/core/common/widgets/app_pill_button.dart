import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_radius.dart';
import '../../theme/app_sizes.dart';
import '../../theme/app_spacing.dart';
import '../../theme/theme_context_extension.dart';

enum AppPillButtonVariant {
  filled,
  muted,
  outlined,
}

class AppPillButton extends StatelessWidget {
  const AppPillButton({
    super.key,
    required this.label,
    this.icon,
    this.onPressed,
    this.variant = AppPillButtonVariant.filled,
    this.expanded = false,
  });

  final String label;
  final IconData? icon;
  final VoidCallback? onPressed;
  final AppPillButtonVariant variant;
  final bool expanded;

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    final foreground = switch (variant) {
      AppPillButtonVariant.filled => context.colors.onPrimary,
      AppPillButtonVariant.muted => context.colors.onSurface,
      AppPillButtonVariant.outlined => context.colors.onSurface,
    };
    final background = switch (variant) {
      AppPillButtonVariant.filled => context.colors.primary,
      AppPillButtonVariant.muted => appTheme.pillMutedBackground,
      AppPillButtonVariant.outlined => Colors.transparent,
    };

    final button = TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        minimumSize: const Size(0, AppSizes.buttonHeight),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.sm,
        ),
        backgroundColor: background,
        foregroundColor: foreground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.full),
          side: variant == AppPillButtonVariant.outlined
              ? const BorderSide(color: AppColors.outlineVariant)
              : BorderSide.none,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: context.textStyles.labelLarge?.copyWith(color: foreground),
          ),
          if (icon != null) ...[
            const SizedBox(width: AppSpacing.sm),
            Icon(icon, size: AppSizes.iconSm),
          ],
        ],
      ),
    );

    if (expanded) {
      return SizedBox(width: double.infinity, child: button);
    }

    return button;
  }
}
