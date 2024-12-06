import 'package:flutter/material.dart';

List<Locale> supportedLocale = [
  const Locale('en'),
  const Locale('de', "DE"),
  const Locale('tr'),
  const Locale('ar'),
];
// ignore: deprecated_member_use
Locale systemLang = WidgetsBinding.instance.window.locale;

Locale? userSelectedLangFromPastTemp;
