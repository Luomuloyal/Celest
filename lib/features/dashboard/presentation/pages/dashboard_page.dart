import 'package:flutter/material.dart';

import '../../../../core/common/layout/app_page_constraints.dart';
import '../../../../core/common/layout/app_page_padding.dart';
import '../../../../core/common/widgets/app_action_tile.dart';
import '../../../../core/common/widgets/app_hero_banner.dart';
import '../../../../core/common/widgets/app_pill.dart';
import '../../../../core/common/widgets/app_pill_button.dart';
import '../../../../core/common/widgets/app_section_card.dart';
import '../../../../core/common/widgets/app_section_header.dart';
import '../../../../core/common/widgets/app_timeline_item.dart';
import '../../../../core/constants/app_breakpoints.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_sizes.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/theme_context_extension.dart';
import '../mock/dashboard_mock_data.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.maxWidth;
        final contentWidth = availableWidth
            .clamp(0.0, AppPageConstraints.dashboard)
            .toDouble();
        final showPrimarySplit =
            contentWidth >= DashboardMockData.primarySplitMinWidth;
        final showSecondarySplit =
            contentWidth >= DashboardMockData.secondarySplitMinWidth;
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
                _DashboardHero(contentWidth: contentWidth),
                SizedBox(height: AppPagePadding.sectionGap(context)),
                if (showPrimarySplit)
                  const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 2, child: _CompetitionCountdownCard()),
                      SizedBox(width: AppSpacing.lg),
                      Expanded(child: _QuickActionsCard()),
                    ],
                  )
                else
                  const Column(
                    children: [
                      _CompetitionCountdownCard(),
                      SizedBox(height: AppSpacing.lg),
                      _QuickActionsCard(),
                    ],
                  ),
                SizedBox(height: AppPagePadding.sectionGap(context)),
                if (showSecondarySplit)
                  const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: _LiveUpdatesCard()),
                      SizedBox(width: AppSpacing.lg),
                      Expanded(child: _BenchmarkCaseCard()),
                    ],
                  )
                else
                  const Column(
                    children: [
                      _LiveUpdatesCard(),
                      SizedBox(height: AppSpacing.lg),
                      _BenchmarkCaseCard(),
                    ],
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _DashboardHero extends StatelessWidget {
  const _DashboardHero({required this.contentWidth});

  final double contentWidth;

  @override
  Widget build(BuildContext context) {
    final titleSize = (contentWidth * DashboardMockData.heroTitleScaleFactor)
        .clamp(
          DashboardMockData.heroTitleMinSize,
          DashboardMockData.heroTitleMaxSize,
        )
        .toDouble();
    final subtitleSize =
        (contentWidth * DashboardMockData.heroSubtitleScaleFactor)
            .clamp(
              DashboardMockData.heroSubtitleMinSize,
              DashboardMockData.heroSubtitleMaxSize,
            )
            .toDouble();
    final horizontalPadding =
        contentWidth < DashboardMockData.heroCompactMaxWidth
        ? AppSpacing.lg
        : AppSpacing.xxl;
    final verticalPadding = contentWidth < DashboardMockData.heroCompactMaxWidth
        ? AppSpacing.lg
        : AppSpacing.xl;

    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.xxl),
      child: Stack(
        children: [
          Positioned(
            top: -120,
            right: -54,
            child: _HeroGlow(
              size: 280,
              color: context.colors.onPrimary.withValues(alpha: 0.14),
            ),
          ),
          Positioned(
            bottom: -96,
            right: contentWidth * 0.12,
            child: _HeroGlow(
              size: 220,
              color: AppColors.primaryFixed.withValues(alpha: 0.26),
            ),
          ),
          AppHeroBanner(
            title: DashboardMockData.hero.title,
            subtitle: DashboardMockData.hero.subtitle,
            actionLabel: DashboardMockData.hero.actionLabel,
            actionIcon: Icons.arrow_forward_rounded,
            onActionTap: () {},
            actionForegroundColor: AppColors.onPrimaryContainer,
            actionBackgroundColor: AppColors.surfaceContainerLowest,
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: verticalPadding,
            ),
            titleStyle: context.textStyles.displaySmall?.copyWith(
              fontSize: titleSize,
              color: context.colors.onPrimary,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.6,
              height: 1.05,
            ),
            subtitleStyle: context.textStyles.bodyLarge?.copyWith(
              fontSize: subtitleSize,
              color: context.colors.onPrimary.withValues(alpha: 0.7),
            ),
            gradientColors: DashboardMockData.hero.gradientColors,
          ),
        ],
      ),
    );
  }
}

class _HeroGlow extends StatelessWidget {
  const _HeroGlow({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
          boxShadow: [
            BoxShadow(color: color, blurRadius: 90, spreadRadius: 26),
          ],
        ),
      ),
    );
  }
}

class _CompetitionCountdownCard extends StatelessWidget {
  const _CompetitionCountdownCard();

  @override
  Widget build(BuildContext context) {
    final countdown = DashboardMockData.countdown;

    return AppSectionCard(
      padding: EdgeInsets.zero,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final compact =
              constraints.maxWidth < DashboardMockData.heroCompactMaxWidth;

          return ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.xl),
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  top: 0,
                  bottom: 0,
                  child: Container(width: 3, color: AppColors.primaryFixed),
                ),
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerRight,
                        end: Alignment.centerLeft,
                        colors: [
                          AppColors.primaryFixed.withValues(alpha: 0.24),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(
                    compact ? AppSpacing.lg : AppSpacing.xlMinus,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          AppPill(
                            label: countdown.statusLabel,
                            leading: Container(
                              width: 6,
                              height: 6,
                              decoration: const BoxDecoration(
                                color: AppColors.primary,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Icon(
                            Icons.more_horiz_rounded,
                            color: context.colors.onSurfaceVariant,
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Text(
                        countdown.title,
                        style: context.textStyles.displaySmall?.copyWith(
                          fontSize: compact ? 34 : 52,
                          fontWeight: FontWeight.w700,
                          height: 1.08,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        countdown.subtitle,
                        style: context.textStyles.bodyMedium?.copyWith(
                          color: context.colors.onSurfaceVariant,
                        ),
                      ),
                      SizedBox(height: compact ? AppSpacing.lg : AppSpacing.xl),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _CountdownBlock(
                            value: countdown.days,
                            unit: countdown.daysUnitLabel,
                          ),
                          _CountdownSeparator(label: countdown.separatorLabel),
                          _CountdownBlock(
                            value: countdown.hours,
                            unit: countdown.hoursUnitLabel,
                          ),
                          _CountdownSeparator(label: countdown.separatorLabel),
                          _CountdownBlock(
                            value: countdown.minutes,
                            unit: countdown.minutesUnitLabel,
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.xlMinus),
                      Wrap(
                        spacing: AppSpacing.smPlus,
                        runSpacing: AppSpacing.smPlus,
                        children: [
                          AppPillButton(
                            label: countdown.primaryActionLabel,
                            onPressed: () {},
                          ),
                          AppPillButton(
                            label: countdown.secondaryActionLabel,
                            variant: AppPillButtonVariant.muted,
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _CountdownBlock extends StatelessWidget {
  const _CountdownBlock({required this.value, required this.unit});

  final String value;
  final String unit;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: context.textStyles.displaySmall?.copyWith(
            color: AppColors.primary,
            fontSize: 54,
            fontWeight: FontWeight.w800,
            letterSpacing: -1.2,
            height: 1,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          unit,
          style: context.textStyles.labelLarge?.copyWith(
            color: context.colors.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

class _CountdownSeparator extends StatelessWidget {
  const _CountdownSeparator({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: Text(
        label,
        style: context.textStyles.displaySmall?.copyWith(
          color: AppColors.outlineVariant,
          fontWeight: FontWeight.w400,
          fontSize: 52,
          height: 1.1,
        ),
      ),
    );
  }
}

class _QuickActionsCard extends StatelessWidget {
  const _QuickActionsCard();

  @override
  Widget build(BuildContext context) {
    return AppSectionCard(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final aspectRatio =
              constraints.maxWidth <
                  DashboardMockData.quickActionCompactMaxWidth
              ? 1.0
              : DashboardMockData.quickActionAspectRatio;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppSectionHeader(title: DashboardMockData.quickActionTitle),
              const SizedBox(height: AppSpacing.md),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: DashboardMockData.quickActions.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: AppSpacing.md,
                  crossAxisSpacing: AppSpacing.md,
                  childAspectRatio: aspectRatio,
                ),
                itemBuilder: (context, index) {
                  final action = DashboardMockData.quickActions[index];
                  return AppActionTile(
                    icon: action.icon,
                    label: action.label,
                    tint: action.tint,
                    onTap: () {},
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

class _LiveUpdatesCard extends StatelessWidget {
  const _LiveUpdatesCard();

  @override
  Widget build(BuildContext context) {
    final liveUpdates = DashboardMockData.liveUpdates;

    return AppSectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppSectionHeader(
            title: DashboardMockData.liveUpdateTitle,
            actionLabel: DashboardMockData.liveUpdateActionLabel,
          ),
          const SizedBox(height: AppSpacing.lg),
          for (var index = 0; index < liveUpdates.length; index++)
            AppTimelineItem(
              icon: liveUpdates[index].icon,
              title: liveUpdates[index].title,
              subtitle: liveUpdates[index].subtitle,
              showConnector: liveUpdates[index].showConnector,
              tint: liveUpdates[index].tint,
            ),
        ],
      ),
    );
  }
}

class _BenchmarkCaseCard extends StatelessWidget {
  const _BenchmarkCaseCard();

  @override
  Widget build(BuildContext context) {
    final benchmarkCase = DashboardMockData.benchmarkCase;

    return AppSectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: AppSectionHeader(
                  title: DashboardMockData.benchmarkTitle,
                ),
              ),
              AppPill(label: benchmarkCase.categoryLabel, tinted: false),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.lg),
            child: AspectRatio(
              aspectRatio: 1.86,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(benchmarkCase.imageUrl, fit: BoxFit.cover),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          context.colors.onSurface.withValues(alpha: 0.86),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: AppSpacing.md,
                    right: AppSpacing.md,
                    bottom: AppSpacing.md,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.emoji_events_rounded,
                              size: AppSizes.iconSm,
                              color: AppColors.primaryFixed,
                            ),
                            const SizedBox(width: AppSpacing.xs),
                            Text(
                              benchmarkCase.badgeLabel,
                              style: context.textStyles.bodySmall?.copyWith(
                                color: AppColors.primaryFixed,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          benchmarkCase.title,
                          style: context.textStyles.titleLarge?.copyWith(
                            color: context.colors.onPrimary,
                            fontWeight: FontWeight.w700,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            benchmarkCase.description,
            style: context.textStyles.bodyMedium?.copyWith(
              color: context.colors.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(AppRadius.full),
                child: Image.network(
                  benchmarkCase.avatarUrl,
                  width: 28,
                  height: 28,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  benchmarkCase.teamLabel,
                  style: context.textStyles.bodySmall?.copyWith(
                    color: context.colors.onSurfaceVariant,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
