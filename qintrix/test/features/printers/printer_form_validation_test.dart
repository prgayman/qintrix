import 'package:flutter_test/flutter_test.dart';
import 'package:qintrix/data/models/exports.dart';
import 'package:qintrix/features/printers/helpers/printer_form_validation.dart';

void main() {
  group('PrinterFormValidation', () {
    test('normalizes USB ids to uppercase 4-digit hex', () {
      expect(PrinterFormValidation.normalizeHexId('0x4b8'), '04B8');
      expect(PrinterFormValidation.normalizeHexId('0202'), '0202');
    });

    test('validates hostnames and ip addresses', () {
      expect(PrinterFormValidation.isValidHost('127.0.0.1'), isTrue);
      expect(PrinterFormValidation.isValidHost('printer.local'), isTrue);
      expect(PrinterFormValidation.isValidHost('bad host'), isFalse);
    });

    test('rejects matching USB endpoints in cross-field validation', () {
      final printer = PrinterModel(
        id: '1',
        uniqueKey: 'printer_123',
        name: 'USB Printer',
        connectionType: PrinterConnectionType.usbRawEscPos,
        isEnabled: true,
        createdAt: DateTime(2026, 1, 1),
        updatedAt: DateTime(2026, 1, 1),
        usbVendorId: '04B8',
        usbProductId: '0202',
        usbOutEndpoint: 1,
        usbInEndpoint: 1,
      );

      expect(
        PrinterFormValidation.validateConnectionSpecificRules(printer),
        'usb-endpoints-match',
      );
    });
  });
}
