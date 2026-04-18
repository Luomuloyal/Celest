import 'package:flutter/material.dart';

import '../../theme/app_radius.dart';
import '../../theme/app_spacing.dart';
import '../../theme/theme_context_extension.dart';
import '../../utils/formatters/countdown_formatter.dart';
import '../../utils/formatters/date_time_formatter.dart';
import 'app_pill.dart';
import 'app_pill_button.dart';

class AppCompetitionCard extends StatelessWidget {
  const AppCompetitionCard({
    super.key,
    required this.levelLabel,
    required this.title,
    required this.description,
    this.deadline,
    this.teamInfo,
    this.countdown,
    this.headerColors,
    this.secondaryActionLabel = '详情',
    this.primaryActionLabel = '立即报名',
    this.onSecondaryTap,
    this.onPrimaryTap,
  });

  final String levelLabel;
  final String title;
  final String description;
  final DateTime? deadline;
  final String? teamInfo;
  final Duration? countdown;
  final List<Color>? headerColors;
  final String secondaryActionLabel;
  final String primaryActionLabel;
  final VoidCallback? onSecondaryTap;
  final VoidCallback? onPrimaryTap;

  @override
  Widget build(BuildContext context) {
    final gradientColors = headerColors ??
        <Color>[
          context.appTheme.heroGradientStart,
          context.appTheme.heroGradientEnd,
        ];
    final countdownParts = countdown == null
        ? null
        : CountdownFormatter.toParts(countdown!);

    return Container(
      decoration: BoxDecoration(
        color: context.appTheme.sectionBackground,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(color: context.appTheme.sectionBorder),
        boxShadow: [
          BoxShadow(
            color: context.appTheme.sectionShadow,
            blurRadius: 22,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 108,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: gradientColors,
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(AppRadius.xl),
                topRight: Radius.circular(AppRadius.xl),
              ),
            ),
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppPill(label: levelLabel, tinted: false),
                const Spacer(),
                Icon(
                  Icons.bookmark_border_rounded,
                  color: context.colors.onPrimary,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: context.textStyles.titleLarge),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  description,
                  style: context.textStyles.bodyMedium?.copyWith(
                    color: context.colors.onSurfaceVariant,
                  ),
                ),
                if (countdownParts != null) ...[
                  const SizedBox(height: AppSpacing.lg),
                  Row(
                    children: [
                      _CountdownValue(
                        value: countdownParts.days.toString(),
                        label: '天',
                      ),
                      const SizedBox(width: AppSpacing.lg),
                      _CountdownValue(
                        value: CountdownFormatter.twoDigits(countdownParts.hours),
                        label: '小时',
                      ),
                      const SizedBox(width: AppSpacing.lg),
                      _CountdownValue(
                        value: CountdownFormatter.twoDigits(
                          countdownParts.minutes,
                        ),
                        label: '分钟',
                      ),
                    ],
                  ),
                ],
                if (deadline != null || teamInfo != null) ...[
                  const SizedBox(height: AppSpacing.lg),
                  if (deadline != null)
                    _InfoRow(
                      icon: Icons.calendar_today_outlined,
                      text: '报名截止: ${DateTimeFormatter.formatYmd(deadline!)}',
                    ),
                  if (teamInfo != null) ...[
                    const SizedBox(height: AppSpacing.sm),
                    _InfoRow(
                      icon: Icons.group_outlined,
                      text: teamInfo!,
                    ),
                  ],
                ],
                const SizedBox(height: AppSpacing.lg),
                Row(
                  children: [
                    Expanded(
                      child: AppPillButton(
                        label: secondaryActionLabel,
                        onPressed: onSecondaryTap,
                        variant: AppPillButtonVariant.muted,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: AppPillButton(
                        label: primaryActionLabel,
                        onPressed: onPrimaryTap,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CountdownValue extends StatelessWidget {
  const _CountdownValue({
    required this.value,
    required this.label,
  });

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: context.textStyles.headlineMedium?.copyWith(
            fontSize: 22,
            color: context.colors.primary,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          label,
          style: context.textStyles.bodySmall?.copyWith(
            color: context.colors.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.text,
  });

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: context.colors.onSurfaceVariant),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Text(
            text,
            style: context.textStyles.bodySmall?.copyWith(
              color: context.colors.onSurfaceVariant,
            ),
          ),
        ),
      ],
    );
  }
}
