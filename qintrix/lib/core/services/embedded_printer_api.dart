import 'dart:convert';
import 'dart:io';

import 'package:qintrix/core/services/exports.dart';
import 'package:qintrix/data/models/exports.dart';
import 'package:qintrix/data/repositories/exports.dart';

typedef ServerStateReader = Future<ServerStateModel> Function();

class EmbeddedPrinterApi {
  const EmbeddedPrinterApi({
    required AppAuthorizationService authorizationService,
    required PrintersRepository printersRepository,
    required PrintJobsRepository printJobsRepository,
    required PrintQueueService printQueueService,
    required PrinterConnectionTestService printerConnectionTestService,
    required LoggerService loggerService,
    required PrinterAccessScopeService printerAccessScopeService,
    required ServerStateReader serverStateReader,
  }) : _authorizationService = authorizationService,
       _printersRepository = printersRepository,
       _printJobsRepository = printJobsRepository,
       _printQueueService = printQueueService,
       _printerConnectionTestService = printerConnectionTestService,
       _loggerService = loggerService,
       _printerAccessScopeService = printerAccessScopeService,
       _serverStateReader = serverStateReader;

  final AppAuthorizationService _authorizationService;
  final PrintersRepository _printersRepository;
  final PrintJobsRepository _printJobsRepository;
  final PrintQueueService _printQueueService;
  final PrinterConnectionTestService _printerConnectionTestService;
  final LoggerService _loggerService;
  final PrinterAccessScopeService _printerAccessScopeService;
  final ServerStateReader _serverStateReader;

  Future<void> handle(HttpRequest request) async {
    try {
      _applyCorsHeaders(request.response);
      final pathSegments = request.uri.pathSegments;
      final method = request.method.toUpperCase();

      if (method == 'OPTIONS') {
        request.response.statusCode = HttpStatus.noContent;
        await request.response.close();
        return;
      }

      if (method == 'GET' &&
          pathSegments.length == 1 &&
          pathSegments.first == 'health') {
        await _handleHealth(request);
        return;
      }

      if (method == 'GET' &&
          pathSegments.length == 1 &&
          pathSegments.first == 'favicon.ico') {
        await _handleFavicon(request);
        return;
      }

      final authorization = await _authorize(request);
      if (authorization == null) {
        return;
      }

      if (pathSegments.length == 1 &&
          pathSegments.first == 'printers' &&
          method == 'GET') {
        await _handlePrinters(request, authorization);
        return;
      }

      if (pathSegments.length == 1 &&
          pathSegments.first == 'print-jobs' &&
          method == 'POST') {
        await _handleCreatePrintJob(request, authorization);
        return;
      }

      if (pathSegments.length == 1 &&
          pathSegments.first == 'print-jobs' &&
          method == 'GET') {
        await _handlePrintJobs(request, authorization);
        return;
      }

      if (pathSegments.length == 2 &&
          pathSegments.first == 'printers' &&
          method == 'GET') {
        await _handlePrinterDetails(request, authorization, pathSegments[1]);
        return;
      }

      if (pathSegments.length == 3 &&
          pathSegments.first == 'printers' &&
          pathSegments[2] == 'test' &&
          method == 'POST') {
        await _handlePrinterTest(request, authorization, pathSegments[1]);
        return;
      }

      if (pathSegments.length == 2 &&
          pathSegments.first == 'print-jobs' &&
          method == 'GET') {
        await _handlePrintJobDetails(request, authorization, pathSegments[1]);
        return;
      }

      if (pathSegments.length == 3 &&
          pathSegments.first == 'print-jobs' &&
          pathSegments[2] == 'retry' &&
          method == 'POST') {
        await _handleRetryPrintJob(request, authorization, pathSegments[1]);
        return;
      }

      if (pathSegments.length == 3 &&
          pathSegments.first == 'print-jobs' &&
          pathSegments[2] == 'cancel' &&
          method == 'POST') {
        await _handleCancelPrintJob(request, authorization, pathSegments[1]);
        return;
      }

      if (pathSegments.length == 2 &&
          pathSegments.first == 'queue' &&
          pathSegments[1] == 'status' &&
          method == 'GET') {
        await _handleQueueStatus(request);
        return;
      }

      if (pathSegments.length == 2 &&
          pathSegments.first == 'queue' &&
          pathSegments[1] == 'pause' &&
          method == 'POST') {
        await _printQueueService.pause();
        await _handleQueueStatus(request);
        return;
      }

      if (pathSegments.length == 2 &&
          pathSegments.first == 'queue' &&
          pathSegments[1] == 'resume' &&
          method == 'POST') {
        await _printQueueService.resume();
        await _handleQueueStatus(request);
        return;
      }

      await _writeJson(request.response, HttpStatus.notFound, {
        'error': 'not_found',
      });
    } catch (error) {
      await _writeJson(request.response, HttpStatus.internalServerError, {
        'error': 'internal_server_error',
        'message': error.toString(),
      });
    }
  }

  Future<void> _handleHealth(HttpRequest request) async {
    final state = await _serverStateReader();

    await _writeJson(request.response, HttpStatus.ok, {
      'status': 'ok',
      'server': {
        'isRunning': state.isRunning,
        'host': state.host,
        'port': state.port,
        'startedAt': state.startedAt?.toIso8601String(),
        'lastChangedAt': state.lastChangedAt?.toIso8601String(),
        'lastError': state.lastError,
      },
      'timestamp': DateTime.now().toIso8601String(),
      'app': 'Qintrix Print Agent',
    });
  }

  Future<void> _handleFavicon(HttpRequest request) async {
    request.response.statusCode = HttpStatus.noContent;
    await request.response.close();
  }

  Future<void> _handlePrinters(
    HttpRequest request,
    AppAuthorizationResult authorization,
  ) async {
    final printers = await _printersRepository.getPrinters();
    final visiblePrinters = _printerAccessScopeService.filterPrinters(
      printers,
      authorization,
    );

    await _writeJson(request.response, HttpStatus.ok, {
      'items': visiblePrinters.map(_mapPrinterSummary).toList(growable: false),
    });
  }

  Future<void> _handlePrinterDetails(
    HttpRequest request,
    AppAuthorizationResult authorization,
    String printerId,
  ) async {
    final printers = await _printersRepository.getPrinters();
    final printer = _printerAccessScopeService.findAccessiblePrinter(
      printers,
      authorization,
      printerId,
    );

    if (printer == null) {
      await _writeJson(request.response, HttpStatus.notFound, {
        'error': 'printer_not_found',
      });
      return;
    }

    await _writeJson(
      request.response,
      HttpStatus.ok,
      _mapPrinterDetails(printer),
    );
  }

  Future<void> _handlePrinterTest(
    HttpRequest request,
    AppAuthorizationResult authorization,
    String printerId,
  ) async {
    final printers = await _printersRepository.getPrinters();
    final printer = _printerAccessScopeService.findAccessiblePrinter(
      printers,
      authorization,
      printerId,
    );

    if (printer == null) {
      await _writeJson(request.response, HttpStatus.notFound, {
        'error': 'printer_not_found',
      });
      return;
    }

    final result = await _printerConnectionTestService.testConnection(printer);
    await _loggerService.logPrinterTestResult(
      'API printer test for ${printer.name}: ${result.message}',
    );

    await _writeJson(request.response, HttpStatus.ok, {
      'printerId': printer.id,
      'status': result.status.name,
      'message': result.message,
    });
  }

  Future<void> _handleCreatePrintJob(
    HttpRequest request,
    AppAuthorizationResult authorization,
  ) async {
    final body = await _readJsonBody(request);
    final printerId = (body['printerId'] as String?)?.trim() ?? '';
    final contentType =
        (body['contentType'] as String?)?.trim().toLowerCase() ?? '';
    final copies = (body['copies'] as num?)?.toInt() ?? 1;
    final payload = _readMap(body['payload']);
    final options = _readMap(body['options']);
    final meta = _readMap(body['meta']);
    final idempotencyKey =
        (body['idempotencyKey'] as String?)?.trim() ??
        (body['clientRequestId'] as String?)?.trim();

    if (printerId.isEmpty) {
      await _writeJson(request.response, HttpStatus.badRequest, {
        'error': 'validation_error',
        'message': 'printerId is required.',
      });
      return;
    }

    if (!const {'text', 'pdf', 'image'}.contains(contentType)) {
      await _writeJson(request.response, HttpStatus.badRequest, {
        'error': 'validation_error',
        'message': 'contentType must be text, pdf, or image.',
      });
      return;
    }

    if (copies < 1) {
      await _writeJson(request.response, HttpStatus.badRequest, {
        'error': 'validation_error',
        'message': 'copies must be at least 1.',
      });
      return;
    }

    final printers = await _printersRepository.getPrinters();
    final printer = _printerAccessScopeService.findAccessiblePrinter(
      printers,
      authorization,
      printerId,
    );

    if (printer == null || !printer.isEnabled) {
      await _writeJson(request.response, HttpStatus.notFound, {
        'error': 'printer_not_found',
      });
      return;
    }

    try {
      final job = await _printQueueService.createJob(
        CreatePrintJobRequest(
          app: authorization.app!,
          printer: printer,
          contentType: contentType,
          copies: copies,
          payload: payload,
          options: options,
          meta: meta,
          idempotencyKey: idempotencyKey,
        ),
      );
      await _writeJson(request.response, HttpStatus.accepted, {
        'job': _mapJobDetails(job),
      });
    } on PrintJobRenderException catch (error) {
      await _writeJson(request.response, HttpStatus.badRequest, {
        'error': 'validation_error',
        'message': error.message,
      });
    } catch (error) {
      await _writeJson(request.response, HttpStatus.badRequest, {
        'error': 'job_creation_failed',
        'message': error.toString(),
      });
    }
  }

  Future<void> _handlePrintJobs(
    HttpRequest request,
    AppAuthorizationResult authorization,
  ) async {
    final query = JobsQuery(
      page: int.tryParse(request.uri.queryParameters['page'] ?? '0') ?? 0,
      pageSize:
          int.tryParse(request.uri.queryParameters['perPage'] ?? '10') ?? 10,
      sortBy: request.uri.queryParameters['sortBy'] ?? 'createdAt',
      sortDirection: request.uri.queryParameters['sortDirection'] ?? 'desc',
      status: request.uri.queryParameters['status'] ?? '',
      printerId: request.uri.queryParameters['printerId'] ?? '',
      contentType: request.uri.queryParameters['contentType'] ?? '',
      referenceType: request.uri.queryParameters['referenceType'] ?? '',
      referenceId: request.uri.queryParameters['referenceId'] ?? '',
      search: request.uri.queryParameters['search'] ?? '',
    );

    final result = await _printJobsRepository.queryPrintJobs(query);
    final visible = authorization.allowsAllPrinters
        ? result.items
        : result.items
              .where(
                (job) =>
                    job.printerId == null ||
                    authorization.allowedPrinterIds.contains(job.printerId),
              )
              .toList(growable: false);

    await _writeJson(request.response, HttpStatus.ok, {
      'items': visible.map(_mapJobSummary).toList(growable: false),
      'totalCount': visible.length == result.items.length
          ? result.totalCount
          : visible.length,
      'page': result.page,
      'pageSize': result.pageSize,
    });
  }

  Future<void> _handlePrintJobDetails(
    HttpRequest request,
    AppAuthorizationResult authorization,
    String jobId,
  ) async {
    final job = await _printJobsRepository.getPrintJobById(jobId);
    if (job == null || !_isJobVisible(job, authorization)) {
      await _writeJson(request.response, HttpStatus.notFound, {
        'error': 'job_not_found',
      });
      return;
    }

    await _writeJson(request.response, HttpStatus.ok, {
      'job': _mapJobDetails(job),
    });
  }

  Future<void> _handleRetryPrintJob(
    HttpRequest request,
    AppAuthorizationResult authorization,
    String jobId,
  ) async {
    final job = await _printJobsRepository.getPrintJobById(jobId);
    if (job == null || !_isJobVisible(job, authorization)) {
      await _writeJson(request.response, HttpStatus.notFound, {
        'error': 'job_not_found',
      });
      return;
    }

    try {
      final updated = await _printQueueService.retryJob(jobId);
      await _writeJson(request.response, HttpStatus.ok, {
        'job': _mapJobDetails(updated),
      });
    } catch (error) {
      await _writeJson(request.response, HttpStatus.conflict, {
        'error': 'retry_not_allowed',
        'message': error.toString(),
      });
    }
  }

  Future<void> _handleCancelPrintJob(
    HttpRequest request,
    AppAuthorizationResult authorization,
    String jobId,
  ) async {
    final job = await _printJobsRepository.getPrintJobById(jobId);
    if (job == null || !_isJobVisible(job, authorization)) {
      await _writeJson(request.response, HttpStatus.notFound, {
        'error': 'job_not_found',
      });
      return;
    }

    try {
      final updated = await _printQueueService.cancelJob(jobId);
      await _writeJson(request.response, HttpStatus.ok, {
        'job': _mapJobDetails(updated),
      });
    } catch (error) {
      final statusCode = error.toString().contains('already processing')
          ? HttpStatus.conflict
          : HttpStatus.badRequest;
      await _writeJson(request.response, statusCode, {
        'error': 'cancel_not_allowed',
        'message': error.toString(),
      });
    }
  }

  Future<void> _handleQueueStatus(HttpRequest request) async {
    final status = await _printQueueService.getQueueStatus();
    await _writeJson(request.response, HttpStatus.ok, {
      'state': status.state.name,
      'workers': status.workers
          .map(
            (worker) => {
              'printerId': worker.printerId,
              'state': worker.state.name,
              'activeJobId': worker.activeJobId,
              'errorMessage': worker.errorMessage,
            },
          )
          .toList(growable: false),
    });
  }

  Future<AppAuthorizationResult?> _authorize(HttpRequest request) async {
    final apiKey = request.headers.value('X-API-Key')?.trim() ?? '';
    final authorization = await _authorizationService.authorize(apiKey: apiKey);

    if (authorization.isAllowed) {
      return authorization;
    }

    await _loggerService.logApiAuthFailure(
      'Rejected ${request.method} ${request.uri.path} due to invalid API key.',
    );
    await _writeJson(request.response, HttpStatus.unauthorized, {
      'error': 'unauthorized',
      'message': 'A valid X-API-Key for an enabled app is required.',
    });
    return null;
  }

  Future<Map<String, dynamic>> _readJsonBody(HttpRequest request) async {
    final body = await utf8.decoder.bind(request).join();
    if (body.trim().isEmpty) {
      return <String, dynamic>{};
    }
    final decoded = jsonDecode(body);
    if (decoded is! Map<String, dynamic>) {
      throw const FormatException('Request body must be a JSON object.');
    }
    return decoded;
  }

  Map<String, dynamic> _readMap(Object? value) {
    if (value is Map<String, dynamic>) {
      return value;
    }
    if (value is Map) {
      return value.map((key, entry) => MapEntry(key.toString(), entry));
    }
    return <String, dynamic>{};
  }

  bool _isJobVisible(PrintJobModel job, AppAuthorizationResult authorization) {
    if (authorization.allowsAllPrinters) {
      return true;
    }
    final printerId = job.printerId;
    if (printerId == null) {
      return false;
    }
    return authorization.allowedPrinterIds.contains(printerId);
  }

  Map<String, Object?> _mapPrinterSummary(PrinterModel printer) {
    return {
      'id': printer.id,
      'identifier': printer.uniqueKey,
      'name': printer.name,
      'connectionType': printer.connectionType.value,
      'isEnabled': printer.isEnabled,
      'lastStatus': printer.lastStatus,
      'lastStatusKey': printer.lastStatusKey,
      'lastStatusMessage': printer.lastStatusMessage,
      'updatedAt': printer.updatedAt.toIso8601String(),
    };
  }

  Map<String, Object?> _mapPrinterDetails(PrinterModel printer) {
    return {
      ..._mapPrinterSummary(printer),
      'description': printer.description,
      'createdAt': printer.createdAt.toIso8601String(),
      'connection': {
        'tcpHost': printer.tcpHost,
        'tcpPort': printer.tcpPort,
        'tcpConnectTimeoutMs': printer.tcpConnectTimeoutMs,
        'tcpWriteTimeoutMs': printer.tcpWriteTimeoutMs,
        'tcpReadTimeoutMs': printer.tcpReadTimeoutMs,
        'tcpAutoReconnect': printer.tcpAutoReconnect,
        'tcpReconnectDelayMs': printer.tcpReconnectDelayMs,
        'tcpEncoding': printer.tcpEncoding,
        'tcpCodePage': printer.tcpCodePage,
        'tcpLineEnding': printer.tcpLineEnding,
        'systemPrinterName': printer.systemPrinterName,
        'systemPaperSize': printer.systemPaperSize,
        'systemDefaultCopies': printer.systemDefaultCopies,
        'systemColorEnabled': printer.systemColorEnabled,
        'systemDuplexMode': printer.systemDuplexMode,
        'systemOrientation': printer.systemOrientation,
        'usbVendorId': printer.usbVendorId,
        'usbProductId': printer.usbProductId,
        'usbSerialNumber': printer.usbSerialNumber,
        'rawGraphicsMode': printer.rawGraphicsMode,
      },
    };
  }

  Map<String, Object?> _mapJobSummary(PrintJobModel job) {
    return {
      'id': job.id,
      'printerId': job.printerId,
      'status': job.status.value,
      'contentType': job.contentType,
      'title': job.title,
      'referenceType': job.referenceType,
      'referenceId': job.referenceId,
      'retryCount': job.retryCount,
      'createdAt': job.createdAt.toIso8601String(),
      'updatedAt': job.updatedAt.toIso8601String(),
    };
  }

  Map<String, Object?> _mapJobDetails(PrintJobModel job) {
    final meta = job.metaJson == null ? null : jsonDecode(job.metaJson!);
    final render = meta is Map ? _readMap(meta['render']) : <String, dynamic>{};
    final execution = meta is Map
        ? _readMap(meta['execution'])
        : <String, dynamic>{};
    return {
      ..._mapJobSummary(job),
      'appId': job.appId,
      'copies': job.copies,
      'payloadSourceType': job.payloadSourceType,
      'payloadSummary': job.payloadSummary,
      'artifactPath': job.artifactPath,
      'artifactMimeType': job.artifactMimeType,
      'artifactSize': job.artifactSize,
      'artifactCreatedAt': job.artifactCreatedAt?.toIso8601String(),
      'artifactChecksum': job.artifactChecksum,
      'options': job.optionsJson == null ? null : jsonDecode(job.optionsJson!),
      'meta': meta,
      'documentDeliveryMode':
          execution['documentDeliveryMode'] ?? render['preferredDeliveryMode'],
      'usedFallback': execution['usedFallback'],
      'fallbackReason': execution['fallbackReason'],
      'pdfDiagnostics': render['pdf'],
      'imageDiagnostics': render['image'],
      'source': job.source,
      'idempotencyKey': job.idempotencyKey,
      'failureCategory': job.failureCategory?.value,
      'failureMessage': job.failureMessage,
      'lastRetryAt': job.lastRetryAt?.toIso8601String(),
      'nextRetryAt': job.nextRetryAt?.toIso8601String(),
      'queuedAt': job.queuedAt?.toIso8601String(),
      'startedAt': job.startedAt?.toIso8601String(),
      'completedAt': job.completedAt?.toIso8601String(),
      'canceledAt': job.canceledAt?.toIso8601String(),
    };
  }

  Future<void> _writeJson(
    HttpResponse response,
    int statusCode,
    Map<String, Object?> body,
  ) async {
    _applyCorsHeaders(response);
    response.statusCode = statusCode;
    response.headers.contentType = ContentType.json;
    response.write(jsonEncode(body));
    await response.close();
  }

  void _applyCorsHeaders(HttpResponse response) {
    response.headers
      ..set('Access-Control-Allow-Origin', '*')
      ..set('Access-Control-Allow-Methods', 'GET, POST, OPTIONS')
      ..set('Access-Control-Allow-Headers', 'Content-Type, X-API-Key')
      ..set('Access-Control-Expose-Headers', 'Content-Type')
      ..set('Access-Control-Max-Age', '86400')
      ..set('Vary', 'Origin');
  }
}
