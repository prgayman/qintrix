import 'package:flutter/material.dart';
import 'package:qintrix/theme/tokens/color_tokens.dart';
import 'package:qintrix/theme/tokens/radius_tokens.dart';
import 'package:qintrix/theme/tokens/shadow_tokens.dart';

class AppSectionCard extends StatelessWidget {
  const AppSectionCard({
    required this.title,
    this.subtitle,
    this.leading,
    this.actions,
    this.child,
    super.key,
  });

  final String title;
  final String? subtitle;
  final Widget? leading;
  final List<Widget>? actions;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final titleColor = isDark
        ? AppColorTokens.darkTextPrimary
        : AppColorTokens.lightTextPrimary;
    final subtitleColor = isDark
        ? AppColorTokens.darkTextSecondary
        : AppColorTokens.lightTextSecondary;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadiusTokens.lg),
        color: theme.cardColor.withValues(alpha: isDark ? 0.96 : 0.98),
        border: Border.all(
          color: theme.dividerColor.withValues(alpha: isDark ? 0.72 : 0.9),
        ),
        boxShadow: AppShadowTokens.soft(
          isDark ? Colors.black : Colors.black.withValues(alpha: 0.08),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (leading != null) ...[
                  leading!,
                  const SizedBox(width: 10),
                ],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: titleColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      if (subtitle != null) ...[
                        const SizedBox(height: 3),
                        Text(
                          subtitle!,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: subtitleColor,
                            height: 1.35,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                if (actions != null) ...actions!,
              ],
            ),
            if (child != null) ...[const SizedBox(height: 12), child!],
          ],
        ),
      ),
    );
  }
}
