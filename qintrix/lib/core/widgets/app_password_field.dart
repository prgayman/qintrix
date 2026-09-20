import 'package:flutter/material.dart';
import 'package:lucide_flutter/lucide_flutter.dart';
import 'package:qintrix/core/widgets/app_field_wrapper.dart';

import 'form_control_style.dart';

class AppPasswordField extends StatefulWidget {
  const AppPasswordField({
    required this.label,
    this.controller,
    this.required = false,
    super.key,
  });

  final String label;
  final TextEditingController? controller;
  final bool required;

  @override
  State<AppPasswordField> createState() => _AppPasswordFieldState();
}

class _AppPasswordFieldState extends State<AppPasswordField> {
  bool _obscureText = true;

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FormField<String>(
      initialValue: widget.controller?.text,
      builder: (state) {
        return AppFieldWrapper(
          label: widget.label,
          required: widget.required,
          supportText: state.errorText,
          isError: state.hasError,
          child: SizedBox(
            height: FormControlStyle.controlHeight,
            child: TextField(
              controller: widget.controller,
              obscureText: _obscureText,
              onChanged: state.didChange,
              style: theme.textTheme.bodyMedium,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                errorText: null,
                helperText: null,
                enabledBorder: state.hasError
                    ? Theme.of(context).inputDecorationTheme.errorBorder
                    : null,
                focusedBorder: state.hasError
                    ? Theme.of(context).inputDecorationTheme.focusedErrorBorder
                    : null,
                suffixIcon: IconButton(
                  onPressed: _toggleVisibility,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(
                    minWidth: 32,
                    minHeight: 32,
                  ),
                  visualDensity: VisualDensity.comfortable,
                  splashRadius: 18,
                  icon: Icon(
                    _obscureText ? LucideIcons.eyeOff : LucideIcons.eye,
                    size: 16,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
