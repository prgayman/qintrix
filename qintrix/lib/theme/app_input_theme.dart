import 'package:flutter/material.dart';

import 'app_color_scheme.dart';
import 'tokens/color_tokens.dart';
import 'tokens/radius_tokens.dart';

abstract final class AppInputThemeFactory {
  static InputDecorationTheme build(AppThemePalette palette) {
    final fillColor = Color.alphaBlend(
      palette.textPrimary.withValues(alpha: 0.025),
      palette.surface,
    );
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadiusTokens.md),
      borderSide: BorderSide(
        color: palette.border.withValues(alpha: 0.9),
        width: 1,
      ),
    );

    return InputDecorationTheme(
      filled: true,
      fillColor: fillColor,
      contentPadding: const EdgeInsets.symmetric(horizontal: 11, vertical: 8),
      hintStyle: TextStyle(color: palette.textSecondary.withValues(alpha: 0.9)),
      labelStyle: TextStyle(
        color: palette.textSecondary,
        fontWeight: FontWeight.w500,
      ),
      helperStyle: TextStyle(
        color: palette.textSecondary.withValues(alpha: 0.92),
        fontSize: 11,
      ),
      errorStyle: const TextStyle(fontSize: 11),
      prefixIconColor: palette.textSecondary,
      suffixIconColor: palette.textSecondary,
      border: border,
      enabledBorder: border,
      disabledBorder: border.copyWith(
        borderSide: BorderSide(color: palette.border.withValues(alpha: 0.5)),
      ),
      focusedBorder: border.copyWith(
        borderSide: const BorderSide(
          color: AppColorTokens.supportCyan,
          width: 1.5,
        ),
      ),
      errorBorder: border.copyWith(
        borderSide: const BorderSide(color: AppColorTokens.error, width: 1.2),
      ),
      focusedErrorBorder: border.copyWith(
        borderSide: const BorderSide(color: AppColorTokens.error, width: 1.5),
      ),
    );
  }
}
