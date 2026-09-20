import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qintrix/core/widgets/app_field_wrapper.dart';

import 'form_control_style.dart';

class AppNumberField extends StatelessWidget {
  const AppNumberField({
    required this.label,
    this.hintText,
    this.controller,
    this.validator,
    this.onChanged,
    this.helperText,
    this.readOnly = false,
    this.required = false,
    this.inputFormatters,
    this.suffixIcon,
    super.key,
  });

  final String label;
  final String? hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final String? helperText;
  final bool readOnly;
  final bool required;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      initialValue: controller?.text,
      validator: validator,
      builder: (state) {
        return AppFieldWrapper(
          label: label,
          required: required,
          supportText: state.errorText ?? helperText,
          isError: state.hasError,
          child: SizedBox(
            height: FormControlStyle.controlHeight,
            child: TextField(
              controller: controller,
              onChanged: (value) {
                state.didChange(value);
                onChanged?.call(value);
              },
              readOnly: readOnly,
              keyboardType: TextInputType.number,
              inputFormatters:
                  inputFormatters ?? [FilteringTextInputFormatter.digitsOnly],
              style: Theme.of(context).textTheme.bodyMedium,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                hintText: hintText,
                suffixIcon: suffixIcon,
                errorText: null,
                helperText: null,
                enabledBorder: state.hasError
                    ? Theme.of(context).inputDecorationTheme.errorBorder
                    : null,
                focusedBorder: state.hasError
                    ? Theme.of(context).inputDecorationTheme.focusedErrorBorder
                    : null,
              ),
            ),
          ),
        );
      },
    );
  }
}
