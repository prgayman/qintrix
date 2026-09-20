import 'package:flutter/material.dart';

import 'app_color_scheme.dart';
import 'tokens/radius_tokens.dart';

abstract final class AppCardThemeFactory {
  static CardThemeData build(AppThemePalette palette) {
    return CardThemeData(
      color: palette.card,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadiusTokens.lg),
        side: BorderSide(color: palette.border),
      ),
    );
  }
}
