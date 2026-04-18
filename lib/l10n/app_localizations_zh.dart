// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => 'Celest';

  @override
  String get navHome => '首页';

  @override
  String get navCompetition => '赛事';

  @override
  String get navWorkspace => '工作区';

  @override
  String get navResources => '资源库';

  @override
  String get navProfile => '我的';

  @override
  String get authTitle => '登录';

  @override
  String pagePlaceholder(String title) {
    return '$title 页面占位';
  }
}
