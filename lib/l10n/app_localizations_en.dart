// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Celest';

  @override
  String get navHome => 'Home';

  @override
  String get navCompetition => 'Competition';

  @override
  String get navWorkspace => 'Workspace';

  @override
  String get navResources => 'Resources';

  @override
  String get navProfile => 'Profile';

  @override
  String get authTitle => 'Sign In';

  @override
  String pagePlaceholder(String title) {
    return '$title page placeholder';
  }
}
