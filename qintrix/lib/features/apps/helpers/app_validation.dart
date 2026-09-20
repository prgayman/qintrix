import 'package:qintrix/features/printers/helpers/printer_form_validation.dart';

abstract final class AppValidation {
  static String? validateName(String? value) {
    return PrinterFormValidation.validateRequiredText(value, maxLength: 255);
  }
}
