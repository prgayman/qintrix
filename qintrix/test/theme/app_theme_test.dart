import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qintrix/theme/app_color_scheme.dart';
import 'package:qintrix/theme/app_text_theme.dart';
import 'package:qintrix/theme/app_theme.dart';
import 'package:qintrix/theme/tokens/color_tokens.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  GoogleFonts.config.allowRuntimeFetching = false;

  group('AppThemePalette', () {
    test('returns light palette for light brightness', () {
      final palette = AppThemePalette.fromBrightness(Brightness.light);

      expect(palette.background, AppColorTokens.lightBackground);
      expect(palette.textPrimary, AppColorTokens.lightTextPrimary);
    });

    test('returns dark palette for dark brightness', () {
      final palette = AppThemePalette.fromBrightness(Brightness.dark);

      expect(palette.background, AppColorTokens.darkBackground);
      expect(palette.textPrimary, AppColorTokens.darkTextPrimary);
    });
  });

  group('AppTextThemeFactory', () {
    test('uses Cairo for all locales', () {
      final english = AppTextThemeFactory.build(
        brightness: Brightness.light,
        locale: const Locale('en'),
      );
      final arabic = AppTextThemeFactory.build(
        brightness: Brightness.light,
        locale: const Locale('ar'),
      );

      expect(english.bodyMedium, isNotNull);
      expect(arabic.bodyMedium, isNotNull);
      expect(english.bodyMedium?.fontFamily, 'Cairo');
      expect(arabic.bodyMedium?.fontFamily, 'Cairo');
      expect(english.bodyMedium?.fontFamilyFallback, isNotEmpty);
      expect(arabic.bodyMedium?.fontFamilyFallback, isNotEmpty);
      expect(
        arabic.bodyMedium?.fontFamilyFallback,
        english.bodyMedium?.fontFamilyFallback,
      );
    });
  });

  group('AppTheme', () {
    test('builds light and dark theme data', () {
      final lightTheme = AppTheme.light(const Locale('en'));
      final darkTheme = AppTheme.dark(const Locale('ar'));

      expect(
        lightTheme.scaffoldBackgroundColor,
        AppColorTokens.lightBackground,
      );
      expect(darkTheme.scaffoldBackgroundColor, AppColorTokens.darkBackground);
      expect(
        lightTheme.textTheme.bodyMedium?.fontFamily,
        AppTextThemeFactory.fontFamily,
      );
      expect(
        darkTheme.textTheme.bodyMedium?.fontFamily,
        AppTextThemeFactory.fontFamily,
      );
      expect(lightTheme.inputDecorationTheme.fillColor, isNotNull);
      expect(darkTheme.inputDecorationTheme.fillColor, isNotNull);
    });
  });
}
