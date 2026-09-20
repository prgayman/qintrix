import 'package:qintrix/data/models/exports.dart';

abstract final class PrinterConnectionSummary {
  static String forPrinter(PrinterModel printer) {
    return switch (printer.connectionType) {
      PrinterConnectionType.networkTcp => _tcpSummary(printer),
      PrinterConnectionType.systemSpooler => printer.systemPrinterName ?? '-',
      PrinterConnectionType.usbRawEscPos => _usbSummary(printer),
    };
  }

  static String _tcpSummary(PrinterModel printer) {
    if (printer.tcpHost == null || printer.tcpHost!.isEmpty) {
      return '-';
    }

    if (printer.tcpPort == null) {
      return printer.tcpHost!;
    }

    return '${printer.tcpHost}:${printer.tcpPort}';
  }

  static String _usbSummary(PrinterModel printer) {
    final vendor = printer.usbVendorId ?? '----';
    final product = printer.usbProductId ?? '----';
    if (printer.usbSerialNumber != null && printer.usbSerialNumber!.isNotEmpty) {
      return '$vendor:$product • ${printer.usbSerialNumber}';
    }

    return '$vendor:$product';
  }
}
