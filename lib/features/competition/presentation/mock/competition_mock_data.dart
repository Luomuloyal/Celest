import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

enum CompetitionLevelFilter {
  all('全部'),
  school('校级'),
  provincial('省级'),
  national('国家级');

  const CompetitionLevelFilter(this.label);

  final String label;
}

class CompetitionStatData {
  const CompetitionStatData({
    required this.label,
    required this.value,
    this.unit = '项',
    required this.accentColor,
  });

  final String label;
  final String value;
  final String unit;
  final Color accentColor;
}

class RecommendedCompetitionData {
  const RecommendedCompetitionData({
    required this.level,
    required this.title,
    required this.description,
    required this.deadline,
    required this.teamInfo,
    required this.headerStartColor,
    required this.headerEndColor,
    this.bookmarked = false,
    this.primaryActionLabel = '立即报名',
    this.secondaryActionLabel = '详情',
  });

  final CompetitionLevelFilter level;
  final String title;
  final String description;
  final DateTime deadline;
  final String teamInfo;
  final Color headerStartColor;
  final Color headerEndColor;
  final bool bookmarked;
  final String primaryActionLabel;
  final String secondaryActionLabel;
}

abstract final class CompetitionMockData {
  static const double statsWideMinWidth = 900;
  static const double recommendationsThreeColumnMinWidth = 1120;
  static const double recommendationsTwoColumnMinWidth = 760;
  static const double statsGridAspectRatio = 1.22;
  static const double recommendationsTwoColumnItemExtent = 430;
  static const double recommendationsThreeColumnItemExtent = 410;

  static const String pageTitle = '赛事';
  static const String searchHint = '搜索比赛名称、主办方...';
  static const String searchButtonLabel = '搜索';

  static const List<CompetitionStatData> stats = <CompetitionStatData>[
    CompetitionStatData(
      label: '累计获奖',
      value: '128',
      accentColor: AppColors.primaryFixed,
    ),
    CompetitionStatData(
      label: '进行中',
      value: '12',
      accentColor: AppColors.tertiaryContainer,
    ),
    CompetitionStatData(
      label: '已完成',
      value: '45',
      accentColor: AppColors.secondaryContainer,
    ),
  ];

  static const String addRecordLabel = '新增记录';

  static const List<CompetitionLevelFilter> categories =
      <CompetitionLevelFilter>[
        CompetitionLevelFilter.all,
        CompetitionLevelFilter.school,
        CompetitionLevelFilter.provincial,
        CompetitionLevelFilter.national,
      ];

  static const String categorySectionTitle = '赛事分类';
  static const String recommendationSectionTitle = '推荐赛事';
  static const String recommendationActionLabel = '查看更多';
  static const String emptyStateTitle = '没有匹配结果';
  static const String emptyStateDescription = '换个关键词试试，或切换赛事分类。';

  static final List<RecommendedCompetitionData> recommendations =
      <RecommendedCompetitionData>[
        RecommendedCompetitionData(
          level: CompetitionLevelFilter.national,
          title: '2024年全国大学生数学建模竞赛',
          description: '培养大学生的创新意识及运用数学方法和计算机技术解决实际问题的能力。',
          deadline: DateTime(2024, 9, 1),
          teamInfo: '组队要求: 3人/队',
          headerStartColor: Color(0xFF1B7BA5),
          headerEndColor: Color(0xFF6BC7F2),
          bookmarked: false,
        ),
        RecommendedCompetitionData(
          level: CompetitionLevelFilter.provincial,
          title: '第十五届"蓝桥杯"全国软件和信息技术专业人才大赛',
          description: '促进软件和信息领域专业技术人才培养，提升高校毕业生的就业竞争力。',
          deadline: DateTime(2024, 3, 15),
          teamInfo: '个人赛',
          headerStartColor: Color(0xFF456272),
          headerEndColor: Color(0xFF4D7081),
          bookmarked: true,
        ),
        RecommendedCompetitionData(
          level: CompetitionLevelFilter.school,
          title: '校园创新创业大赛暨"互联网+"选拔赛',
          description: '激发学生创新创业热情，展示我校创新创业教育成果。',
          deadline: DateTime(2024, 5, 10),
          teamInfo: '组队要求: 3-5人/队',
          headerStartColor: Color(0xFFF2B656),
          headerEndColor: Color(0xFFF3B247),
          bookmarked: false,
        ),
      ];
}
