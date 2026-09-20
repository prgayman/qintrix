import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;
import 'package:qintrix/core/services/print_document_models.dart';
import 'package:qintrix/core/services/print_job_execution_service.dart';
import 'package:qintrix/core/services/print_job_render_service.dart';
import 'package:qintrix/data/models/exports.dart';

import '../../helpers/mock_path_provider.dart';

class _RecordedProcessCall {
  const _RecordedProcessCall(this.executable, this.arguments, {this.scriptBody});

  final String executable;
  final List<String> arguments;
  final String? scriptBody;
}

class _FakeProcessRunner implements PrintProcessRunner {
  final List<_RecordedProcessCall> calls = <_RecordedProcessCall>[];
  final Map<String, ProcessResult> failuresByPath = <String, ProcessResult>{};

  @override
  Future<ProcessResult> run(String executable, List<String> arguments) async {
    String? scriptBody;
    final fileIndex = arguments.indexOf('-File');
    if (fileIndex != -1 && fileIndex + 1 < arguments.length) {
      final scriptPath = arguments[fileIndex + 1];
      final scriptFile = File(scriptPath);
      if (await scriptFile.exists()) {
        scriptBody = await scriptFile.readAsString();
      }
    }
    calls.add(
      _RecordedProcessCall(
        executable,
        List<String>.from(arguments),
        scriptBody: scriptBody,
      ),
    );
    if (executable == 'which') {
      return ProcessResult(0, 0, '/usr/bin/${arguments.first}', '');
    }
    final targetPath = arguments.isEmpty ? null : arguments.last;
    if (targetPath != null && failuresByPath.containsKey(targetPath)) {
      return failuresByPath[targetPath]!;
    }
    return ProcessResult(0, 0, '', '');
  }
}

class _NetworkSend {
  const _NetworkSend(this.bytes, this.timeoutMs);

  final List<int> bytes;
  final int? timeoutMs;
}

class _UsbSend {
  const _UsbSend(this.bytes);

  final List<int> bytes;
}

class _FakeRawByteTransport implements RawByteTransport {
  final List<_NetworkSend> networkSends = <_NetworkSend>[];
  final List<_UsbSend> usbSends = <_UsbSend>[];

  @override
  Future<void> sendNetwork({
    required PrinterModel printer,
    required List<int> bytes,
    int? timeoutMs,
  }) async {
    networkSends.add(_NetworkSend(List<int>.from(bytes), timeoutMs));
  }

  @override
  Future<void> sendUsb({
    required PrinterModel printer,
    required List<int> bytes,
    required PrintProcessRunner processRunner,
  }) async {
    usbSends.add(_UsbSend(List<int>.from(bytes)));
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Directory tempDir;
  late _FakeProcessRunner processRunner;
  late _FakeRawByteTransport rawTransport;
  late PrintJobExecutionService service;

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp('qintrix-execution-test');
    await mockPathProvider(tempDir);
    processRunner = _FakeProcessRunner();
    rawTransport = _FakeRawByteTransport();
    service = PrintJobExecutionService(
      processRunner: processRunner,
      rawByteTransport: rawTransport,
    );
  });

  tearDown(() async {
    await clearMockPathProvider();
    if (await tempDir.exists()) {
      await tempDir.delete(recursive: true);
    }
  });

  test('system spooler images print full page order for each copy', () async {
    final manifestPath = await _writeImageManifest(
      tempDir,
      pageNames: const <String>['page-001.png', 'page-002.png'],
    );
    final job = _buildJob(
      artifactPath: manifestPath,
      copies: 2,
      contentType: 'pdf',
    );
    final printer = _buildPrinter(
      connectionType: PrinterConnectionType.systemSpooler,
      systemPrinterName: 'Office Printer',
    );

    final result = await service.execute(job: job, printer: printer);

    final spoolCalls = processRunner.calls
        .where((call) => call.executable == 'lp' || call.executable == 'lpr')
        .toList(growable: false);
    final files = spoolCalls
        .map((call) => call.arguments.last.split(Platform.pathSeparator).last)
        .toList(growable: false);

    expect(result.executionMode, PrintExecutionMode.systemSpoolerImage.value);
    expect(files, <String>[
      'page-001.png',
      'page-002.png',
      'page-001.png',
      'page-002.png',
    ]);
  });

  test('system spooler uses original pdf source when available', () async {
    final manifestPath = await _writeImageManifest(
      tempDir,
      pageNames: const <String>['page-001.png', 'page-002.png'],
      sourceContentType: 'pdf',
      sourceFileName: 'source.pdf',
    );
    final job = _buildJob(
      artifactPath: manifestPath,
      copies: 2,
      contentType: 'pdf',
    );
    final printer = _buildPrinter(
      connectionType: PrinterConnectionType.systemSpooler,
      systemPrinterName: 'Office Printer',
    );

    final result = await service.execute(job: job, printer: printer);

    final spoolCalls = processRunner.calls
        .where((call) => call.executable == 'lp' || call.executable == 'lpr')
        .toList(growable: false);
    final files = spoolCalls
        .map((call) => call.arguments.last.split(Platform.pathSeparator).last)
        .toList(growable: false);

    expect(result.executionMode, PrintExecutionMode.systemSpoolerImage.value);
    expect(
      result.documentDeliveryMode,
      PrintDocumentDeliveryMode.nativePdf.value,
    );
    expect(result.usedFallback, isFalse);
    expect(files, <String>['source.pdf', 'source.pdf']);
  });

  test(
    'system spooler falls back to raster pages when native pdf spool fails',
    () async {
      final manifestPath = await _writeImageManifest(
        tempDir,
        pageNames: const <String>['page-001.png', 'page-002.png'],
        sourceContentType: 'pdf',
        sourceFileName: 'source.pdf',
      );
      final sourcePath = '${tempDir.path}/source.pdf';
      processRunner.failuresByPath[sourcePath] = ProcessResult(
        1,
        1,
        '',
        'native spool failed',
      );
      final job = _buildJob(
        artifactPath: manifestPath,
        copies: 1,
        contentType: 'pdf',
        optionsJson: jsonEncode(<String, Object?>{'allowRasterFallback': true}),
      );
      final printer = _buildPrinter(
        connectionType: PrinterConnectionType.systemSpooler,
        systemPrinterName: 'Office Printer',
      );

      final result = await service.execute(job: job, printer: printer);

      final spoolCalls = processRunner.calls
          .where((call) => call.executable == 'lp' || call.executable == 'lpr')
          .toList(growable: false);
      final files = spoolCalls
          .map((call) => call.arguments.last.split(Platform.pathSeparator).last)
          .toList(growable: false);

      expect(
        result.documentDeliveryMode,
        PrintDocumentDeliveryMode.rasterPages.value,
      );
      expect(result.usedFallback, isTrue);
      expect(result.fallbackReason, contains('Native PDF spool failed'));
      expect(files, <String>['source.pdf', 'page-001.png', 'page-002.png']);
    },
  );

  test('system spooler uses original image source when available', () async {
    final manifestPath = await _writeImageManifest(
      tempDir,
      pageNames: const <String>['page-001.png'],
      sourceContentType: 'image',
      sourceFileName: 'source.jpg',
    );
    final job = _buildJob(
      artifactPath: manifestPath,
      copies: 2,
      contentType: 'image',
    );
    final printer = _buildPrinter(
      connectionType: PrinterConnectionType.systemSpooler,
      systemPrinterName: 'Office Printer',
    );

    final result = await service.execute(job: job, printer: printer);

    final spoolCalls = processRunner.calls
        .where((call) => call.executable == 'lp' || call.executable == 'lpr')
        .toList(growable: false);
    final files = spoolCalls
        .map((call) => call.arguments.last.split(Platform.pathSeparator).last)
        .toList(growable: false);

    expect(result.executionMode, PrintExecutionMode.systemSpoolerImage.value);
    expect(files, <String>['source.jpg', 'source.jpg']);
  });

  test('windows system spooler prints pdfs through raster pages directly', () async {
    service = PrintJobExecutionService(
      processRunner: processRunner,
      rawByteTransport: rawTransport,
      platformOverride: 'windows',
    );
    final manifestPath = await _writeImageManifest(
      tempDir,
      pageNames: const <String>['page-001.png', 'page-002.png'],
      sourceContentType: 'pdf',
      sourceFileName: 'source.pdf',
    );
    final job = _buildJob(
      artifactPath: manifestPath,
      copies: 1,
      contentType: 'pdf',
    );
    final printer = _buildPrinter(
      connectionType: PrinterConnectionType.systemSpooler,
      systemPrinterName: 'Office Printer',
    );

    final result = await service.execute(job: job, printer: printer);

    expect(result.documentDeliveryMode, PrintDocumentDeliveryMode.rasterPages.value);
    final powershellCalls = processRunner.calls
        .where((call) => call.executable == 'powershell')
        .toList(growable: false);
    expect(powershellCalls, hasLength(2));
    expect(
      powershellCalls
          .map((call) => call.arguments.lastWhere((arg) => arg.endsWith('.png')).split(Platform.pathSeparator).last)
          .toList(growable: false),
      <String>['page-001.png', 'page-002.png'],
    );
    expect(
      powershellCalls.every(
        (call) => call.arguments.contains('-File'),
      ),
      isTrue,
    );
    expect(
      powershellCalls.every(
        (call) => call.scriptBody?.contains('PrintDocument') == true,
      ),
      isTrue,
    );
    expect(
      powershellCalls.every(
        (call) => call.scriptBody?.contains('Start-Process') != true,
      ),
      isTrue,
    );
  });

  test('windows system spooler prints images directly without shell open', () async {
    service = PrintJobExecutionService(
      processRunner: processRunner,
      rawByteTransport: rawTransport,
      platformOverride: 'windows',
    );
    final manifestPath = await _writeImageManifest(
      tempDir,
      pageNames: const <String>['page-001.png'],
      sourceContentType: 'image',
      sourceFileName: 'source.jpg',
    );
    final job = _buildJob(
      artifactPath: manifestPath,
      copies: 1,
      contentType: 'image',
      optionsJson: jsonEncode(<String, Object?>{'paperSize': '80mm'}),
    );
    final printer = _buildPrinter(
      connectionType: PrinterConnectionType.systemSpooler,
      systemPrinterName: 'Office Printer',
    );

    final result = await service.execute(job: job, printer: printer);

    expect(
      result.documentDeliveryMode,
      PrintDocumentDeliveryMode.nativeSourceImage.value,
    );
    final call = processRunner.calls.singleWhere(
      (entry) => entry.executable == 'powershell',
    );
    expect(call.arguments.contains('-File'), isTrue);
    expect(call.scriptBody?.contains('DrawImage'), isTrue);
    expect(call.scriptBody?.contains("\$paperWidth = 315"), isTrue);
    expect(call.scriptBody?.contains("PaperSize('80mm'"), isTrue);
    expect(
      call.scriptBody?.contains('Start-Process') != true,
      isTrue,
    );
  });

  test('system spooler forwards receipt media size when configured', () async {
    final manifestPath = await _writeImageManifest(
      tempDir,
      pageNames: const <String>['page-001.png'],
    );
    final job = _buildJob(
      artifactPath: manifestPath,
      copies: 1,
      contentType: 'image',
      optionsJson: jsonEncode(<String, Object?>{'paperSize': '80mm'}),
    );
    final printer = _buildPrinter(
      connectionType: PrinterConnectionType.systemSpooler,
      systemPrinterName: 'Receipt Printer',
    );

    await service.execute(job: job, printer: printer);

    final spoolCall = processRunner.calls.firstWhere(
      (call) => call.executable == 'lp' || call.executable == 'lpr',
    );

    expect(spoolCall.executable, 'lp');
    expect(
      spoolCall.arguments,
      containsAllInOrder(<String>['-o', 'media=80mm']),
    );
  });

  test('network tcp text sends one native text payload per copy', () async {
    final manifestPath = await _writeTextManifest(tempDir, 'Hello printer');
    final job = _buildJob(
      artifactPath: manifestPath,
      copies: 2,
      contentType: 'text',
      optionsJson: jsonEncode(<String, Object?>{'paperSize': '80mm'}),
    );
    final printer = _buildPrinter(
      connectionType: PrinterConnectionType.networkTcp,
      tcpHost: '192.168.1.20',
      tcpPort: 9100,
      tcpEncoding: 'UTF-8',
      tcpLineEnding: 'LF',
    );

    final result = await service.execute(job: job, printer: printer);

    expect(result.executionMode, PrintExecutionMode.networkTcpText.value);
    expect(
      result.documentDeliveryMode,
      PrintDocumentDeliveryMode.plainText.value,
    );
    expect(rawTransport.networkSends, hasLength(2));
    expect(
      utf8.decode(rawTransport.networkSends.first.bytes),
      contains('Hello printer'),
    );
  });

  test('usb raw esc pos includes drawer pulse and cut commands', () async {
    final manifestPath = await _writeTextManifest(tempDir, 'Ticket 42');
    final job = _buildJob(
      artifactPath: manifestPath,
      copies: 1,
      contentType: 'text',
      optionsJson: jsonEncode(<String, Object?>{
        'paperSize': '80mm',
        'openDrawer': true,
      }),
    );
    final printer = _buildPrinter(
      connectionType: PrinterConnectionType.usbRawEscPos,
      systemQueueName: 'Raw USB Queue',
      usbEncoding: 'UTF-8',
      usbAutoCutEnabled: true,
      usbCutMode: 'FULL',
      usbCashDrawerEnabled: true,
      usbDrawerPin: 2,
    );

    final result = await service.execute(job: job, printer: printer);
    final payload = rawTransport.usbSends.single.bytes;

    expect(result.executionMode, PrintExecutionMode.usbRawEscPos.value);
    expect(
      result.documentDeliveryMode,
      PrintDocumentDeliveryMode.plainText.value,
    );
    expect(_containsSequence(payload, const <int>[0x1B, 0x40]), isTrue);
    expect(_containsSequence(payload, const <int>[0x1B, 0x70, 0x00]), isTrue);
    expect(_containsSequence(payload, const <int>[0x1D, 0x56, 0x00]), isTrue);
  });

  test(
    'usb raw esc pos can print narrow image pages without padding errors',
    () async {
      final manifestPath = await _writeImageManifest(
        tempDir,
        pageNames: const <String>['page-001.png'],
        sourceContentType: 'image',
      );
      final job = _buildJob(
        artifactPath: manifestPath,
        copies: 1,
        contentType: 'image',
        optionsJson: jsonEncode(<String, Object?>{'paperSize': '80mm'}),
      );
      final printer = _buildPrinter(
        connectionType: PrinterConnectionType.usbRawEscPos,
        systemQueueName: 'Raw USB Queue',
        usbEncoding: 'UTF-8',
      );

      final result = await service.execute(job: job, printer: printer);

      expect(result.executionMode, PrintExecutionMode.usbRawEscPos.value);
      expect(
        result.documentDeliveryMode,
        PrintDocumentDeliveryMode.rasterPages.value,
      );
      expect(rawTransport.usbSends, hasLength(1));
      expect(rawTransport.usbSends.single.bytes, isNotEmpty);
    },
  );

  test('usb raw image jobs use modern graphics mode by default', () async {
    final manifestPath = await _writeImageManifest(
      tempDir,
      pageNames: const <String>['page-001.png'],
      sourceContentType: 'image',
    );
    final job = _buildJob(
      artifactPath: manifestPath,
      copies: 1,
      contentType: 'image',
      optionsJson: jsonEncode(<String, Object?>{'paperSize': '80mm'}),
    );
    final printer = _buildPrinter(
      connectionType: PrinterConnectionType.usbRawEscPos,
      systemQueueName: 'Raw USB Queue',
      usbEncoding: 'UTF-8',
    );

    final result = await service.execute(job: job, printer: printer);
    final payload = rawTransport.usbSends.single.bytes;

    expect(result.executionMode, PrintExecutionMode.usbRawEscPos.value);
    expect(result.appliedOptions['imagePreset'], 'mixed_receipt');
    expect(result.appliedOptions['rawGraphicsMode'], 'modern');
    expect(_containsSequence(payload, const <int>[0x1D, 0x28, 0x4C]), isTrue);
    expect(_containsSequence(payload, const <int>[0x30, 0x70]), isTrue);
    expect(_containsSequence(payload, const <int>[0x30, 0x32]), isTrue);
  });

  test('usb raw image jobs can fall back to legacy graphics mode', () async {
    final manifestPath = await _writeImageManifest(
      tempDir,
      pageNames: const <String>['page-001.png'],
      sourceContentType: 'image',
    );
    final job = _buildJob(
      artifactPath: manifestPath,
      copies: 1,
      contentType: 'image',
      optionsJson: jsonEncode(<String, Object?>{
        'paperSize': '80mm',
        'imagePreset': 'text_barcode',
      }),
    );
    final printer = _buildPrinter(
      connectionType: PrinterConnectionType.usbRawEscPos,
      systemQueueName: 'Raw USB Queue',
      usbEncoding: 'UTF-8',
      rawGraphicsMode: 'legacy',
    );

    final result = await service.execute(job: job, printer: printer);
    final payload = rawTransport.usbSends.single.bytes;

    expect(result.appliedOptions['imagePreset'], 'text_barcode');
    expect(result.appliedOptions['rawGraphicsMode'], 'legacy');
    expect(
      _containsSequence(payload, const <int>[0x1D, 0x76, 0x30, 0x00]),
      isTrue,
    );
    expect(_containsSequence(payload, const <int>[0x1D, 0x28, 0x4C]), isFalse);
  });

  test('usb raw pdf jobs use modern graphics mode by default', () async {
    final manifestPath = await _writeImageManifest(
      tempDir,
      pageNames: const <String>['page-001.png'],
      sourceContentType: 'pdf',
    );
    final job = _buildJob(
      artifactPath: manifestPath,
      copies: 1,
      contentType: 'pdf',
      optionsJson: jsonEncode(<String, Object?>{'paperSize': '80mm'}),
    );
    final printer = _buildPrinter(
      connectionType: PrinterConnectionType.usbRawEscPos,
      systemQueueName: 'Raw USB Queue',
      usbEncoding: 'UTF-8',
    );

    final result = await service.execute(job: job, printer: printer);
    final payload = rawTransport.usbSends.single.bytes;

    expect(result.appliedOptions['rawGraphicsMode'], 'modern');
    expect(_containsSequence(payload, const <int>[0x1D, 0x28, 0x4C]), isTrue);
    expect(_containsSequence(payload, const <int>[0x30, 0x70]), isTrue);
    expect(_containsSequence(payload, const <int>[0x30, 0x32]), isTrue);
  });

  test('usb raw pdf jobs can fall back to legacy graphics mode', () async {
    final manifestPath = await _writeImageManifest(
      tempDir,
      pageNames: const <String>['page-001.png'],
      sourceContentType: 'pdf',
    );
    final job = _buildJob(
      artifactPath: manifestPath,
      copies: 1,
      contentType: 'pdf',
      optionsJson: jsonEncode(<String, Object?>{'paperSize': '80mm'}),
    );
    final printer = _buildPrinter(
      connectionType: PrinterConnectionType.usbRawEscPos,
      systemQueueName: 'Raw USB Queue',
      usbEncoding: 'UTF-8',
      rawGraphicsMode: 'legacy',
    );

    final result = await service.execute(job: job, printer: printer);
    final payload = rawTransport.usbSends.single.bytes;

    expect(result.appliedOptions['rawGraphicsMode'], 'legacy');
    expect(
      _containsSequence(payload, const <int>[0x1D, 0x76, 0x30, 0x00]),
      isTrue,
    );
    expect(_containsSequence(payload, const <int>[0x1D, 0x28, 0x4C]), isFalse);
  });

  test('image preset overrides stay image-only for pdf jobs', () async {
    final manifestPath = await _writeImageManifest(
      tempDir,
      pageNames: const <String>['page-001.png'],
      sourceContentType: 'pdf',
    );
    final job = _buildJob(
      artifactPath: manifestPath,
      copies: 1,
      contentType: 'pdf',
      optionsJson: jsonEncode(<String, Object?>{
        'paperSize': '80mm',
        'imagePreset': 'logo_graphics',
      }),
    );
    final printer = _buildPrinter(
      connectionType: PrinterConnectionType.usbRawEscPos,
      systemQueueName: 'Raw USB Queue',
      usbEncoding: 'UTF-8',
    );

    final result = await service.execute(job: job, printer: printer);

    expect(result.appliedOptions.containsKey('imagePreset'), isFalse);
    expect(result.appliedOptions['trimWhitespace'], isTrue);
    expect(result.appliedOptions['thermalDithering'], isTrue);
    expect(result.ignoredOptions['imagePreset'], 'logo_graphics');
  });

  test('invalid imagePreset fails clearly for image jobs', () async {
    final manifestPath = await _writeImageManifest(
      tempDir,
      pageNames: const <String>['page-001.png'],
      sourceContentType: 'image',
    );
    final job = _buildJob(
      artifactPath: manifestPath,
      copies: 1,
      contentType: 'image',
      optionsJson: jsonEncode(<String, Object?>{
        'paperSize': '80mm',
        'imagePreset': 'logoGraphic',
      }),
    );
    final printer = _buildPrinter(
      connectionType: PrinterConnectionType.usbRawEscPos,
      systemQueueName: 'Raw USB Queue',
      usbEncoding: 'UTF-8',
    );

    await expectLater(
      () => service.execute(job: job, printer: printer),
      throwsA(
        isA<PrintJobRenderException>().having(
          (error) => error.message,
          'message',
          contains('Invalid imagePreset'),
        ),
      ),
    );
  });

  test('usb raw pdf normalizes unsupported paper sizes to 80mm', () async {
    final manifestPath = await _writeImageManifest(
      tempDir,
      pageNames: const <String>['page-001.png'],
      sourceContentType: 'pdf',
    );
    final job = _buildJob(
      artifactPath: manifestPath,
      copies: 1,
      contentType: 'pdf',
      optionsJson: jsonEncode(<String, Object?>{'paperSize': 'A4'}),
    );
    final printer = _buildPrinter(
      connectionType: PrinterConnectionType.usbRawEscPos,
      systemQueueName: 'Raw USB Queue',
      usbEncoding: 'UTF-8',
      systemPaperSize: 'A4',
    );

    final result = await service.execute(job: job, printer: printer);

    expect(result.appliedOptions['paperSize'], '80mm');
    expect(result.ignoredOptions['paperSize'], 'A4');
    expect(rawTransport.usbSends.single.bytes, isNotEmpty);
  });

  test('usb raw esc pos trims wide white margins when enabled', () async {
    final marginImage = img.Image(width: 120, height: 40);
    img.fill(marginImage, color: img.ColorRgb8(255, 255, 255));
    img.fillRect(
      marginImage,
      x1: 45,
      y1: 8,
      x2: 75,
      y2: 32,
      color: img.ColorRgb8(0, 0, 0),
    );

    final trimmedManifestPath = await _writeCustomImageManifest(
      tempDir,
      image: marginImage,
    );
    final untrimmedManifestPath = await _writeCustomImageManifest(
      tempDir,
      image: marginImage,
      manifestFileName: 'manifest-untrimmed.json',
      pageFileName: 'page-untrimmed.png',
    );

    final printer = _buildPrinter(
      connectionType: PrinterConnectionType.usbRawEscPos,
      systemQueueName: 'Raw USB Queue',
      usbEncoding: 'UTF-8',
    );

    await service.execute(
      job: _buildJob(
        artifactPath: trimmedManifestPath,
        copies: 1,
        contentType: 'pdf',
        optionsJson: jsonEncode(<String, Object?>{
          'paperSize': '80mm',
          'trimWhitespace': true,
        }),
      ),
      printer: printer,
    );
    final trimmedBytes = rawTransport.usbSends.last.bytes;

    await service.execute(
      job: _buildJob(
        artifactPath: untrimmedManifestPath,
        copies: 1,
        contentType: 'pdf',
        optionsJson: jsonEncode(<String, Object?>{
          'paperSize': '80mm',
          'trimWhitespace': false,
        }),
      ),
      printer: printer,
    );
    final untrimmedBytes = rawTransport.usbSends.last.bytes;

    expect(trimmedBytes.length, lessThan(untrimmedBytes.length));
  });

  test(
    'usb raw esc pos dithering changes raster output for gradients',
    () async {
      final gradient = img.Image(width: 32, height: 32);
      for (var y = 0; y < gradient.height; y++) {
        for (var x = 0; x < gradient.width; x++) {
          final tone = ((x / (gradient.width - 1)) * 255).round();
          gradient.setPixelRgb(x, y, tone, tone, tone);
        }
      }

      final ditheredManifestPath = await _writeCustomImageManifest(
        tempDir,
        image: gradient,
        manifestFileName: 'manifest-dithered.json',
        pageFileName: 'page-dithered.png',
      );
      final thresholdManifestPath = await _writeCustomImageManifest(
        tempDir,
        image: gradient,
        manifestFileName: 'manifest-threshold.json',
        pageFileName: 'page-threshold.png',
      );

      final printer = _buildPrinter(
        connectionType: PrinterConnectionType.usbRawEscPos,
        systemQueueName: 'Raw USB Queue',
        usbEncoding: 'UTF-8',
      );

      await service.execute(
        job: _buildJob(
          artifactPath: ditheredManifestPath,
          copies: 1,
          contentType: 'pdf',
          optionsJson: jsonEncode(<String, Object?>{
            'paperSize': '80mm',
            'thermalDithering': true,
          }),
        ),
        printer: printer,
      );
      final ditheredBytes = rawTransport.usbSends.last.bytes;

      await service.execute(
        job: _buildJob(
          artifactPath: thresholdManifestPath,
          copies: 1,
          contentType: 'pdf',
          optionsJson: jsonEncode(<String, Object?>{
            'paperSize': '80mm',
            'thermalDithering': false,
          }),
        ),
        printer: printer,
      );
      final thresholdBytes = rawTransport.usbSends.last.bytes;

      expect(ditheredBytes, isNot(equals(thresholdBytes)));
    },
  );

  test(
    'usb raw esc pos defaults trimWhitespace and thermalDithering to true',
    () async {
      final marginGradient = img.Image(width: 120, height: 40);
      img.fill(marginGradient, color: img.ColorRgb8(255, 255, 255));
      for (var y = 8; y < 32; y++) {
        for (var x = 45; x < 75; x++) {
          final tone = (((x - 45) / 29) * 255).round();
          marginGradient.setPixelRgb(x, y, tone, tone, tone);
        }
      }

      final implicitDefaultManifestPath = await _writeCustomImageManifest(
        tempDir,
        image: marginGradient,
        manifestFileName: 'manifest-defaults.json',
        pageFileName: 'page-defaults.png',
      );
      final explicitTrueManifestPath = await _writeCustomImageManifest(
        tempDir,
        image: marginGradient,
        manifestFileName: 'manifest-explicit-true.json',
        pageFileName: 'page-explicit-true.png',
      );

      final printer = _buildPrinter(
        connectionType: PrinterConnectionType.usbRawEscPos,
        systemQueueName: 'Raw USB Queue',
        usbEncoding: 'UTF-8',
      );

      final implicitResult = await service.execute(
        job: _buildJob(
          artifactPath: implicitDefaultManifestPath,
          copies: 1,
          contentType: 'pdf',
          optionsJson: jsonEncode(<String, Object?>{'paperSize': '80mm'}),
        ),
        printer: printer,
      );
      final implicitBytes = rawTransport.usbSends.last.bytes;

      final explicitResult = await service.execute(
        job: _buildJob(
          artifactPath: explicitTrueManifestPath,
          copies: 1,
          contentType: 'pdf',
          optionsJson: jsonEncode(<String, Object?>{
            'paperSize': '80mm',
            'trimWhitespace': true,
            'thermalDithering': true,
          }),
        ),
        printer: printer,
      );
      final explicitBytes = rawTransport.usbSends.last.bytes;

      expect(implicitResult.appliedOptions['trimWhitespace'], isTrue);
      expect(implicitResult.appliedOptions['thermalDithering'], isTrue);
      expect(explicitResult.appliedOptions['trimWhitespace'], isTrue);
      expect(explicitResult.appliedOptions['thermalDithering'], isTrue);
      expect(implicitBytes, equals(explicitBytes));
    },
  );

  test(
    'capability mismatch fails clearly for incomplete tcp profile',
    () async {
      final manifestPath = await _writeImageManifest(
        tempDir,
        pageNames: const <String>['page-001.png'],
      );
      final job = _buildJob(
        artifactPath: manifestPath,
        copies: 1,
        contentType: 'image',
      );
      final printer = _buildPrinter(
        connectionType: PrinterConnectionType.networkTcp,
        tcpHost: null,
        tcpPort: null,
      );

      await expectLater(
        service.execute(job: job, printer: printer),
        throwsA(
          isA<PrintJobExecutionException>().having(
            (error) => error.message,
            'message',
            contains('tcpHost and tcpPort'),
          ),
        ),
      );
    },
  );
}

PrinterModel _buildPrinter({
  required PrinterConnectionType connectionType,
  String? systemPrinterName,
  String? systemPaperSize,
  String? systemQueueName,
  String? tcpHost,
  int? tcpPort,
  String? tcpEncoding,
  String? tcpLineEnding,
  String? usbEncoding,
  bool usbAutoCutEnabled = false,
  String? usbCutMode,
  bool usbCashDrawerEnabled = false,
  int? usbDrawerPin,
  String? rawGraphicsMode,
}) {
  final now = DateTime(2026, 3, 21, 12);
  return PrinterModel(
    id: 'printer-1',
    uniqueKey: 'printer-1',
    name: 'Printer 1',
    connectionType: connectionType,
    isEnabled: true,
    createdAt: now,
    updatedAt: now,
    systemPrinterName: systemPrinterName,
    systemPaperSize: systemPaperSize,
    systemQueueName: systemQueueName,
    tcpHost: tcpHost,
    tcpPort: tcpPort,
    tcpEncoding: tcpEncoding,
    tcpLineEnding: tcpLineEnding,
    usbEncoding: usbEncoding,
    usbAutoCutEnabled: usbAutoCutEnabled,
    usbCutMode: usbCutMode,
    usbCashDrawerEnabled: usbCashDrawerEnabled,
    usbDrawerPin: usbDrawerPin,
    rawGraphicsMode: rawGraphicsMode,
  );
}

PrintJobModel _buildJob({
  required String artifactPath,
  required int copies,
  required String contentType,
  String? optionsJson,
}) {
  final now = DateTime(2026, 3, 21, 12);
  return PrintJobModel(
    id: 'job-1',
    title: 'Job 1',
    status: PrintJobStatus.processing,
    createdAt: now,
    updatedAt: now,
    artifactPath: artifactPath,
    copies: copies,
    contentType: contentType,
    optionsJson: optionsJson,
  );
}

Future<String> _writeTextManifest(Directory tempDir, String text) async {
  final textFile = File('${tempDir.path}/document.txt');
  await textFile.writeAsString(text, flush: true);
  final manifestFile = File('${tempDir.path}/manifest.json');
  await manifestFile.writeAsString(
    jsonEncode(
      const PrintDocumentArtifactManifest(
        kind: PrintDocumentKind.text,
        sourceContentType: 'text',
        pageCount: 1,
        textPath: 'document.txt',
      ).toJson(),
    ).replaceFirst('"document.txt"', '"${textFile.path}"'),
    flush: true,
  );
  return manifestFile.path;
}

Future<String> _writeImageManifest(
  Directory tempDir, {
  required List<String> pageNames,
  String sourceContentType = 'pdf',
  String? sourceFileName,
}) async {
  final pagePaths = <String>[];
  for (final pageName in pageNames) {
    final file = File('${tempDir.path}/$pageName');
    final width = pageName.endsWith('1.png') ? 12 : 24;
    final image = img.Image(width: width, height: 16);
    await file.writeAsBytes(img.encodePng(image), flush: true);
    pagePaths.add(file.path);
  }
  String? sourcePath;
  if (sourceFileName != null) {
    final sourceFile = File('${tempDir.path}/$sourceFileName');
    final sourceBytes = sourceFileName.endsWith('.pdf')
        ? utf8.encode('%PDF-1.4\n1 0 obj\n<<>>\nendobj\ntrailer\n<<>>\n%%EOF')
        : img.encodeJpg(img.Image(width: 32, height: 16));
    await sourceFile.writeAsBytes(sourceBytes, flush: true);
    sourcePath = sourceFile.path;
  }
  final manifest = PrintDocumentArtifactManifest(
    kind: PrintDocumentKind.imagePages,
    sourceContentType: sourceContentType,
    pageCount: pagePaths.length,
    pagePaths: pagePaths,
    targetWidthPx: 384,
    sourcePath: sourcePath,
  );
  final manifestFile = File('${tempDir.path}/manifest.json');
  await manifestFile.writeAsString(jsonEncode(manifest.toJson()), flush: true);
  return manifestFile.path;
}

Future<String> _writeCustomImageManifest(
  Directory tempDir, {
  required img.Image image,
  String manifestFileName = 'manifest-custom.json',
  String pageFileName = 'page-custom.png',
  String sourceContentType = 'pdf',
}) async {
  final pageFile = File('${tempDir.path}/$pageFileName');
  await pageFile.writeAsBytes(img.encodePng(image), flush: true);
  final manifest = PrintDocumentArtifactManifest(
    kind: PrintDocumentKind.imagePages,
    sourceContentType: sourceContentType,
    pageCount: 1,
    pagePaths: [pageFile.path],
    targetWidthPx: 384,
  );
  final manifestFile = File('${tempDir.path}/$manifestFileName');
  await manifestFile.writeAsString(jsonEncode(manifest.toJson()), flush: true);
  return manifestFile.path;
}

bool _containsSequence(List<int> bytes, List<int> sequence) {
  for (var i = 0; i <= bytes.length - sequence.length; i++) {
    var matches = true;
    for (var j = 0; j < sequence.length; j++) {
      if (bytes[i + j] != sequence[j]) {
        matches = false;
        break;
      }
    }
    if (matches) {
      return true;
    }
  }
  return false;
}
