import 'dart:ui';

import 'package:flutter/widgets.dart';

abstract final class AppLocaleUtils {
  static const Locale english = Locale('en');
  static const Locale arabic = Locale('ar');

  static const List<Locale> supportedLocales = [english, arabic];

  static Locale normalize(Locale? locale) {
    if (locale == null) {
      return english;
    }

    return supportedLocales.firstWhere(
      (supportedLocale) => supportedLocale.languageCode == locale.languageCode,
      orElse: () => english,
    );
  }

  static bool isArabic(Locale? locale) {
    return normalize(locale).languageCode == arabic.languageCode;
  }

  static TextDirection textDirectionFor(Locale? locale) {
    return isArabic(locale) ? TextDirection.rtl : TextDirection.ltr;
  }

  static Locale alternate(Locale locale) {
    return isArabic(locale) ? english : arabic;
  }
}
