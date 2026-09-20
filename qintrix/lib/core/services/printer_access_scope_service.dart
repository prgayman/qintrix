import 'package:qintrix/core/services/app_authorization_service.dart';
import 'package:qintrix/data/models/exports.dart';

class PrinterAccessScopeService {
  const PrinterAccessScopeService();

  List<PrinterModel> filterPrinters(
    Iterable<PrinterModel> printers,
    AppAuthorizationResult authorization,
  ) {
    if (authorization.allowsAllPrinters) {
      return printers.toList(growable: false);
    }

    return printers
        .where(
          (printer) => authorization.allowedPrinterIds.contains(printer.id),
        )
        .toList(growable: false);
  }

  PrinterModel? findAccessiblePrinter(
    Iterable<PrinterModel> printers,
    AppAuthorizationResult authorization,
    String printerId,
  ) {
    for (final printer in filterPrinters(printers, authorization)) {
      if (printer.id == printerId || printer.uniqueKey == printerId) {
        return printer;
      }
    }

    return null;
  }
}
