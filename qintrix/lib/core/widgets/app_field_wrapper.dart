import 'package:flutter/material.dart';

class AppFieldWrapper extends StatelessWidget {
  const AppFieldWrapper({
    required this.label,
    required this.child,
    this.required = false,
    this.supportText,
    this.isError = false,
    super.key,
  });

  final String label;
  final Widget child;
  final bool required;
  final String? supportText;
  final bool isError;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.only(start: 2, bottom: 6),
          child: RichText(
            text: TextSpan(
              style: theme.textTheme.labelMedium?.copyWith(
                color: theme.textTheme.bodyMedium?.color?.withValues(
                  alpha: 0.82,
                ),
                fontWeight: FontWeight.w600,
              ),
              children: [
                TextSpan(text: label),
                if (required)
                  TextSpan(
                    text: ' *',
                    style: TextStyle(color: theme.colorScheme.error),
                  ),
              ],
            ),
          ),
        ),
        child,
        if (supportText != null) ...[
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 2),
            child: Text(
              supportText!,
              style:
                  (isError
                          ? theme.textTheme.labelSmall?.copyWith(
                              color: theme.colorScheme.error,
                            )
                          : theme.textTheme.labelSmall)
                      ?.copyWith(height: 1.2),
            ),
          ),
        ],
      ],
    );
  }
}
