import 'package:flutter/material.dart';

import '../../../../core/common/layout/app_page_constraints.dart';
import '../../../../core/common/layout/app_page_padding.dart';
import '../../../../core/common/widgets/app_pill.dart';
import '../../../../core/common/widgets/app_pill_button.dart';
import '../../../../core/common/widgets/app_section_card.dart';
import '../../../../core/common/widgets/app_top_bar.dart';
import '../../../../core/constants/app_breakpoints.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_semantic_colors.dart';
import '../../../../core/theme/app_sizes.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/theme_context_extension.dart';
import '../mock/workspace_mock_data.dart';

class WorkspacePage extends StatelessWidget {
  const WorkspacePage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.maxWidth;
        final contentWidth = availableWidth
            .clamp(0.0, AppPageConstraints.dashboard)
            .toDouble();
        final hasBottomNav = availableWidth < AppBreakpoints.tablet;
        final bottomPadding = hasBottomNav
            ? AppSizes.bottomNavHeight +
                  MediaQuery.paddingOf(context).bottom +
                  AppSpacing.xxl
            : AppSpacing.section;

        return Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: AppPageConstraints.dashboard,
            ),
            child: ListView(
              padding: AppPagePadding.content(
                context,
                top: AppSpacing.lg,
                bottom: bottomPadding,
              ),
              children: [
                const _WorkspaceHeader(),
                const SizedBox(height: AppSpacing.lg),
                const _WorkspaceHeroCard(),
                SizedBox(height: AppPagePadding.sectionGap(context)),
                _WorkspaceMainCards(contentWidth: contentWidth),
                const SizedBox(height: AppSpacing.md),
                const _GuidanceRecordsCard(),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _WorkspaceHeader extends StatelessWidget {
  const _WorkspaceHeader();

  @override
  Widget build(BuildContext context) {
    return AppTopBar(
      title: WorkspaceMockData.appTitle,
      height: AppSizes.appBarHeight + AppSpacing.sm,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xs,
        vertical: AppSpacing.xs,
      ),
      leading: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: AppColors.primaryContainer.withValues(alpha: 0.35),
          borderRadius: BorderRadius.circular(AppRadius.full),
        ),
        alignment: Alignment.center,
        child: Icon(
          Icons.person_rounded,
          size: 22,
          color: AppColors.onPrimaryContainer,
        ),
      ),
      trailing: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.notifications_none_rounded),
        color: AppColors.primary,
      ),
    );
  }
}

class _WorkspaceHeroCard extends StatelessWidget {
  const _WorkspaceHeroCard();

  @override
  Widget build(BuildContext context) {
    return AppSectionCard(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final compact =
              constraints.maxWidth < WorkspaceMockData.heroCompactMaxWidth;

          return Stack(
            children: [
              Positioned(
                top: -40,
                right: -30,
                child: Container(
                  width: 170,
                  height: 170,
                  decoration: BoxDecoration(
                    color: AppColors.primaryContainer.withValues(alpha: 0.35),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primaryContainer.withValues(
                          alpha: 0.22,
                        ),
                        blurRadius: 46,
                        spreadRadius: 18,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColors.primary.withValues(alpha: 0.08),
                        AppColors.primaryContainer.withValues(alpha: 0.2),
                      ],
                    ),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    WorkspaceMockData.greetingTitle,
                    style: context.textStyles.displaySmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: compact ? 44 : 42,
                      letterSpacing: -0.8,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(
                        WorkspaceMockData.greetingPrefix,
                        style: context.textStyles.bodyLarge,
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      Text(
                        WorkspaceMockData.greetingHighlight,
                        style: context.textStyles.titleLarge?.copyWith(
                          color: AppColors.error,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      Text(
                        WorkspaceMockData.greetingSuffix,
                        style: context.textStyles.bodyLarge?.copyWith(
                          color: context.colors.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Wrap(
                    spacing: AppSpacing.md,
                    runSpacing: AppSpacing.md,
                    children: [
                      for (final metric in WorkspaceMockData.heroMetrics)
                        _HeroMetricCard(
                          metric: metric,
                          width: compact ? 104 : 128,
                        ),
                    ],
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

class _HeroMetricCard extends StatelessWidget {
  const _HeroMetricCard({required this.metric, required this.width});

  final WorkspaceHeroMetricData metric;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      child: Column(
        children: [
          Text(
            metric.value,
            style: context.textStyles.displaySmall?.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
              fontSize: 42,
              height: 1,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            metric.label,
            style: context.textStyles.bodySmall?.copyWith(
              color: context.colors.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _WorkspaceMainCards extends StatelessWidget {
  const _WorkspaceMainCards({required this.contentWidth});

  final double contentWidth;

  @override
  Widget build(BuildContext context) {
    if (contentWidth >= WorkspaceMockData.mainCardsThreeColumnMinWidth) {
      return const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 2, child: _AiAssistantCard()),
          SizedBox(width: AppSpacing.md),
          Expanded(child: _BatchApprovalCard()),
          SizedBox(width: AppSpacing.md),
          Expanded(child: _WorkloadCard()),
        ],
      );
    }

    if (contentWidth >= WorkspaceMockData.mainCardsTwoColumnMinWidth) {
      return const Column(
        children: [
          _AiAssistantCard(),
          SizedBox(height: AppSpacing.md),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _BatchApprovalCard()),
              SizedBox(width: AppSpacing.md),
              Expanded(child: _WorkloadCard()),
            ],
          ),
        ],
      );
    }

    return const Column(
      children: [
        _AiAssistantCard(),
        SizedBox(height: AppSpacing.md),
        _BatchApprovalCard(),
        SizedBox(height: AppSpacing.md),
        _WorkloadCard(),
      ],
    );
  }
}

class _AiAssistantCard extends StatelessWidget {
  const _AiAssistantCard();

  @override
  Widget build(BuildContext context) {
    return AppSectionCard(
      child: Stack(
        children: [
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.primary.withValues(alpha: 0.04),
                    AppColors.primaryFixedDim.withValues(alpha: 0.12),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: -AppSpacing.lg,
            top: 0,
            bottom: 0,
            child: Container(width: 3, color: AppColors.primaryFixed),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.primaryContainer.withValues(alpha: 0.24),
                      borderRadius: BorderRadius.circular(AppRadius.md),
                    ),
                    child: const Icon(
                      Icons.auto_awesome_rounded,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(
                      WorkspaceMockData.aiAssistantTitle,
                      style: context.textStyles.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const AppPill(
                    label: WorkspaceMockData.aiAssistantPendingLabel,
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                WorkspaceMockData.aiAssistantDescription,
                style: context.textStyles.bodyMedium?.copyWith(
                  color: context.colors.onSurfaceVariant,
                  height: 1.55,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              AppPillButton(
                label: WorkspaceMockData.aiAssistantActionLabel,
                icon: Icons.arrow_forward_rounded,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _BatchApprovalCard extends StatelessWidget {
  const _BatchApprovalCard();

  @override
  Widget build(BuildContext context) {
    return AppSectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.secondaryContainer.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: const Icon(
                  Icons.rule_rounded,
                  color: AppColors.onPrimaryContainer,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  WorkspaceMockData.batchApprovalTitle,
                  style: context.textStyles.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          for (
            var index = 0;
            index < WorkspaceMockData.batchApprovalItems.length;
            index++
          ) ...[
            _TaskGroupRow(item: WorkspaceMockData.batchApprovalItems[index]),
            if (index != WorkspaceMockData.batchApprovalItems.length - 1)
              const SizedBox(height: AppSpacing.sm),
          ],
        ],
      ),
    );
  }
}

class _TaskGroupRow extends StatelessWidget {
  const _TaskGroupRow({required this.item});

  final WorkspaceTaskGroupItemData item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.smPlus,
      ),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              item.label,
              style: context.textStyles.labelLarge?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: item.highlight
                  ? AppSemanticColors.dangerBackground
                  : AppColors.surfaceDim,
              borderRadius: BorderRadius.circular(AppRadius.full),
            ),
            alignment: Alignment.center,
            child: Text(
              item.count.toString(),
              style: context.textStyles.bodySmall?.copyWith(
                color: item.highlight
                    ? AppSemanticColors.dangerForeground
                    : context.colors.onSurfaceVariant,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _WorkloadCard extends StatelessWidget {
  const _WorkloadCard();

  @override
  Widget build(BuildContext context) {
    return AppSectionCard(
      child: Stack(
        children: [
          Positioned(
            right: -42,
            bottom: -42,
            child: Container(
              width: 130,
              height: 130,
              decoration: BoxDecoration(
                color: AppColors.primaryContainer.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.tertiaryContainer.withValues(
                        alpha: 0.32,
                      ),
                      borderRadius: BorderRadius.circular(AppRadius.md),
                    ),
                    child: const Icon(
                      Icons.calculate_rounded,
                      color: AppColors.tertiary,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(
                      WorkspaceMockData.workloadTitle,
                      style: context.textStyles.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                WorkspaceMockData.workloadLabel,
                style: context.textStyles.bodySmall?.copyWith(
                  color: context.colors.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    WorkspaceMockData.workloadValue,
                    style: context.textStyles.displaySmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 54,
                      height: 1,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Text(
                      WorkspaceMockData.workloadUnit,
                      style: context.textStyles.labelLarge?.copyWith(
                        color: context.colors.onSurfaceVariant,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              AppPillButton(
                label: WorkspaceMockData.workloadActionLabel,
                variant: AppPillButtonVariant.muted,
                expanded: true,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _GuidanceRecordsCard extends StatelessWidget {
  const _GuidanceRecordsCard();

  @override
  Widget build(BuildContext context) {
    return AppSectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: Icon(
                  Icons.history_edu_rounded,
                  color: context.colors.onSurfaceVariant,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  WorkspaceMockData.guidanceRecordTitle,
                  style: context.textStyles.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              InkWell(
                borderRadius: BorderRadius.circular(AppRadius.sm),
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.xs,
                    vertical: AppSpacing.xs,
                  ),
                  child: Row(
                    children: [
                      Text(
                        WorkspaceMockData.guidanceRecordActionLabel,
                        style: context.textStyles.labelLarge?.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(width: 2),
                      const Icon(
                        Icons.chevron_right_rounded,
                        color: AppColors.primary,
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          const _GuidanceRecordTable(),
        ],
      ),
    );
  }
}

class _GuidanceRecordTable extends StatelessWidget {
  const _GuidanceRecordTable();

  @override
  Widget build(BuildContext context) {
    final headerStyle = context.textStyles.labelLarge?.copyWith(
      color: context.colors.onSurfaceVariant,
      fontWeight: FontWeight.w500,
    );
    final contentStyle = context.textStyles.bodyMedium?.copyWith(height: 1.6);

    return LayoutBuilder(
      builder: (context, constraints) {
        final compact =
            constraints.maxWidth < WorkspaceMockData.tableCompactMaxWidth;
        final projectWidth = compact
            ? WorkspaceMockData.tableProjectWidthCompact
            : WorkspaceMockData.tableProjectWidthWide;
        final teamWidth = compact
            ? WorkspaceMockData.tableTeamWidthCompact
            : WorkspaceMockData.tableTeamWidthWide;
        final timeWidth = compact
            ? WorkspaceMockData.tableTimeWidthCompact
            : WorkspaceMockData.tableTimeWidthWide;
        final statusWidth = compact
            ? WorkspaceMockData.tableStatusWidthCompact
            : WorkspaceMockData.tableStatusWidthWide;
        final actionWidth = compact
            ? WorkspaceMockData.tableActionWidthCompact
            : WorkspaceMockData.tableActionWidthWide;

        final table = Table(
          columnWidths: <int, TableColumnWidth>{
            0: FixedColumnWidth(projectWidth),
            1: FixedColumnWidth(teamWidth),
            2: FixedColumnWidth(timeWidth),
            3: FixedColumnWidth(statusWidth),
            4: FixedColumnWidth(actionWidth),
          },
          border: const TableBorder(horizontalInside: BorderSide.none),
          children: [
            TableRow(
              children: [
                for (final header in WorkspaceMockData.guidanceTableHeaders)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.sm,
                      0,
                      AppSpacing.sm,
                      AppSpacing.md,
                    ),
                    child: Text(header, style: headerStyle),
                  ),
              ],
            ),
            for (final record in WorkspaceMockData.guidanceRecords)
              TableRow(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.sm,
                      AppSpacing.md,
                      AppSpacing.sm,
                      AppSpacing.md,
                    ),
                    child: Text(record.projectName, style: contentStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.sm,
                      AppSpacing.md,
                      AppSpacing.sm,
                      AppSpacing.md,
                    ),
                    child: Text(
                      record.teamName,
                      style: contentStyle?.copyWith(
                        color: context.colors.onSurfaceVariant,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.sm,
                      AppSpacing.md,
                      AppSpacing.sm,
                      AppSpacing.md,
                    ),
                    child: Text(
                      record.guidanceTime,
                      style: contentStyle?.copyWith(
                        color: context.colors.onSurfaceVariant,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.sm,
                      AppSpacing.md,
                      AppSpacing.sm,
                      AppSpacing.md,
                    ),
                    child: _GuidanceStatusTag(status: record.status),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.sm,
                      AppSpacing.md,
                      AppSpacing.sm,
                      AppSpacing.md,
                    ),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        record.actionLabel,
                        style: context.textStyles.labelLarge?.copyWith(
                          color: record.actionHighlight
                              ? AppColors.primary
                              : context.colors.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
          ],
        );

        if (!compact) {
          return table;
        }

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: table,
        );
      },
    );
  }
}

class _GuidanceStatusTag extends StatelessWidget {
  const _GuidanceStatusTag({required this.status});

  final WorkspaceGuidanceStatus status;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: status.background,
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 5,
            height: 5,
            decoration: BoxDecoration(
              color: status.dotColor,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: AppSpacing.xs),
          Text(
            status.label,
            style: context.textStyles.bodySmall?.copyWith(
              color: status.foreground,
            ),
          ),
        ],
      ),
    );
  }
}
