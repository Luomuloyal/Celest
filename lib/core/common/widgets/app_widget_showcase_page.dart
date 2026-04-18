import 'package:flutter/material.dart';

import '../../theme/app_spacing.dart';
import '../../theme/theme_context_extension.dart';
import 'app_action_tile.dart';
import 'app_input_field.dart';
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
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.md),
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
                    Text('欢迎回来, Alex'),
                    SizedBox(height: AppSpacing.md),
                    Text('浅色和深色主题、通知兜底与通用页面组件已经就绪。'),
                    SizedBox(height: AppSpacing.lg),
                    AppPillButton(
                      label: '查看我的工作台',
                      icon: Icons.arrow_forward,
                      variant: AppPillButtonVariant.muted,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
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
              const SizedBox(height: AppSpacing.xl),
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
              const SizedBox(height: AppSpacing.xl),
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
    );
  }
}
