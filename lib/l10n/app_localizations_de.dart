// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'arifayduran.dev';

  @override
  String get appDescription => 'Portfolio von Arif Ayduran, Softwareentwickler';

  @override
  String get specialization => 'Software Entwickler';

  @override
  String get greeting => 'Hallo!';

  @override
  String get fullGreeting => 'Willkommen zum Portfolio von Arif Ayduran';

  @override
  String get toggleHoverToLight => 'Farbschema auf Light Mode wechseln';

  @override
  String get toggleHoverToDark => 'Farbschema auf Dark Mode wechseln';

  @override
  String get switchModeMessageToLight => 'Farbschema auf den Light Modus geändert';

  @override
  String get switchModeMessageToDark => 'Farbschema auf den Dark Modus geändert';

  @override
  String get darkMode => 'Dark Modus';

  @override
  String get lightMode => 'Light Modus';

  @override
  String get scrolldownText => 'Nach unten scrollen';

  @override
  String get scrollupText => 'Nach oben scrollen';

  @override
  String get langSelectHover => 'Spracheinstellungen ändern';

  @override
  String get systemLang => 'Systemsprache';

  @override
  String get switchLanguageMessage => 'Sie haben die Sprache auf Deutsch umgestellt.';

  @override
  String get langCopiedFromSettingsMessage => 'Anzeigesprache wurde von Ihren Spracheinstellungen übernommen.';

  @override
  String get languageSettingsCopiedFromLastTimeMessage => 'Ihre Spracheinstellungen wurden vom letzten Mal übernommen';

  @override
  String get onHoverSystemLang => 'Die Systemsprache wird verwendet, um Daten-, Währungsformate und andere lokale Einstellungen zu verwalten.';

  @override
  String get lastRouteMessage => 'Die letzte Routensitzung wurde erfolgreich wiederhergestellt.';

  @override
  String get drawerOnHover => 'Zugriff auf das Einstellungen-Menü.';

  @override
  String get logoOnHover => 'Kalligraphisches, selbst gestaltetes Logo';

  @override
  String get goToHome => 'Zur Startseite gehen';

  @override
  String get back => 'Zurück';

  @override
  String pageNotFound(Object path) {
    return 'Die Seite \'$path\' wurde nicht gefunden.';
  }

  @override
  String get naviBarHome => 'Startseite';

  @override
  String get naviBarAboutme => 'Über mich';

  @override
  String get naviBarProjects => 'Projekte';

  @override
  String get naviBarContact => 'Kontakt';
}
