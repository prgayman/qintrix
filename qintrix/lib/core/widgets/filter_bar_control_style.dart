import 'package:flutter/material.dart';
import 'package:qintrix/theme/tokens/radius_tokens.dart';

abstract final class FilterBarControlStyle {
  static const double controlHeight = 34;
  static const double compactWidth = 192;
  static const double iconSize = 14;
  static const double menuItemHeight = 34;
  static const EdgeInsets controlPadding = EdgeInsets.symmetric(
    horizontal: 10,
    vertical: 7,
  );
  static const BorderRadius controlRadius = BorderRadius.all(
    Radius.circular(AppRadiusTokens.md),
  );
  static const BorderRadius panelRadius = BorderRadius.all(
    Radius.circular(AppRadiusTokens.md),
  );
  static const BorderRadius itemRadius = BorderRadius.all(
    Radius.circular(AppRadiusTokens.sm),
  );

  static Color controlFillColor(ThemeData theme) {
    return Color.alphaBlend(
      theme.colorScheme.primary.withValues(
        alpha: theme.brightness == Brightness.dark ? 0.04 : 0.022,
      ),
      theme.inputDecorationTheme.fillColor ?? theme.cardColor,
    );
  }

  static BorderSide controlBorder(ThemeData theme, {required bool focused}) {
    return BorderSide(
      color: focused
          ? theme.colorScheme.primary.withValues(alpha: 0.78)
          : theme.dividerColor.withValues(alpha: 0.86),
      width: focused ? 1.25 : 1,
    );
  }

  static List<BoxShadow> controlShadow(
    ThemeData theme, {
    required bool focused,
  }) {
    return [
      BoxShadow(
        color: theme.colorScheme.primary.withValues(
          alpha: focused ? 0.08 : 0.02,
        ),
        blurRadius: focused ? 14 : 8,
        offset: const Offset(0, 4),
      ),
    ];
  }

  static BoxDecoration panelDecoration(ThemeData theme) {
    return BoxDecoration(
      borderRadius: panelRadius,
      color: Color.alphaBlend(
        theme.colorScheme.primary.withValues(
          alpha: theme.brightness == Brightness.dark ? 0.028 : 0.014,
        ),
        theme.cardColor,
      ),
      border: Border.all(color: theme.dividerColor.withValues(alpha: 0.82)),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(
            alpha: theme.brightness == Brightness.dark ? 0.18 : 0.07,
          ),
          blurRadius: 18,
          offset: const Offset(0, 8),
        ),
      ],
    );
  }

  static Color menuItemBackground(
    ThemeData theme, {
    required bool selected,
    required bool highlighted,
  }) {
    if (selected) {
      return theme.colorScheme.primary.withValues(alpha: 0.1);
    }
    if (highlighted) {
      return theme.colorScheme.primary.withValues(alpha: 0.05);
    }
    return Colors.transparent;
  }
}
