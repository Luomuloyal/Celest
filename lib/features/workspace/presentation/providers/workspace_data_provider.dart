import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/mock/workspace_mock_data.dart';

final workspaceViewDataProvider = Provider<WorkspaceViewData>(
  (ref) => const WorkspaceViewData(),
);

class WorkspaceViewData {
  const WorkspaceViewData();

  List<WorkspaceHeroMetricData> get heroMetrics => WorkspaceMockData.heroMetrics;
  List<WorkspaceTaskGroupItemData> get batchApprovalItems =>
      WorkspaceMockData.batchApprovalItems;
  List<String> get guidanceTableHeaders => WorkspaceMockData.guidanceTableHeaders;
  List<WorkspaceGuidanceRecordData> get guidanceRecords =>
      WorkspaceMockData.guidanceRecords;

  String get appTitle => WorkspaceMockData.appTitle;
  String get greetingTitle => WorkspaceMockData.greetingTitle;
  String get greetingPrefix => WorkspaceMockData.greetingPrefix;
  String get greetingHighlight => WorkspaceMockData.greetingHighlight;
  String get greetingSuffix => WorkspaceMockData.greetingSuffix;
  String get aiAssistantTitle => WorkspaceMockData.aiAssistantTitle;
  String get aiAssistantPendingLabel => WorkspaceMockData.aiAssistantPendingLabel;
  String get aiAssistantDescription => WorkspaceMockData.aiAssistantDescription;
  String get aiAssistantActionLabel => WorkspaceMockData.aiAssistantActionLabel;
  String get batchApprovalTitle => WorkspaceMockData.batchApprovalTitle;
  String get workloadTitle => WorkspaceMockData.workloadTitle;
  String get workloadLabel => WorkspaceMockData.workloadLabel;
  String get workloadValue => WorkspaceMockData.workloadValue;
  String get workloadUnit => WorkspaceMockData.workloadUnit;
  String get workloadActionLabel => WorkspaceMockData.workloadActionLabel;
  String get guidanceRecordTitle => WorkspaceMockData.guidanceRecordTitle;
  String get guidanceRecordActionLabel =>
      WorkspaceMockData.guidanceRecordActionLabel;

  double get mainCardsThreeColumnMinWidth =>
      WorkspaceMockData.mainCardsThreeColumnMinWidth;
  double get mainCardsTwoColumnMinWidth =>
      WorkspaceMockData.mainCardsTwoColumnMinWidth;
  double get heroCompactMaxWidth => WorkspaceMockData.heroCompactMaxWidth;
  double get tableCompactMaxWidth => WorkspaceMockData.tableCompactMaxWidth;
  double get tableProjectWidthCompact => WorkspaceMockData.tableProjectWidthCompact;
  double get tableProjectWidthWide => WorkspaceMockData.tableProjectWidthWide;
  double get tableTeamWidthCompact => WorkspaceMockData.tableTeamWidthCompact;
  double get tableTeamWidthWide => WorkspaceMockData.tableTeamWidthWide;
  double get tableTimeWidthCompact => WorkspaceMockData.tableTimeWidthCompact;
  double get tableTimeWidthWide => WorkspaceMockData.tableTimeWidthWide;
  double get tableStatusWidthCompact => WorkspaceMockData.tableStatusWidthCompact;
  double get tableStatusWidthWide => WorkspaceMockData.tableStatusWidthWide;
  double get tableActionWidthCompact => WorkspaceMockData.tableActionWidthCompact;
  double get tableActionWidthWide => WorkspaceMockData.tableActionWidthWide;
}
