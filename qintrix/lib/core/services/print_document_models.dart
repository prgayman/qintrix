import 'dart:convert';

enum PrintDocumentKind {
  text('text'),
  imagePages('image_pages');

  const PrintDocumentKind(this.value);

  final String value;

  static PrintDocumentKind fromValue(String value) {
    return PrintDocumentKind.values.firstWhere(
      (kind) => kind.value == value,
      orElse: () => PrintDocumentKind.imagePages,
    );
  }
}

enum PrintExecutionMode {
  systemSpoolerText('system_spooler_text'),
  systemSpoolerImage('system_spooler_image'),
  networkTcpText('network_tcp_text'),
  networkTcpEscPos('network_tcp_escpos'),
  usbRawEscPos('usb_raw_escpos');

  const PrintExecutionMode(this.value);

  final String value;
}

enum PrintDocumentDeliveryMode {
  plainText('plain_text'),
  rasterPages('raster_pages'),
  nativePdf('native_pdf'),
  nativeSourceImage('native_source_image');

  const PrintDocumentDeliveryMode(this.value);

  final String value;

  static PrintDocumentDeliveryMode fromValue(String value) {
    return PrintDocumentDeliveryMode.values.firstWhere(
      (mode) => mode.value == value,
      orElse: () => PrintDocumentDeliveryMode.rasterPages,
    );
  }
}

enum RawGraphicsMode {
  modern('modern'),
  legacy('legacy');

  const RawGraphicsMode(this.value);

  final String value;

  static RawGraphicsMode fromValue(String? value) {
    return RawGraphicsMode.values.firstWhere(
      (mode) => mode.value == value,
      orElse: () => RawGraphicsMode.modern,
    );
  }
}

class PrintDocumentArtifactManifest {
  const PrintDocumentArtifactManifest({
    required this.kind,
    required this.sourceContentType,
    required this.pageCount,
    this.textPath,
    this.pagePaths = const <String>[],
    this.targetWidthPx,
    this.sourcePath,
    this.preferredDeliveryMode,
    this.pdfDiagnostics,
    this.imageDiagnostics,
  });

  final PrintDocumentKind kind;
  final String sourceContentType;
  final int pageCount;
  final String? textPath;
  final List<String> pagePaths;
  final int? targetWidthPx;
  final String? sourcePath;
  final PrintDocumentDeliveryMode? preferredDeliveryMode;
  final Map<String, Object?>? pdfDiagnostics;
  final Map<String, Object?>? imageDiagnostics;

  Map<String, Object?> toJson() {
    return {
      'kind': kind.value,
      'sourceContentType': sourceContentType,
      'pageCount': pageCount,
      'textPath': textPath,
      'pagePaths': pagePaths,
      'targetWidthPx': targetWidthPx,
      'sourcePath': sourcePath,
      'preferredDeliveryMode': preferredDeliveryMode?.value,
      'pdfDiagnostics': pdfDiagnostics,
      'imageDiagnostics': imageDiagnostics,
    };
  }

  factory PrintDocumentArtifactManifest.fromJson(Map<String, dynamic> json) {
    return PrintDocumentArtifactManifest(
      kind: PrintDocumentKind.fromValue(
        json['kind'] as String? ?? 'image_pages',
      ),
      sourceContentType: json['sourceContentType'] as String? ?? 'unknown',
      pageCount: (json['pageCount'] as num?)?.toInt() ?? 0,
      textPath: json['textPath'] as String?,
      pagePaths: ((json['pagePaths'] as List?) ?? const <Object?>[])
          .map((item) => item.toString())
          .toList(growable: false),
      targetWidthPx: (json['targetWidthPx'] as num?)?.toInt(),
      sourcePath: json['sourcePath'] as String?,
      preferredDeliveryMode: (json['preferredDeliveryMode'] as String?) == null
          ? null
          : PrintDocumentDeliveryMode.fromValue(
              json['preferredDeliveryMode'] as String,
            ),
      pdfDiagnostics: switch (json['pdfDiagnostics']) {
        final Map<String, dynamic> value => value,
        final Map value => value.map(
          (key, item) => MapEntry(key.toString(), item),
        ),
        _ => null,
      },
      imageDiagnostics: switch (json['imageDiagnostics']) {
        final Map<String, dynamic> value => value,
        final Map value => value.map(
          (key, item) => MapEntry(key.toString(), item),
        ),
        _ => null,
      },
    );
  }

  String encode() => jsonEncode(toJson());
}

class ResolvedPrintOptions {
  const ResolvedPrintOptions({
    required this.copies,
    required this.paperSize,
    required this.silent,
    required this.openDrawer,
    required this.autoCut,
    required this.allowRasterFallback,
    this.cutMode,
    this.textEncoding,
    this.codePage,
    this.characterTable,
    this.lineEnding,
    this.orientation,
    this.duplexMode,
    this.colorEnabled,
    this.timeoutMs,
    this.packetDelayMs,
    this.fitMode,
    this.autoRotate,
    this.rasterDpi,
    this.trimWhitespace,
    this.thermalDithering,
    this.imagePreset,
  });

  final int copies;
  final String paperSize;
  final bool silent;
  final bool openDrawer;
  final bool autoCut;
  final bool allowRasterFallback;
  final String? cutMode;
  final String? textEncoding;
  final String? codePage;
  final String? characterTable;
  final String? lineEnding;
  final String? orientation;
  final String? duplexMode;
  final bool? colorEnabled;
  final int? timeoutMs;
  final int? packetDelayMs;
  final String? fitMode;
  final bool? autoRotate;
  final int? rasterDpi;
  final bool? trimWhitespace;
  final bool? thermalDithering;
  final String? imagePreset;
}

class ConnectionCapabilityResult {
  const ConnectionCapabilityResult({
    required this.canExecute,
    required this.mode,
    required this.options,
    required this.appliedOptions,
    required this.ignoredOptions,
    this.reason,
  });

  final bool canExecute;
  final PrintExecutionMode mode;
  final ResolvedPrintOptions options;
  final Map<String, Object?> appliedOptions;
  final Map<String, Object?> ignoredOptions;
  final String? reason;
}

class PrintExecutionResult {
  const PrintExecutionResult({
    required this.executionMode,
    required this.pageCount,
    required this.appliedOptions,
    required this.ignoredOptions,
    required this.documentDeliveryMode,
    this.capabilityMismatchReason,
    this.usedFallback = false,
    this.fallbackReason,
  });

  final String executionMode;
  final int pageCount;
  final Map<String, Object?> appliedOptions;
  final Map<String, Object?> ignoredOptions;
  final String documentDeliveryMode;
  final String? capabilityMismatchReason;
  final bool usedFallback;
  final String? fallbackReason;

  Map<String, Object?> toJson() {
    return {
      'executionMode': executionMode,
      'pageCount': pageCount,
      'appliedOptions': appliedOptions,
      'ignoredOptions': ignoredOptions,
      'documentDeliveryMode': documentDeliveryMode,
      'capabilityMismatchReason': capabilityMismatchReason,
      'usedFallback': usedFallback,
      'fallbackReason': fallbackReason,
    };
  }
}
