import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/mock/profile_mock_data.dart';

final profileViewDataProvider = Provider<ProfileViewData>(
  (ref) => const ProfileViewData(),
);

class ProfileViewData {
  const ProfileViewData();

  List<ProfileBadgeData> get badges => ProfileMockData.badges;
  ProfileAssetSummaryData get assets => ProfileMockData.assets;
  List<ProfileArchiveData> get archives => ProfileMockData.archives;
  List<ProfileSettingItemData> get settingsItems => ProfileMockData.settingsItems;

  String get appTitle => ProfileMockData.appTitle;
  String get avatarUrl => ProfileMockData.avatarUrl;
  String get displayName => ProfileMockData.displayName;
  String get profileSubTitle => ProfileMockData.profileSubTitle;
  String get assetSectionTitle => ProfileMockData.assetSectionTitle;
  String get archiveSectionTitle => ProfileMockData.archiveSectionTitle;
  String get settingsSectionTitle => ProfileMockData.settingsSectionTitle;
  String get logoutLabel => ProfileMockData.logoutLabel;

  double get heroSplitMinWidth => ProfileMockData.heroSplitMinWidth;
  double get archiveSplitMinWidth => ProfileMockData.archiveSplitMinWidth;
  double get profileAvatarSize => ProfileMockData.profileAvatarSize;
  double get profileBadgeSpacing => ProfileMockData.profileBadgeSpacing;
}
