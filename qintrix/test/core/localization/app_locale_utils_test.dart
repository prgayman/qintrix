import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qintrix/core/localization/app_locale_utils.dart';

void main() {
  group('AppLocaleUtils', () {
    test('normalizes unknown locales to english', () {
      expect(AppLocaleUtils.normalize(const Locale('fr')), const Locale('en'));
    });

    test('recognizes arabic locale', () {
      expect(AppLocaleUtils.isArabic(const Locale('ar')), isTrue);
      expect(AppLocaleUtils.isArabic(const Locale('en')), isFalse);
    });

    test('returns rtl for arabic locales', () {
      expect(
        AppLocaleUtils.textDirectionFor(const Locale('ar')),
        TextDirection.rtl,
      );
      expect(
        AppLocaleUtils.textDirectionFor(const Locale('en')),
        TextDirection.ltr,
      );
    });
  });
}
