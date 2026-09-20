import 'package:flutter/material.dart';

class SettingsPanel extends StatelessWidget {
  const SettingsPanel({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        color: theme.cardColor,
        border: Border.all(color: theme.dividerColor.withValues(alpha: 0.85)),
      ),
      child: Padding(padding: const EdgeInsets.all(18), child: child),
    );
  }
}
