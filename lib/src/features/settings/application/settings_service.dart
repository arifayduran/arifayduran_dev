import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:shared_preferences/shared_preferences.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

class SettingsService {
  Future<ThemeMode> themeMode() async {
    if (kIsWeb) {
      final themeCookie = _getCookie('theme_mode');
      if (themeCookie == 'dark') {
        return ThemeMode.dark;
      } else if (themeCookie == 'light') {
        return ThemeMode.light;
      } else {
        return ThemeMode.system;
      }
    } else {
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

  Future<void> updateThemeMode(ThemeMode theme, BuildContext context) async {
    if (kIsWeb) {
      _setCookie('theme_mode', theme == ThemeMode.dark ? 'dark' : 'light');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              "Theme saved as ${theme == ThemeMode.dark ? 'Dark' : 'Light'}"),
          duration: const Duration(seconds: 2),
        ),
      );
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
