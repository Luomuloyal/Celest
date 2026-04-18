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
    this.footer,
    this.trailing,
  });

  final String title;
  final String subtitle;
  final String? actionLabel;
  final IconData? actionIcon;
  final VoidCallback? onActionTap;
  final Widget? footer;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            context.appTheme.heroGradientStart,
            context.appTheme.heroGradientEnd,
          ],
        ),
        borderRadius: BorderRadius.circular(28),
      ),
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (trailing != null)
            Align(
              alignment: Alignment.topRight,
              child: trailing!,
            ),
          Text(
            title,
            style: context.textStyles.headlineMedium?.copyWith(
              color: context.colors.onPrimary,
              fontSize: 24,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            subtitle,
            style: context.textStyles.bodyMedium?.copyWith(
              color: context.colors.onPrimary.withValues(alpha: 0.88),
            ),
          ),
          if (actionLabel != null) ...[
            const SizedBox(height: AppSpacing.lg),
            AppPillButton(
              label: actionLabel!,
              icon: actionIcon,
              onPressed: onActionTap,
              variant: AppPillButtonVariant.muted,
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
