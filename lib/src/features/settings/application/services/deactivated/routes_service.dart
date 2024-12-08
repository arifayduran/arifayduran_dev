// import 'package:arifayduran_dev/src/features/settings/application/set_get_cookie.dart';
// import 'package:arifayduran_dev/src/features/settings/data/session_settings.dart';
// import 'package:flutter/foundation.dart' show kIsWeb;
// import 'package:shared_preferences/shared_preferences.dart';

// // not using since observer

// class RouteService {
//   Future<void> getLastVisitedRoute() async {
//     if (kIsWeb) {
//       final routeCookie = getCookie('lastVisitedRoute');
//       if (routeCookie != null && routeCookie.isNotEmpty) {
//         lastVisitedRouteFromPastTemp = routeCookie;
//       } else {
//         lastVisitedRouteFromPastTemp = null;
//       }
//     } else {
//       final SharedPreferences prefs = await SharedPreferences.getInstance();
//       final String? route = prefs.getString('lastVisitedRoute');
//       if (route != null && route.isNotEmpty) {
//         lastVisitedRouteFromPastTemp = route;
//       } else {
//         lastVisitedRouteFromPastTemp = null;
//       }
//     }
//   }
  

//   Future<void> updateLastVisitedRoute(String route) async {
//     if (kIsWeb) {
//       setCookie('lastVisitedRoute', route);
//     } else {
//       final SharedPreferences prefs = await SharedPreferences.getInstance();
//       await prefs.setString('lastVisitedRoute', route);
//     }
//   }
// }
