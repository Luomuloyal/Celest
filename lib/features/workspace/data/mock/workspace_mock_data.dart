import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class WorkspaceHeroMetricData {
  const WorkspaceHeroMetricData({required this.value, required this.label});

  final String value;
  final String label;
}

class WorkspaceTaskGroupItemData {
  const WorkspaceTaskGroupItemData({
    required this.label,
    required this.count,
    required this.highlight,
  });

  final String label;
  final int count;
  final bool highlight;
}

enum WorkspaceGuidanceStatus {
  pending(
    label: '待填写记录',
    background: Color(0xFFE4F3FB),
    foreground: Color(0xFF355B6C),
    dotColor: AppColors.secondary,
  ),
  archived(
    label: '已归档',
    background: AppColors.surfaceContainerLow,
    foreground: AppColors.onSurfaceVariant,
    dotColor: AppColors.outline,
  );

  const WorkspaceGuidanceStatus({
    required this.label,
    required this.background,
    required this.foreground,
    required this.dotColor,
  });

  final String label;
  final Color background;
  final Color foreground;
  final Color dotColor;
}

class WorkspaceGuidanceRecordData {
  const WorkspaceGuidanceRecordData({
    required this.projectName,
    required this.teamName,
    required this.guidanceTime,
    required this.status,
    required this.actionLabel,
    required this.actionHighlight,
  });

  final String projectName;
  final String teamName;
  final String guidanceTime;
  final WorkspaceGuidanceStatus status;
  final String actionLabel;
  final bool actionHighlight;
}

abstract final class WorkspaceMockData {
  static const double mainCardsThreeColumnMinWidth = 980;
  static const double mainCardsTwoColumnMinWidth = 700;
  static const double heroCompactMaxWidth = 540;
  static const double tableCompactMaxWidth = 640;
  static const double tableProjectWidthCompact = 128;
  static const double tableProjectWidthWide = 220;
  static const double tableTeamWidthCompact = 84;
  static const double tableTeamWidthWide = 120;
  static const double tableTimeWidthCompact = 84;
  static const double tableTimeWidthWide = 120;
  static const double tableStatusWidthCompact = 96;
  static const double tableStatusWidthWide = 140;
  static const double tableActionWidthCompact = 56;
  static const double tableActionWidthWide = 76;

  static const String appTitle = '赛育通';
  static const String greetingTitle = '早上好，李老师';
  static const String greetingPrefix = '您今天有';
  static const String greetingHighlight = '12';
  static const String greetingSuffix = '项待处理任务，建议优先处理项目评审。';

  static const List<WorkspaceHeroMetricData> heroMetrics =
      <WorkspaceHeroMetricData>[
        WorkspaceHeroMetricData(value: '12', label: '待办任务'),
        WorkspaceHeroMetricData(value: '5', label: '今日指导'),
      ];

  static const String aiAssistantTitle = 'AI评审助手';
  static const String aiAssistantPendingLabel = '8 份待评';
  static const String aiAssistantDescription =
      '系统已对提交的8份创新创业项目计划书进行了初步分析，发现3份存在查重率过高风险，建议优先人工复核。';
  static const String aiAssistantActionLabel = '开始评审';

  static const String batchApprovalTitle = '批量审批';
  static const List<WorkspaceTaskGroupItemData> batchApprovalItems =
      <WorkspaceTaskGroupItemData>[
        WorkspaceTaskGroupItemData(label: '团队组建申请', count: 4, highlight: true),
        WorkspaceTaskGroupItemData(label: '经费报销', count: 0, highlight: false),
      ];

  static const String workloadTitle = '工作量核算';
  static const String workloadLabel = '本月累计指导时长';
  static const String workloadValue = '24.5';
  static const String workloadUnit = '小时';
  static const String workloadActionLabel = '查看明细';

  static const String guidanceRecordTitle = '近期指导记录';
  static const String guidanceRecordActionLabel = '全部记录';

  static const List<String> guidanceTableHeaders = <String>[
    '项目名称',
    '团队/学生',
    '指导时间',
    '状态',
    '操作',
  ];

  static const List<WorkspaceGuidanceRecordData> guidanceRecords =
      <WorkspaceGuidanceRecordData>[
        WorkspaceGuidanceRecordData(
          projectName: '智能农业监测系统',
          teamName: '张三团队',
          guidanceTime: '今天 14:00',
          status: WorkspaceGuidanceStatus.pending,
          actionLabel: '补录',
          actionHighlight: true,
        ),
        WorkspaceGuidanceRecordData(
          projectName: '城市微型储能方案',
          teamName: '李四团队',
          guidanceTime: '昨天 10:30',
          status: WorkspaceGuidanceStatus.archived,
          actionLabel: '查看',
          actionHighlight: false,
        ),
      ];
}
