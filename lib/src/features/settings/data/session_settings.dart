import 'package:flutter/material.dart';

List<Locale> supportedLocale = [
  const Locale('en'),
  const Locale('de', "DE"),
  const Locale('tr'),
  const Locale('ar'),
];
// ignore: deprecated_member_use
Locale systemLang = WidgetsBinding.instance.window.locale == const Locale("de")
    ? const Locale("de", "DE")
    // ignore: deprecated_member_use
    : WidgetsBinding.instance.window.locale;

Locale? userSelectedLangFromPastTemp;

// String? lastVisitedRouteFromPastTemp; // not using since observer
// String? currentRoute; // not using since observer

bool? isFirstLaunch;
bool isStartedNew =
    true; // for snackbar on change system language and and first init, otherwise it will show every route

// bool dontSaveFirstRoute = false; // not using since observer

bool notNavigatedFromRefresh = false;
