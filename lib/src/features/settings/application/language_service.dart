import 'package:arifayduran_dev/src/features/settings/data/language_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universal_html/html.dart' as html;

class LanguageService {
  Future<void> getLanguage() async {
    if (kIsWeb) {
      final languageCookie = _getCookie('language');
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
      _setCookie('language', langToSave);
    } else {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final langToSave = (language == "de") ? "de_DE" : language;
      await prefs.setString('language', langToSave);
    }
  }

  void _setCookie(String name, String value) {
    final now = DateTime.now();
    final expires = now.add(const Duration(days: 365));

    final cookieValue =
        '$name=$value; expires=${expires.toUtc().toIso8601String()}; path=/; secure; samesite=lax';
    html.document.cookie = '$cookieValue; domain=.arifayduran.dev';
    html.document.cookie =
        '$cookieValue; domain=arifayduran.github.io; path=/arifayduran_dev';
    html.document.cookie =
        '$cookieValue; domain=arifayduran-dev.firebaseapp.com';
    html.document.cookie = '$cookieValue; domain=arifayduran-dev.web.app';
  }

  String? _getCookie(String name) {
    final cookies = html.document.cookie?.split('; ') ?? [];
    for (var cookie in cookies) {
      if (cookie.startsWith(name)) {
        return cookie.split('=')[1];
      }
    }
    return null;
  }
}
