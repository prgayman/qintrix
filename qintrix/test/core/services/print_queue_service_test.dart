import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:qintrix/core/services/exports.dart';
import 'package:qintrix/data/models/exports.dart';
import 'package:qintrix/data/repositories/exports.dart';

class _FakeSettingsRepository implements SettingsRepository {
  _FakeSettingsRepository(this.settings);

  AppSettingsModel settings;

  @override
  Future<AppSettingsModel> loadSettings() async => settings;

  @override
  Future<AppSettingsModel> saveSettings(AppSettingsModel settings) async {
    this.settings = settings;
    return settings;
  }
}

class _FakeLogsRepository implements LogsRepository {
  final List<AppLogModel> logs = <AppLogModel>[];

  @override
  Future<void> addLog(AppLogModel log) async {
    logs.add(log);
  }

  @override
  Future<List<AppLogModel>> getLogs({int? limit}) async => logs;

  @override
  Future<PagedResult<AppLogModel>> queryLogs(LogsQuery query) async {
    return PagedResult<AppLogModel>(
      items: logs,
      totalCount: logs.length,
      page: query.page,
      pageSize: query.pageSize,
    );
  }
}

class _FakePrintersRepository implements PrintersRepository {
  _FakePrintersRepository(this.printers);

  final Map<String, PrinterModel> printers;

  @override
  Future<void> deletePrinter(String id) async {}

  @override
  Future<void> deletePrinters(List<String> ids) async {}

  @override
  Future<PrinterModel?> getPrinterById(String id) async => printers[id];

  @override
  Future<List<PrinterModel>> getPrinters() async =>
      printers.values.toList(growable: false);

  @override
  Future<PagedResult<PrinterModel>> queryPrinters(PrintersQuery query) async {
    final items = printers.values.toList(growable: false);
    return PagedResult<PrinterModel>(
      items: items,
      totalCount: items.length,
      page: query.page,
      pageSize: query.pageSize,
    );
  }

  @override
  Future<void> savePrinter(PrinterModel printer) async {
    printers[printer.id] = printer;
  }

  @override
  Future<bool> uniqueKeyExists(String uniqueKey, {String? excludingId}) async =>
      false;
}

class _FakePrintJobsRepository implements PrintJobsRepository {
  final Map<String, PrintJobModel> jobs = <String, PrintJobModel>{};

  @override
  Future<void> deletePrintJobs(List<String> ids) async {
    for (final id in ids) {
      jobs.remove(id);
    }
  }

  @override
  Future<PrintJobModel?> getPrintJobById(String id) async => jobs[id];

  @override
  Future<PrintJobModel?> getPrintJobByIdempotencyKey(
    String appId,
    String idempotencyKey,
  ) async {
    for (final job in jobs.values) {
      if (job.appId == appId && job.idempotencyKey == idempotencyKey) {
        return job;
      }
    }
    return null;
  }

  @override
  Future<List<PrintJobModel>> getPendingPrintJobs() async =>
      jobs.values
          .where(
            (job) =>
                job.status == PrintJobStatus.queued ||
                job.status == PrintJobStatus.retryScheduled ||
                job.status == PrintJobStatus.processing,
          )
          .toList(growable: false)
        ..sort((left, right) => left.createdAt.compareTo(right.createdAt));

  @override
  Future<List<PrintJobModel>> getPrintJobs() async =>
      jobs.values.toList(growable: false)
        ..sort((left, right) => right.createdAt.compareTo(left.createdAt));

  @override
  Future<PagedResult<PrintJobModel>> queryPrintJobs(JobsQuery query) async {
    final items = await getPrintJobs();
    return PagedResult<PrintJobModel>(
      items: items,
      totalCount: items.length,
      page: query.page,
      pageSize: query.pageSize,
    );
  }

  @override
  Future<void> savePrintJob(PrintJobModel printJob) async {
    jobs[printJob.id] = printJob;
  }
}

class _SequenceExecutionService extends PrintJobExecutionService {
  _SequenceExecutionService(this.outcomes);

  final List<Object?> outcomes;
  int callCount = 0;

  @override
  Future<PrintExecutionResult> execute({
    required PrintJobModel job,
    required PrinterModel printer,
  }) async {
    final outcome = outcomes[callCount++];
    if (outcome is Exception) {
      throw outcome;
    }
    if (outcome is Error) {
      throw outcome;
    }
    return const PrintExecutionResult(
      executionMode: 'test',
      pageCount: 1,
      appliedOptions: <String, Object?>{},
      ignoredOptions: <String, Object?>{},
      documentDeliveryMode: 'plain_text',
    );
  }
}

class _CapturingPdfRenderService extends PdfRenderService {
  _CapturingPdfRenderService(this.onRender);

  final Future<PrintJobArtifact> Function(
    String jobId,
    PrintJobRenderPayload request,
  ) onRender;

  @override
  Future<PrintJobArtifact> render({
    required String jobId,
    required PrintJobRenderPayload request,
  }) {
    return onRender(jobId, request);
  }
}

void main() {
  late _FakeSettingsRepository settingsRepository;
  late _FakePrintJobsRepository printJobsRepository;
  late _FakePrintersRepository printersRepository;
  late _FakeLogsRepository logsRepository;
  late LoggerService loggerService;
  late PrinterModel printer;

  setUp(() {
    settingsRepository = _FakeSettingsRepository(
      AppSettingsModel(
        appPort: 4880,
        bindHost: '127.0.0.1',
        enableBackgroundMode: true,
        startWithOs: true,
        allowLanAccess: false,
        autoStartServer: true,
        jobsStartPaused: false,
        jobsMaxRetryAttempts: 2,
        jobsRetryDelaySeconds: 1,
        jobsHistoryRetentionDays: 7,
        updatedAt: DateTime(2026, 3, 26, 12),
      ),
    );
    printJobsRepository = _FakePrintJobsRepository();
    printer = PrinterModel(
      id: 'printer-1',
      uniqueKey: 'printer-1',
      name: 'Printer 1',
      connectionType: PrinterConnectionType.systemSpooler,
      isEnabled: true,
      createdAt: DateTime(2026, 3, 26, 12),
      updatedAt: DateTime(2026, 3, 26, 12),
      systemPrinterName: 'Printer 1',
    );
    printersRepository = _FakePrintersRepository({'printer-1': printer});
    logsRepository = _FakeLogsRepository();
    loggerService = LoggerService(logsRepository);
  });

  test(
    'auto retry uses configured retry delay and completes after retry',
    () async {
      final job = _buildJob(
        id: 'job-1',
        printerId: printer.id,
        status: PrintJobStatus.queued,
        retryCount: 0,
      );
      printJobsRepository.jobs[job.id] = job;

      final service = DesktopPrintQueueService(
        printJobsRepository: printJobsRepository,
        printersRepository: printersRepository,
        settingsRepository: settingsRepository,
        loggerService: loggerService,
        textRenderService: const TextRenderService(),
        pdfRenderService: const PdfRenderService(),
        imageRenderService: const ImageRenderService(),
        executionService: _SequenceExecutionService([
          const PrintJobExecutionException('printer offline'),
          null,
        ]),
      );

      await service.initialize();
      await Future<void>.delayed(const Duration(milliseconds: 100));

      final scheduled = printJobsRepository.jobs[job.id]!;
      expect(scheduled.status, PrintJobStatus.retryScheduled);
      expect(scheduled.retryCount, 1);
      expect(scheduled.nextRetryAt, isNotNull);
      expect(
        scheduled.nextRetryAt!.difference(scheduled.lastRetryAt!).inSeconds,
        1,
      );

      await Future<void>.delayed(const Duration(milliseconds: 1200));
      final completed = printJobsRepository.jobs[job.id]!;
      expect(completed.status, PrintJobStatus.completed);
      expect(completed.retryCount, 1);
      expect(
        printersRepository.printers[printer.id]!.lastStatus,
        'Job ${job.id} completed.',
      );
      expect(
        printersRepository.printers[printer.id]!.lastStatusKey,
        'print_success',
      );
      expect(
        printersRepository.printers[printer.id]!.lastStatusMessage,
        'Job ${job.id} completed.',
      );
    },
  );

  test(
    'max retry attempts stops automatic retries after the configured limit',
    () async {
      settingsRepository.settings = settingsRepository.settings.copyWith(
        jobsMaxRetryAttempts: 1,
        jobsRetryDelaySeconds: 0,
      );

      final job = _buildJob(
        id: 'job-2',
        printerId: printer.id,
        status: PrintJobStatus.queued,
        retryCount: 0,
      );
      printJobsRepository.jobs[job.id] = job;

      final service = DesktopPrintQueueService(
        printJobsRepository: printJobsRepository,
        printersRepository: printersRepository,
        settingsRepository: settingsRepository,
        loggerService: loggerService,
        textRenderService: const TextRenderService(),
        pdfRenderService: const PdfRenderService(),
        imageRenderService: const ImageRenderService(),
        executionService: _SequenceExecutionService([
          const PrintJobExecutionException('temporary failure'),
          const PrintJobExecutionException('temporary failure'),
        ]),
      );

      await service.initialize();
      await Future<void>.delayed(const Duration(milliseconds: 200));

      final failed = printJobsRepository.jobs[job.id]!;
      expect(failed.status, PrintJobStatus.failed);
      expect(failed.retryCount, 1);
      expect(failed.failureCategory, PrintJobFailureCategory.execution);
      expect(
        printersRepository.printers[printer.id]!.lastStatus,
        'temporary failure',
      );
      expect(
        printersRepository.printers[printer.id]!.lastStatusKey,
        'print_failure',
      );
      expect(
        printersRepository.printers[printer.id]!.lastStatusMessage,
        'temporary failure',
      );
    },
  );

  test(
    'history retention removes finalized jobs older than the configured cutoff',
    () async {
      settingsRepository.settings = settingsRepository.settings.copyWith(
        jobsHistoryRetentionDays: 7,
      );

      final expiredDir = await Directory.systemTemp.createTemp(
        'qintrix-old-job',
      );
      final expiredManifest = File('${expiredDir.path}/manifest.json');
      await expiredManifest.writeAsString('{}');

      final oldCompleted = _buildJob(
        id: 'job-old',
        printerId: printer.id,
        status: PrintJobStatus.completed,
        artifactPath: expiredManifest.path,
        updatedAt: DateTime.now().subtract(const Duration(days: 8)),
      );
      final recentCompleted = _buildJob(
        id: 'job-recent',
        printerId: printer.id,
        status: PrintJobStatus.completed,
        updatedAt: DateTime.now().subtract(const Duration(days: 2)),
      );
      final queuedOld = _buildJob(
        id: 'job-queued',
        printerId: printer.id,
        status: PrintJobStatus.queued,
        updatedAt: DateTime.now().subtract(const Duration(days: 20)),
      );

      printJobsRepository.jobs[oldCompleted.id] = oldCompleted;
      printJobsRepository.jobs[recentCompleted.id] = recentCompleted;
      printJobsRepository.jobs[queuedOld.id] = queuedOld;

      final service = DesktopPrintQueueService(
        printJobsRepository: printJobsRepository,
        printersRepository: printersRepository,
        settingsRepository: settingsRepository,
        loggerService: loggerService,
        textRenderService: const TextRenderService(),
        pdfRenderService: const PdfRenderService(),
        imageRenderService: const ImageRenderService(),
        executionService: _SequenceExecutionService(const []),
      );

      await service.initialize();

      expect(printJobsRepository.jobs.containsKey(oldCompleted.id), isFalse);
      expect(printJobsRepository.jobs.containsKey(recentCompleted.id), isTrue);
      expect(printJobsRepository.jobs.containsKey(queuedOld.id), isTrue);
      expect(await expiredDir.exists(), isFalse);
    },
  );

  test(
    'raw printer pdf jobs normalize render paper size to receipt width',
    () async {
      final rawPrinter = printer.copyWith(
        connectionType: PrinterConnectionType.usbRawEscPos,
        systemQueueName: 'Raw USB Queue',
        systemPaperSize: 'A4',
      );
      printersRepository.printers[rawPrinter.id] = rawPrinter;

      PrintJobRenderPayload? capturedRequest;
      final service = DesktopPrintQueueService(
        printJobsRepository: printJobsRepository,
        printersRepository: printersRepository,
        settingsRepository: settingsRepository,
        loggerService: loggerService,
        textRenderService: const TextRenderService(),
        pdfRenderService: _CapturingPdfRenderService((jobId, request) async {
          capturedRequest = request;
          final artifactDir = await Directory.systemTemp.createTemp(
            'qintrix-queue-render',
          );
          final manifest = File('${artifactDir.path}/manifest.json');
          await manifest.writeAsString(
            const PrintDocumentArtifactManifest(
              kind: PrintDocumentKind.imagePages,
              sourceContentType: 'pdf',
              pageCount: 1,
              pagePaths: <String>[],
            ).encode(),
          );
          return PrintJobArtifact(
            path: manifest.path,
            mimeType: 'application/vnd.qintrix.print-document+json',
            size: await manifest.length(),
            createdAt: DateTime.now(),
            checksum: 'checksum',
            documentKind: PrintDocumentKind.imagePages,
            pageCount: 1,
            sourceContentType: 'pdf',
          );
        }),
        imageRenderService: const ImageRenderService(),
        executionService: _SequenceExecutionService(const []),
      );

      final app = AppModel(
        id: 'app-1',
        name: 'App 1',
        isEnabled: true,
        apiKey: 'secret',
        allowedPrinterIds: const <String>[],
        allowedPrinterNames: const <String>[],
        createdAt: DateTime(2026, 3, 26, 12),
        updatedAt: DateTime(2026, 3, 26, 12),
      );

      await service.createJob(
        CreatePrintJobRequest(
          app: app,
          printer: rawPrinter,
          contentType: 'pdf',
          copies: 1,
          payload: <String, dynamic>{'content': 'JVBERi0xLjQK'},
          options: <String, dynamic>{'paperSize': 'A4'},
          meta: const <String, dynamic>{},
        ),
      );

      expect(capturedRequest, isNotNull);
      expect(capturedRequest!.options['paperSize'], '80mm');
    },
  );
}

PrintJobModel _buildJob({
  required String id,
  required String printerId,
  required PrintJobStatus status,
  int retryCount = 0,
  String? artifactPath,
  DateTime? updatedAt,
}) {
  final createdAt = DateTime.now().subtract(const Duration(minutes: 5));
  final effectiveUpdatedAt = updatedAt ?? createdAt;
  return PrintJobModel(
    id: id,
    appId: 'app-1',
    printerId: printerId,
    title: 'Job $id',
    status: status,
    contentType: 'text',
    copies: 1,
    retryCount: retryCount,
    artifactPath: artifactPath,
    createdAt: createdAt,
    updatedAt: effectiveUpdatedAt,
    completedAt: status == PrintJobStatus.completed ? effectiveUpdatedAt : null,
  );
}
