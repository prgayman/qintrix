import 'package:flutter/material.dart';

import 'app_button_theme.dart';
import 'app_card_theme.dart';
import 'app_color_scheme.dart';
import 'app_dialog_theme.dart';
import 'app_input_theme.dart';
import 'app_text_theme.dart';

abstract final class AppTheme {
  static ThemeData light(Locale locale) => _build(Brightness.light, locale);

  static ThemeData dark(Locale locale) => _build(Brightness.dark, locale);

  static ThemeData _build(Brightness brightness, Locale locale) {
    final palette = AppThemePalette.fromBrightness(brightness);

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      fontFamily: AppTextThemeFactory.fontFamily,
      colorScheme: palette.toColorScheme(brightness),
      scaffoldBackgroundColor: palette.background,
      cardColor: palette.card,
      dividerColor: palette.border,
      textTheme: AppTextThemeFactory.build(
        brightness: brightness,
        locale: locale,
      ),
      primaryTextTheme: AppTextThemeFactory.build(
        brightness: brightness,
        locale: locale,
      ),
      inputDecorationTheme: AppInputThemeFactory.build(palette),
      filledButtonTheme: AppButtonThemeFactory.filled(palette),
      outlinedButtonTheme: AppButtonThemeFactory.outlined(palette),
      cardTheme: AppCardThemeFactory.build(palette),
      dialogTheme: AppDialogThemeFactory.build(palette),
    );
  }
}
