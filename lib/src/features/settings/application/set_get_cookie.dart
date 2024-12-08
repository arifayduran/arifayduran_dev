import 'package:universal_html/html.dart' as html;

void setCookie(String name, String value) {
  final now = DateTime.now();
  final expires = now.add(const Duration(days: 365));

  final cookieValue =
      '$name=$value; expires=${expires.toUtc().toIso8601String()}; path=/; secure; samesite=lax';
  html.document.cookie = '$cookieValue; domain=.arifayduran.dev';
  html.document.cookie =
      '$cookieValue; domain=arifayduran.github.io; path=/arifayduran_dev';
  html.document.cookie = '$cookieValue; domain=arifayduran-dev.firebaseapp.com';
  html.document.cookie = '$cookieValue; domain=arifayduran-dev.web.app';
  html.document.cookie = '$cookieValue; domain=localhost';
}

String? getCookie(String name) {
  final cookies = html.document.cookie?.split('; ') ?? [];
  for (var cookie in cookies) {
    if (cookie.startsWith(name)) {
      return cookie.split('=')[1];
    }
  }
  return null;
}
