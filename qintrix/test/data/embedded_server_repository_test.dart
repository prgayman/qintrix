import 'dart:convert';
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

class _FakePrintersRepository implements PrintersRepository {
  _FakePrintersRepository(this.printers);

  final List<PrinterModel> printers;

  @override
  Future<void> deletePrinter(String id) async {}

  @override
  Future<void> deletePrinters(List<String> ids) async {}

  @override
  Future<PrinterModel?> getPrinterById(String id) async {
    for (final printer in printers) {
      if (printer.id == id) {
        return printer;
      }
    }

    return null;
  }

  @override
  Future<List<PrinterModel>> getPrinters() async => printers;

  @override
  Future<PagedResult<PrinterModel>> queryPrinters(PrintersQuery query) async {
    return PagedResult<PrinterModel>(
      items: printers,
      totalCount: printers.length,
      page: query.page,
      pageSize: query.pageSize,
    );
  }

  @override
  Future<void> savePrinter(PrinterModel printer) async {}

  @override
  Future<bool> uniqueKeyExists(String uniqueKey, {String? excludingId}) async =>
      false;
}

class _FakeAppsRepository implements AppsRepository {
  _FakeAppsRepository(this.apps);

  final List<AppModel> apps;

  @override
  Future<bool> apiKeyExists(String apiKey, {String? excludingId}) async => false;

  @override
  Future<void> deleteApp(String id) async {}

  @override
  Future<void> deleteApps(List<String> ids) async {}

  @override
  Future<AppModel?> getAppByApiKey(String apiKey) async {
    for (final app in apps) {
      if (app.apiKey == apiKey) {
        return app;
      }
    }

    return null;
  }

  @override
  Future<AppModel?> getAppById(String id) async {
    for (final app in apps) {
      if (app.id == id) {
        return app;
      }
    }

    return null;
  }

  @override
  Future<List<AppModel>> getApps() async => apps;

  @override
  Future<PagedResult<AppModel>> queryApps(AppsQuery query) async {
    return PagedResult<AppModel>(
      items: apps,
      totalCount: apps.length,
      page: query.page,
      pageSize: query.pageSize,
    );
  }

  @override
  Future<void> saveApp(AppModel app) async {}
}

class _FakeLogsRepository implements LogsRepository {
  final List<AppLogModel> logs = <AppLogModel>[];

  @override
  Future<void> addLog(AppLogModel log) async {
    logs.add(log);
  }

  @override
  Future<List<AppLogModel>> getLogs({int? limit}) async => limit == null
      ? List<AppLogModel>.of(logs)
      : logs.take(limit).toList(growable: false);

  @override
  Future<PagedResult<AppLogModel>> queryLogs(LogsQuery query) async {
    return PagedResult<AppLogModel>(
      items: List<AppLogModel>.of(logs),
      totalCount: logs.length,
      page: query.page,
      pageSize: query.pageSize,
    );
  }
}

class _FakePrinterConnectionTestService extends PrinterConnectionTestService {
  const _FakePrinterConnectionTestService(this.result);

  final PrinterConnectionTestResult result;

  @override
  Future<PrinterConnectionTestResult> testConnection(PrinterModel printer) async {
    return result;
  }
}

class _FakePrintJobsRepository implements PrintJobsRepository {
  final Map<String, PrintJobModel> jobs = <String, PrintJobModel>{};

  @override
  Future<List<PrintJobModel>> getPrintJobs() async =>
      jobs.values.toList(growable: false);

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
  Future<List<PrintJobModel>> getPendingPrintJobs() async => jobs.values
      .where(
        (job) => job.status == PrintJobStatus.queued ||
            job.status == PrintJobStatus.retryScheduled ||
            job.status == PrintJobStatus.processing,
      )
      .toList(growable: false);

  @override
  Future<PagedResult<PrintJobModel>> queryPrintJobs(JobsQuery query) async {
    final items = jobs.values.toList(growable: false);
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

  @override
  Future<void> deletePrintJobs(List<String> ids) async {
    for (final id in ids) {
      jobs.remove(id);
    }
  }
}

class _NoopPrintQueueService implements PrintQueueService {
  @override
  Future<PrintJobModel> cancelJob(String jobId) async {
    throw UnimplementedError();
  }

  @override
  Future<PrintJobModel> createJob(CreatePrintJobRequest request) async {
    throw UnimplementedError();
  }

  @override
  Future<PrintJobModel?> getJobById(String jobId) async => null;

  @override
  Future<QueueStatusModel> getQueueStatus() async =>
      const QueueStatusModel(state: QueueRunState.running, workers: []);

  @override
  Future<void> initialize() async {}

  @override
  Future<void> pause() async {}

  @override
  Future<void> resume() async {}

  @override
  Future<PrintJobModel> retryJob(String jobId) async {
    throw UnimplementedError();
  }
}

void main() {
  late _FakeSettingsRepository settingsRepository;
  late _FakePrintersRepository printersRepository;
  late _FakeAppsRepository appsRepository;
  late _FakePrintJobsRepository printJobsRepository;
  late _FakeLogsRepository logsRepository;
  late LoggerService loggerService;
  late EmbeddedServerRepository serverRepository;

  setUp(() {
    settingsRepository = _FakeSettingsRepository(
      AppSettingsModel(
        appPort: 0,
        bindHost: InternetAddress.loopbackIPv4.address,
        enableBackgroundMode: false,
        startWithOs: false,
        allowLanAccess: false,
        autoStartServer: false,
        jobsStartPaused: false,
        jobsMaxRetryAttempts: 2,
        jobsRetryDelaySeconds: 30,
        jobsHistoryRetentionDays: 7,
        updatedAt: DateTime(2026, 3, 19),
      ),
    );
    printersRepository = _FakePrintersRepository([
      PrinterModel(
        id: 'printer-1',
        uniqueKey: 'PRN-111111',
        name: 'Front Desk',
        connectionType: PrinterConnectionType.networkTcp,
        isEnabled: true,
        createdAt: DateTime(2026, 3, 19),
        updatedAt: DateTime(2026, 3, 19),
        tcpHost: '127.0.0.1',
        tcpPort: 9100,
      ),
      PrinterModel(
        id: 'printer-2',
        uniqueKey: 'PRN-222222',
        name: 'Warehouse',
        connectionType: PrinterConnectionType.systemSpooler,
        isEnabled: true,
        createdAt: DateTime(2026, 3, 19),
        updatedAt: DateTime(2026, 3, 19),
        systemPrinterName: 'Warehouse',
      ),
    ]);
    appsRepository = _FakeAppsRepository([
      AppModel(
        id: 'app-1',
        name: 'Local app',
        isEnabled: true,
        apiKey: 'secret',
        allowedPrinterIds: const ['printer-1'],
        allowedPrinterNames: const ['Front Desk'],
        createdAt: DateTime(2026, 3, 19),
        updatedAt: DateTime(2026, 3, 19),
      ),
    ]);
    printJobsRepository = _FakePrintJobsRepository();
    logsRepository = _FakeLogsRepository();
    loggerService = LoggerService(logsRepository);

    late ServerRepository stateReader;
    final api = EmbeddedPrinterApi(
      authorizationService: AppAuthorizationService(
        repository: appsRepository,
      ),
      printersRepository: printersRepository,
      printJobsRepository: printJobsRepository,
      printQueueService: _NoopPrintQueueService(),
      printerConnectionTestService: const _FakePrinterConnectionTestService(
        PrinterConnectionTestResult(
          status: PrinterConnectionTestStatus.success,
          message: 'Connection ok.',
        ),
      ),
      loggerService: loggerService,
      printerAccessScopeService: const PrinterAccessScopeService(),
      serverStateReader: () => stateReader.getState(),
    );
    serverRepository = EmbeddedServerRepository(
      settingsRepository: settingsRepository,
      api: api,
      loggerService: loggerService,
    );
    stateReader = serverRepository;
  });

  tearDown(() async {
    await serverRepository.stopServer();
  });

  test('health endpoint is public', () async {
    await serverRepository.startServer();
    final state = await serverRepository.getState();

    final client = HttpClient();
    final request = await client.get(
      InternetAddress.loopbackIPv4.address,
      state.port!,
      '/health',
    );
    final response = await request.close();
    final body = jsonDecode(await response.transform(utf8.decoder).join())
        as Map<String, dynamic>;

    expect(response.statusCode, HttpStatus.ok);
    expect(body['status'], 'ok');
    expect(response.headers.value('Access-Control-Allow-Origin'), '*');
    client.close();
  });

  test('cors preflight is allowed for api routes', () async {
    await serverRepository.startServer();
    final state = await serverRepository.getState();

    final client = HttpClient();
    final request = await client.open(
      'OPTIONS',
      InternetAddress.loopbackIPv4.address,
      state.port!,
      '/printers',
    );
    request.headers
      ..set('Origin', 'http://localhost:5173')
      ..set('Access-Control-Request-Method', 'GET')
      ..set('Access-Control-Request-Headers', 'X-API-Key');
    final response = await request.close();

    expect(response.statusCode, HttpStatus.noContent);
    expect(response.headers.value('Access-Control-Allow-Origin'), '*');
    expect(
      response.headers.value('Access-Control-Allow-Headers'),
      contains('X-API-Key'),
    );
    client.close();
  });

  test('favicon request is ignored without api auth failure', () async {
    await serverRepository.startServer();
    final state = await serverRepository.getState();

    final client = HttpClient();
    final request = await client.get(
      InternetAddress.loopbackIPv4.address,
      state.port!,
      '/favicon.ico',
    );
    final response = await request.close();

    expect(response.statusCode, HttpStatus.noContent);
    expect(
      logsRepository.logs.any((log) => log.eventType == 'api_auth_failure'),
      isFalse,
    );
    client.close();
  });

  test('printers endpoint is filtered by app printer scope', () async {
    await serverRepository.startServer();
    final state = await serverRepository.getState();

    final client = HttpClient();
    final request = await client.get(
      InternetAddress.loopbackIPv4.address,
      state.port!,
      '/printers',
    );
    request.headers.set('X-API-Key', 'secret');
    final response = await request.close();
    final body = jsonDecode(await response.transform(utf8.decoder).join())
        as Map<String, dynamic>;

    expect(response.statusCode, HttpStatus.ok);
    expect((body['items'] as List).length, 1);
    expect((body['items'] as List).first['id'], 'printer-1');
    client.close();
  });

  test('printer details outside app scope return 404', () async {
    await serverRepository.startServer();
    final state = await serverRepository.getState();

    final client = HttpClient();
    final request = await client.get(
      InternetAddress.loopbackIPv4.address,
      state.port!,
      '/printers/printer-2',
    );
    request.headers.set('X-API-Key', 'secret');
    final response = await request.close();

    expect(response.statusCode, HttpStatus.notFound);
    client.close();
  });

  test('printer test endpoint returns the connection result', () async {
    await serverRepository.startServer();
    final state = await serverRepository.getState();

    final client = HttpClient();
    final request = await client.post(
      InternetAddress.loopbackIPv4.address,
      state.port!,
      '/printers/printer-1/test',
    );
    request.headers.set('X-API-Key', 'secret');
    final response = await request.close();
    final body = jsonDecode(await response.transform(utf8.decoder).join())
        as Map<String, dynamic>;

    expect(response.statusCode, HttpStatus.ok);
    expect(body['status'], 'success');
    expect(logsRepository.logs.any((log) => log.eventType == 'printer_test_result'), isTrue);
    client.close();
  });

  test('print job creation rejects html content type', () async {
    await serverRepository.startServer();
    final state = await serverRepository.getState();

    final client = HttpClient();
    final request = await client.post(
      InternetAddress.loopbackIPv4.address,
      state.port!,
      '/print-jobs',
    );
    request.headers
      ..set('X-API-Key', 'secret')
      ..contentType = ContentType.json;
    request.write(
      jsonEncode(<String, Object?>{
        'printerId': 'printer-1',
        'contentType': 'html',
        'payload': <String, Object?>{'content': '<p>Hello</p>'},
      }),
    );
    final response = await request.close();
    final body = jsonDecode(await response.transform(utf8.decoder).join())
        as Map<String, dynamic>;

    expect(response.statusCode, HttpStatus.badRequest);
    expect(body['error'], 'validation_error');
    expect(body['message'], 'contentType must be text, pdf, or image.');
    client.close();
  });

  test('fails to start when the configured lan host cannot bind', () async {
    settingsRepository.settings = settingsRepository.settings.copyWith(
      allowLanAccess: true,
      bindHost: '192.0.2.10',
    );

    await expectLater(serverRepository.startServer(), throwsA(isA<SocketException>()));
    final state = await serverRepository.getState();

    expect(state.isRunning, isFalse);
    expect(state.host, '192.0.2.10');
    expect(state.lastError, isNotNull);
  });

  test('stopped state reflects updated saved network settings', () async {
    await serverRepository.startServer();
    await serverRepository.stopServer();

    settingsRepository.settings = settingsRepository.settings.copyWith(
      appPort: 4999,
      allowLanAccess: true,
      bindHost: '192.0.2.10',
    );

    final state = await serverRepository.getState();

    expect(state.isRunning, isFalse);
    expect(state.host, '192.0.2.10');
    expect(state.port, 4999);
  });

  test('restart uses the latest saved network settings', () async {
    await serverRepository.startServer();

    settingsRepository.settings = settingsRepository.settings.copyWith(
      appPort: 0,
      bindHost: InternetAddress.loopbackIPv4.address,
      allowLanAccess: false,
    );

    await serverRepository.restartServer();
    final state = await serverRepository.getState();

    expect(state.isRunning, isTrue);
    expect(state.host, InternetAddress.loopbackIPv4.address);
    expect(state.port, isNotNull);
    expect(state.port, isNot(equals(0)));
  });
}
