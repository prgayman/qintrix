import 'package:flutter/material.dart';
import 'package:lucide_flutter/lucide_flutter.dart';

class AppCopyButton extends StatelessWidget {
  const AppCopyButton({
    required this.tooltip,
    this.onPressed,
    this.compact = false,
    this.outlined = true,
    super.key,
  });

  final String tooltip;
  final VoidCallback? onPressed;
  final bool compact;
  final bool outlined;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final size = compact ? 24.0 : 30.0;
    final radius = compact ? 8.0 : 9.0;
    final iconSize = compact ? 14.0 : 15.0;
    final background = outlined
        ? scheme.surfaceContainerHighest.withValues(alpha: 0.45)
        : Colors.transparent;
    final border = outlined
        ? BorderSide(color: theme.dividerColor.withValues(alpha: 0.7))
        : BorderSide.none;

    return Tooltip(
      message: tooltip,
      child: Material(
        color: background,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
          side: border,
        ),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(radius),
          child: SizedBox(
            width: size,
            height: size,
            child: Icon(
              LucideIcons.copy,
              size: iconSize,
              color: onPressed == null
                  ? theme.disabledColor
                  : scheme.primary,
            ),
          ),
        ),
      ),
    );
  }
}
