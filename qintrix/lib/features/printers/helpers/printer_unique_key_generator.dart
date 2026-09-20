import 'package:uuid/uuid.dart';

abstract final class PrinterUniqueKeyGenerator {
  static const Uuid _uuid = Uuid();

  static String generate() {
    final raw = _uuid.v4().replaceAll('-', '').toUpperCase();
    return 'PRN-${raw.substring(0, 6)}';
  }
}
