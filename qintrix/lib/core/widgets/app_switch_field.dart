import 'package:flutter/material.dart';
import 'package:qintrix/core/widgets/app_field_wrapper.dart';
import 'package:qintrix/core/widgets/form_control_style.dart';
import 'package:qintrix/theme/tokens/color_tokens.dart';
import 'package:qintrix/theme/tokens/radius_tokens.dart';

class AppSwitchField extends StatelessWidget {
  const AppSwitchField({
    required this.label,
    required this.value,
    required this.onChanged,
    this.description,
    this.required = false,
    super.key,
  });

  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;
  final String? description;
  final bool required;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return AppFieldWrapper(
      label: label,
      required: required,
      child: InkWell(
        onTap: () => onChanged(!value),
        borderRadius: BorderRadius.circular(AppRadiusTokens.md),
        child: Container(
          height: FormControlStyle.controlHeight,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: theme.inputDecorationTheme.fillColor,
            borderRadius: BorderRadius.circular(AppRadiusTokens.md),
            border: Border.all(
              color: value
                  ? theme.colorScheme.primary.withValues(alpha: 0.42)
                  : theme.dividerColor.withValues(alpha: 0.9),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: description == null
                    ? Text(
                        value ? 'Enabled' : 'Disabled',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.textTheme.bodySmall?.color?.withValues(
                            alpha: 0.84,
                          ),
                        ),
                      )
                    : Text(
                        description!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.textTheme.bodySmall?.color?.withValues(
                            alpha: 0.84,
                          ),
                        ),
                      ),
              ),
              AppSwitchControl(
                value: value,
                onChanged: onChanged,
                isDark: isDark,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AppSwitchControl extends StatelessWidget {
  const AppSwitchControl({
    required this.value,
    required this.onChanged,
    required this.isDark,
    this.width = 42,
    this.height = 24,
    this.thumbSize = 18,
    super.key,
  });

  final bool value;
  final ValueChanged<bool> onChanged;
  final bool isDark;
  final double width;
  final double height;
  final double thumbSize;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final activeTrack = Color.alphaBlend(
      AppColorTokens.supportCyan.withValues(alpha: 0.18),
      theme.colorScheme.primary.withValues(alpha: 0.82),
    );
    final inactiveTrack = isDark
        ? theme.dividerColor.withValues(alpha: 0.4)
        : const Color(0xFFD7DEE9);

    return Semantics(
      toggled: value,
      child: SizedBox(
        width: width,
        height: height,
        child: GestureDetector(
          onTap: () => onChanged(!value),
          behavior: HitTestBehavior.deferToChild,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 160),
            curve: Curves.easeOutCubic,
            width: width,
            height: height,
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppRadiusTokens.pill),
              color: value ? activeTrack : inactiveTrack,
              border: Border.all(
                color: value
                    ? theme.colorScheme.primary.withValues(alpha: 0.24)
                    : theme.dividerColor.withValues(alpha: 0.2),
              ),
            ),
            child: AnimatedAlign(
              duration: const Duration(milliseconds: 160),
              curve: Curves.easeOutCubic,
              alignment: value ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                width: thumbSize,
                height: thumbSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(
                        alpha: isDark ? 0.24 : 0.12,
                      ),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
