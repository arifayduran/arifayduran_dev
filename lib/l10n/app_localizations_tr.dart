// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appTitle => 'arifayduran.dev';

  @override
  String get appDescription => 'Arif Ayduran\'ın Portföyü, Yazılım Geliştirici';

  @override
  String get specialization => 'Yazılım Geliştiricisi';

  @override
  String get greeting => 'Merhaba!';

  @override
  String get fullGreeting => 'Arif Ayduran\'ın Portföyüne Hoş Geldiniz';

  @override
  String get toggleHoverToLight => 'Renk şemasını Açık Moda değiştir';

  @override
  String get toggleHoverToDark => 'Renk şemasını Koyu Moda değiştir';

  @override
  String get switchModeMessageToLight => 'Renk şeması Açık Moda değiştirildi';

  @override
  String get switchModeMessageToDark => 'Renk şeması Koyu Moda değiştirildi';

  @override
  String get darkMode => 'Koyu Mod';

  @override
  String get lightMode => 'Açık Mod';

  @override
  String get scrolldownText => 'Aşağı Kaydır';

  @override
  String get scrollupText => 'Yukarı Kaydır';

  @override
  String get langSelectHover => 'Dil Ayarlarını Değiştir';

  @override
  String get systemLang => 'Sistem Dili';

  @override
  String get switchLanguageMessage => 'Dil ayarı Türkçe olarak güncellendi.';

  @override
  String get langCopiedFromSettingsMessage => 'Görüntü dili, dil ayarlarınızdan alındı.';

  @override
  String get languageSettingsCopiedFromLastTimeMessage => 'Dil ayarlarınız son seferden alındı.';

  @override
  String get onHoverSystemLang => 'Sistem dili, veri, para birimi formatı ve diğer yerel ayarları işlemek için kullanılır.';

  @override
  String get lastRouteMessage => 'Son rota oturumu başarıyla geri yüklendi.';

  @override
  String get drawerOnHover => 'Ayarlar menüsüne erişim.';

  @override
  String get logoOnHover => 'Kaligrafik, kendi tasarımımız olan logo';

  @override
  String get goToHome => 'Ana sayfaya git';

  @override
  String get back => 'Geri dön';

  @override
  String pageNotFound(Object path) {
    return '\'$path\' sayfası bulunamadı.';
  }

  @override
  String get naviBarHome => 'Ana Sayfa';

  @override
  String get naviBarAboutme => 'Hakkımda';

  @override
  String get naviBarProjects => 'Projeler';

  @override
  String get naviBarContact => 'İletişim';
}
