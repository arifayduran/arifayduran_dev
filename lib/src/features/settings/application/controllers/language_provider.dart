// ignore_for_file: deprecated_member_use

import 'package:arifayduran_dev/src/features/settings/data/session_settings.dart';
import 'package:flutter/material.dart';

class LanguageProvider with ChangeNotifier {
  Locale? _userSelectedLang;
  Locale? userSelectedLangFromPast; // Sprache von Cookies/SharedPreferences
  Locale _providerSystemLang = WidgetsBinding.instance.window.locale;
  late Locale _currentLocale;

  LanguageProvider() {
    _initializeLanguage();
  }

  // Initialisiert die Sprache basierend auf verschiedenen Quellen
  void _initializeLanguage() {
    if (_providerSystemLang.languageCode == "de" &&
        _providerSystemLang.countryCode == null) {
      _providerSystemLang = const Locale("de", "DE");
    }
    userSelectedLangFromPast = userSelectedLangFromPastTemp;

    // 1. Sprache aus Cookies/SharedPreferences priorisieren
    if (userSelectedLangFromPast != null) {
      _currentLocale = userSelectedLangFromPast!;
    }
    // 2. Andernfalls Systemsprache verwenden, wenn unterstützt
    else if (supportedLocale.contains(_providerSystemLang)) {
      _currentLocale = _providerSystemLang;
    }
    // 3. Fallback auf Standardsprache
    else {
      _currentLocale = supportedLocale.first;
    }
  }

  // Getter für die aktuell verwendete Sprache
  Locale get userSelectedLang => _userSelectedLang ?? _currentLocale;

  Locale get providerSystemLang => _providerSystemLang;

  Locale get currentLocale => _currentLocale;

  // Setter für benutzerdefinierte Sprache
  set userSelectedLang(Locale? locale) {
    if (locale != null && locale != _currentLocale) {
      _userSelectedLang = locale;
      _currentLocale = locale;
      notifyListeners();
    }
  }

  // Aktualisiert die Systemsprache, falls keine Benutzerauswahl vorliegt
  void checkAndSetSystemLanguage({VoidCallback? snackbarOnLanguageChanged}) {
    _providerSystemLang = WidgetsBinding.instance.window.locale;

    if (_providerSystemLang.languageCode == "de" &&
        _providerSystemLang.countryCode == null) {
      _providerSystemLang = const Locale("de", "DE");
    }

    systemLang = _providerSystemLang;

    if (_userSelectedLang == null &&
        _providerSystemLang != _currentLocale &&
        userSelectedLangFromPast == null) {
      if (supportedLocale.contains(_providerSystemLang)) {
        _currentLocale = _providerSystemLang;
      } else {
        _currentLocale = supportedLocale.first;
      }
    }
    notifyListeners(); // UI aktualisieren

    // Callback-Funktion aufrufen, falls vorhanden
    if (snackbarOnLanguageChanged != null &&
        // _providerSystemLang != _currentLocale &&
        userSelectedLangFromPast == null &&
        _userSelectedLang == null) {
      activateSecondSnackBar = true;
      activateLastRouteMessage = false;
      snackbarOnLanguageChanged();
    }
  }

  // Methode zum expliziten Setzen der Sprache aus Cookies/SharedPreferences
  void setUserSelectedLangFromPast(Locale locale) {
    userSelectedLangFromPast = locale;
    _currentLocale = locale; // Aktiviere direkt die Sprache
    notifyListeners();
  }
}
