// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'arifayduran.dev';

  @override
  String get appDescription => 'محفظة عارف أيدوران، مطور برمجيات';

  @override
  String get specialization => 'مطور برمجيات';

  @override
  String get greeting => 'مرحبًا!';

  @override
  String get fullGreeting => 'مرحبًا بكم في محفظة عارف أيدوران';

  @override
  String get toggleHoverToLight => 'تغيير نظام الألوان إلى الوضع الفاتح';

  @override
  String get toggleHoverToDark => 'تغيير نظام الألوان إلى الوضع الداكن';

  @override
  String get switchModeMessageToLight => 'تم تغيير نظام الألوان إلى الوضع الفاتح';

  @override
  String get switchModeMessageToDark => 'تم تغيير نظام الألوان إلى الوضع الداكن';

  @override
  String get darkMode => 'الوضع الداكن';

  @override
  String get lightMode => 'الوضع الفاتح';

  @override
  String get scrolldownText => 'التمرير للأسفل';

  @override
  String get scrollupText => 'التمرير للأعلى';

  @override
  String get langSelectHover => 'تغيير إعدادات اللغة';

  @override
  String get systemLang => 'لغة النظام';

  @override
  String get switchLanguageMessage => 'لقد قمت بتغيير اللغة إلى العربية.';

  @override
  String get langCopiedFromSettingsMessage => 'تم تعيين لغة العرض من إعدادات اللغة الخاصة بك.';

  @override
  String get languageSettingsCopiedFromLastTimeMessage => 'تم نسخ إعدادات اللغة الخاصة بك من آخر مرة.';

  @override
  String get onHoverSystemLang => 'تُستخدم لغة النظام لمعالجة البيانات وتنسيقات العملات والإعدادات المحلية الأخرى.';

  @override
  String get lastRouteMessage => 'تمت استعادة جلسة الطريق الأخيرة بنجاح.';

  @override
  String get drawerOnHover => 'الوصول إلى قائمة الإعدادات.';

  @override
  String get logoOnHover => 'شعار بخط اليد مصمم ذاتيًا';

  @override
  String get goToHome => 'اذهب إلى الصفحة الرئيسية';

  @override
  String get back => 'رجوع';

  @override
  String pageNotFound(Object path) {
    return 'الصفحة \'$path\' غير موجودة.';
  }

  @override
  String get naviBarHome => 'الرئيسية';

  @override
  String get naviBarAboutme => 'عني';

  @override
  String get naviBarProjects => 'المشاريع';

  @override
  String get naviBarContact => 'اتصل';
}
