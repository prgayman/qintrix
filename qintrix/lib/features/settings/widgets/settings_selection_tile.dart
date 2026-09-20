import 'package:flutter/material.dart';
import 'package:lucide_flutter/lucide_flutter.dart';

class SettingsSelectionTile extends StatelessWidget {
  const SettingsSelectionTile({
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.icon,
    super.key,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: isSelected
              ? theme.colorScheme.primary.withValues(alpha: 0.06)
              : Colors.transparent,
          border: Border.all(
            color: isSelected
                ? theme.colorScheme.primary.withValues(alpha: 0.2)
                : theme.dividerColor.withValues(alpha: 0.8),
          ),
        ),
        child: Row(
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: 16,
                color: isSelected
                    ? theme.colorScheme.primary
                    : theme.textTheme.bodySmall?.color?.withValues(alpha: 0.82),
              ),
              const SizedBox(width: 10),
            ],
            Expanded(child: Text(label, style: theme.textTheme.labelLarge)),
            if (isSelected)
              Icon(
                LucideIcons.check,
                size: 16,
                color: theme.colorScheme.primary,
              ),
          ],
        ),
      ),
    );
  }
}
