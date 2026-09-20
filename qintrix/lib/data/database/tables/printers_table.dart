import 'package:drift/drift.dart';

class PrintersTable extends Table {
  TextColumn get id => text()();

  TextColumn get uniqueKey => text().withDefault(const Constant(''))();

  TextColumn get name => text()();

  TextColumn get description => text().nullable()();

  TextColumn get connectionType =>
      text().withDefault(const Constant('system_spooler'))();

  TextColumn get address => text().nullable()();

  TextColumn get tcpHost => text().nullable()();

  IntColumn get tcpPort => integer().nullable()();

  IntColumn get tcpConnectTimeoutMs => integer().nullable()();

  IntColumn get tcpWriteTimeoutMs => integer().nullable()();

  IntColumn get tcpReadTimeoutMs => integer().nullable()();

  BoolColumn get tcpAutoReconnect =>
      boolean().withDefault(const Constant(false))();

  IntColumn get tcpReconnectDelayMs => integer().nullable()();

  TextColumn get tcpEncoding => text().nullable()();

  TextColumn get tcpCodePage => text().nullable()();

  TextColumn get tcpLineEnding => text().nullable()();

  BoolColumn get tcpKeepAlive => boolean().withDefault(const Constant(false))();

  BoolColumn get tcpNoDelay => boolean().withDefault(const Constant(false))();

  IntColumn get tcpLingerSeconds => integer().nullable()();

  TextColumn get systemPrinterName => text().nullable()();

  TextColumn get systemPaperSize => text().nullable()();

  IntColumn get systemDefaultCopies =>
      integer().withDefault(const Constant(1))();

  BoolColumn get systemColorEnabled =>
      boolean().withDefault(const Constant(false))();

  TextColumn get systemDuplexMode => text().nullable()();

  TextColumn get systemOrientation => text().nullable()();

  IntColumn get systemJobTimeoutMs => integer().nullable()();

  TextColumn get systemNotes => text().nullable()();

  TextColumn get systemDriverName => text().nullable()();

  TextColumn get systemQueueName => text().nullable()();

  TextColumn get systemSpoolFormat => text().nullable()();

  BoolColumn get systemUseRawSpool =>
      boolean().withDefault(const Constant(false))();

  TextColumn get usbVendorId => text().nullable()();

  TextColumn get usbProductId => text().nullable()();

  TextColumn get usbSerialNumber => text().nullable()();

  IntColumn get usbInterfaceNumber => integer().nullable()();

  IntColumn get usbOutEndpoint => integer().nullable()();

  IntColumn get usbInEndpoint => integer().nullable()();

  IntColumn get usbTimeoutMs => integer().nullable()();

  TextColumn get usbEncoding => text().nullable()();

  TextColumn get usbCodePage => text().nullable()();

  TextColumn get usbCharacterTable => text().nullable()();

  BoolColumn get usbAutoCutEnabled =>
      boolean().withDefault(const Constant(false))();

  TextColumn get usbCutMode => text().nullable()();

  BoolColumn get usbCashDrawerEnabled =>
      boolean().withDefault(const Constant(false))();

  IntColumn get usbDrawerPin => integer().nullable()();

  BoolColumn get usbStatusMonitoringEnabled =>
      boolean().withDefault(const Constant(false))();

  TextColumn get usbManufacturer => text().nullable()();

  TextColumn get usbProductName => text().nullable()();

  IntColumn get usbAlternateSetting => integer().nullable()();

  IntColumn get usbPacketDelayMs => integer().nullable()();

  TextColumn get rawGraphicsMode =>
      text().withDefault(const Constant('modern'))();

  BoolColumn get isEnabled => boolean().withDefault(const Constant(true))();

  TextColumn get lastStatus => text().nullable()();

  TextColumn get lastStatusKey => text().nullable()();

  TextColumn get lastStatusMessage => text().nullable()();

  DateTimeColumn get createdAt => dateTime()();

  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}
