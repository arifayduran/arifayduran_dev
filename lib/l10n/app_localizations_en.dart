// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'arifayduran.dev';

  @override
  String get appDescription => 'Portfolio of Arif Ayduran, Software Developer';

  @override
  String get specialization => 'Software Developer';

  @override
  String get greeting => 'Hello!';

  @override
  String get fullGreeting => 'Welcome to the Portfolio of Arif Ayduran';

  @override
  String get toggleHoverToLight => 'Switch color sheme to Light Mode';

  @override
  String get toggleHoverToDark => 'Switch color sheme to Dark Mode';

  @override
  String get switchModeMessageToLight => 'Color scheme switched to Light Mode';

  @override
  String get switchModeMessageToDark => 'Color scheme switched to Dark Mode';

  @override
  String get darkMode => 'Dark Mode';

  @override
  String get lightMode => 'Light Mode';

  @override
  String get scrolldownText => 'Scroll Down';

  @override
  String get scrollupText => 'Scroll Up';

  @override
  String get langSelectHover => 'Change Language Settings';

  @override
  String get systemLang => 'System Language';

  @override
  String get switchLanguageMessage => 'You have switched the language to English.';

  @override
  String get langCopiedFromSettingsMessage => 'Display language has been set from your language settings.';

  @override
  String get languageSettingsCopiedFromLastTimeMessage => 'Your language settings have been copied from last time.';

  @override
  String get onHoverSystemLang => 'The system language is used to handle data, currency formats, and other locale settings.';

  @override
  String get lastRouteMessage => 'The last route session has been successfully restored.';

  @override
  String get drawerOnHover => 'Access the settings menu.';

  @override
  String get logoOnHover => 'Calligraphic self-designed logo';

  @override
  String get goToHome => 'Go to home';

  @override
  String get back => 'Back';

  @override
  String pageNotFound(Object path) {
    return 'The page \'$path\' was not found.';
  }

  @override
  String get naviBarHome => 'Home';

  @override
  String get naviBarAboutme => 'About Me';

  @override
  String get naviBarProjects => 'Projects';

  @override
  String get naviBarContact => 'Contact';
}
