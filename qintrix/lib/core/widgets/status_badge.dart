import 'package:flutter/material.dart';
import 'package:qintrix/theme/tokens/color_tokens.dart';

enum StatusBadgeSize { small, medium }

class StatusBadge extends StatelessWidget {
  const StatusBadge({
    required this.label,
    required this.tone,
    this.size = StatusBadgeSize.medium,
    this.uppercase = false,
    this.icon,
    super.key,
  });

  final String label;
  final AppStatusTone tone;
  final StatusBadgeSize size;
  final bool uppercase;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final foreground = AppStatusToneColors.resolveForeground(tone);
    final background = AppStatusToneColors.resolveBackground(tone, brightness);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: size == StatusBadgeSize.small ? 8 : 12,
          vertical: size == StatusBadgeSize.small ? 3 : 6,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: size == StatusBadgeSize.small ? 12 : 14,
                color: foreground,
              ),
              SizedBox(width: size == StatusBadgeSize.small ? 6 : 8),
            ],
            Flexible(
              child: Text(
                uppercase ? label.toUpperCase() : label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: foreground,
                  fontSize: size == StatusBadgeSize.small ? 10.5 : 12,
                  fontWeight: FontWeight.w700,
                  letterSpacing: uppercase ? 0.3 : null,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
