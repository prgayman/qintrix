import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_color_scheme.dart';
import 'tokens/typography_tokens.dart';

abstract final class AppTextThemeFactory {
  static const String fontFamily = 'Cairo';

  static const List<String> _fallbacks = [
    fontFamily,
    'Noto Sans Arabic',
    'Noto Naskh Arabic',
    'Inter',
    'SF Pro Text',
    'Segoe UI',
    'Geeza Pro',
    'Tahoma',
    'Arial',
    'sans-serif',
  ];

  static TextTheme build({
    required Brightness brightness,
    required Locale locale,
  }) {
    final palette = AppThemePalette.fromBrightness(brightness);
    final baseTheme = brightness == Brightness.dark
        ? ThemeData.dark().textTheme
        : ThemeData.light().textTheme;
    final themedBase = _applyCairo(baseTheme);

    return themedBase.copyWith(
      headlineSmall: _resolve(
        themedBase.headlineSmall?.copyWith(
          fontSize: AppTypographyTokens.headline,
          fontWeight: FontWeight.w700,
          color: palette.textPrimary,
          height: 1.15,
        ),
      ),
      titleLarge: _resolve(
        themedBase.titleLarge?.copyWith(
          fontSize: AppTypographyTokens.title,
          fontWeight: FontWeight.w700,
          color: palette.textPrimary,
        ),
      ),
      titleMedium: _resolve(
        themedBase.titleMedium?.copyWith(
          fontSize: AppTypographyTokens.body,
          fontWeight: FontWeight.w600,
          color: palette.textPrimary,
          height: 1.25,
        ),
      ),
      bodyLarge: _resolve(
        themedBase.bodyLarge?.copyWith(
          fontSize: AppTypographyTokens.body,
          color: palette.textPrimary,
          height: 1.4,
        ),
      ),
      bodyMedium: _resolve(
        themedBase.bodyMedium?.copyWith(
          fontSize: AppTypographyTokens.body,
          color: palette.textSecondary,
          height: 1.4,
        ),
      ),
      bodySmall: _resolve(
        themedBase.bodySmall?.copyWith(
          fontSize: AppTypographyTokens.label,
          color: palette.textSecondary,
          height: 1.35,
        ),
      ),
      labelLarge: _resolve(
        themedBase.labelLarge?.copyWith(
          fontSize: AppTypographyTokens.label,
          fontWeight: FontWeight.w600,
          color: palette.textPrimary,
        ),
      ),
      labelMedium: _resolve(
        themedBase.labelMedium?.copyWith(
          fontSize: AppTypographyTokens.label,
          fontWeight: FontWeight.w600,
          color: palette.textPrimary,
        ),
      ),
      labelSmall: _resolve(
        themedBase.labelSmall?.copyWith(
          fontSize: AppTypographyTokens.caption,
          fontWeight: FontWeight.w600,
          color: palette.textSecondary,
        ),
      ),
    );
  }

  static TextTheme _applyCairo(TextTheme baseTheme) {
    if (GoogleFonts.config.allowRuntimeFetching) {
      return GoogleFonts.cairoTextTheme(baseTheme);
    }

    return baseTheme.apply(
      fontFamily: fontFamily,
      fontFamilyFallback: _fallbacks,
    );
  }

  static TextStyle _resolve(TextStyle? baseStyle) {
    final resolvedBase = baseStyle ?? const TextStyle();

    return resolvedBase.copyWith(
      fontFamily: fontFamily,
      fontFamilyFallback: _fallbacks,
    );
  }
}
