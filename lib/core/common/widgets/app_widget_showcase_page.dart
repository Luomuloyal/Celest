import 'package:flutter/material.dart';

import '../layout/app_page_constraints.dart';
import '../layout/app_page_padding.dart';
import '../../theme/app_semantic_colors.dart';
import '../../theme/app_spacing.dart';
import '../../theme/theme_context_extension.dart';
import 'app_action_tile.dart';
import 'app_empty_state.dart';
import 'app_error_state.dart';
import 'app_input_field.dart';
import 'app_loading_state.dart';
import 'app_pill.dart';
import 'app_pill_button.dart';
import 'app_section_card.dart';
import 'app_section_header.dart';
import 'app_timeline_item.dart';

class AppWidgetShowcasePage extends StatelessWidget {
  const AppWidgetShowcasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Celest'),
      ),
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              context.appTheme.pageGradientStart,
              context.appTheme.pageGradientEnd,
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: AppPageConstraints.dashboard,
              ),
              child: ListView(
                padding: AppPagePadding.content(context),
                children: [
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.xl),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          context.appTheme.heroGradientStart,
                          context.appTheme.heroGradientEnd,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(28),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Celest Design System'),
                        SizedBox(height: AppSpacing.md),
                        Text('优先补齐语义颜色、页面布局规则和统一状态组件。'),
                        SizedBox(height: AppSpacing.lg),
                        AppPillButton(
                          label: '查看基础件',
                          icon: Icons.arrow_downward,
                          variant: AppPillButtonVariant.muted,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: AppPagePadding.sectionGap(context)),
                  const AppSectionCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppSectionHeader(title: '语义颜色'),
                        SizedBox(height: AppSpacing.lg),
                        Wrap(
                          spacing: AppSpacing.md,
                          runSpacing: AppSpacing.md,
                          children: [
                            _ColorTokenTile(
                              label: 'Info',
                              background: AppSemanticColors.infoBackground,
                              foreground: AppSemanticColors.infoForeground,
                            ),
                            _ColorTokenTile(
                              label: 'Success',
                              background: AppSemanticColors.successBackground,
                              foreground: AppSemanticColors.successForeground,
                            ),
                            _ColorTokenTile(
                              label: 'Warning',
                              background: AppSemanticColors.warningBackground,
                              foreground: AppSemanticColors.warningForeground,
                            ),
                            _ColorTokenTile(
                              label: 'Danger',
                              background: AppSemanticColors.dangerBackground,
                              foreground: AppSemanticColors.dangerForeground,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: AppPagePadding.sectionGap(context)),
                  const AppSectionCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppSectionHeader(title: '统一状态'),
                        SizedBox(height: AppSpacing.lg),
                        AppLoadingState(
                          title: '正在同步设计资源',
                          description: '统一状态页适合在列表、详情和弹窗里复用。',
                        ),
                        SizedBox(height: AppSpacing.xl),
                        AppEmptyState(
                          title: '暂无可展示内容',
                          description: '空状态保持轻量、明确，并提供下一步操作。',
                          actionLabel: '新建内容',
                        ),
                        SizedBox(height: AppSpacing.xl),
                        AppErrorState(
                          title: '加载失败',
                          description: '错误状态建议只保留一条核心信息和一个重试动作。',
                          retryLabel: '重新加载',
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: AppPagePadding.sectionGap(context)),
                  const AppSectionCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppSectionHeader(title: '快捷操作'),
                        SizedBox(height: AppSpacing.md),
                        Row(
                          children: [
                            Expanded(
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: AppActionTile(
                                  icon: Icons.app_registration,
                                  label: '报名',
                                ),
                              ),
                            ),
                            SizedBox(width: AppSpacing.md),
                            Expanded(
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: AppActionTile(
                                  icon: Icons.groups_2_outlined,
                                  label: '组队',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: AppPagePadding.sectionGap(context)),
                  const AppSectionCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppSectionHeader(title: '实时动态', actionLabel: '查看全部'),
                        SizedBox(height: AppSpacing.lg),
                        AppTimelineItem(
                          icon: Icons.celebration_outlined,
                          title: '团队“星火计划”成功晋级决赛',
                          subtitle: '10分钟前 · 全国创新挑战赛',
                        ),
                        AppTimelineItem(
                          icon: Icons.assignment_outlined,
                          title: '导师对项目方案提出了新建议',
                          subtitle: '2小时前 · 项目指导',
                        ),
                        AppTimelineItem(
                          icon: Icons.event_note_outlined,
                          title: '“数学乡村”赛道报名即将截止',
                          subtitle: '昨天 14:30 · 系统通知',
                          showConnector: false,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: AppPagePadding.sectionGap(context)),
                  const AppSectionCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppSectionHeader(title: '交互组件'),
                        SizedBox(height: AppSpacing.lg),
                        Wrap(
                          spacing: AppSpacing.sm,
                          runSpacing: AppSpacing.sm,
                          children: [
                            AppPill(label: '报名中'),
                            AppPill(label: 'AI科技赛道', tinted: false),
                          ],
                        ),
                        SizedBox(height: AppSpacing.lg),
                        AppInputField(
                          hintText: '搜索比赛名称、导师或资源',
                          prefixIcon: Icon(Icons.search),
                        ),
                        SizedBox(height: AppSpacing.lg),
                        Row(
                          children: [
                            Expanded(
                              child: AppPillButton(
                                label: '主操作',
                                variant: AppPillButtonVariant.filled,
                              ),
                            ),
                            SizedBox(width: AppSpacing.md),
                            Expanded(
                              child: AppPillButton(
                                label: '次操作',
                                variant: AppPillButtonVariant.muted,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ColorTokenTile extends StatelessWidget {
  const _ColorTokenTile({
    required this.label,
    required this.background,
    required this.foreground,
  });

  final String label;
  final Color background;
  final Color foreground;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Text(
        label,
        style: context.textStyles.labelLarge?.copyWith(color: foreground),
      ),
    );
  }
}
