import 'package:qintrix/data/models/exports.dart';

abstract class PrintersRepository {
  Future<List<PrinterModel>> getPrinters();

  Future<PagedResult<PrinterModel>> queryPrinters(PrintersQuery query);

  Future<PrinterModel?> getPrinterById(String id);

  Future<void> savePrinter(PrinterModel printer);

  Future<void> deletePrinter(String id);

  Future<void> deletePrinters(List<String> ids);

  Future<bool> uniqueKeyExists(String uniqueKey, {String? excludingId});
}
