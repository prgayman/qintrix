import 'dart:io';

import 'package:qintrix/data/models/exports.dart';
import 'package:qintrix/features/printers/helpers/printer_form_options.dart';

abstract final class PrinterFormValidation {
  static final RegExp _hostnamePattern = RegExp(
    r'^(?=.{1,253}$)(?!-)[A-Za-z0-9-]{1,63}(?<!-)(\.(?!-)[A-Za-z0-9-]{1,63}(?<!-))*$',
  );
  static final RegExp _hexUsbIdPattern = RegExp(r'^(0x)?[0-9A-Fa-f]{4}$');
  static final RegExp _integerPattern = RegExp(r'^\d+$');
  static final RegExp _usbEndpointPattern = RegExp(
    r'^(0x)?[0-9A-Fa-f]{1,2}$|^([1-9]|1[0-5])$',
  );

  static String? trimToNull(String? value) {
    final trimmed = value?.trim() ?? '';
    return trimmed.isEmpty ? null : trimmed;
  }

  static String normalizeHexId(String value) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) {
      return trimmed;
    }

    final raw = trimmed.toUpperCase().replaceFirst('0X', '');
    return raw.padLeft(4, '0');
  }

  static int? parseInteger(String? value) {
    final trimmed = trimToNull(value);
    if (trimmed == null || !_integerPattern.hasMatch(trimmed)) {
      return null;
    }

    return int.tryParse(trimmed);
  }

  static bool isValidHost(String value) {
    final trimmed = value.trim();
    if (trimmed.isEmpty || trimmed.length > 253) {
      return false;
    }

    final parsedAddress = InternetAddress.tryParse(trimmed);
    if (parsedAddress != null) {
      return true;
    }

    return _hostnamePattern.hasMatch(trimmed);
  }

  static bool isValidUsbId(String value) {
    return _hexUsbIdPattern.hasMatch(value.trim());
  }

  static bool isValidUsbEndpoint(String value) {
    final trimmed = value.trim();
    if (!_usbEndpointPattern.hasMatch(trimmed)) {
      return false;
    }

    final parsed = _parseEndpoint(trimmed);
    return parsed != null && parsed >= 1 && parsed <= 15;
  }

  static int? parseUsbEndpoint(String? value) {
    final trimmed = trimToNull(value);
    if (trimmed == null) {
      return null;
    }

    return _parseEndpoint(trimmed);
  }

  static int? _parseEndpoint(String value) {
    final normalized = value.trim().toLowerCase();
    if (normalized.startsWith('0x')) {
      return int.tryParse(normalized.substring(2), radix: 16);
    }

    return int.tryParse(normalized);
  }

  static bool isSupportedEncoding(String? value) {
    if (value == null || value.isEmpty) {
      return true;
    }

    return PrinterFormOptions.encodings.contains(value);
  }

  static bool isSupportedCodePage(String? value) {
    if (value == null || value.isEmpty) {
      return true;
    }

    return PrinterFormOptions.codePages.contains(value);
  }

  static bool isSupportedPaperSize(String? value) {
    if (value == null || value.isEmpty) {
      return true;
    }

    return PrinterFormOptions.paperSizes.contains(value);
  }

  static bool isSupportedSpoolFormat(String? value) {
    if (value == null || value.isEmpty) {
      return true;
    }

    return PrinterFormOptions.spoolFormats.contains(value);
  }

  static bool isSupportedCharacterTable(String? value) {
    if (value == null || value.isEmpty) {
      return true;
    }

    return PrinterFormOptions.characterTables.contains(value);
  }

  static bool isSupportedCutMode(String? value) {
    if (value == null || value.isEmpty) {
      return true;
    }

    return PrinterFormOptions.cutModes.contains(value);
  }

  static bool isValidLineEnding(String? value) {
    if (value == null || value.isEmpty) {
      return true;
    }

    return PrinterFormOptions.lineEndings.contains(value);
  }

  static bool isValidDuplexMode(String? value) {
    if (value == null || value.isEmpty) {
      return true;
    }

    return PrinterFormOptions.duplexModes.contains(value);
  }

  static bool isValidOrientation(String? value) {
    if (value == null || value.isEmpty) {
      return true;
    }

    return PrinterFormOptions.orientations.contains(value);
  }

  static String? validateRequiredText(String? value, {int? maxLength}) {
    final trimmed = trimToNull(value);
    if (trimmed == null) {
      return 'required';
    }
    if (maxLength != null && trimmed.length > maxLength) {
      return 'max-length';
    }
    return null;
  }

  static String? validateOptionalText(String? value, {int? maxLength}) {
    final trimmed = trimToNull(value);
    if (trimmed == null) {
      return null;
    }
    if (maxLength != null && trimmed.length > maxLength) {
      return 'max-length';
    }
    return null;
  }

  static String? validateIntegerField(
    String? value, {
    int? min,
    int? max,
    bool required = false,
  }) {
    final trimmed = trimToNull(value);
    if (trimmed == null) {
      return required ? 'required' : null;
    }
    if (!_integerPattern.hasMatch(trimmed)) {
      return 'invalid-integer';
    }
    final parsed = int.parse(trimmed);
    if (min != null && parsed < min) {
      return 'min';
    }
    if (max != null && parsed > max) {
      return 'max';
    }
    return null;
  }

  static String? validateConnectionSpecificRules(PrinterModel printer) {
    if (printer.connectionType == PrinterConnectionType.usbRawEscPos &&
        printer.usbInEndpoint != null &&
        printer.usbOutEndpoint != null &&
        printer.usbInEndpoint == printer.usbOutEndpoint) {
      return 'usb-endpoints-match';
    }

    if (printer.connectionType == PrinterConnectionType.systemSpooler &&
        printer.systemUseRawSpool &&
        printer.systemSpoolFormat != null &&
        printer.systemSpoolFormat!.isNotEmpty &&
        printer.systemSpoolFormat != 'RAW') {
      return 'invalid-spool-format';
    }

    return null;
  }
}
