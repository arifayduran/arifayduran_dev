import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../services/ui_mode_service.dart';

/// A class that many Widgets can interact with to read user settings, update
/// user settings, or listen to user settings changes.
///
/// Controllers glue Data Services to Flutter Widgets. The UiModeController
/// uses the UiModeService to store and retrieve user settings.
class UiModeController with ChangeNotifier {
  UiModeController(this._uiModeService);

  // Make UiModeService a private variable so it is not used directly.
  final UiModeService _uiModeService;

  // Make ThemeMode a private variable so it is not updated directly without
  // also persisting the changes with the UiModeService.
  late ThemeMode _themeMode;

  // Allow Widgets to read the user's preferred ThemeMode.
  ThemeMode get themeMode => _themeMode;

  bool get systemDarkMode =>
      SchedulerBinding.instance.platformDispatcher.platformBrightness ==
      Brightness.dark;
  bool get darkModeSet =>
      themeMode == ThemeMode.dark ||
      (themeMode == ThemeMode.system && systemDarkMode);

  /// Load the user's settings from the UiModeService. It may load from a
  /// local database or the internet. The controller only knows it can load the
  /// settings from the service.
  Future<void> loadSettings() async {
    _themeMode = await _uiModeService.themeMode();

    // Important! Inform listeners a change has occurred.
    notifyListeners();
  }

  /// Update and persist the ThemeMode based on the user's selection.
  Future<void> updateThemeMode(
      ThemeMode? newThemeMode, BuildContext context) async {
    if (newThemeMode == null) return;

    // Do not perform any work if new and old ThemeMode are identical
    if (newThemeMode == _themeMode) return;

    // Otherwise, store the new ThemeMode in memory
    _themeMode = newThemeMode;

    // Important! Inform listeners a change has occurred.
    notifyListeners();

    // Persist the changes to a local database or the internet using the
    // SettingService.
    await _uiModeService.updateThemeMode(newThemeMode, context);
  }
}
