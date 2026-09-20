import 'dart:convert';
import 'dart:io';

import 'package:qintrix/data/models/exports.dart';

import 'print_document_models.dart';
import 'print_job_render_service.dart';

const _supportedImagePresets = <String>{
  'mixed_receipt',
  'text_barcode',
  'logo_graphics',
  'photo',
};
const _supportedReceiptPaperSizes = <String>{'58mm', '80mm'};

class _ResolvedImagePreset {
  const _ResolvedImagePreset({
    required this.name,
    required this.trimWhitespace,
    required this.thermalDithering,
  });

  final String name;
  final bool trimWhitespace;
  final bool thermalDithering;
}

class PrintOptionResolverService {
  const PrintOptionResolverService();

  ConnectionCapabilityResult resolve({
    required PrintJobModel job,
    required PrinterModel printer,
    required PrintDocumentArtifactManifest manifest,
  }) {
    final rawOptions = _decodeOptions(job.optionsJson);
    final isImageSource = manifest.sourceContentType == 'image';
    final requestedPaperSize = (rawOptions['paperSize'] as String?)?.trim();
    final configuredPaperSize = printer.systemPaperSize?.trim();
    _validateImagePreset(
      rawOptions['imagePreset'],
      sourceContentType: manifest.sourceContentType,
    );
    final copies = job.copies <= 0 ? 1 : job.copies;
    final paperSize = switch (printer.connectionType) {
      PrinterConnectionType.systemSpooler =>
        requestedPaperSize ??
            configuredPaperSize ??
            (manifest.kind == PrintDocumentKind.text ? 'A4' : '80mm'),
      PrinterConnectionType.networkTcp || PrinterConnectionType.usbRawEscPos =>
        _normalizeReceiptPaperSize(requestedPaperSize) ??
            _normalizeReceiptPaperSize(configuredPaperSize) ??
            '80mm',
    };
    final silent = (rawOptions['silent'] as bool?) ?? true;
    final openDrawer = (rawOptions['openDrawer'] as bool?) ?? false;
    final allowRasterFallback =
        (rawOptions['allowRasterFallback'] as bool?) ?? true;
    final fitMode = (rawOptions['fitMode'] as String?)?.trim();
    final autoRotate = (rawOptions['autoRotate'] as bool?) ?? true;
    final rasterDpi = _parseInt(rawOptions['rasterDpi']);
    final imagePreset = _resolveImagePreset(
      (rawOptions['imagePreset'] as String?)?.trim(),
    );
    final imagePresetProvided = rawOptions.containsKey('imagePreset');
    final trimWhitespace =
        (rawOptions['trimWhitespace'] as bool?) ??
        (isImageSource ? imagePreset.trimWhitespace : true);
    final thermalDithering =
        (rawOptions['thermalDithering'] as bool?) ??
        (isImageSource ? imagePreset.thermalDithering : true);
    final graphicsMode = RawGraphicsMode.fromValue(printer.rawGraphicsMode);

    return switch (printer.connectionType) {
      PrinterConnectionType.systemSpooler => _resolveSystemSpooler(
        printer: printer,
        manifest: manifest,
        copies: copies,
        paperSize: paperSize,
        silent: silent,
        rawOptions: rawOptions,
        allowRasterFallback: allowRasterFallback,
        fitMode: fitMode,
        autoRotate: autoRotate,
        rasterDpi: rasterDpi,
        trimWhitespace: trimWhitespace,
        thermalDithering: thermalDithering,
        imagePreset: imagePreset.name,
        imagePresetProvided: imagePresetProvided,
      ),
      PrinterConnectionType.networkTcp => _resolveNetworkTcp(
        printer: printer,
        manifest: manifest,
        copies: copies,
        paperSize: paperSize,
        requestedPaperSize: requestedPaperSize,
        silent: silent,
        fitMode: fitMode,
        autoRotate: autoRotate,
        rasterDpi: rasterDpi,
        trimWhitespace: trimWhitespace,
        thermalDithering: thermalDithering,
        imagePreset: imagePreset.name,
        graphicsMode: graphicsMode,
        imagePresetProvided: imagePresetProvided,
      ),
      PrinterConnectionType.usbRawEscPos => _resolveUsbRaw(
        printer: printer,
        manifest: manifest,
        copies: copies,
        paperSize: paperSize,
        requestedPaperSize: requestedPaperSize,
        silent: silent,
        openDrawer: openDrawer,
        allowRasterFallback: allowRasterFallback,
        fitMode: fitMode,
        autoRotate: autoRotate,
        rasterDpi: rasterDpi,
        trimWhitespace: trimWhitespace,
        thermalDithering: thermalDithering,
        imagePreset: imagePreset.name,
        graphicsMode: graphicsMode,
        imagePresetProvided: imagePresetProvided,
      ),
    };
  }

  ConnectionCapabilityResult _resolveSystemSpooler({
    required PrinterModel printer,
    required PrintDocumentArtifactManifest manifest,
    required int copies,
    required String paperSize,
    required bool silent,
    required Map<String, dynamic> rawOptions,
    required bool allowRasterFallback,
    required String? fitMode,
    required bool autoRotate,
    required int? rasterDpi,
    required bool trimWhitespace,
    required bool thermalDithering,
    required String imagePreset,
    required bool imagePresetProvided,
  }) {
    final applied = <String, Object?>{'copies': copies, 'silent': silent};
    final ignored = <String, Object?>{};
    final supportsAdvancedSpoolerOptions = !Platform.isWindows;
    final printerName = printer.systemPrinterName?.trim() ?? '';
    if (printerName.isEmpty) {
      return ConnectionCapabilityResult(
        canExecute: false,
        mode: manifest.kind == PrintDocumentKind.text
            ? PrintExecutionMode.systemSpoolerText
            : PrintExecutionMode.systemSpoolerImage,
        options: ResolvedPrintOptions(
          copies: copies,
          paperSize: paperSize,
          silent: silent,
          openDrawer: false,
          autoCut: false,
          allowRasterFallback: allowRasterFallback,
          trimWhitespace: trimWhitespace,
          thermalDithering: thermalDithering,
          imagePreset: imagePreset,
        ),
        appliedOptions: applied,
        ignoredOptions: ignored,
        reason: 'System spooler printing requires systemPrinterName.',
      );
    }

    if (supportsAdvancedSpoolerOptions &&
        _supportsSpoolerPaperSize(paperSize)) {
      applied['paperSize'] = paperSize;
    } else {
      ignored['paperSize'] = paperSize;
    }

    final duplexMode =
        (rawOptions['duplexMode'] as String?)?.trim() ??
        printer.systemDuplexMode?.trim();
    if (supportsAdvancedSpoolerOptions &&
        duplexMode != null &&
        duplexMode.isNotEmpty &&
        duplexMode != 'NONE') {
      applied['duplexMode'] = duplexMode;
    } else if (duplexMode != null && duplexMode.isNotEmpty) {
      ignored['duplexMode'] = duplexMode;
    }

    final orientation =
        (rawOptions['orientation'] as String?)?.trim() ??
        printer.systemOrientation?.trim();
    if (supportsAdvancedSpoolerOptions &&
        orientation != null &&
        orientation.isNotEmpty) {
      applied['orientation'] = orientation;
    } else if (orientation != null && orientation.isNotEmpty) {
      ignored['orientation'] = orientation;
    }

    if (printer.systemColorEnabled) {
      ignored['colorEnabled'] = true;
    }

    if (rawOptions.containsKey('openDrawer')) {
      ignored['openDrawer'] = rawOptions['openDrawer'];
    }
    if (manifest.sourceContentType == 'pdf') {
      final effectiveFitMode = fitMode == null || fitMode.isEmpty
          ? 'printer_default'
          : fitMode;
      ignored['fitMode'] = effectiveFitMode;
      ignored['autoRotate'] = autoRotate;
      applied['allowRasterFallback'] = allowRasterFallback;
      if (rasterDpi != null) {
        ignored['rasterDpi'] = rasterDpi;
      }
      if (rawOptions.containsKey('trimWhitespace')) {
        ignored['trimWhitespace'] = trimWhitespace;
      }
      if (rawOptions.containsKey('thermalDithering')) {
        ignored['thermalDithering'] = thermalDithering;
      }
      if (imagePresetProvided) {
        ignored['imagePreset'] = imagePreset;
      }
    } else {
      if (fitMode != null && fitMode.isNotEmpty) {
        ignored['fitMode'] = fitMode;
      }
      if (rawOptions.containsKey('autoRotate')) {
        ignored['autoRotate'] = autoRotate;
      }
      if (rawOptions.containsKey('allowRasterFallback')) {
        ignored['allowRasterFallback'] = allowRasterFallback;
      }
      if (rasterDpi != null) {
        ignored['rasterDpi'] = rasterDpi;
      }
      if (rawOptions.containsKey('trimWhitespace')) {
        ignored['trimWhitespace'] = trimWhitespace;
      }
      if (rawOptions.containsKey('thermalDithering')) {
        ignored['thermalDithering'] = thermalDithering;
      }
      if (imagePresetProvided) {
        ignored['imagePreset'] = imagePreset;
      }
    }

    return ConnectionCapabilityResult(
      canExecute: true,
      mode: manifest.kind == PrintDocumentKind.text
          ? PrintExecutionMode.systemSpoolerText
          : PrintExecutionMode.systemSpoolerImage,
      options: ResolvedPrintOptions(
        copies: copies,
        paperSize: paperSize,
        silent: silent,
        openDrawer: false,
        autoCut: false,
        allowRasterFallback: allowRasterFallback,
        duplexMode: duplexMode,
        orientation: orientation,
        colorEnabled: printer.systemColorEnabled,
        fitMode: null,
        autoRotate: null,
        rasterDpi: rasterDpi,
        trimWhitespace: null,
        thermalDithering: null,
        imagePreset: null,
      ),
      appliedOptions: applied,
      ignoredOptions: ignored,
    );
  }

  ConnectionCapabilityResult _resolveNetworkTcp({
    required PrinterModel printer,
    required PrintDocumentArtifactManifest manifest,
    required int copies,
    required String paperSize,
    required String? requestedPaperSize,
    required bool silent,
    required String? fitMode,
    required bool autoRotate,
    required int? rasterDpi,
    required bool trimWhitespace,
    required bool thermalDithering,
    required String imagePreset,
    required RawGraphicsMode graphicsMode,
    required bool imagePresetProvided,
  }) {
    final applied = <String, Object?>{'copies': copies, 'silent': silent};
    final ignored = <String, Object?>{};
    _recordRawPaperSizeResolution(
      applied: applied,
      ignored: ignored,
      paperSize: paperSize,
      requestedPaperSize: requestedPaperSize,
    );
    final host = printer.tcpHost?.trim() ?? '';
    final port = printer.tcpPort;
    if (host.isEmpty || port == null) {
      return ConnectionCapabilityResult(
        canExecute: false,
        mode: manifest.kind == PrintDocumentKind.text
            ? PrintExecutionMode.networkTcpText
            : PrintExecutionMode.networkTcpEscPos,
        options: ResolvedPrintOptions(
          copies: copies,
          paperSize: paperSize,
          silent: silent,
          openDrawer: false,
          autoCut: false,
          allowRasterFallback: true,
          imagePreset: imagePreset,
        ),
        appliedOptions: applied,
        ignoredOptions: ignored,
        reason: 'TCP printing requires tcpHost and tcpPort.',
      );
    }

    if (printer.tcpEncoding != null && printer.tcpEncoding!.isNotEmpty) {
      applied['encoding'] = printer.tcpEncoding;
    }
    if (printer.tcpCodePage != null && printer.tcpCodePage!.isNotEmpty) {
      applied['codePage'] = printer.tcpCodePage;
    }
    if (printer.tcpLineEnding != null && printer.tcpLineEnding!.isNotEmpty) {
      applied['lineEnding'] = printer.tcpLineEnding;
    }
    if (printer.usbAutoCutEnabled) {
      applied['cutMode'] = printer.usbCutMode ?? 'FULL';
    }
    if (printer.usbCashDrawerEnabled && printer.usbDrawerPin != null) {
      applied['drawerPin'] = printer.usbDrawerPin;
    }
    if (manifest.sourceContentType == 'pdf') {
      ignored['fitMode'] = fitMode ?? 'fit_width';
      ignored['autoRotate'] = autoRotate;
      if (rasterDpi != null) {
        ignored['rasterDpi'] = rasterDpi;
      }
      applied['trimWhitespace'] = trimWhitespace;
      applied['thermalDithering'] = thermalDithering;
      applied['rawGraphicsMode'] = graphicsMode.value;
      if (imagePresetProvided) {
        ignored['imagePreset'] = imagePreset;
      }
    } else if (manifest.sourceContentType == 'image') {
      applied['trimWhitespace'] = trimWhitespace;
      applied['thermalDithering'] = thermalDithering;
      applied['imagePreset'] = imagePreset;
      applied['rawGraphicsMode'] = graphicsMode.value;
    } else if (manifest.kind == PrintDocumentKind.imagePages) {
      applied['trimWhitespace'] = trimWhitespace;
      applied['thermalDithering'] = thermalDithering;
      if (imagePresetProvided) {
        ignored['imagePreset'] = imagePreset;
      }
    }

    return ConnectionCapabilityResult(
      canExecute: true,
      mode: manifest.kind == PrintDocumentKind.text
          ? PrintExecutionMode.networkTcpText
          : PrintExecutionMode.networkTcpEscPos,
      options: ResolvedPrintOptions(
        copies: copies,
        paperSize: paperSize,
        silent: silent,
        openDrawer: printer.usbCashDrawerEnabled,
        autoCut: printer.usbAutoCutEnabled,
        allowRasterFallback: true,
        cutMode: printer.usbCutMode,
        textEncoding: printer.tcpEncoding,
        codePage: printer.tcpCodePage,
        lineEnding: printer.tcpLineEnding,
        timeoutMs: printer.tcpWriteTimeoutMs ?? printer.tcpConnectTimeoutMs,
        packetDelayMs: printer.usbPacketDelayMs,
        fitMode: null,
        autoRotate: null,
        rasterDpi: rasterDpi,
        trimWhitespace: trimWhitespace,
        thermalDithering: thermalDithering,
        imagePreset: manifest.sourceContentType == 'image' ? imagePreset : null,
      ),
      appliedOptions: applied,
      ignoredOptions: ignored,
    );
  }

  ConnectionCapabilityResult _resolveUsbRaw({
    required PrinterModel printer,
    required PrintDocumentArtifactManifest manifest,
    required int copies,
    required String paperSize,
    required String? requestedPaperSize,
    required bool silent,
    required bool openDrawer,
    required bool allowRasterFallback,
    required String? fitMode,
    required bool autoRotate,
    required int? rasterDpi,
    required bool trimWhitespace,
    required bool thermalDithering,
    required String imagePreset,
    required RawGraphicsMode graphicsMode,
    required bool imagePresetProvided,
  }) {
    final applied = <String, Object?>{'copies': copies, 'silent': silent};
    final ignored = <String, Object?>{};
    _recordRawPaperSizeResolution(
      applied: applied,
      ignored: ignored,
      paperSize: paperSize,
      requestedPaperSize: requestedPaperSize,
    );

    if (printer.usbEncoding != null && printer.usbEncoding!.isNotEmpty) {
      applied['encoding'] = printer.usbEncoding;
    }
    if (printer.usbCodePage != null && printer.usbCodePage!.isNotEmpty) {
      applied['codePage'] = printer.usbCodePage;
    }
    if (printer.usbCharacterTable != null &&
        printer.usbCharacterTable!.isNotEmpty) {
      applied['characterTable'] = printer.usbCharacterTable;
    }
    if (printer.usbAutoCutEnabled) {
      applied['cutMode'] = printer.usbCutMode ?? 'FULL';
    }
    if (openDrawer &&
        printer.usbCashDrawerEnabled &&
        printer.usbDrawerPin != null) {
      applied['openDrawer'] = true;
      applied['drawerPin'] = printer.usbDrawerPin;
    } else if (openDrawer) {
      ignored['openDrawer'] = true;
    }
    if (printer.usbPacketDelayMs != null) {
      applied['packetDelayMs'] = printer.usbPacketDelayMs;
    }
    if (printer.usbTimeoutMs != null) {
      applied['timeoutMs'] = printer.usbTimeoutMs;
    }
    if (manifest.sourceContentType == 'pdf') {
      ignored['fitMode'] = fitMode ?? 'fit_width';
      ignored['autoRotate'] = autoRotate;
      if (rasterDpi != null) {
        ignored['rasterDpi'] = rasterDpi;
      }
      if (allowRasterFallback != true) {
        ignored['allowRasterFallback'] = allowRasterFallback;
      }
      applied['trimWhitespace'] = trimWhitespace;
      applied['thermalDithering'] = thermalDithering;
      applied['rawGraphicsMode'] = graphicsMode.value;
      if (imagePresetProvided) {
        ignored['imagePreset'] = imagePreset;
      }
    } else if (manifest.sourceContentType == 'image') {
      applied['trimWhitespace'] = trimWhitespace;
      applied['thermalDithering'] = thermalDithering;
      applied['imagePreset'] = imagePreset;
      applied['rawGraphicsMode'] = graphicsMode.value;
    } else if (manifest.kind == PrintDocumentKind.imagePages) {
      applied['trimWhitespace'] = trimWhitespace;
      applied['thermalDithering'] = thermalDithering;
      if (imagePresetProvided) {
        ignored['imagePreset'] = imagePreset;
      }
    } else {
      if (fitMode != null && fitMode.isNotEmpty) {
        ignored['fitMode'] = fitMode;
      }
      if (rasterDpi != null) {
        ignored['rasterDpi'] = rasterDpi;
      }
      if (autoRotate != true) {
        ignored['autoRotate'] = autoRotate;
      }
      if (allowRasterFallback != true) {
        ignored['allowRasterFallback'] = allowRasterFallback;
      }
      if (trimWhitespace != true) {
        ignored['trimWhitespace'] = trimWhitespace;
      }
      if (thermalDithering != true) {
        ignored['thermalDithering'] = thermalDithering;
      }
      if (imagePresetProvided) {
        ignored['imagePreset'] = imagePreset;
      }
    }

    final canUseTransport =
        (Platform.isLinux || Platform.isMacOS) &&
        ((printer.systemPrinterName?.trim().isNotEmpty ?? false) ||
            (printer.systemQueueName?.trim().isNotEmpty ?? false));

    return ConnectionCapabilityResult(
      canExecute: canUseTransport,
      mode: PrintExecutionMode.usbRawEscPos,
      options: ResolvedPrintOptions(
        copies: copies,
        paperSize: paperSize,
        silent: silent,
        openDrawer: openDrawer && printer.usbCashDrawerEnabled,
        autoCut: printer.usbAutoCutEnabled,
        allowRasterFallback: allowRasterFallback,
        cutMode: printer.usbCutMode,
        textEncoding: printer.usbEncoding,
        codePage: printer.usbCodePage,
        characterTable: printer.usbCharacterTable,
        timeoutMs: printer.usbTimeoutMs,
        packetDelayMs: printer.usbPacketDelayMs,
        fitMode: null,
        autoRotate: null,
        rasterDpi: rasterDpi,
        trimWhitespace: trimWhitespace,
        thermalDithering: thermalDithering,
        imagePreset: manifest.sourceContentType == 'image' ? imagePreset : null,
      ),
      appliedOptions: applied,
      ignoredOptions: ignored,
      reason: canUseTransport
          ? null
          : 'USB raw execution requires a configured raw system queue on macOS/Linux in this build.',
    );
  }

  int? _parseInt(Object? value) {
    return switch (value) {
      final int item => item,
      final num item => item.toInt(),
      final String item => int.tryParse(item.trim()),
      _ => null,
    };
  }

  Map<String, dynamic> _decodeOptions(String? optionsJson) {
    if (optionsJson == null || optionsJson.trim().isEmpty) {
      return <String, dynamic>{};
    }
    final decoded = jsonDecode(optionsJson);
    if (decoded is Map<String, dynamic>) {
      return decoded;
    }
    if (decoded is Map) {
      return decoded.map((key, value) => MapEntry(key.toString(), value));
    }
    return <String, dynamic>{};
  }

  void _recordRawPaperSizeResolution({
    required Map<String, Object?> applied,
    required Map<String, Object?> ignored,
    required String paperSize,
    required String? requestedPaperSize,
  }) {
    final requested = requestedPaperSize?.trim();
    if (requested != null && requested.isNotEmpty && requested != paperSize) {
      ignored['paperSize'] = requested;
    }
    applied['paperSize'] = paperSize;
  }

  bool _supportsSpoolerPaperSize(String value) {
    return const {
      'A4',
      'A5',
      'Letter',
      'Legal',
      '80mm',
      '58mm',
    }.contains(value);
  }

  void _validateImagePreset(
    Object? rawValue, {
    required String sourceContentType,
  }) {
    if (sourceContentType != 'image') {
      return;
    }
    final value = (rawValue as String?)?.trim();
    if (value == null || value.isEmpty) {
      return;
    }
    final normalized = value.toLowerCase();
    if (_supportedImagePresets.contains(normalized)) {
      return;
    }
    throw const PrintJobRenderException(
      'Invalid imagePreset. Supported values are mixed_receipt, text_barcode, logo_graphics, and photo.',
    );
  }

  _ResolvedImagePreset _resolveImagePreset(String? rawValue) {
    return switch ((rawValue ?? '').trim().toLowerCase()) {
      'text_barcode' => const _ResolvedImagePreset(
        name: 'text_barcode',
        trimWhitespace: true,
        thermalDithering: false,
      ),
      'logo_graphics' => const _ResolvedImagePreset(
        name: 'logo_graphics',
        trimWhitespace: true,
        thermalDithering: true,
      ),
      'photo' => const _ResolvedImagePreset(
        name: 'photo',
        trimWhitespace: false,
        thermalDithering: true,
      ),
      _ => const _ResolvedImagePreset(
        name: 'mixed_receipt',
        trimWhitespace: true,
        thermalDithering: true,
      ),
    };
  }
}

String? _normalizeReceiptPaperSize(String? paperSize) {
  final normalized = paperSize?.trim();
  if (normalized == null || normalized.isEmpty) {
    return null;
  }
  if (_supportedReceiptPaperSizes.contains(normalized)) {
    return normalized;
  }
  return null;
}
