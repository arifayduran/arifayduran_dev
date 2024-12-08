// import 'package:arifayduran_dev/src/features/settings/application/set_get_cookie.dart';
// import 'package:arifayduran_dev/src/features/settings/data/session_settings.dart';
// import 'package:flutter/foundation.dart' show kIsWeb;
// import 'package:shared_preferences/shared_preferences.dart';


// // unused for now

// class FirstLaunchService {

//   Future<void> checkFirstLaunch() async {
//     if (kIsWeb) {
//       final launchCookie = getCookie('isFirstLaunch');
//       if (launchCookie != null && launchCookie == 'false') {
//         isFirstLaunch = false;
//       } else {
//         isFirstLaunch = true;
//         setCookie('isFirstLaunch', 'false');
//       }
//     } else {
//       final SharedPreferences prefs = await SharedPreferences.getInstance();
//       final bool? launchStatus = prefs.getBool('isFirstLaunch');
//       if (launchStatus != null && !launchStatus) {
//         isFirstLaunch = false;
//       } else {
//         isFirstLaunch = true;
//         await prefs.setBool('isFirstLaunch', false);
//       }
//     }
//   }
// }
