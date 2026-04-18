import 'package:flutter/material.dart';

import '../../theme/app_radius.dart';
import '../../theme/app_spacing.dart';
import '../../theme/theme_context_extension.dart';

class AppPill extends StatelessWidget {
  const AppPill({
    super.key,
    required this.label,
    this.leading,
    this.tinted = true,
  });

  final String label;
  final Widget? leading;
  final bool tinted;

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.smPlus,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: tinted ? appTheme.pillBackground : appTheme.pillMutedBackground,
        borderRadius: BorderRadius.circular(AppRadius.full),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (leading != null) ...[
            leading!,
            const SizedBox(width: AppSpacing.xs),
          ],
          Text(
            label,
            style: context.textStyles.bodySmall?.copyWith(
              color: tinted
                  ? appTheme.pillForeground
                  : appTheme.pillMutedForeground,
            ),
          ),
        ],
      ),
    );
  }
}
