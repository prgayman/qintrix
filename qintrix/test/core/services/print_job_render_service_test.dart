import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;
import 'package:qintrix/core/services/print_document_models.dart';
import 'package:qintrix/core/services/print_job_render_service.dart';

import '../../helpers/mock_path_provider.dart';

class _FakePdfPageRasterizer implements PdfPageRasterizer {
  const _FakePdfPageRasterizer(this.pages);

  final List<Uint8List> pages;

  @override
  Future<List<Uint8List>> rasterize({
    required List<int> pdfBytes,
    required int targetWidthPx,
    int? rasterDpi,
  }) async {
    return pages;
  }
}

class _ThrowingPdfPageRasterizer implements PdfPageRasterizer {
  const _ThrowingPdfPageRasterizer(this.message);

  final String message;

  @override
  Future<List<Uint8List>> rasterize({
    required List<int> pdfBytes,
    required int targetWidthPx,
    int? rasterDpi,
  }) async {
    throw Exception(message);
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Directory tempDir;

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp('qintrix-render-test');
    await mockPathProvider(tempDir);
  });

  tearDown(() async {
    await clearMockPathProvider();
    if (await tempDir.exists()) {
      await tempDir.delete(recursive: true);
    }
  });

  test('text renderer requires inline content', () async {
    const service = TextRenderService();

    expect(
      () => service.render(
        jobId: 'job-text-empty',
        request: const PrintJobRenderPayload(
          contentType: 'text',
          payload: <String, dynamic>{},
        ),
      ),
      throwsA(isA<PrintJobRenderException>()),
    );
  });

  test('pdf renderer rejects url payloads', () async {
    final service = PdfRenderService(
      pdfPageRasterizer: const _FakePdfPageRasterizer(<Uint8List>[]),
    );

    await expectLater(
      service.render(
        jobId: 'job-pdf-url',
        request: const PrintJobRenderPayload(
          contentType: 'pdf',
          payload: <String, dynamic>{
            'content': 'cGRm',
            'url': 'https://example.com/file.pdf',
          },
        ),
      ),
      throwsA(isA<PrintJobRenderException>()),
    );
  });

  test('pdf renderer preserves page order in manifest', () async {
    final pageOne = Uint8List.fromList(
      img.encodePng(img.Image(width: 6, height: 6)),
    );
    final pageTwo = Uint8List.fromList(
      img.encodePng(img.Image(width: 10, height: 8)),
    );
    final service = PdfRenderService(
      pdfPageRasterizer: _FakePdfPageRasterizer(<Uint8List>[pageOne, pageTwo]),
    );

    final artifact = await service.render(
      jobId: 'job-pdf-ok',
      request: PrintJobRenderPayload(
        contentType: 'pdf',
        payload: <String, dynamic>{'content': base64Encode(_minimalPdfBytes())},
        options: const <String, dynamic>{'paperSize': 'A4', 'rasterDpi': 200},
      ),
    );

    final manifest = PrintDocumentArtifactManifest.fromJson(
      jsonDecode(await File(artifact.path).readAsString())
          as Map<String, dynamic>,
    );

    expect(manifest.kind, PrintDocumentKind.imagePages);
    expect(manifest.sourceContentType, 'pdf');
    expect(manifest.pageCount, 2);
    expect(manifest.pagePaths[0], contains('page-001.png'));
    expect(manifest.pagePaths[1], contains('page-002.png'));
    expect(manifest.sourcePath, endsWith('source.pdf'));
    expect(File(manifest.sourcePath!).existsSync(), isTrue);
    expect(manifest.preferredDeliveryMode, PrintDocumentDeliveryMode.nativePdf);
    expect(manifest.pdfDiagnostics?['pageCount'], 2);
    expect(manifest.pdfDiagnostics?['rasterDpi'], 200);
  });

  test('pdf renderer rejects corrupt payloads with parse message', () async {
    final service = PdfRenderService(
      pdfPageRasterizer: const _FakePdfPageRasterizer(<Uint8List>[]),
    );

    await expectLater(
      service.render(
        jobId: 'job-pdf-corrupt',
        request: PrintJobRenderPayload(
          contentType: 'pdf',
          payload: <String, dynamic>{
            'content': base64Encode(utf8.encode('not a pdf')),
          },
        ),
      ),
      throwsA(
        isA<PrintJobRenderException>().having(
          (error) => error.message,
          'message',
          contains('not a valid PDF'),
        ),
      ),
    );
  });

  test('pdf renderer rejects encrypted payloads clearly', () async {
    final service = PdfRenderService(
      pdfPageRasterizer: const _ThrowingPdfPageRasterizer(
        'Document is encrypted and requires a password.',
      ),
    );

    await expectLater(
      service.render(
        jobId: 'job-pdf-encrypted',
        request: PrintJobRenderPayload(
          contentType: 'pdf',
          payload: <String, dynamic>{
            'content': base64Encode(_minimalPdfBytes()),
          },
        ),
      ),
      throwsA(
        isA<PrintJobRenderException>().having(
          (error) => error.message,
          'message',
          contains('Protected PDF is not supported'),
        ),
      ),
    );
  });

  test('pdf renderer rejects zero-page payloads clearly', () async {
    final service = PdfRenderService(
      pdfPageRasterizer: const _FakePdfPageRasterizer(<Uint8List>[]),
    );

    await expectLater(
      service.render(
        jobId: 'job-pdf-zero',
        request: PrintJobRenderPayload(
          contentType: 'pdf',
          payload: <String, dynamic>{
            'content': base64Encode(_zeroPagePdfBytes()),
          },
        ),
      ),
      throwsA(
        isA<PrintJobRenderException>().having(
          (error) => error.message,
          'message',
          contains('did not produce any printable pages'),
        ),
      ),
    );
  });

  test(
    'image renderer requires base64 and normalizes to png manifest',
    () async {
      final imageBytes = img.encodeJpg(img.Image(width: 640, height: 120));
      const service = ImageRenderService();

      final artifact = await service.render(
        jobId: 'job-image-ok',
        request: PrintJobRenderPayload(
          contentType: 'image',
          payload: <String, dynamic>{
            'content': base64Encode(imageBytes),
            'mimeType': 'image/jpeg',
          },
          options: const <String, dynamic>{'paperSize': '80mm'},
        ),
      );

      final manifest = PrintDocumentArtifactManifest.fromJson(
        jsonDecode(await File(artifact.path).readAsString())
            as Map<String, dynamic>,
      );

      expect(manifest.kind, PrintDocumentKind.imagePages);
      expect(manifest.pageCount, 1);
      expect(manifest.pagePaths.single, endsWith('.png'));
      expect(File(manifest.pagePaths.single).existsSync(), isTrue);
      expect(manifest.sourcePath, endsWith('.jpg'));
      expect(File(manifest.sourcePath!).existsSync(), isTrue);
      final normalized = img.decodeImage(
        await File(manifest.pagePaths.single).readAsBytes(),
      )!;
      expect(normalized.width, 640);
      expect(normalized.height, 120);
      expect(manifest.imageDiagnostics?['originalWidth'], 640);
      expect(manifest.imageDiagnostics?['normalizedWidth'], 640);
      expect(manifest.imageDiagnostics?['targetWidthPx'], 576);
    },
  );
}

List<int> _minimalPdfBytes() {
  return utf8.encode(
    '%PDF-1.4\n'
    '1 0 obj\n<< /Type /Catalog /Pages 2 0 R >>\nendobj\n'
    '2 0 obj\n<< /Type /Pages /Kids [3 0 R] /Count 1 >>\nendobj\n'
    '3 0 obj\n<< /Type /Page /Parent 2 0 R >>\nendobj\n'
    'trailer\n<< /Root 1 0 R >>\n'
    '%%EOF',
  );
}

List<int> _zeroPagePdfBytes() {
  return utf8.encode(
    '%PDF-1.4\n'
    '1 0 obj\n<< /Type /Catalog /Pages 2 0 R >>\nendobj\n'
    '2 0 obj\n<< /Type /Pages /Kids [] /Count 0 >>\nendobj\n'
    'trailer\n<< /Root 1 0 R >>\n'
    '%%EOF',
  );
}
