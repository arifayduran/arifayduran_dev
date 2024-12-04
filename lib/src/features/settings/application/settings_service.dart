import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:shared_preferences/shared_preferences.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

class SettingsService {
  // Methode zum Abrufen des aktuellen ThemeMode
  Future<ThemeMode> themeMode() async {
    if (kIsWeb) {
      // Wenn auf Web, lesen wir das Cookie
      final themeCookie = _getCookie('theme_mode');
      if (themeCookie == 'dark') {
        return ThemeMode.dark;
      } else if (themeCookie == 'light') {
        return ThemeMode.light;
      } else {
        return ThemeMode.system;
      }
    } else {
      // Wenn auf mobile Plattformen, verwenden wir SharedPreferences
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final bool? isDarkMode = prefs.getBool("theme_mode");
      switch (isDarkMode) {
        case true:
          return ThemeMode.dark;
        case false:
          return ThemeMode.light;
        default:
          return ThemeMode.system;
      }
    }
  }

  Future<void> updateThemeMode(ThemeMode theme) async {
    if (kIsWeb) {
      _setCookie('theme_mode', theme == ThemeMode.dark ? 'dark' : 'light');
    } else {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      if (theme == ThemeMode.dark) {
        await prefs.setBool("theme_mode", true);
      } else {
        await prefs.setBool("theme_mode", false);
      }
    }
  }

  void _setCookie(String name, String value) {
    final now = DateTime.now();
    final expires = now.add(const Duration(days: 365));
    html.document.cookie =
        '$name=$value; expires=${expires.toUtc().toIso8601String()}; path=/; domain=.arifayduran.dev; secure; samesite=lax';
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
