import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:image/image.dart' as img;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';

import 'print_document_models.dart';

class PrintJobArtifact {
  const PrintJobArtifact({
    required this.path,
    required this.mimeType,
    required this.size,
    required this.createdAt,
    required this.checksum,
    required this.documentKind,
    required this.pageCount,
    required this.sourceContentType,
    this.preferredDeliveryMode,
    this.pdfDiagnostics,
    this.imageDiagnostics,
  });

  final String path;
  final String mimeType;
  final int size;
  final DateTime createdAt;
  final String checksum;
  final PrintDocumentKind documentKind;
  final int pageCount;
  final String sourceContentType;
  final PrintDocumentDeliveryMode? preferredDeliveryMode;
  final Map<String, Object?>? pdfDiagnostics;
  final Map<String, Object?>? imageDiagnostics;
}

class PrintJobRenderPayload {
  const PrintJobRenderPayload({
    required this.contentType,
    required this.payload,
    this.options = const <String, dynamic>{},
  });

  final String contentType;
  final Map<String, dynamic> payload;
  final Map<String, dynamic> options;
}

class PrintJobRenderException implements Exception {
  const PrintJobRenderException(this.message);

  final String message;

  @override
  String toString() => message;
}

abstract class PrintJobRenderService {
  Future<PrintJobArtifact> render({
    required String jobId,
    required PrintJobRenderPayload request,
  });
}

abstract class PdfPageRasterizer {
  Future<List<Uint8List>> rasterize({
    required List<int> pdfBytes,
    required int targetWidthPx,
    int? rasterDpi,
  });
}

class PrintingPdfPageRasterizer implements PdfPageRasterizer {
  const PrintingPdfPageRasterizer();

  @override
  Future<List<Uint8List>> rasterize({
    required List<int> pdfBytes,
    required int targetWidthPx,
    int? rasterDpi,
  }) async {
    final pages = <Uint8List>[];
    final dpi = rasterDpi ?? math.max(144, (targetWidthPx / 4).round());
    await for (final page in Printing.raster(
      Uint8List.fromList(pdfBytes),
      dpi: dpi.toDouble(),
    )) {
      final png = await page.toPng();
      pages.add(png);
    }
    return pages;
  }
}


class TextRenderService implements PrintJobRenderService {
  static const maxPayloadBytes = 1024 * 1024;

  const TextRenderService();

  @override
  Future<PrintJobArtifact> render({
    required String jobId,
    required PrintJobRenderPayload request,
  }) async {
    final content = (request.payload['content'] as String?) ?? '';
    if (content.trim().isEmpty) {
      throw const PrintJobRenderException('Text payload.content is required.');
    }
    final bytes = utf8.encode(content);
    if (bytes.length > maxPayloadBytes) {
      throw const PrintJobRenderException(
        'Text payload exceeds the 1MB limit.',
      );
    }

    final root = await _jobArtifactsDirectory(jobId);
    final textFile = File(p.join(root.path, 'document.txt'));
    await textFile.writeAsString(content, flush: true);

    final manifest = PrintDocumentArtifactManifest(
      kind: PrintDocumentKind.text,
      sourceContentType: 'text',
      pageCount: 1,
      textPath: textFile.path,
      preferredDeliveryMode: PrintDocumentDeliveryMode.plainText,
    );
    return _writeManifest(jobId: jobId, manifest: manifest);
  }
}

class PdfRenderService implements PrintJobRenderService {
  static const supportedMimeTypes = <String>{'application/pdf'};
  static const maxPayloadBytes = 1024 * 1024 * 10;

  const PdfRenderService({
    PdfPageRasterizer pdfPageRasterizer = const PrintingPdfPageRasterizer(),
  }) : _pdfPageRasterizer = pdfPageRasterizer;

  final PdfPageRasterizer _pdfPageRasterizer;

  @override
  Future<PrintJobArtifact> render({
    required String jobId,
    required PrintJobRenderPayload request,
  }) async {
    if ((request.payload['url'] as String?)?.trim().isNotEmpty == true) {
      throw const PrintJobRenderException(
        'PDF payload.url is not supported. Use base64 payload.content only.',
      );
    }
    final bytes = _resolveBase64Payload(
      request.payload,
      maxBytes: maxPayloadBytes,
      emptyMessage: 'PDF payload.content is required as base64.',
      invalidMessage: 'PDF payload.content must be valid base64.',
    );
    _validatePdfBytes(bytes);

    final targetWidthPx = _paperSizeToWidthPx(
      (request.options['paperSize'] as String?)?.trim(),
    );
    final rasterDpi = _resolvePdfRasterDpi(request.options['rasterDpi']);
    late final List<Uint8List> pages;
    try {
      pages = await _pdfPageRasterizer.rasterize(
        pdfBytes: bytes,
        targetWidthPx: targetWidthPx,
        rasterDpi: rasterDpi,
      );
    } catch (error) {
      final message = error.toString().toLowerCase();
      if (message.contains('encrypt') || message.contains('password')) {
        throw const PrintJobRenderException(
          'Protected PDF is not supported. Remove the password or encryption and try again.',
        );
      }
      throw const PrintJobRenderException(
        'PDF rasterization failed. The document could not be parsed or rendered.',
      );
    }
    if (pages.isEmpty) {
      throw const PrintJobRenderException(
        'PDF rasterization failed. The PDF did not produce any printable pages.',
      );
    }

    final root = await _jobArtifactsDirectory(jobId);
    final sourceFile = File(p.join(root.path, 'source.pdf'));
    await sourceFile.writeAsBytes(bytes, flush: true);

    final pagePaths = <String>[];
    for (var index = 0; index < pages.length; index++) {
      final pageFile = File(
        p.join(root.path, 'page-${(index + 1).toString().padLeft(3, '0')}.png'),
      );
      await pageFile.writeAsBytes(pages[index], flush: true);
      pagePaths.add(pageFile.path);
    }

    final manifest = PrintDocumentArtifactManifest(
      kind: PrintDocumentKind.imagePages,
      sourceContentType: 'pdf',
      pageCount: pagePaths.length,
      pagePaths: pagePaths,
      targetWidthPx: targetWidthPx,
      sourcePath: sourceFile.path,
      preferredDeliveryMode: PrintDocumentDeliveryMode.nativePdf,
      pdfDiagnostics: {'pageCount': pagePaths.length, 'rasterDpi': rasterDpi},
    );
    return _writeManifest(jobId: jobId, manifest: manifest);
  }
}

class ImageRenderService implements PrintJobRenderService {
  static const supportedMimeTypes = <String>{
    'image/png',
    'image/jpeg',
    'image/jpg',
    'image/webp',
  };
  static const maxPayloadBytes = 1024 * 1024 * 10;

  const ImageRenderService();

  @override
  Future<PrintJobArtifact> render({
    required String jobId,
    required PrintJobRenderPayload request,
  }) async {
    if ((request.payload['url'] as String?)?.trim().isNotEmpty == true) {
      throw const PrintJobRenderException(
        'Image payload.url is not supported. Use base64 payload.content only.',
      );
    }
    final bytes = _resolveBase64Payload(
      request.payload,
      maxBytes: maxPayloadBytes,
      emptyMessage: 'Image payload.content is required as base64.',
      invalidMessage: 'Image payload.content must be valid base64.',
    );
    final decoded = img.decodeImage(Uint8List.fromList(bytes));
    if (decoded == null) {
      throw const PrintJobRenderException(
        'Image payload could not be decoded.',
      );
    }

    final targetWidthPx = _paperSizeToWidthPx(
      (request.options['paperSize'] as String?)?.trim(),
    );
    final normalized = Uint8List.fromList(img.encodePng(decoded));

    final root = await _jobArtifactsDirectory(jobId);
    final sourceExtension = _imageMimeTypeToExtension(
      (request.payload['mimeType'] as String?)?.trim(),
    );
    final sourceFile = File(p.join(root.path, 'source.$sourceExtension'));
    await sourceFile.writeAsBytes(bytes, flush: true);
    final imageFile = File(p.join(root.path, 'page-001.png'));
    await imageFile.writeAsBytes(normalized, flush: true);

    final manifest = PrintDocumentArtifactManifest(
      kind: PrintDocumentKind.imagePages,
      sourceContentType: 'image',
      pageCount: 1,
      pagePaths: [imageFile.path],
      targetWidthPx: targetWidthPx,
      sourcePath: sourceFile.path,
      preferredDeliveryMode: PrintDocumentDeliveryMode.nativeSourceImage,
      imageDiagnostics: {
        'originalWidth': decoded.width,
        'originalHeight': decoded.height,
        'normalizedWidth': decoded.width,
        'normalizedHeight': decoded.height,
        'targetWidthPx': targetWidthPx,
      },
    );
    return _writeManifest(jobId: jobId, manifest: manifest);
  }
}

List<int> _resolveBase64Payload(
  Map<String, dynamic> payload, {
  required int maxBytes,
  required String emptyMessage,
  required String invalidMessage,
}) {
  final content = (payload['content'] as String?)?.trim();
  if (content == null || content.isEmpty) {
    throw PrintJobRenderException(emptyMessage);
  }
  late final List<int> bytes;
  try {
    bytes = base64Decode(content);
  } catch (_) {
    throw PrintJobRenderException(invalidMessage);
  }
  if (bytes.length > maxBytes) {
    throw const PrintJobRenderException(
      'Payload exceeds the maximum allowed size.',
    );
  }
  return bytes;
}

String _imageMimeTypeToExtension(String? mimeType) {
  return switch ((mimeType ?? '').toLowerCase()) {
    'image/jpeg' || 'image/jpg' => 'jpg',
    'image/webp' => 'webp',
    _ => 'png',
  };
}

Future<Directory> _jobArtifactsDirectory(String jobId) async {
  final directory = await getApplicationSupportDirectory();
  final artifactsDir = Directory(
    p.join(directory.path, 'print-job-artifacts', jobId),
  );
  await artifactsDir.create(recursive: true);
  return artifactsDir;
}

Future<PrintJobArtifact> _writeManifest({
  required String jobId,
  required PrintDocumentArtifactManifest manifest,
}) async {
  final root = await _jobArtifactsDirectory(jobId);
  final manifestFile = File(p.join(root.path, 'manifest.json'));
  final encoded = utf8.encode(
    const JsonEncoder.withIndent('  ').convert(manifest.toJson()),
  );
  await manifestFile.writeAsBytes(encoded, flush: true);
  final now = DateTime.now();
  return PrintJobArtifact(
    path: manifestFile.path,
    mimeType: 'application/vnd.qintrix.print-document+json',
    size: encoded.length,
    createdAt: now,
    checksum: sha256.convert(encoded).toString(),
    documentKind: manifest.kind,
    pageCount: manifest.pageCount,
    sourceContentType: manifest.sourceContentType,
    preferredDeliveryMode: manifest.preferredDeliveryMode,
    pdfDiagnostics: manifest.pdfDiagnostics,
    imageDiagnostics: manifest.imageDiagnostics,
  );
}

void _validatePdfBytes(List<int> bytes) {
  final content = latin1.decode(bytes, allowInvalid: true);
  final headerWindow = content.length <= 1024
      ? content
      : content.substring(0, 1024);
  if (!headerWindow.contains('%PDF-')) {
    throw const PrintJobRenderException(
      'PDF parsing failed. The payload is not a valid PDF document.',
    );
  }
}

int _resolvePdfRasterDpi(Object? rawValue) {
  final parsed = switch (rawValue) {
    final int value => value,
    final num value => value.toInt(),
    final String value => int.tryParse(value.trim()),
    _ => null,
  };
  if (parsed == null) {
    return 144;
  }
  return parsed.clamp(72, 600);
}

int _paperSizeToWidthPx(String? paperSize) {
  return switch ((paperSize ?? '').toUpperCase()) {
    '58MM' => 384,
    '80MM' => 576,
    'A5' => 874,
    'A4' => 1240,
    'LETTER' => 1224,
    'LEGAL' => 1344,
    _ => 576,
  };
}
