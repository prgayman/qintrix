enum PrinterConnectionType {
  networkTcp('network_tcp'),
  systemSpooler('system_spooler'),
  usbRawEscPos('usb_raw_esc_pos');

  const PrinterConnectionType(this.value);

  final String value;

  static PrinterConnectionType fromValue(String value) {
    return PrinterConnectionType.values.firstWhere(
      (type) => type.value == value,
      orElse: () => PrinterConnectionType.systemSpooler,
    );
  }
}

class PrinterModel {
  const PrinterModel({
    required this.id,
    required this.uniqueKey,
    required this.name,
    required this.connectionType,
    required this.isEnabled,
    required this.createdAt,
    required this.updatedAt,
    this.description,
    this.lastStatus,
    this.lastStatusKey,
    this.lastStatusMessage,
    this.tcpHost,
    this.tcpPort,
    this.tcpConnectTimeoutMs,
    this.tcpWriteTimeoutMs,
    this.tcpReadTimeoutMs,
    this.tcpAutoReconnect = false,
    this.tcpReconnectDelayMs,
    this.tcpEncoding,
    this.tcpCodePage,
    this.tcpLineEnding,
    this.tcpKeepAlive = false,
    this.tcpNoDelay = false,
    this.tcpLingerSeconds,
    this.systemPrinterName,
    this.systemPaperSize,
    this.systemDefaultCopies = 1,
    this.systemColorEnabled = false,
    this.systemDuplexMode,
    this.systemOrientation,
    this.systemJobTimeoutMs,
    this.systemNotes,
    this.systemDriverName,
    this.systemQueueName,
    this.systemSpoolFormat,
    this.systemUseRawSpool = false,
    this.usbVendorId,
    this.usbProductId,
    this.usbSerialNumber,
    this.usbInterfaceNumber,
    this.usbOutEndpoint,
    this.usbInEndpoint,
    this.usbTimeoutMs,
    this.usbEncoding,
    this.usbCodePage,
    this.usbCharacterTable,
    this.usbAutoCutEnabled = false,
    this.usbCutMode,
    this.usbCashDrawerEnabled = false,
    this.usbDrawerPin,
    this.usbStatusMonitoringEnabled = false,
    this.usbManufacturer,
    this.usbProductName,
    this.usbAlternateSetting,
    this.usbPacketDelayMs,
    this.rawGraphicsMode,
  });

  final String id;
  final String uniqueKey;
  final String name;
  final String? description;
  final PrinterConnectionType connectionType;
  final bool isEnabled;
  final String? lastStatus;
  final String? lastStatusKey;
  final String? lastStatusMessage;
  final DateTime createdAt;
  final DateTime updatedAt;

  final String? tcpHost;
  final int? tcpPort;
  final int? tcpConnectTimeoutMs;
  final int? tcpWriteTimeoutMs;
  final int? tcpReadTimeoutMs;
  final bool tcpAutoReconnect;
  final int? tcpReconnectDelayMs;
  final String? tcpEncoding;
  final String? tcpCodePage;
  final String? tcpLineEnding;
  final bool tcpKeepAlive;
  final bool tcpNoDelay;
  final int? tcpLingerSeconds;

  final String? systemPrinterName;
  final String? systemPaperSize;
  final int systemDefaultCopies;
  final bool systemColorEnabled;
  final String? systemDuplexMode;
  final String? systemOrientation;
  final int? systemJobTimeoutMs;
  final String? systemNotes;
  final String? systemDriverName;
  final String? systemQueueName;
  final String? systemSpoolFormat;
  final bool systemUseRawSpool;

  final String? usbVendorId;
  final String? usbProductId;
  final String? usbSerialNumber;
  final int? usbInterfaceNumber;
  final int? usbOutEndpoint;
  final int? usbInEndpoint;
  final int? usbTimeoutMs;
  final String? usbEncoding;
  final String? usbCodePage;
  final String? usbCharacterTable;
  final bool usbAutoCutEnabled;
  final String? usbCutMode;
  final bool usbCashDrawerEnabled;
  final int? usbDrawerPin;
  final bool usbStatusMonitoringEnabled;
  final String? usbManufacturer;
  final String? usbProductName;
  final int? usbAlternateSetting;
  final int? usbPacketDelayMs;
  final String? rawGraphicsMode;

  PrinterModel copyWith({
    String? id,
    String? uniqueKey,
    String? name,
    String? description,
    PrinterConnectionType? connectionType,
    bool? isEnabled,
    String? lastStatus,
    String? lastStatusKey,
    String? lastStatusMessage,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? tcpHost,
    int? tcpPort,
    int? tcpConnectTimeoutMs,
    int? tcpWriteTimeoutMs,
    int? tcpReadTimeoutMs,
    bool? tcpAutoReconnect,
    int? tcpReconnectDelayMs,
    String? tcpEncoding,
    String? tcpCodePage,
    String? tcpLineEnding,
    bool? tcpKeepAlive,
    bool? tcpNoDelay,
    int? tcpLingerSeconds,
    String? systemPrinterName,
    String? systemPaperSize,
    int? systemDefaultCopies,
    bool? systemColorEnabled,
    String? systemDuplexMode,
    String? systemOrientation,
    int? systemJobTimeoutMs,
    String? systemNotes,
    String? systemDriverName,
    String? systemQueueName,
    String? systemSpoolFormat,
    bool? systemUseRawSpool,
    String? usbVendorId,
    String? usbProductId,
    String? usbSerialNumber,
    int? usbInterfaceNumber,
    int? usbOutEndpoint,
    int? usbInEndpoint,
    int? usbTimeoutMs,
    String? usbEncoding,
    String? usbCodePage,
    String? usbCharacterTable,
    bool? usbAutoCutEnabled,
    String? usbCutMode,
    bool? usbCashDrawerEnabled,
    int? usbDrawerPin,
    bool? usbStatusMonitoringEnabled,
    String? usbManufacturer,
    String? usbProductName,
    int? usbAlternateSetting,
    int? usbPacketDelayMs,
    String? rawGraphicsMode,
  }) {
    return PrinterModel(
      id: id ?? this.id,
      uniqueKey: uniqueKey ?? this.uniqueKey,
      name: name ?? this.name,
      description: description ?? this.description,
      connectionType: connectionType ?? this.connectionType,
      isEnabled: isEnabled ?? this.isEnabled,
      lastStatus: lastStatus ?? this.lastStatus,
      lastStatusKey: lastStatusKey ?? this.lastStatusKey,
      lastStatusMessage: lastStatusMessage ?? this.lastStatusMessage,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      tcpHost: tcpHost ?? this.tcpHost,
      tcpPort: tcpPort ?? this.tcpPort,
      tcpConnectTimeoutMs: tcpConnectTimeoutMs ?? this.tcpConnectTimeoutMs,
      tcpWriteTimeoutMs: tcpWriteTimeoutMs ?? this.tcpWriteTimeoutMs,
      tcpReadTimeoutMs: tcpReadTimeoutMs ?? this.tcpReadTimeoutMs,
      tcpAutoReconnect: tcpAutoReconnect ?? this.tcpAutoReconnect,
      tcpReconnectDelayMs: tcpReconnectDelayMs ?? this.tcpReconnectDelayMs,
      tcpEncoding: tcpEncoding ?? this.tcpEncoding,
      tcpCodePage: tcpCodePage ?? this.tcpCodePage,
      tcpLineEnding: tcpLineEnding ?? this.tcpLineEnding,
      tcpKeepAlive: tcpKeepAlive ?? this.tcpKeepAlive,
      tcpNoDelay: tcpNoDelay ?? this.tcpNoDelay,
      tcpLingerSeconds: tcpLingerSeconds ?? this.tcpLingerSeconds,
      systemPrinterName: systemPrinterName ?? this.systemPrinterName,
      systemPaperSize: systemPaperSize ?? this.systemPaperSize,
      systemDefaultCopies: systemDefaultCopies ?? this.systemDefaultCopies,
      systemColorEnabled: systemColorEnabled ?? this.systemColorEnabled,
      systemDuplexMode: systemDuplexMode ?? this.systemDuplexMode,
      systemOrientation: systemOrientation ?? this.systemOrientation,
      systemJobTimeoutMs: systemJobTimeoutMs ?? this.systemJobTimeoutMs,
      systemNotes: systemNotes ?? this.systemNotes,
      systemDriverName: systemDriverName ?? this.systemDriverName,
      systemQueueName: systemQueueName ?? this.systemQueueName,
      systemSpoolFormat: systemSpoolFormat ?? this.systemSpoolFormat,
      systemUseRawSpool: systemUseRawSpool ?? this.systemUseRawSpool,
      usbVendorId: usbVendorId ?? this.usbVendorId,
      usbProductId: usbProductId ?? this.usbProductId,
      usbSerialNumber: usbSerialNumber ?? this.usbSerialNumber,
      usbInterfaceNumber: usbInterfaceNumber ?? this.usbInterfaceNumber,
      usbOutEndpoint: usbOutEndpoint ?? this.usbOutEndpoint,
      usbInEndpoint: usbInEndpoint ?? this.usbInEndpoint,
      usbTimeoutMs: usbTimeoutMs ?? this.usbTimeoutMs,
      usbEncoding: usbEncoding ?? this.usbEncoding,
      usbCodePage: usbCodePage ?? this.usbCodePage,
      usbCharacterTable: usbCharacterTable ?? this.usbCharacterTable,
      usbAutoCutEnabled: usbAutoCutEnabled ?? this.usbAutoCutEnabled,
      usbCutMode: usbCutMode ?? this.usbCutMode,
      usbCashDrawerEnabled: usbCashDrawerEnabled ?? this.usbCashDrawerEnabled,
      usbDrawerPin: usbDrawerPin ?? this.usbDrawerPin,
      usbStatusMonitoringEnabled:
          usbStatusMonitoringEnabled ?? this.usbStatusMonitoringEnabled,
      usbManufacturer: usbManufacturer ?? this.usbManufacturer,
      usbProductName: usbProductName ?? this.usbProductName,
      usbAlternateSetting: usbAlternateSetting ?? this.usbAlternateSetting,
      usbPacketDelayMs: usbPacketDelayMs ?? this.usbPacketDelayMs,
      rawGraphicsMode: rawGraphicsMode ?? this.rawGraphicsMode,
    );
  }
}
