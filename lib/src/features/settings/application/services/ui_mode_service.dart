import 'package:arifayduran_dev/src/config/theme.dart';
import 'package:arifayduran_dev/src/core/application/scaffold_messenger_key.dart';
import 'package:arifayduran_dev/src/features/settings/application/set_get_cookie.dart';
import 'package:arifayduran_dev/src/features/settings/data/session_settings.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class UiModeService {
  Future<ThemeMode> themeMode() async {
    if (isPlatformWeb) {
      final themeCookie = getCookie('theme_mode');
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
    if (isPlatformWeb) {
      setCookie('theme_mode', theme == ThemeMode.dark ? 'dark' : 'light');
    } else {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      if (theme == ThemeMode.dark) {
        await prefs.setBool("theme_mode", true);
      } else {
        await prefs.setBool("theme_mode", false);
      }
    }

    if (context.mounted) {
      scaffoldMessengerKey.currentState?.showSnackBar(
        SnackBar(
          content: Text(theme == ThemeMode.dark
              ? AppLocalizations.of(context)!.switchModeMessageToDark
              : AppLocalizations.of(context)!.switchModeMessageToDark),
          duration: const Duration(seconds: 2),
          backgroundColor:
              theme == ThemeMode.dark ? snackBarColorDark : snackBarColorLight,
        ),
      );
    }
  }
}
