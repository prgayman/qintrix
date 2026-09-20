import 'package:flutter/material.dart';

class SettingsBooleanTile extends StatelessWidget {
  const SettingsBooleanTile({
    required this.label,
    required this.value,
    required this.onChanged,
    this.icon,
    super.key,
  });

  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: () => onChanged(!value),
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: theme.dividerColor.withValues(alpha: 0.8),
            ),
          ),
          child: Row(
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  size: 15,
                  color: theme.colorScheme.primary.withValues(
                    alpha: value ? 0.95 : 0.78,
                  ),
                ),
                const SizedBox(width: 8),
              ],
              Expanded(child: Text(label)),
              Switch(
                value: value,
                onChanged: onChanged,
                activeThumbColor: Colors.white,
                activeTrackColor: isDark
                    ? colorScheme.primary.withValues(alpha: 0.88)
                    : colorScheme.primary.withValues(alpha: 0.78),
                inactiveThumbColor: isDark
                    ? const Color(0xFFF4F7FB)
                    : Colors.white,
                inactiveTrackColor: isDark
                    ? const Color(0xFF4A5568)
                    : const Color(0xFFD7DEE9),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
