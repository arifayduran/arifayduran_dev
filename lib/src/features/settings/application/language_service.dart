import 'package:arifayduran_dev/src/features/settings/application/set_get_cookie.dart';
import 'package:arifayduran_dev/src/features/settings/data/language_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:shared_preferences/shared_preferences.dart';

class LanguageService {
  Future<void> getLanguage() async {
    if (kIsWeb) {
      final languageCookie = getCookie('language');
      if (languageCookie != null && languageCookie.isNotEmpty) {
        if (languageCookie == "de" || languageCookie == "de_DE") {
          userSelectedLangFromPastTemp = const Locale("de", "DE");
        } else {
          userSelectedLangFromPastTemp = Locale(languageCookie);
        }
      }
    } else {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? language = prefs.getString('language');
      if (language != null && language.isNotEmpty) {
        if (language == "de" || language == "de_DE") {
          userSelectedLangFromPastTemp = const Locale("de", "DE");
        } else {
          userSelectedLangFromPastTemp = Locale(language);
        }
      }
    }
  }

  Future<void> updateLanguage(String language) async {
    if (kIsWeb) {
      final langToSave = (language == "de") ? "de_DE" : language;
      setCookie('language', langToSave);
    } else {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final langToSave = (language == "de") ? "de_DE" : language;
      await prefs.setString('language', langToSave);
    }
  }
}
