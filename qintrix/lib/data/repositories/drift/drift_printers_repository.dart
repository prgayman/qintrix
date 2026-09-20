import 'package:drift/drift.dart';
import 'package:qintrix/data/database/app_database.dart';
import 'package:qintrix/data/models/exports.dart';

import '../contracts/printers_repository.dart';

class DriftPrintersRepository implements PrintersRepository {
  DriftPrintersRepository(this._printersDao);

  final PrintersDao _printersDao;

  @override
  Future<List<PrinterModel>> getPrinters() async {
    final rows = await _printersDao.getPrinters();
    return rows.map(_mapPrinter).toList(growable: false);
  }

  @override
  Future<PagedResult<PrinterModel>> queryPrinters(PrintersQuery query) async {
    final results = await Future.wait([
      _printersDao.queryPrinters(query),
      _printersDao.countPrinters(query),
    ]);
    final rows = results[0] as List<PrintersTableData>;
    final totalCount = results[1] as int;

    return PagedResult<PrinterModel>(
      items: rows.map(_mapPrinter).toList(growable: false),
      totalCount: totalCount,
      page: query.page,
      pageSize: query.pageSize,
    );
  }

  @override
  Future<PrinterModel?> getPrinterById(String id) async {
    final row = await _printersDao.getPrinterById(id);
    if (row == null) {
      return null;
    }

    return _mapPrinter(row);
  }

  @override
  Future<void> savePrinter(PrinterModel printer) {
    return _printersDao.upsertPrinter(
      PrintersTableCompanion(
        id: Value(printer.id),
        uniqueKey: Value(printer.uniqueKey),
        name: Value(printer.name),
        description: Value(printer.description),
        connectionType: Value(printer.connectionType.value),
        address: Value(printer.tcpHost),
        tcpHost: Value(printer.tcpHost),
        tcpPort: Value(printer.tcpPort),
        tcpConnectTimeoutMs: Value(printer.tcpConnectTimeoutMs),
        tcpWriteTimeoutMs: Value(printer.tcpWriteTimeoutMs),
        tcpReadTimeoutMs: Value(printer.tcpReadTimeoutMs),
        tcpAutoReconnect: Value(printer.tcpAutoReconnect),
        tcpReconnectDelayMs: Value(printer.tcpReconnectDelayMs),
        tcpEncoding: Value(printer.tcpEncoding),
        tcpCodePage: Value(printer.tcpCodePage),
        tcpLineEnding: Value(printer.tcpLineEnding),
        tcpKeepAlive: Value(printer.tcpKeepAlive),
        tcpNoDelay: Value(printer.tcpNoDelay),
        tcpLingerSeconds: Value(printer.tcpLingerSeconds),
        systemPrinterName: Value(printer.systemPrinterName),
        systemPaperSize: Value(printer.systemPaperSize),
        systemDefaultCopies: Value(printer.systemDefaultCopies),
        systemColorEnabled: Value(printer.systemColorEnabled),
        systemDuplexMode: Value(printer.systemDuplexMode),
        systemOrientation: Value(printer.systemOrientation),
        systemJobTimeoutMs: Value(printer.systemJobTimeoutMs),
        systemNotes: Value(printer.systemNotes),
        systemDriverName: Value(printer.systemDriverName),
        systemQueueName: Value(printer.systemQueueName),
        systemSpoolFormat: Value(printer.systemSpoolFormat),
        systemUseRawSpool: Value(printer.systemUseRawSpool),
        usbVendorId: Value(printer.usbVendorId),
        usbProductId: Value(printer.usbProductId),
        usbSerialNumber: Value(printer.usbSerialNumber),
        usbInterfaceNumber: Value(printer.usbInterfaceNumber),
        usbOutEndpoint: Value(printer.usbOutEndpoint),
        usbInEndpoint: Value(printer.usbInEndpoint),
        usbTimeoutMs: Value(printer.usbTimeoutMs),
        usbEncoding: Value(printer.usbEncoding),
        usbCodePage: Value(printer.usbCodePage),
        usbCharacterTable: Value(printer.usbCharacterTable),
        usbAutoCutEnabled: Value(printer.usbAutoCutEnabled),
        usbCutMode: Value(printer.usbCutMode),
        usbCashDrawerEnabled: Value(printer.usbCashDrawerEnabled),
        usbDrawerPin: Value(printer.usbDrawerPin),
        usbStatusMonitoringEnabled: Value(printer.usbStatusMonitoringEnabled),
        usbManufacturer: Value(printer.usbManufacturer),
        usbProductName: Value(printer.usbProductName),
        usbAlternateSetting: Value(printer.usbAlternateSetting),
        usbPacketDelayMs: Value(printer.usbPacketDelayMs),
        rawGraphicsMode: Value(printer.rawGraphicsMode ?? 'modern'),
        isEnabled: Value(printer.isEnabled),
        lastStatus: Value(printer.lastStatus),
        lastStatusKey: Value(printer.lastStatusKey),
        lastStatusMessage: Value(printer.lastStatusMessage),
        createdAt: Value(printer.createdAt),
        updatedAt: Value(printer.updatedAt),
      ),
    );
  }

  @override
  Future<void> deletePrinter(String id) => _printersDao.deletePrinter(id);

  @override
  Future<void> deletePrinters(List<String> ids) =>
      _printersDao.deletePrinters(ids);

  @override
  Future<bool> uniqueKeyExists(String uniqueKey, {String? excludingId}) {
    return _printersDao.uniqueKeyExists(uniqueKey, excludingId: excludingId);
  }

  PrinterModel _mapPrinter(PrintersTableData row) {
    return PrinterModel(
      id: row.id,
      uniqueKey: row.uniqueKey,
      name: row.name,
      description: row.description,
      connectionType: PrinterConnectionType.fromValue(row.connectionType),
      isEnabled: row.isEnabled,
      lastStatus: row.lastStatus,
      lastStatusKey: row.lastStatusKey,
      lastStatusMessage: row.lastStatusMessage,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
      tcpHost: row.tcpHost ?? row.address,
      tcpPort: row.tcpPort,
      tcpConnectTimeoutMs: row.tcpConnectTimeoutMs,
      tcpWriteTimeoutMs: row.tcpWriteTimeoutMs,
      tcpReadTimeoutMs: row.tcpReadTimeoutMs,
      tcpAutoReconnect: row.tcpAutoReconnect,
      tcpReconnectDelayMs: row.tcpReconnectDelayMs,
      tcpEncoding: row.tcpEncoding,
      tcpCodePage: row.tcpCodePage,
      tcpLineEnding: row.tcpLineEnding,
      tcpKeepAlive: row.tcpKeepAlive,
      tcpNoDelay: row.tcpNoDelay,
      tcpLingerSeconds: row.tcpLingerSeconds,
      systemPrinterName: row.systemPrinterName,
      systemPaperSize: row.systemPaperSize,
      systemDefaultCopies: row.systemDefaultCopies,
      systemColorEnabled: row.systemColorEnabled,
      systemDuplexMode: row.systemDuplexMode,
      systemOrientation: row.systemOrientation,
      systemJobTimeoutMs: row.systemJobTimeoutMs,
      systemNotes: row.systemNotes,
      systemDriverName: row.systemDriverName,
      systemQueueName: row.systemQueueName,
      systemSpoolFormat: row.systemSpoolFormat,
      systemUseRawSpool: row.systemUseRawSpool,
      usbVendorId: row.usbVendorId,
      usbProductId: row.usbProductId,
      usbSerialNumber: row.usbSerialNumber,
      usbInterfaceNumber: row.usbInterfaceNumber,
      usbOutEndpoint: row.usbOutEndpoint,
      usbInEndpoint: row.usbInEndpoint,
      usbTimeoutMs: row.usbTimeoutMs,
      usbEncoding: row.usbEncoding,
      usbCodePage: row.usbCodePage,
      usbCharacterTable: row.usbCharacterTable,
      usbAutoCutEnabled: row.usbAutoCutEnabled,
      usbCutMode: row.usbCutMode,
      usbCashDrawerEnabled: row.usbCashDrawerEnabled,
      usbDrawerPin: row.usbDrawerPin,
      usbStatusMonitoringEnabled: row.usbStatusMonitoringEnabled,
      usbManufacturer: row.usbManufacturer,
      usbProductName: row.usbProductName,
      usbAlternateSetting: row.usbAlternateSetting,
      usbPacketDelayMs: row.usbPacketDelayMs,
      rawGraphicsMode: row.rawGraphicsMode,
    );
  }
}
