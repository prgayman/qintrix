import 'package:flutter/material.dart';
import 'package:lucide_flutter/lucide_flutter.dart';
import 'package:qintrix/theme/tokens/color_tokens.dart';

class AppFloatingToastData {
  const AppFloatingToastData({required this.tone, this.title, this.message});

  final String? title;
  final String? message;
  final AppStatusTone tone;
}

class AppFloatingToast extends StatelessWidget {
  const AppFloatingToast({required this.data, super.key});

  final AppFloatingToastData data;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final brightness = theme.brightness;
    final toneColor = AppStatusToneColors.resolveForeground(data.tone);
    final toneBackground = AppStatusToneColors.resolveBackground(
      data.tone,
      brightness,
    );
    final title = data.title;
    final message = data.message;

    return IgnorePointer(
      child: Material(
        color: Colors.transparent,
        child: Align(
          alignment: AlignmentDirectional.topEnd,
          child: Container(
            width: 320,
            margin: const EdgeInsetsDirectional.only(top: 12, end: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: theme.dividerColor.withValues(alpha: 0.78),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(
                    alpha: brightness == Brightness.dark ? 0.28 : 0.1,
                  ),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: toneBackground,
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: Icon(
                    _iconForTone(data.tone),
                    size: 16,
                    color: toneColor,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (title != null) ...[
                        Text(
                          title,
                          style: theme.textTheme.labelLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: theme.textTheme.bodyLarge?.color,
                          ),
                        ),
                        const SizedBox(height: 2),
                      ],
                      if (message != null) ...[
                        Text(
                          message,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.textTheme.bodyMedium?.color
                                ?.withValues(alpha: 0.82),
                            height: 1.35,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  IconData _iconForTone(AppStatusTone tone) {
    return switch (tone) {
      AppStatusTone.success => LucideIcons.badgeCheck,
      AppStatusTone.error => LucideIcons.circleAlert,
      AppStatusTone.warning => LucideIcons.triangleAlert,
      AppStatusTone.info => LucideIcons.info,
    };
  }
}
