import 'dart:async';
import 'dart:ui';

import 'package:drift/drift.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qintrix/app/exports.dart';
import 'package:qintrix/core/services/exports.dart';
import 'package:qintrix/data/database/app_database.dart';
import 'package:qintrix/data/models/exports.dart';
import 'package:qintrix/data/repositories/exports.dart';
import 'package:qintrix/features/startup/exports.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ControlledStartupService extends StartupService {
  ControlledStartupService(this.completer);

  final Completer<void> completer;

  @override
  Future<void> initialize() => completer.future;
}

Future<void> pumpQintrixApp(
  WidgetTester tester, {
  required StartupService startupService,
  Duration minimumSplashDuration = Duration.zero,
  Map<String, Object> preferenceValues = const {},
  NetworkInterfaceService networkInterfaceService =
      const NetworkInterfaceService(),
  PrinterConnectionTestService printerConnectionTestService =
      const PrinterConnectionTestService(),
  ServerBindValidationService serverBindValidationService =
      const ServerBindValidationService(),
  Future<void> Function(AppDatabase database)? seedDatabase,
}) async {
  TestWidgetsFlutterBinding.ensureInitialized();
  GoogleFonts.config.allowRuntimeFetching = false;
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  SharedPreferences.setMockInitialValues(preferenceValues);
  await tester.binding.setSurfaceSize(const Size(1440, 960));

  final database = AppDatabase.forTest();
  final preferencesService = await AppPreferencesService.create();
  final settingsRepository = DriftSettingsRepository(database);
  final serverRepository = InMemoryServerRepository();
  final appLaunchAtStartupService = _NoopAppLaunchAtStartupService();
  final appWindowBehaviorService = _NoopAppWindowBehaviorService();
  final printersRepository = DriftPrintersRepository(database.printersDao);
  final appsRepository = DriftAppsRepository(
    database.appsDao,
    database.printersDao,
  );
  final appAuthorizationService = AppAuthorizationService(
    repository: appsRepository,
  );
  final printJobsRepository = DriftPrintJobsRepository(database.printJobsDao);
  final logsRepository = DriftLogsRepository(database.logsDao);
  final loggerService = LoggerService(logsRepository);
  final printQueueService = _NoopPrintQueueService();

  if (seedDatabase != null) {
    await seedDatabase(database);
  }

  await tester.pumpWidget(
    QintrixApp(
      startupService: startupService,
      preferencesService: preferencesService,
      networkInterfaceService: networkInterfaceService,
      appLaunchAtStartupService: appLaunchAtStartupService,
      appAuthorizationService: appAuthorizationService,
      appWindowBehaviorService: appWindowBehaviorService,
      printerConnectionTestService: printerConnectionTestService,
      serverBindValidationService: serverBindValidationService,
      printQueueService: printQueueService,
      loggerService: loggerService,
      settingsRepository: settingsRepository,
      serverRepository: serverRepository,
      printersRepository: printersRepository,
      appsRepository: appsRepository,
      printJobsRepository: printJobsRepository,
      logsRepository: logsRepository,
      minimumSplashDuration: minimumSplashDuration,
    ),
  );
}

class _NoopAppLaunchAtStartupService implements AppLaunchAtStartupService {
  @override
  Future<void> initialize({required bool enabled}) async {}

  @override
  Future<bool> isEnabled() async => false;

  @override
  Future<void> setEnabled(bool enabled) async {}
}

class _NoopAppWindowBehaviorService implements AppWindowBehaviorService {
  @override
  Future<void> configureTrayActions({
    required Future<ServerStateModel> Function() readServerState,
    required Future<void> Function() startServer,
    required Future<void> Function() stopServer,
    required Future<void> Function() restartServer,
    required Future<void> Function() openSettings,
    required Future<void> Function() openServerOverview,
  }) async {}

  @override
  Future<void> initialize({required bool backgroundModeEnabled}) async {}

  @override
  Future<AppWindowBehaviorStatus> getStatus() async =>
      const AppWindowBehaviorStatus(
        backgroundModeEnabled: false,
        trayActive: false,
      );

  @override
  Future<void> setBackgroundModeEnabled(bool enabled) async {}
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
