import 'package:flutter/material.dart';
import 'package:qintrix/theme/tokens/radius_tokens.dart';

abstract final class FormControlStyle {
  static const double controlHeight = 40;
  static const double multilineMinLines = 3;
  static const double multilineMaxLines = 5;
  static const EdgeInsets controlPadding = EdgeInsets.symmetric(
    horizontal: 12,
    vertical: 10,
  );
  static const BorderRadius controlRadius = BorderRadius.all(
    Radius.circular(AppRadiusTokens.md),
  );
}
