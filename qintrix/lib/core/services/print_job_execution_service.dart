import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:image/image.dart' as img;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:qintrix/data/models/exports.dart';

import 'print_document_models.dart';
import 'print_option_resolver_service.dart';

class PrintJobExecutionException implements Exception {
  const PrintJobExecutionException(this.message);

  final String message;

  @override
  String toString() => message;
}

class _DeliveryOutcome {
  const _DeliveryOutcome({
    required this.documentDeliveryMode,
    this.usedFallback = false,
    this.fallbackReason,
  });

  final PrintDocumentDeliveryMode documentDeliveryMode;
  final bool usedFallback;
  final String? fallbackReason;
}

class _ImageThermalProfile {
  const _ImageThermalProfile({
    required this.name,
    required this.trimWhitespace,
    required this.thermalDithering,
    required this.threshold,
    required this.contrast,
  });

  final String name;
  final bool trimWhitespace;
  final bool thermalDithering;
  final int threshold;
  final double contrast;
}

abstract class PrintProcessRunner {
  Future<ProcessResult> run(String executable, List<String> arguments);
}

class DefaultPrintProcessRunner implements PrintProcessRunner {
  const DefaultPrintProcessRunner();

  @override
  Future<ProcessResult> run(String executable, List<String> arguments) {
    return Process.run(executable, arguments);
  }
}

abstract class RawByteTransport {
  Future<void> sendNetwork({
    required PrinterModel printer,
    required List<int> bytes,
    int? timeoutMs,
  });

  Future<void> sendUsb({
    required PrinterModel printer,
    required List<int> bytes,
    required PrintProcessRunner processRunner,
  });
}

class DefaultRawByteTransport implements RawByteTransport {
  const DefaultRawByteTransport();

  @override
  Future<void> sendNetwork({
    required PrinterModel printer,
    required List<int> bytes,
    int? timeoutMs,
  }) async {
    final host = printer.tcpHost?.trim() ?? '';
    final port = printer.tcpPort;
    if (host.isEmpty || port == null) {
      throw const PrintJobExecutionException(
        'TCP printer requires host and port.',
      );
    }

    final socket = await Socket.connect(
      host,
      port,
      timeout: Duration(
        milliseconds: timeoutMs ?? printer.tcpConnectTimeoutMs ?? 5000,
      ),
    );
    socket.add(bytes);
    await socket.flush();
    await socket.close();
  }

  @override
  Future<void> sendUsb({
    required PrinterModel printer,
    required List<int> bytes,
    required PrintProcessRunner processRunner,
  }) async {
    final printerName =
        printer.systemQueueName?.trim() ??
        printer.systemPrinterName?.trim() ??
        '';
    if (printerName.isEmpty) {
      throw const PrintJobExecutionException(
        'USB raw execution requires a configured raw system printer queue.',
      );
    }
    if (!(Platform.isLinux || Platform.isMacOS)) {
      throw const PrintJobExecutionException(
        'USB raw execution is only supported through raw spool queues on macOS/Linux in this build.',
      );
    }

    final supportDir = await getApplicationSupportDirectory();
    final file = File(
      p.join(
        supportDir.path,
        'print-job-artifacts',
        'usb-${DateTime.now().microsecondsSinceEpoch}.bin',
      ),
    );
    await file.parent.create(recursive: true);
    await file.writeAsBytes(bytes, flush: true);

    final command = await _resolveRawPrintCommand(processRunner);
    final args = command == 'lp'
        ? <String>['-d', printerName, '-o', 'raw', file.path]
        : <String>['-P', printerName, '-l', file.path];
    final result = await processRunner.run(command, args);
    if (result.exitCode != 0) {
      throw PrintJobExecutionException(
        'USB raw spooler failed: ${result.stderr}'.trim(),
      );
    }
  }
}

class PrintJobExecutionService {
  PrintJobExecutionService({
    PrintOptionResolverService optionResolver =
        const PrintOptionResolverService(),
    PrintProcessRunner processRunner = const DefaultPrintProcessRunner(),
    RawByteTransport rawByteTransport = const DefaultRawByteTransport(),
    String? platformOverride,
  }) : _optionResolver = optionResolver,
       _processRunner = processRunner,
       _rawByteTransport = rawByteTransport,
       _platformOverride = platformOverride;

  final PrintOptionResolverService _optionResolver;
  final PrintProcessRunner _processRunner;
  final RawByteTransport _rawByteTransport;
  final String? _platformOverride;

  Future<PrintExecutionResult> execute({
    required PrintJobModel job,
    required PrinterModel printer,
  }) async {
    final artifactPath = job.artifactPath;
    if (artifactPath == null || artifactPath.trim().isEmpty) {
      throw const PrintJobExecutionException('Missing rendered artifact.');
    }

    final manifest = await _readManifest(artifactPath);
    final capability = _optionResolver.resolve(
      job: job,
      printer: printer,
      manifest: manifest,
    );
    if (!capability.canExecute) {
      throw PrintJobExecutionException(
        capability.reason ?? 'Printer connection cannot execute this job.',
      );
    }

    late final _DeliveryOutcome outcome;
    switch (capability.mode) {
      case PrintExecutionMode.systemSpoolerText:
        outcome = await _executeSystemSpoolerText(
          manifest,
          printer,
          capability.options,
        );
        break;
      case PrintExecutionMode.systemSpoolerImage:
        outcome = await _executeSystemSpoolerImages(
          manifest,
          printer,
          capability.options,
        );
        break;
      case PrintExecutionMode.networkTcpText:
        outcome = await _executeNetworkText(
          manifest,
          printer,
          capability.options,
        );
        break;
      case PrintExecutionMode.networkTcpEscPos:
        outcome = await _executeRawImageDocument(
          manifest: manifest,
          printer: printer,
          options: capability.options,
          transport: _rawByteTransport.sendNetwork,
        );
        break;
      case PrintExecutionMode.usbRawEscPos:
        outcome = await _executeRawDocumentToUsb(
          manifest,
          printer,
          capability.options,
        );
        break;
    }

    return PrintExecutionResult(
      executionMode: capability.mode.value,
      pageCount: manifest.pageCount,
      appliedOptions: capability.appliedOptions,
      ignoredOptions: capability.ignoredOptions,
      documentDeliveryMode: outcome.documentDeliveryMode.value,
      capabilityMismatchReason: capability.reason,
      usedFallback: outcome.usedFallback,
      fallbackReason: outcome.fallbackReason,
    );
  }

  Future<_DeliveryOutcome> _executeSystemSpoolerText(
    PrintDocumentArtifactManifest manifest,
    PrinterModel printer,
    ResolvedPrintOptions options,
  ) async {
    final textPath = manifest.textPath;
    if (textPath == null || textPath.isEmpty) {
      throw const PrintJobExecutionException('Missing text artifact.');
    }
    for (var copy = 0; copy < options.copies; copy++) {
      await _spoolFile(filePath: textPath, printer: printer, options: options);
    }
    return const _DeliveryOutcome(
      documentDeliveryMode: PrintDocumentDeliveryMode.plainText,
    );
  }

  Future<_DeliveryOutcome> _executeSystemSpoolerImages(
    PrintDocumentArtifactManifest manifest,
    PrinterModel printer,
    ResolvedPrintOptions options,
  ) async {
    if (_isWindows && manifest.sourceContentType == 'pdf') {
      for (var copy = 0; copy < options.copies; copy++) {
        for (final pagePath in manifest.pagePaths) {
          await _spoolFile(
            filePath: pagePath,
            printer: printer,
            options: options,
          );
        }
      }
      return const _DeliveryOutcome(
        documentDeliveryMode: PrintDocumentDeliveryMode.rasterPages,
      );
    }

    final sourcePath = manifest.sourcePath;
    if (const {'image', 'pdf'}.contains(manifest.sourceContentType) &&
        sourcePath != null &&
        sourcePath.isNotEmpty) {
      try {
        for (var copy = 0; copy < options.copies; copy++) {
          await _spoolFile(
            filePath: sourcePath,
            printer: printer,
            options: options,
          );
        }
        return _DeliveryOutcome(
          documentDeliveryMode: manifest.sourceContentType == 'pdf'
              ? PrintDocumentDeliveryMode.nativePdf
              : PrintDocumentDeliveryMode.nativeSourceImage,
        );
      } on PrintJobExecutionException catch (error) {
        if (manifest.sourceContentType == 'pdf' &&
            options.allowRasterFallback &&
            manifest.pagePaths.isNotEmpty) {
          final fallbackReason =
              'Native PDF spool failed. Falling back to raster pages: ${error.message}';
          for (var copy = 0; copy < options.copies; copy++) {
            for (final pagePath in manifest.pagePaths) {
              await _spoolFile(
                filePath: pagePath,
                printer: printer,
                options: options,
              );
            }
          }
          return _DeliveryOutcome(
            documentDeliveryMode: PrintDocumentDeliveryMode.rasterPages,
            usedFallback: true,
            fallbackReason: fallbackReason,
          );
        }
        if (manifest.sourceContentType == 'pdf') {
          throw PrintJobExecutionException(
            'Native PDF spool failed: ${error.message}',
          );
        }
        rethrow;
      }
    }

    for (var copy = 0; copy < options.copies; copy++) {
      for (final pagePath in manifest.pagePaths) {
        await _spoolFile(
          filePath: pagePath,
          printer: printer,
          options: options,
        );
      }
    }
    return const _DeliveryOutcome(
      documentDeliveryMode: PrintDocumentDeliveryMode.rasterPages,
    );
  }

  Future<_DeliveryOutcome> _executeNetworkText(
    PrintDocumentArtifactManifest manifest,
    PrinterModel printer,
    ResolvedPrintOptions options,
  ) async {
    final textPath = manifest.textPath;
    if (textPath == null || textPath.isEmpty) {
      throw const PrintJobExecutionException('Missing text artifact.');
    }
    final content = await File(textPath).readAsString();
    final bytes = <int>[
      ..._escPosInitialize(),
      ..._encodeTextDocument(content, options),
      if (options.openDrawer) ..._drawerPulse(printer.usbDrawerPin ?? 2),
      if (options.autoCut && (options.cutMode ?? 'FULL') != 'NONE')
        ..._cutCommand(options.cutMode ?? 'FULL')
      else
        ..._lineFeed(5),
    ];
    for (var copy = 0; copy < options.copies; copy++) {
      await _rawByteTransport.sendNetwork(
        printer: printer,
        bytes: bytes,
        timeoutMs: options.timeoutMs,
      );
    }
    return const _DeliveryOutcome(
      documentDeliveryMode: PrintDocumentDeliveryMode.plainText,
    );
  }

  Future<_DeliveryOutcome> _executeRawDocumentToUsb(
    PrintDocumentArtifactManifest manifest,
    PrinterModel printer,
    ResolvedPrintOptions options,
  ) async {
    final bytes = await _buildRawDocumentBytes(
      manifest: manifest,
      printer: printer,
      options: options,
    );
    await _rawByteTransport.sendUsb(
      printer: printer,
      bytes: bytes,
      processRunner: _processRunner,
    );
    return _DeliveryOutcome(
      documentDeliveryMode: manifest.kind == PrintDocumentKind.text
          ? PrintDocumentDeliveryMode.plainText
          : PrintDocumentDeliveryMode.rasterPages,
    );
  }

  Future<_DeliveryOutcome> _executeRawImageDocument({
    required PrintDocumentArtifactManifest manifest,
    required PrinterModel printer,
    required ResolvedPrintOptions options,
    required Future<void> Function({
      required PrinterModel printer,
      required List<int> bytes,
      int? timeoutMs,
    })
    transport,
  }) async {
    final bytes = await _buildRawDocumentBytes(
      manifest: manifest,
      printer: printer,
      options: options,
    );
    await transport(
      printer: printer,
      bytes: bytes,
      timeoutMs: options.timeoutMs,
    );
    return _DeliveryOutcome(
      documentDeliveryMode: manifest.kind == PrintDocumentKind.text
          ? PrintDocumentDeliveryMode.plainText
          : PrintDocumentDeliveryMode.rasterPages,
    );
  }

  Future<List<int>> _buildRawDocumentBytes({
    required PrintDocumentArtifactManifest manifest,
    required PrinterModel printer,
    required ResolvedPrintOptions options,
  }) async {
    final output = <int>[];
    for (var copy = 0; copy < options.copies; copy++) {
      output.addAll(_escPosInitialize());
      if (manifest.kind == PrintDocumentKind.text) {
        final textPath = manifest.textPath;
        if (textPath == null || textPath.isEmpty) {
          throw const PrintJobExecutionException('Missing text artifact.');
        }
        final content = await File(textPath).readAsString();
        output.addAll(_encodeTextDocument(content, options));
      } else {
        for (final pagePath in manifest.pagePaths) {
          final pageBytes = await File(pagePath).readAsBytes();
          final targetWidthPx =
              manifest.targetWidthPx ?? _paperSizeToWidthPx(options.paperSize);
          if (manifest.sourceContentType == 'image') {
            output.addAll(
              _encodeImageJobPage(
                pageBytes,
                targetWidthPx: targetWidthPx,
                presetName: options.imagePreset ?? 'mixed_receipt',
                trimWhitespaceOverride: options.trimWhitespace,
                thermalDitheringOverride: options.thermalDithering,
                graphicsMode: RawGraphicsMode.fromValue(
                  printer.rawGraphicsMode,
                ),
              ),
            );
          } else {
            output.addAll(
              _encodeRasterPage(
                pageBytes,
                targetWidthPx: targetWidthPx,
                trimWhitespace: options.trimWhitespace ?? true,
                thermalDithering: options.thermalDithering ?? true,
                graphicsMode: RawGraphicsMode.fromValue(
                  printer.rawGraphicsMode,
                ),
              ),
            );
          }
          output.addAll(_lineFeed(4));
        }
      }
      if (options.openDrawer) {
        output.addAll(_drawerPulse(printer.usbDrawerPin ?? 2));
      }
      if (options.autoCut && (options.cutMode ?? 'FULL') != 'NONE') {
        output.addAll(_cutCommand(options.cutMode ?? 'FULL'));
      } else {
        output.addAll(_lineFeed(5));
      }
      final delayMs = options.packetDelayMs;
      if (delayMs != null && delayMs > 0) {
        await Future<void>.delayed(Duration(milliseconds: delayMs));
      }
    }
    return output;
  }

  Future<void> _spoolFile({
    required String filePath,
    required PrinterModel printer,
    required ResolvedPrintOptions options,
  }) async {
    if (_isMacOS || _isLinux) {
      final printerName = printer.systemPrinterName?.trim();
      final command = await _resolveSystemSpoolPrintCommand(_processRunner);
      final spoolerPaperSize = _mapSpoolerPaperSize(options.paperSize);
      final arguments = <String>[
        if (printerName != null && printerName.isNotEmpty) ...[
          '-d',
          printerName,
        ],
        if (spoolerPaperSize != null) ...['-o', 'media=$spoolerPaperSize'],
        if (options.duplexMode != null && options.duplexMode != 'NONE') ...[
          '-o',
          _mapLpDuplex(options.duplexMode!),
        ],
        if (options.orientation != null) ...[
          '-o',
          'orientation-requested=${_mapLpOrientation(options.orientation!)}',
        ],
        filePath,
      ];
      final result = await _processRunner.run(command, arguments);
      if (result.exitCode != 0) {
        throw PrintJobExecutionException(
          'System spooler failed: ${result.stderr}'.trim(),
        );
      }
      return;
    }

    if (_isWindows) {
      final extension = p.extension(filePath).toLowerCase();
      if (extension == '.txt') {
        await _spoolWindowsTextFile(
          filePath: filePath,
          printer: printer,
          options: options,
        );
        return;
      }
      if (const {'.png', '.jpg', '.jpeg', '.bmp', '.gif'}.contains(extension)) {
        await _spoolWindowsImageFile(
          filePath: filePath,
          printer: printer,
          options: options,
        );
        return;
      }
      throw PrintJobExecutionException(
        'Windows direct print does not support "$extension" files.',
      );
    }

    throw const PrintJobExecutionException(
      'System spooler execution is not supported on this platform.',
    );
  }

  Future<void> _spoolWindowsTextFile({
    required String filePath,
    required PrinterModel printer,
    required ResolvedPrintOptions options,
  }) async {
    final printerName =
        printer.systemPrinterName?.trim() ??
        printer.systemQueueName?.trim() ??
        '';
    final script = r'''
Add-Type -AssemblyName System.Drawing
$path = $args[0]
$printer = $args[1]
$paper = $args[2]
$content = [System.IO.File]::ReadAllText($path)
$font = New-Object System.Drawing.Font("Consolas", 10)
$brush = [System.Drawing.Brushes]::Black
$lines = $content -split "`r?`n"
$lineIndex = 0
$doc = New-Object System.Drawing.Printing.PrintDocument
if ($printer -ne '') { $doc.PrinterSettings.PrinterName = $printer }
switch ($paper.ToUpper()) {
  '58MM' {
    $doc.DefaultPageSettings.PaperSize = New-Object System.Drawing.Printing.PaperSize('58mm', 228, 2000)
    $doc.DefaultPageSettings.Margins = New-Object System.Drawing.Printing.Margins(0, 0, 0, 0)
    $doc.OriginAtMargins = $false
  }
  '80MM' {
    $doc.DefaultPageSettings.PaperSize = New-Object System.Drawing.Printing.PaperSize('80mm', 315, 2000)
    $doc.DefaultPageSettings.Margins = New-Object System.Drawing.Printing.Margins(0, 0, 0, 0)
    $doc.OriginAtMargins = $false
  }
  'A4' {
    $doc.DefaultPageSettings.PaperSize = New-Object System.Drawing.Printing.PaperSize('A4', 827, 1169)
  }
}
$doc.add_PrintPage({
  param($sender, $e)
  $bounds = if ($paper.ToUpper() -eq '58MM' -or $paper.ToUpper() -eq '80MM') { $e.PageBounds } else { $e.MarginBounds }
  $left = $bounds.Left
  $top = $bounds.Top
  $lineHeight = $font.GetHeight($e.Graphics)
  while ($lineIndex -lt $lines.Length) {
    if (($top + $lineHeight) -gt $bounds.Bottom) {
      $e.HasMorePages = $true
      return
    }
    $e.Graphics.DrawString($lines[$lineIndex], $font, $brush, $left, $top)
    $lineIndex++
    $top += $lineHeight
  }
  $e.HasMorePages = $false
})
$doc.Print()
$doc.Dispose()
$font.Dispose()
''';
    final result = await _runWindowsPowerShellScript(
      script: script,
      arguments: <String>[filePath, printerName, options.paperSize],
    );
    if (result.exitCode != 0) {
      throw PrintJobExecutionException(
        'Windows text print failed: ${result.stderr}'.trim(),
      );
    }
  }

  Future<void> _spoolWindowsImageFile({
    required String filePath,
    required PrinterModel printer,
    required ResolvedPrintOptions options,
  }) async {
    final printerName =
        printer.systemPrinterName?.trim() ??
        printer.systemQueueName?.trim() ??
        '';
    final script = r'''
Add-Type -AssemblyName System.Drawing
$path = $args[0]
$printer = $args[1]
$paper = $args[2]
$image = [System.Drawing.Image]::FromFile($path)
$doc = New-Object System.Drawing.Printing.PrintDocument
if ($printer -ne '') { $doc.PrinterSettings.PrinterName = $printer }
switch ($paper.ToUpper()) {
  '58MM' {
    $paperWidth = 228
    $paperHeight = [Math]::Ceiling(($image.Height / $image.Width) * $paperWidth)
    $doc.DefaultPageSettings.PaperSize = New-Object System.Drawing.Printing.PaperSize('58mm', $paperWidth, $paperHeight)
    $doc.DefaultPageSettings.Margins = New-Object System.Drawing.Printing.Margins(0, 0, 0, 0)
    $doc.OriginAtMargins = $false
  }
  '80MM' {
    $paperWidth = 315
    $paperHeight = [Math]::Ceiling(($image.Height / $image.Width) * $paperWidth)
    $doc.DefaultPageSettings.PaperSize = New-Object System.Drawing.Printing.PaperSize('80mm', $paperWidth, $paperHeight)
    $doc.DefaultPageSettings.Margins = New-Object System.Drawing.Printing.Margins(0, 0, 0, 0)
    $doc.OriginAtMargins = $false
  }
  'A4' {
    $doc.DefaultPageSettings.PaperSize = New-Object System.Drawing.Printing.PaperSize('A4', 827, 1169)
  }
}
$doc.add_PrintPage({
  param($sender, $e)
  $bounds = if ($paper.ToUpper() -eq '58MM' -or $paper.ToUpper() -eq '80MM') { $e.PageBounds } else { $e.MarginBounds }
  $ratioX = $bounds.Width / $image.Width
  $ratioY = $bounds.Height / $image.Height
  $ratio = [Math]::Min($ratioX, $ratioY)
  $drawWidth = [int]($image.Width * $ratio)
  $drawHeight = [int]($image.Height * $ratio)
  $drawX = $bounds.Left + [int](($bounds.Width - $drawWidth) / 2)
  $drawY = $bounds.Top + [int](($bounds.Height - $drawHeight) / 2)
  $e.Graphics.DrawImage($image, $drawX, $drawY, $drawWidth, $drawHeight)
  $e.HasMorePages = $false
})
$doc.Print()
$doc.Dispose()
$image.Dispose()
''';
    final result = await _runWindowsPowerShellScript(
      script: script,
      arguments: <String>[filePath, printerName, options.paperSize],
    );
    if (result.exitCode != 0) {
      throw PrintJobExecutionException(
        'Windows image print failed: ${result.stderr}'.trim(),
      );
    }
  }

  Future<ProcessResult> _runWindowsPowerShellScript({
    required String script,
    required List<String> arguments,
  }) async {
    final supportDir = await getApplicationSupportDirectory();
    final scriptFile = File(
      p.join(
        supportDir.path,
        'print-job-artifacts',
        'windows-print-${DateTime.now().microsecondsSinceEpoch}.ps1',
      ),
    );
    await scriptFile.parent.create(recursive: true);
    await scriptFile.writeAsString(script, flush: true);

    try {
      return await _processRunner.run('powershell', <String>[
        '-NoProfile',
        '-ExecutionPolicy',
        'Bypass',
        '-File',
        scriptFile.path,
        ...arguments,
      ]);
    } finally {
      if (await scriptFile.exists()) {
        await scriptFile.delete();
      }
    }
  }

  bool get _isLinux => (_platformOverride ?? Platform.operatingSystem) == 'linux';
  bool get _isMacOS => (_platformOverride ?? Platform.operatingSystem) == 'macos';
  bool get _isWindows => (_platformOverride ?? Platform.operatingSystem) == 'windows';

  Future<PrintDocumentArtifactManifest> _readManifest(
    String artifactPath,
  ) async {
    final file = File(artifactPath);
    final decoded = jsonDecode(await file.readAsString());
    if (decoded is! Map<String, dynamic>) {
      throw const PrintJobExecutionException(
        'Invalid print artifact manifest.',
      );
    }
    return PrintDocumentArtifactManifest.fromJson(decoded);
  }

  List<int> _encodeTextDocument(String text, ResolvedPrintOptions options) {
    final normalized = switch ((options.lineEnding ?? 'LF').toUpperCase()) {
      'CR' => text.replaceAll('\n', '\r'),
      'CRLF' => text.replaceAll('\n', '\r\n'),
      'NONE' => text,
      _ => text.replaceAll('\r\n', '\n'),
    };

    final encoding = (options.textEncoding ?? 'UTF-8').toUpperCase();
    if (encoding == 'UTF-8') {
      return utf8.encode(normalized);
    }

    return normalized.runes
        .map((rune) => rune <= 0xFF ? rune : 0x3F)
        .toList(growable: false);
  }

  List<int> _encodeImageJobPage(
    List<int> pngBytes, {
    required int targetWidthPx,
    required String presetName,
    required bool? trimWhitespaceOverride,
    required bool? thermalDitheringOverride,
    required RawGraphicsMode graphicsMode,
  }) {
    final profile = _resolveImageThermalProfile(
      presetName,
      trimWhitespaceOverride: trimWhitespaceOverride,
      thermalDitheringOverride: thermalDitheringOverride,
    );
    final prepared = _prepareThermalRasterImage(
      pngBytes,
      targetWidthPx: targetWidthPx,
      trimWhitespace: profile.trimWhitespace,
      thermalDithering: profile.thermalDithering,
      threshold: profile.threshold,
      contrast: profile.contrast,
    );
    return switch (graphicsMode) {
      RawGraphicsMode.legacy => _encodeLegacyRasterBytes(prepared),
      RawGraphicsMode.modern => _encodeModernGraphicsBytes(prepared),
    };
  }

  List<int> _encodeRasterPage(
    List<int> pngBytes, {
    required int targetWidthPx,
    required bool trimWhitespace,
    required bool thermalDithering,
    required RawGraphicsMode graphicsMode,
  }) {
    final prepared = _prepareThermalRasterImage(
      pngBytes,
      targetWidthPx: targetWidthPx,
      trimWhitespace: trimWhitespace,
      thermalDithering: thermalDithering,
      threshold: thermalDithering ? 160 : 180,
      contrast: thermalDithering ? 1.05 : 1.1,
    );
    return switch (graphicsMode) {
      RawGraphicsMode.legacy => _encodeLegacyRasterBytes(prepared),
      RawGraphicsMode.modern => _encodeModernGraphicsBytes(prepared),
    };
  }

  img.Image _prepareThermalRasterImage(
    List<int> pngBytes, {
    required int targetWidthPx,
    required bool trimWhitespace,
    required bool thermalDithering,
    required int threshold,
    required double contrast,
  }) {
    final decoded = img.decodeImage(Uint8List.fromList(pngBytes));
    if (decoded == null) {
      throw const PrintJobExecutionException(
        'Failed to decode rendered image page.',
      );
    }
    final prepared = trimWhitespace
        ? _trimWhitespace(decoded)
        : img.Image.from(decoded);
    final resized = prepared.width > targetWidthPx
        ? img.copyResize(prepared, width: targetWidthPx)
        : prepared;
    final grayscale = img.grayscale(resized);
    final toned = _applyContrast(grayscale, contrast);
    final width = (grayscale.width + 7) & ~7;
    final padded = width == toned.width
        ? toned
        : img.copyExpandCanvas(
            toned,
            newWidth: width,
            newHeight: toned.height,
            position: img.ExpandCanvasPosition.topLeft,
          );
    final monochrome = thermalDithering
        ? _ditherImage(padded, threshold: threshold)
        : _thresholdImage(padded, threshold: threshold);
    return monochrome;
  }

  List<int> _encodeLegacyRasterBytes(img.Image monochrome) {
    final bytes = <int>[];
    const chunkHeight = 128;
    for (var offsetY = 0; offsetY < monochrome.height; offsetY += chunkHeight) {
      final currentHeight = (offsetY + chunkHeight > monochrome.height)
          ? monochrome.height - offsetY
          : chunkHeight;
      final widthBytes = monochrome.width ~/ 8;
      bytes.addAll([
        0x1D,
        0x76,
        0x30,
        0x00,
        widthBytes & 0xFF,
        (widthBytes >> 8) & 0xFF,
        currentHeight & 0xFF,
        (currentHeight >> 8) & 0xFF,
      ]);

      for (var y = 0; y < currentHeight; y++) {
        for (var xByte = 0; xByte < widthBytes; xByte++) {
          var value = 0;
          for (var bit = 0; bit < 8; bit++) {
            final pixel = monochrome.getPixel(xByte * 8 + bit, offsetY + y);
            if (img.getLuminance(pixel) < 128) {
              value |= 1 << (7 - bit);
            }
          }
          bytes.add(value);
        }
      }
    }
    return bytes;
  }

  List<int> _encodeModernGraphicsBytes(img.Image monochrome) {
    final bytes = <int>[];
    const chunkHeight = 192;
    for (var offsetY = 0; offsetY < monochrome.height; offsetY += chunkHeight) {
      final currentHeight = (offsetY + chunkHeight > monochrome.height)
          ? monochrome.height - offsetY
          : chunkHeight;
      final chunk = img.copyCrop(
        monochrome,
        x: 0,
        y: offsetY,
        width: monochrome.width,
        height: currentHeight,
      );
      final raster = _imageToRasterBytes(chunk);
      final widthBytes = chunk.width ~/ 8;
      final parameterLength = raster.length + 10;
      bytes.addAll([
        0x1D,
        0x28,
        0x4C,
        parameterLength & 0xFF,
        (parameterLength >> 8) & 0xFF,
        0x30,
        0x70,
        0x30,
        0x01,
        0x01,
        0x31,
        chunk.width & 0xFF,
        (chunk.width >> 8) & 0xFF,
        currentHeight & 0xFF,
        (currentHeight >> 8) & 0xFF,
        ...raster,
        0x1D,
        0x28,
        0x4C,
        0x02,
        0x00,
        0x30,
        0x32,
      ]);
      if (widthBytes <= 0) {
        throw const PrintJobExecutionException(
          'Prepared thermal image page has invalid width.',
        );
      }
    }
    return bytes;
  }

  img.Image _trimWhitespace(img.Image source) {
    var minX = source.width;
    var minY = source.height;
    var maxX = -1;
    var maxY = -1;

    for (var y = 0; y < source.height; y++) {
      for (var x = 0; x < source.width; x++) {
        if (img.getLuminance(source.getPixel(x, y)) < 245) {
          if (x < minX) minX = x;
          if (y < minY) minY = y;
          if (x > maxX) maxX = x;
          if (y > maxY) maxY = y;
        }
      }
    }

    if (maxX < 0 || maxY < 0) {
      return img.Image.from(source);
    }

    const margin = 4;
    final left = (minX - margin).clamp(0, source.width - 1);
    final top = (minY - margin).clamp(0, source.height - 1);
    final right = (maxX + margin).clamp(0, source.width - 1);
    final bottom = (maxY + margin).clamp(0, source.height - 1);
    final width = (right - left) + 1;
    final height = (bottom - top) + 1;

    if (width >= source.width && height >= source.height) {
      return img.Image.from(source);
    }

    return img.copyCrop(source, x: left, y: top, width: width, height: height);
  }

  img.Image _thresholdImage(img.Image source, {required int threshold}) {
    final result = img.Image.from(source);
    for (var y = 0; y < result.height; y++) {
      for (var x = 0; x < result.width; x++) {
        final luminance = img.getLuminance(result.getPixel(x, y));
        final color = luminance < threshold ? 0 : 255;
        result.setPixelRgb(x, y, color, color, color);
      }
    }
    return result;
  }

  img.Image _ditherImage(img.Image source, {required int threshold}) {
    final result = img.Image.from(source);
    final errors = List<double>.filled(result.width * result.height, 0);

    for (var y = 0; y < result.height; y++) {
      for (var x = 0; x < result.width; x++) {
        final index = (y * result.width) + x;
        final current =
            img.getLuminance(result.getPixel(x, y)).toDouble() + errors[index];
        final nextColor = current < threshold ? 0 : 255;
        final quantError = current - nextColor;
        result.setPixelRgb(x, y, nextColor, nextColor, nextColor);

        _diffuseError(
          errors,
          result.width,
          result.height,
          x + 1,
          y,
          quantError * 7 / 16,
        );
        _diffuseError(
          errors,
          result.width,
          result.height,
          x - 1,
          y + 1,
          quantError * 3 / 16,
        );
        _diffuseError(
          errors,
          result.width,
          result.height,
          x,
          y + 1,
          quantError * 5 / 16,
        );
        _diffuseError(
          errors,
          result.width,
          result.height,
          x + 1,
          y + 1,
          quantError * 1 / 16,
        );
      }
    }

    return result;
  }

  img.Image _applyContrast(img.Image source, double contrast) {
    if (contrast == 1) {
      return img.Image.from(source);
    }

    final result = img.Image.from(source);
    for (var y = 0; y < result.height; y++) {
      for (var x = 0; x < result.width; x++) {
        final luminance = img.getLuminance(result.getPixel(x, y)).toDouble();
        final adjusted = ((luminance - 128) * contrast + 128).round().clamp(
          0,
          255,
        );
        result.setPixelRgb(x, y, adjusted, adjusted, adjusted);
      }
    }
    return result;
  }

  List<int> _imageToRasterBytes(img.Image monochrome) {
    final widthBytes = monochrome.width ~/ 8;
    final bytes = <int>[];
    for (var y = 0; y < monochrome.height; y++) {
      for (var xByte = 0; xByte < widthBytes; xByte++) {
        var value = 0;
        for (var bit = 0; bit < 8; bit++) {
          final pixel = monochrome.getPixel(xByte * 8 + bit, y);
          if (img.getLuminance(pixel) < 128) {
            value |= 1 << (7 - bit);
          }
        }
        bytes.add(value);
      }
    }
    return bytes;
  }

  _ImageThermalProfile _resolveImageThermalProfile(
    String presetName, {
    required bool? trimWhitespaceOverride,
    required bool? thermalDitheringOverride,
  }) {
    final base = switch (presetName.trim().toLowerCase()) {
      'text_barcode' => const _ImageThermalProfile(
        name: 'text_barcode',
        trimWhitespace: true,
        thermalDithering: false,
        threshold: 200,
        contrast: 1.18,
      ),
      'logo_graphics' => const _ImageThermalProfile(
        name: 'logo_graphics',
        trimWhitespace: true,
        thermalDithering: true,
        threshold: 155,
        contrast: 1.12,
      ),
      'photo' => const _ImageThermalProfile(
        name: 'photo',
        trimWhitespace: false,
        thermalDithering: true,
        threshold: 148,
        contrast: 1.0,
      ),
      _ => const _ImageThermalProfile(
        name: 'mixed_receipt',
        trimWhitespace: true,
        thermalDithering: true,
        threshold: 165,
        contrast: 1.08,
      ),
    };
    return _ImageThermalProfile(
      name: base.name,
      trimWhitespace: trimWhitespaceOverride ?? base.trimWhitespace,
      thermalDithering: thermalDitheringOverride ?? base.thermalDithering,
      threshold: base.threshold,
      contrast: base.contrast,
    );
  }

  void _diffuseError(
    List<double> errors,
    int width,
    int height,
    int x,
    int y,
    double amount,
  ) {
    if (x < 0 || y < 0 || x >= width || y >= height) {
      return;
    }
    errors[(y * width) + x] += amount;
  }

  List<int> _escPosInitialize() => const [0x1B, 0x40];

  List<int> _lineFeed(int count) =>
      List<int>.filled(count, 0x0A, growable: false);

  List<int> _cutCommand(String mode) => switch (mode.toUpperCase()) {
    'PARTIAL' => const [0x1D, 0x56, 0x01],
    'NONE' => const <int>[],
    _ => const [0x1D, 0x56, 0x00],
  };

  List<int> _drawerPulse(int pin) => [
    0x1B,
    0x70,
    pin == 5 ? 0x01 : 0x00,
    0x19,
    0xFA,
  ];

  String? _mapSpoolerPaperSize(String value) {
    return switch (value.toUpperCase()) {
      'A4' => 'A4',
      'A5' => 'A5',
      'LETTER' => 'Letter',
      'LEGAL' => 'Legal',
      '80MM' => '80mm',
      '58MM' => '58mm',
      _ => null,
    };
  }

  String _mapLpDuplex(String value) => switch (value.toUpperCase()) {
    'LONG_EDGE' => 'sides=two-sided-long-edge',
    'SHORT_EDGE' => 'sides=two-sided-short-edge',
    _ => 'sides=one-sided',
  };

  int _mapLpOrientation(String value) => switch (value.toUpperCase()) {
    'LANDSCAPE' => 4,
    _ => 3,
  };

  int _paperSizeToWidthPx(String paperSize) {
    return switch (paperSize.toUpperCase()) {
      '58MM' => 384,
      '80MM' => 576,
      'A5' => 874,
      'A4' => 1240,
      'LETTER' => 1224,
      'LEGAL' => 1344,
      _ => 576,
    };
  }
}

Future<String> _resolveSystemSpoolPrintCommand(
  PrintProcessRunner runner,
) async {
  final lpCheck = await runner.run('which', ['lp']);
  if (lpCheck.exitCode == 0) {
    return 'lp';
  }

  throw const PrintJobExecutionException(
    'No option-capable system print command was found on this machine.',
  );
}

Future<String> _resolveRawPrintCommand(PrintProcessRunner runner) async {
  final lpCheck = await runner.run('which', ['lp']);
  if (lpCheck.exitCode == 0) {
    return 'lp';
  }

  final lprCheck = await runner.run('which', ['lpr']);
  if (lprCheck.exitCode == 0) {
    return 'lpr';
  }

  throw const PrintJobExecutionException(
    'No system print command was found on this machine.',
  );
}
