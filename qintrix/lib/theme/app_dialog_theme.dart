import 'package:flutter/material.dart';

import 'app_color_scheme.dart';
import 'tokens/radius_tokens.dart';

abstract final class AppDialogThemeFactory {
  static DialogThemeData build(AppThemePalette palette) {
    return DialogThemeData(
      backgroundColor: palette.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadiusTokens.lg),
      ),
    );
  }
}
