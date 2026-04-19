import 'package:flutter/material.dart';

import '../../theme/app_spacing.dart';
import '../../theme/theme_context_extension.dart';
import 'app_pill_button.dart';

class AppHeroBanner extends StatelessWidget {
  const AppHeroBanner({
    super.key,
    required this.title,
    required this.subtitle,
    this.actionLabel,
    this.actionIcon,
    this.onActionTap,
    this.actionVariant = AppPillButtonVariant.muted,
    this.actionForegroundColor,
    this.actionBackgroundColor,
    this.footer,
    this.trailing,
    this.padding = const EdgeInsets.all(AppSpacing.xl),
    this.borderRadius = 28,
    this.gradientColors,
    this.titleStyle,
    this.subtitleStyle,
  });

  final String title;
  final String subtitle;
  final String? actionLabel;
  final IconData? actionIcon;
  final VoidCallback? onActionTap;
  final AppPillButtonVariant actionVariant;
  final Color? actionForegroundColor;
  final Color? actionBackgroundColor;
  final Widget? footer;
  final Widget? trailing;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final List<Color>? gradientColors;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;

  @override
  Widget build(BuildContext context) {
    final titleBaseStyle =
        context.textStyles.headlineMedium?.copyWith(
          color: context.colors.onPrimary,
          fontSize: 24,
        ) ??
        TextStyle(
          color: context.colors.onPrimary,
          fontSize: 24,
          fontWeight: FontWeight.w600,
        );
    final subtitleBaseStyle =
        context.textStyles.bodyMedium?.copyWith(
          color: context.colors.onPrimary.withValues(alpha: 0.88),
        ) ??
        TextStyle(
          color: context.colors.onPrimary.withValues(alpha: 0.88),
          fontSize: 15,
          fontWeight: FontWeight.w400,
        );
    final colors =
        gradientColors ??
        <Color>[
          context.appTheme.heroGradientStart,
          context.appTheme.heroGradientEnd,
        ];

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: colors,
        ),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (trailing != null)
            Align(alignment: Alignment.topRight, child: trailing!),
          Text(title, style: titleBaseStyle.merge(titleStyle)),
          const SizedBox(height: AppSpacing.md),
          Text(subtitle, style: subtitleBaseStyle.merge(subtitleStyle)),
          if (actionLabel != null) ...[
            const SizedBox(height: AppSpacing.lg),
            AppPillButton(
              label: actionLabel!,
              icon: actionIcon,
              onPressed: onActionTap,
              variant: actionVariant,
              foregroundColor: actionForegroundColor,
              backgroundColor: actionBackgroundColor,
            ),
          ],
          if (footer != null) ...[
            const SizedBox(height: AppSpacing.lg),
            footer!,
          ],
        ],
      ),
    );
  }
}
