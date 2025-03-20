import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_tr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('de'),
    Locale('en'),
    Locale('tr')
  ];

  /// Title of the App
  ///
  /// In en, this message translates to:
  /// **'arifayduran.dev'**
  String get appTitle;

  /// Description of the appTitle
  ///
  /// In en, this message translates to:
  /// **'Portfolio of Arif Ayduran, Software Developer'**
  String get appDescription;

  /// specialization of owner of portfolio
  ///
  /// In en, this message translates to:
  /// **'Software Developer'**
  String get specialization;

  /// This is a greeting message shown on the homepage.
  ///
  /// In en, this message translates to:
  /// **'Hello!'**
  String get greeting;

  /// Description of the website and welcoming to the site of the developer
  ///
  /// In en, this message translates to:
  /// **'Welcome to the Portfolio of Arif Ayduran'**
  String get fullGreeting;

  /// Message text for hovering on toggle to swich color cheme mode to dark
  ///
  /// In en, this message translates to:
  /// **'Switch color sheme to Light Mode'**
  String get toggleHoverToLight;

  /// Message text for hovering on toggle to swich color cheme mode to dark
  ///
  /// In en, this message translates to:
  /// **'Switch color sheme to Dark Mode'**
  String get toggleHoverToDark;

  /// Message text for snackbar, when changed color sheme to light mode
  ///
  /// In en, this message translates to:
  /// **'Color scheme switched to Light Mode'**
  String get switchModeMessageToLight;

  /// Message text for snackbar, when changed color sheme to Dark mode
  ///
  /// In en, this message translates to:
  /// **'Color scheme switched to Dark Mode'**
  String get switchModeMessageToDark;

  /// Dark Mode in Text
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// Light Mode in Text
  ///
  /// In en, this message translates to:
  /// **'Light Mode'**
  String get lightMode;

  /// Hovering text on scrolldown button
  ///
  /// In en, this message translates to:
  /// **'Scroll Down'**
  String get scrolldownText;

  /// Hovering text on scrollup button
  ///
  /// In en, this message translates to:
  /// **'Scroll Up'**
  String get scrollupText;

  /// Hovering text on Language Settings Dropdownmenu
  ///
  /// In en, this message translates to:
  /// **'Change Language Settings'**
  String get langSelectHover;

  /// Display Text for System Language, not setted language.
  ///
  /// In en, this message translates to:
  /// **'System Language'**
  String get systemLang;

  /// Message shown when the user switches the language
  ///
  /// In en, this message translates to:
  /// **'You have switched the language to English.'**
  String get switchLanguageMessage;

  /// Message shown for explain, that the language has been set from language settings
  ///
  /// In en, this message translates to:
  /// **'Display language has been set from your language settings.'**
  String get langCopiedFromSettingsMessage;

  /// Message shown to explain that the language settings were taken from the previous session
  ///
  /// In en, this message translates to:
  /// **'Your language settings have been copied from last time.'**
  String get languageSettingsCopiedFromLastTimeMessage;

  /// Message shown to explain that the system language used to handle data/currency format etc.
  ///
  /// In en, this message translates to:
  /// **'The system language is used to handle data, currency formats, and other locale settings.'**
  String get onHoverSystemLang;

  /// Notification shown when the last route session is restored successfully.
  ///
  /// In en, this message translates to:
  /// **'The last route session has been successfully restored.'**
  String get lastRouteMessage;

  /// Manage basic settings and adjustments.
  ///
  /// In en, this message translates to:
  /// **'Access the settings menu.'**
  String get drawerOnHover;

  /// Message shown on hover on logo
  ///
  /// In en, this message translates to:
  /// **'Calligraphic self-designed logo'**
  String get logoOnHover;

  /// Navigation to home button text
  ///
  /// In en, this message translates to:
  /// **'Go to home'**
  String get goToHome;

  /// Navigation back button text
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// Page not found message to show
  ///
  /// In en, this message translates to:
  /// **'The page \'{path}\' was not found.'**
  String pageNotFound(Object path);

  /// Navigation bar Home texts
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get naviBarHome;

  /// Navigation bar About Me texts
  ///
  /// In en, this message translates to:
  /// **'About Me'**
  String get naviBarAboutme;

  /// Navigation bar Projects texts
  ///
  /// In en, this message translates to:
  /// **'Projects'**
  String get naviBarProjects;

  /// Navigation bar Contact texts
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get naviBarContact;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'de', 'en', 'tr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'de': return AppLocalizationsDe();
    case 'en': return AppLocalizationsEn();
    case 'tr': return AppLocalizationsTr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
