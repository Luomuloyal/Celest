import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/mock/competition_mock_data.dart';

final competitionViewDataProvider = Provider<CompetitionViewData>(
  (ref) => const CompetitionViewData(),
);

class CompetitionViewData {
  const CompetitionViewData();

  List<CompetitionStatData> get stats => CompetitionMockData.stats;
  List<CompetitionLevelFilter> get categories => CompetitionMockData.categories;
  List<RecommendedCompetitionData> get recommendations =>
      CompetitionMockData.recommendations;

  String get pageTitle => CompetitionMockData.pageTitle;
  String get searchHint => CompetitionMockData.searchHint;
  String get searchButtonLabel => CompetitionMockData.searchButtonLabel;
  String get addRecordLabel => CompetitionMockData.addRecordLabel;
  String get categorySectionTitle => CompetitionMockData.categorySectionTitle;
  String get recommendationSectionTitle =>
      CompetitionMockData.recommendationSectionTitle;
  String get recommendationActionLabel =>
      CompetitionMockData.recommendationActionLabel;
  String get emptyStateTitle => CompetitionMockData.emptyStateTitle;
  String get emptyStateDescription => CompetitionMockData.emptyStateDescription;

  double get statsWideMinWidth => CompetitionMockData.statsWideMinWidth;
  double get recommendationsThreeColumnMinWidth =>
      CompetitionMockData.recommendationsThreeColumnMinWidth;
  double get recommendationsTwoColumnMinWidth =>
      CompetitionMockData.recommendationsTwoColumnMinWidth;
  double get statsGridAspectRatio => CompetitionMockData.statsGridAspectRatio;
  double get recommendationsTwoColumnItemExtent =>
      CompetitionMockData.recommendationsTwoColumnItemExtent;
  double get recommendationsThreeColumnItemExtent =>
      CompetitionMockData.recommendationsThreeColumnItemExtent;
}
