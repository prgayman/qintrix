import 'package:flutter/material.dart';

import 'tokens/color_tokens.dart';

class AppThemePalette {
  const AppThemePalette({
    required this.background,
    required this.surface,
    required this.card,
    required this.textPrimary,
    required this.textSecondary,
    required this.border,
  });

  factory AppThemePalette.fromBrightness(Brightness brightness) {
    return brightness == Brightness.dark
        ? const AppThemePalette(
            background: AppColorTokens.darkBackground,
            surface: AppColorTokens.darkSurface,
            card: AppColorTokens.darkCard,
            textPrimary: AppColorTokens.darkTextPrimary,
            textSecondary: AppColorTokens.darkTextSecondary,
            border: AppColorTokens.darkBorder,
          )
        : const AppThemePalette(
            background: AppColorTokens.lightBackground,
            surface: AppColorTokens.lightSurface,
            card: AppColorTokens.lightCard,
            textPrimary: AppColorTokens.lightTextPrimary,
            textSecondary: AppColorTokens.lightTextSecondary,
            border: AppColorTokens.lightBorder,
          );
  }

  final Color background;
  final Color surface;
  final Color card;
  final Color textPrimary;
  final Color textSecondary;
  final Color border;

  ColorScheme toColorScheme(Brightness brightness) {
    return brightness == Brightness.dark
        ? const ColorScheme.dark(
            primary: AppColorTokens.primaryBlue,
            secondary: AppColorTokens.secondaryOrange,
            surface: AppColorTokens.darkSurface,
            error: AppColorTokens.error,
            onPrimary: Colors.white,
            onSecondary: Colors.white,
            onSurface: AppColorTokens.darkTextPrimary,
            onError: Colors.white,
          )
        : const ColorScheme.light(
            primary: AppColorTokens.primaryBlue,
            secondary: AppColorTokens.secondaryOrange,
            surface: AppColorTokens.lightSurface,
            error: AppColorTokens.error,
            onPrimary: Colors.white,
            onSecondary: Colors.white,
            onSurface: AppColorTokens.lightTextPrimary,
            onError: Colors.white,
          );
  }
}
