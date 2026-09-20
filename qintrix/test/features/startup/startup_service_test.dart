import 'package:flutter_test/flutter_test.dart';
import 'package:qintrix/core/services/exports.dart';
import 'package:qintrix/data/models/exports.dart';
import 'package:qintrix/data/repositories/exports.dart';
import 'package:qintrix/features/startup/exports.dart';

class _FakeSettingsRepository implements SettingsRepository {
  _FakeSettingsRepository(this.settings);

  final AppSettingsModel settings;

  @override
  Future<AppSettingsModel> loadSettings() async => settings;

  @override
  Future<AppSettingsModel> saveSettings(AppSettingsModel settings) async =>
      settings;
}

class _ThrowingServerRepository implements ServerRepository {
  @override
  Future<ServerStateModel> getState() async =>
      const ServerStateModel(isRunning: false, lastChangedAt: null);

  @override
  Future<void> restartServer() async {}

  @override
  Future<void> startServer() async {
    throw Exception('bind failed');
  }

  @override
  Future<void> stopServer() async {}
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
  test('startup continues when auto-start server fails', () async {
    final logsRepository = _FakeLogsRepository();
    final service = AppStartupService(
      settingsRepository: _FakeSettingsRepository(
        AppSettingsModel(
          appPort: 1432,
          bindHost: '192.0.2.10',
          enableBackgroundMode: false,
          startWithOs: false,
          allowLanAccess: true,
          autoStartServer: true,
          jobsStartPaused: false,
          jobsMaxRetryAttempts: 2,
          jobsRetryDelaySeconds: 30,
          jobsHistoryRetentionDays: 7,
          updatedAt: DateTime(2026, 3, 19),
        ),
      ),
      serverRepository: _ThrowingServerRepository(),
      printQueueService: _NoopPrintQueueService(),
      loggerService: LoggerService(logsRepository),
    );

    await service.initialize();

    expect(logsRepository.logs.any((log) => log.eventType == 'server_error'), isTrue);
    expect(logsRepository.logs.any((log) => log.eventType == 'app_start'), isTrue);
  });
}
