import 'package:arifayduran_dev/src/core/my_toolbar.dart';
import 'package:arifayduran_dev/src/features/settings/application/services/route_observer.dart';
import 'package:flutter/material.dart';

bool isPlatformWeb = true;

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

// bool? isFirstLaunch;
bool activateSecondSnackBar =
    true; // for snackbar on change system language and and first init, otherwise it will show every route
bool activateLastRouteMessage = true;

// bool dontSaveFirstRoute = false; // not using since observer

bool notNavigatedFromRefresh = false;

RouteObserverService routeObserver = RouteObserverService();
List<String>? routeHistory;
String? initialRoute;

late MyToolbar myToolbar;
double maxToolbarHeight = 70.0;
double minToolbarHeight = 50.0;
