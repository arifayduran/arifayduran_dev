import 'package:arifayduran_dev/src/features/settings/application/set_get_cookie.dart';
import 'package:arifayduran_dev/src/features/settings/data/session_settings.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RouteObserverService extends RouteObserver<PageRoute> {
  List<String> routeHistory = [];

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    _saveRoute(route.settings.name ?? '/');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    if (previousRoute != null) {
      _saveRoute(previousRoute.settings.name ?? '/');
    }
  }

  void _saveRoute(String route) async {
    routeHistory.add(route);
    if (isPlatformWeb) {
      setCookie('routeHistory', routeHistory.join(','));
    } else {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setStringList('routeHistory', routeHistory);
    }
  }

  Future<List<String>> getRouteHistory() async {
    if (isPlatformWeb) {
      final cookieData = getCookie('routeHistory');
      if (cookieData != null && cookieData.isNotEmpty) {
        return cookieData.split(',');
      }
    } else {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getStringList('routeHistory') ?? [];
    }
    return [];
  }
}
