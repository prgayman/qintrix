import 'package:flutter/material.dart';

enum AppStatusTone { success, error, warning, info }

abstract final class AppColorTokens {
  static const primaryBlue = Color(0xFF0B5ED7);
  static const secondaryOrange = Color(0xFFFF9800);
  static const supportCyan = Color(0xFF27C2F3);
  static const highlightYellow = Color(0xFFFFC928);

  static const lightBackground = Color(0xFFF7F9FC);
  static const lightSurface = Color(0xFFFFFFFF);
  static const lightCard = Color(0xFFFDFDFD);
  static const lightTextPrimary = Color(0xFF0F172A);
  static const lightTextSecondary = Color(0xFF64748B);
  static const lightBorder = Color(0xFFE2E8F0);

  static const darkBackground = Color(0xFF0B1220);
  static const darkSurface = Color(0xFF121A2B);
  static const darkCard = Color(0xFF182235);
  static const darkTextPrimary = Color(0xFFF8FAFC);
  static const darkTextSecondary = Color(0xFF94A3B8);
  static const darkBorder = Color(0xFF263244);

  static const success = Color(0xFF16A34A);
  static const error = Color(0xFFDC2626);
  static const warning = Color(0xFFF59E0B);
  static const info = Color(0xFF0284C7);

  static const gradientBlueStart = Color(0xFF0A3D91);
  static const gradientBlueMid = Color(0xFF0B5ED7);
  static const gradientCyan = Color(0xFF27C2F3);
  static const gradientOrange = Color(0xFFFF9800);
  static const gradientYellow = Color(0xFFFFC928);
}

abstract final class AppStatusToneColors {
  static Color resolveBackground(AppStatusTone tone, Brightness brightness) {
    final base = resolveForeground(tone);
    final opacity = brightness == Brightness.dark ? 0.2 : 0.12;

    return base.withValues(alpha: opacity);
  }

  static Color resolveForeground(AppStatusTone tone) {
    return switch (tone) {
      AppStatusTone.success => AppColorTokens.success,
      AppStatusTone.error => AppColorTokens.error,
      AppStatusTone.warning => AppColorTokens.warning,
      AppStatusTone.info => AppColorTokens.info,
    };
  }
}
