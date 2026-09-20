import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:qintrix/core/services/logger_service.dart';
import 'package:qintrix/data/models/exports.dart';
import 'package:qintrix/data/repositories/exports.dart';
import 'package:uuid/uuid.dart';

import 'print_document_models.dart';
import 'print_job_execution_service.dart';
import 'print_job_render_service.dart';

const _supportedReceiptPaperSizes = <String>{'58mm', '80mm'};

class CreatePrintJobRequest {
  const CreatePrintJobRequest({
    required this.app,
    required this.printer,
    required this.contentType,
    required this.copies,
    required this.payload,
    required this.options,
    required this.meta,
    this.idempotencyKey,
  });

  final AppModel app;
  final PrinterModel printer;
  final String contentType;
  final int copies;
  final Map<String, dynamic> payload;
  final Map<String, dynamic> options;
  final Map<String, dynamic> meta;
  final String? idempotencyKey;
}

abstract class PrintQueueService {
  Future<void> initialize();

  Future<PrintJobModel> createJob(CreatePrintJobRequest request);

  Future<PrintJobModel?> getJobById(String jobId);

  Future<QueueStatusModel> getQueueStatus();

  Future<PrintJobModel> retryJob(String jobId);

  Future<PrintJobModel> cancelJob(String jobId);

  Future<void> pause();

  Future<void> resume();
}

class DesktopPrintQueueService implements PrintQueueService {
  DesktopPrintQueueService({
    required PrintJobsRepository printJobsRepository,
    required PrintersRepository printersRepository,
    required SettingsRepository settingsRepository,
    required LoggerService loggerService,
    required TextRenderService textRenderService,
    required PdfRenderService pdfRenderService,
    required ImageRenderService imageRenderService,
    required PrintJobExecutionService executionService,
  }) : _printJobsRepository = printJobsRepository,
       _printersRepository = printersRepository,
       _settingsRepository = settingsRepository,
       _loggerService = loggerService,
       _textRenderService = textRenderService,
       _pdfRenderService = pdfRenderService,
       _imageRenderService = imageRenderService,
       _executionService = executionService;

  static const _uuid = Uuid();

  final PrintJobsRepository _printJobsRepository;
  final PrintersRepository _printersRepository;
  final SettingsRepository _settingsRepository;
  final LoggerService _loggerService;
  final TextRenderService _textRenderService;
  final PdfRenderService _pdfRenderService;
  final ImageRenderService _imageRenderService;
  final PrintJobExecutionService _executionService;

  QueueRunState _globalState = QueueRunState.running;
  final Map<String, PrinterWorkerStatus> _workers = {};
  final Set<String> _runningPrinters = <String>{};

  @override
  Future<void> initialize() async {
    final settings = await _settingsRepository.loadSettings();
    _globalState = settings.jobsStartPaused
        ? QueueRunState.paused
        : QueueRunState.running;
    await _enforceHistoryRetention(settings);

    final pending = await _printJobsRepository.getPendingPrintJobs();
    for (final job in pending) {
      if (job.printerId == null) {
        continue;
      }
      final normalized = job.status == PrintJobStatus.processing
          ? job.copyWith(
              status: PrintJobStatus.queued,
              clearStartedAt: true,
              updatedAt: DateTime.now(),
            )
          : job;
      if (job.status == PrintJobStatus.processing) {
        await _printJobsRepository.savePrintJob(normalized);
      }
      _markWorker(normalized.printerId!, PrinterWorkerState.idle);
    }

    if (_globalState == QueueRunState.running) {
      for (final job in pending) {
        if (job.printerId != null) {
          unawaited(_processPrinter(job.printerId!));
        }
      }
    }
  }

  @override
  Future<PrintJobModel> createJob(CreatePrintJobRequest request) async {
    final idempotencyKey = request.idempotencyKey?.trim();
    if (idempotencyKey != null && idempotencyKey.isNotEmpty) {
      final existing = await _printJobsRepository.getPrintJobByIdempotencyKey(
        request.app.id,
        idempotencyKey,
      );
      if (existing != null) {
        return existing;
      }
    }

    final now = DateTime.now();
    final title = _buildTitle(request);
    final initialJob = PrintJobModel(
      id: _uuid.v4(),
      appId: request.app.id,
      printerId: request.printer.id,
      title: title,
      status: PrintJobStatus.accepted,
      contentType: request.contentType,
      copies: request.copies,
      payloadSourceType: _resolvePayloadSourceType(request.payload),
      payloadSummary: _buildPayloadSummary(request.payload),
      optionsJson: jsonEncode(request.options),
      metaJson: jsonEncode(request.meta),
      referenceType: request.meta['referenceType'] as String?,
      referenceId: request.meta['referenceId'] as String?,
      source: request.meta['source'] as String?,
      idempotencyKey: idempotencyKey,
      createdAt: now,
      updatedAt: now,
    );
    await _printJobsRepository.savePrintJob(initialJob);
    await _loggerService.logPrintJobCreated(
      'Accepted job ${initialJob.id} for printer ${request.printer.name}.',
    );

    final renderingJob = initialJob.copyWith(
      status: PrintJobStatus.rendering,
      updatedAt: DateTime.now(),
    );
    await _printJobsRepository.savePrintJob(renderingJob);

    try {
      final artifact = await _renderArtifact(initialJob.id, request);
      final queuedAt = DateTime.now();
      final queuedMeta = _withRenderDiagnostics(request.meta, artifact);
      final queuedJob = renderingJob.copyWith(
        status: PrintJobStatus.queued,
        artifactPath: artifact.path,
        artifactMimeType: artifact.mimeType,
        artifactSize: artifact.size,
        artifactCreatedAt: artifact.createdAt,
        artifactChecksum: artifact.checksum,
        metaJson: jsonEncode(queuedMeta),
        queuedAt: queuedAt,
        updatedAt: queuedAt,
      );
      await _printJobsRepository.savePrintJob(queuedJob);
      if (_globalState == QueueRunState.running) {
        unawaited(_processPrinter(request.printer.id));
      } else {
        _markWorker(request.printer.id, PrinterWorkerState.paused);
      }
      return queuedJob;
    } catch (error) {
      final failedJob = renderingJob.copyWith(
        status: PrintJobStatus.failed,
        failureCategory: PrintJobFailureCategory.render,
        failureMessage: error.toString(),
        updatedAt: DateTime.now(),
      );
      await _printJobsRepository.savePrintJob(failedJob);
      await _updatePrinterLastStatus(
        request.printer,
        statusKey: 'render_failure',
        statusMessage: error.toString(),
      );
      await _loggerService.log(
        level: LogLevelType.error,
        eventType: LogEventType.printJobCreated,
        title: 'Print job render failed',
        message: 'Job ${failedJob.id} failed during rendering: $error',
      );
      return failedJob;
    }
  }

  @override
  Future<PrintJobModel?> getJobById(String jobId) {
    return _printJobsRepository.getPrintJobById(jobId);
  }

  @override
  Future<QueueStatusModel> getQueueStatus() async {
    return QueueStatusModel(
      state: _globalState,
      workers: _workers.values.toList(growable: false),
    );
  }

  @override
  Future<PrintJobModel> retryJob(String jobId) async {
    final job = await _requireJob(jobId);
    if (!job.isRetryable) {
      throw StateError('Only failed or canceled jobs can be retried.');
    }

    final now = DateTime.now();
    final hasArtifact = await _hasUsableArtifact(job);
    final updated = hasArtifact
        ? job.copyWith(
            status: PrintJobStatus.retryScheduled,
            nextRetryAt: now,
            lastRetryAt: now,
            retryCount: job.retryCount + 1,
            clearFailureCategory: true,
            clearFailureMessage: true,
            clearCanceledAt: true,
            clearCompletedAt: true,
            clearStartedAt: true,
            updatedAt: now,
          )
        : job.copyWith(
            status: PrintJobStatus.failed,
            failureCategory: PrintJobFailureCategory.render,
            failureMessage:
                'Artifact is missing. Re-submit the original request.',
            updatedAt: now,
          );

    await _printJobsRepository.savePrintJob(updated);
    if (updated.status == PrintJobStatus.retryScheduled &&
        updated.printerId != null &&
        _globalState == QueueRunState.running) {
      unawaited(_processPrinter(updated.printerId!));
    }
    return updated;
  }

  @override
  Future<PrintJobModel> cancelJob(String jobId) async {
    final job = await _requireJob(jobId);
    if (job.status == PrintJobStatus.processing) {
      throw StateError(
        'Job is already processing and cannot be canceled in v1',
      );
    }
    if (!job.isCancelable) {
      throw StateError('Only queued jobs can be canceled.');
    }
    final updated = job.copyWith(
      status: PrintJobStatus.canceled,
      canceledAt: DateTime.now(),
      updatedAt: DateTime.now(),
      clearNextRetryAt: true,
    );
    await _printJobsRepository.savePrintJob(updated);
    await _enforceHistoryRetention();
    return updated;
  }

  @override
  Future<void> pause() async {
    _globalState = QueueRunState.paused;
    for (final printerId in _workers.keys) {
      final worker = _workers[printerId]!;
      if (worker.state != PrinterWorkerState.processing) {
        _workers[printerId] = PrinterWorkerStatus(
          printerId: printerId,
          state: PrinterWorkerState.paused,
          activeJobId: worker.activeJobId,
          errorMessage: worker.errorMessage,
        );
      }
    }
  }

  @override
  Future<void> resume() async {
    _globalState = QueueRunState.running;
    final pending = await _printJobsRepository.getPendingPrintJobs();
    for (final job in pending) {
      if (job.printerId != null) {
        unawaited(_processPrinter(job.printerId!));
      }
    }
  }

  Future<PrintJobArtifact> _renderArtifact(
    String jobId,
    CreatePrintJobRequest request,
  ) {
    final normalizedOptions = _normalizeRenderOptionsForPrinter(
      printer: request.printer,
      contentType: request.contentType,
      rawOptions: request.options,
    );
    final payload = PrintJobRenderPayload(
      contentType: request.contentType,
      payload: request.payload,
      options: normalizedOptions,
    );
    return switch (request.contentType) {
      'text' => _textRenderService.render(jobId: jobId, request: payload),
      'pdf' => _pdfRenderService.render(jobId: jobId, request: payload),
      'image' => _imageRenderService.render(jobId: jobId, request: payload),
      _ => Future.error(
        const PrintJobRenderException('Unsupported contentType.'),
      ),
    };
  }

  Map<String, dynamic> _normalizeRenderOptionsForPrinter({
    required PrinterModel printer,
    required String contentType,
    required Map<String, dynamic> rawOptions,
  }) {
    if (printer.connectionType == PrinterConnectionType.systemSpooler) {
      return rawOptions;
    }

    if (!const {'pdf', 'image', 'text'}.contains(contentType)) {
      return rawOptions;
    }

    final normalized = Map<String, dynamic>.from(rawOptions);
    final requestedPaperSize = (rawOptions['paperSize'] as String?)?.trim();
    final configuredPaperSize = printer.systemPaperSize?.trim();
    final effectivePaperSize =
        _normalizeReceiptPaperSize(requestedPaperSize) ??
        _normalizeReceiptPaperSize(configuredPaperSize) ??
        '80mm';
    normalized['paperSize'] = effectivePaperSize;
    return normalized;
  }

  Future<void> _processPrinter(String printerId) async {
    if (_globalState == QueueRunState.paused ||
        _runningPrinters.contains(printerId)) {
      return;
    }

    _runningPrinters.add(printerId);
    try {
      while (_globalState == QueueRunState.running) {
        final pending = await _nextPendingJobForPrinter(printerId);
        if (pending == null) {
          _markWorker(printerId, PrinterWorkerState.idle);
          break;
        }

        final processingJob = pending.copyWith(
          status: PrintJobStatus.processing,
          startedAt: DateTime.now(),
          updatedAt: DateTime.now(),
          clearFailureCategory: true,
          clearFailureMessage: true,
        );
        await _printJobsRepository.savePrintJob(processingJob);
        _markWorker(
          printerId,
          PrinterWorkerState.processing,
          activeJobId: processingJob.id,
        );

        final printer = await _printersRepository.getPrinterById(printerId);
        if (printer == null || !printer.isEnabled) {
          await _handleExecutionFailure(
            processingJob,
            'Printer is not available.',
            PrintJobFailureCategory.execution,
          );
          continue;
        }

        try {
          final execution = await _executionService.execute(
            job: processingJob,
            printer: printer,
          );
          final completedJob = processingJob.copyWith(
            status: PrintJobStatus.completed,
            completedAt: DateTime.now(),
            metaJson: jsonEncode(
              _withExecutionDiagnostics(processingJob.metaJson, execution),
            ),
            updatedAt: DateTime.now(),
          );
          await _printJobsRepository.savePrintJob(completedJob);
          await _updatePrinterLastStatus(
            printer,
            statusKey: 'print_success',
            statusMessage: 'Job ${completedJob.id} completed.',
          );
          await _enforceHistoryRetention();
        } catch (error) {
          await _handleExecutionFailure(
            processingJob,
            error.toString(),
            PrintJobFailureCategory.execution,
          );
        }
      }
    } finally {
      _runningPrinters.remove(printerId);
      if (_globalState == QueueRunState.paused) {
        _markWorker(printerId, PrinterWorkerState.paused);
      }
    }
  }

  Future<void> _handleExecutionFailure(
    PrintJobModel job,
    String message,
    PrintJobFailureCategory category,
  ) async {
    final settings = await _settingsRepository.loadSettings();
    final canAutoRetry =
        category == PrintJobFailureCategory.execution &&
        job.retryCount < settings.jobsMaxRetryAttempts;
    final now = DateTime.now();

    final updated = canAutoRetry
        ? job.copyWith(
            status: PrintJobStatus.retryScheduled,
            retryCount: job.retryCount + 1,
            lastRetryAt: now,
            nextRetryAt: now.add(
              Duration(seconds: settings.jobsRetryDelaySeconds),
            ),
            failureCategory: category,
            failureMessage: message,
            updatedAt: now,
            clearStartedAt: true,
          )
        : job.copyWith(
            status: PrintJobStatus.failed,
            failureCategory: category,
            failureMessage: message,
            updatedAt: now,
          );
    await _printJobsRepository.savePrintJob(updated);
    if (job.printerId != null) {
      final printer = await _printersRepository.getPrinterById(job.printerId!);
      if (printer != null) {
        await _updatePrinterLastStatus(
          printer,
          statusKey: 'print_failure',
          statusMessage: message,
        );
      }
    }
    if (!canAutoRetry) {
      await _enforceHistoryRetention(settings);
    }
    if (canAutoRetry && updated.printerId != null) {
      Future<void>.delayed(
        Duration(seconds: settings.jobsRetryDelaySeconds),
        () => _processPrinter(updated.printerId!),
      );
    }
  }

  Future<PrintJobModel?> _nextPendingJobForPrinter(String printerId) async {
    final pending = await _printJobsRepository.getPendingPrintJobs();
    final now = DateTime.now();
    for (final job in pending) {
      if (job.printerId != printerId) {
        continue;
      }
      if (job.status == PrintJobStatus.retryScheduled &&
          job.nextRetryAt != null &&
          job.nextRetryAt!.isAfter(now)) {
        continue;
      }
      return job;
    }
    return null;
  }

  Future<PrintJobModel> _requireJob(String jobId) async {
    final job = await _printJobsRepository.getPrintJobById(jobId);
    if (job == null) {
      throw StateError('Print job not found.');
    }
    return job;
  }

  Future<bool> _hasUsableArtifact(PrintJobModel job) async {
    final path = job.artifactPath;
    if (path == null || path.trim().isEmpty) {
      return false;
    }
    return File(path).exists();
  }

  void _markWorker(
    String printerId,
    PrinterWorkerState state, {
    String? activeJobId,
    String? errorMessage,
  }) {
    _workers[printerId] = PrinterWorkerStatus(
      printerId: printerId,
      state: state,
      activeJobId: activeJobId,
      errorMessage: errorMessage,
    );
  }

  String _buildTitle(CreatePrintJobRequest request) {
    final referenceType = request.meta['referenceType'] as String?;
    final referenceId = request.meta['referenceId'] as String?;
    if (referenceType != null && referenceId != null) {
      return '$referenceType:$referenceId';
    }
    return '${request.contentType.toUpperCase()} -> ${request.printer.name}';
  }

  Future<void> _updatePrinterLastStatus(
    PrinterModel printer, {
    required String statusKey,
    required String statusMessage,
  }) async {
    await _printersRepository.savePrinter(
      printer.copyWith(
        lastStatus: statusMessage,
        lastStatusKey: statusKey,
        lastStatusMessage: statusMessage,
        updatedAt: DateTime.now(),
      ),
    );
  }

  String _resolvePayloadSourceType(Map<String, dynamic> payload) {
    final content = (payload['content'] as String?)?.trim();
    if (content == null || content.isEmpty) {
      return 'inline';
    }
    return _looksLikeBase64(content) ? 'base64' : 'inline';
  }

  String _buildPayloadSummary(Map<String, dynamic> payload) {
    final fileName = (payload['fileName'] as String?)?.trim();
    if (fileName != null && fileName.isNotEmpty) {
      return fileName;
    }
    final content = (payload['content'] as String?)?.trim();
    if (content == null || content.isEmpty) {
      return 'payload';
    }
    if (_looksLikeBase64(content)) {
      return 'base64:${content.length}chars';
    }
    return content.length <= 48 ? content : '${content.substring(0, 48)}...';
  }

  Map<String, dynamic> _withRenderDiagnostics(
    Map<String, dynamic> meta,
    PrintJobArtifact artifact,
  ) {
    return {
      ...meta,
      'render': {
        'documentKind': artifact.documentKind.value,
        'pageCount': artifact.pageCount,
        'sourceContentType': artifact.sourceContentType,
        'preferredDeliveryMode': artifact.preferredDeliveryMode?.value,
        if (artifact.pdfDiagnostics != null) 'pdf': artifact.pdfDiagnostics,
        if (artifact.imageDiagnostics != null)
          'image': artifact.imageDiagnostics,
      },
    };
  }

  Map<String, dynamic> _withExecutionDiagnostics(
    String? metaJson,
    PrintExecutionResult execution,
  ) {
    final existing = _decodeJsonMap(metaJson);
    return {...existing, 'execution': execution.toJson()};
  }

  Map<String, dynamic> _decodeJsonMap(String? encoded) {
    if (encoded == null || encoded.trim().isEmpty) {
      return <String, dynamic>{};
    }
    final decoded = jsonDecode(encoded);
    if (decoded is Map<String, dynamic>) {
      return decoded;
    }
    if (decoded is Map) {
      return decoded.map((key, value) => MapEntry(key.toString(), value));
    }
    return <String, dynamic>{};
  }

  bool _looksLikeBase64(String value) {
    if (value.length < 64 || value.length.isOdd) {
      return false;
    }
    return RegExp(r'^[A-Za-z0-9+/=\s]+$').hasMatch(value);
  }

  Future<void> _enforceHistoryRetention([AppSettingsModel? settings]) async {
    final effectiveSettings =
        settings ?? await _settingsRepository.loadSettings();
    final cutoff = DateTime.now().subtract(
      Duration(days: effectiveSettings.jobsHistoryRetentionDays),
    );
    final jobs = await _printJobsRepository.getPrintJobs();
    final expired = jobs
        .where(
          (job) => _isFinalized(job.status) && job.updatedAt.isBefore(cutoff),
        )
        .toList(growable: false);
    if (expired.isEmpty) {
      return;
    }

    await _deleteArtifacts(expired);
    await _printJobsRepository.deletePrintJobs(
      expired.map((job) => job.id).toList(growable: false),
    );
  }

  bool _isFinalized(PrintJobStatus status) {
    return status == PrintJobStatus.completed ||
        status == PrintJobStatus.failed ||
        status == PrintJobStatus.canceled;
  }

  Future<void> _deleteArtifacts(List<PrintJobModel> jobs) async {
    final directories = jobs
        .map((job) => job.artifactPath)
        .whereType<String>()
        .map((path) => File(path).parent.path)
        .toSet();

    for (final directoryPath in directories) {
      final directory = Directory(directoryPath);
      if (await directory.exists()) {
        await directory.delete(recursive: true);
      }
    }
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
