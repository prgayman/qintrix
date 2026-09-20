import 'package:flutter_test/flutter_test.dart';
import 'package:qintrix/features/printers/helpers/printer_unique_key_generator.dart';

void main() {
  test('generates PRN-XXXXXX printer keys', () {
    final key = PrinterUniqueKeyGenerator.generate();

    expect(key, matches(RegExp(r'^PRN-[A-Z0-9]{6}$')));
  });
}
