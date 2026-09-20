import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qintrix/app/exports.dart';
import 'package:qintrix/core/services/exports.dart';
import 'package:qintrix/data/database/app_database.dart';
import 'package:qintrix/data/repositories/exports.dart';
import 'package:qintrix/features/startup/exports.dart';
import 'package:window_manager/window_manager.dart';

Future<void> bootstrap([List<String> args = const []]) async {
  WidgetsFlutterBinding.ensureInitialized();
  GoogleFonts.config.allowRuntimeFetching = false;
  final launchMode = AppLaunchMode.fromArgs(args);

  final database = await AppDatabase.create();
  final preferencesService = await AppPreferencesService.create();
  const networkInterfaceService = NetworkInterfaceService();
  const printerConnectionTestService = PrinterConnectionTestService();
  const printerAccessScopeService = PrinterAccessScopeService();
  const serverBindValidationService = ServerBindValidationService();
  final textRenderService = TextRenderService();
  final pdfRenderService = PdfRenderService();
  final imageRenderService = ImageRenderService();
  final printJobExecutionService = PrintJobExecutionService();
  final appLaunchAtStartupService = DesktopAppLaunchAtStartupService();
  final appWindowBehaviorService = DesktopAppWindowBehaviorService();
  final settingsRepository = DriftSettingsRepository(database);
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
  final printQueueService = DesktopPrintQueueService(
    printJobsRepository: printJobsRepository,
    printersRepository: printersRepository,
    settingsRepository: settingsRepository,
    loggerService: loggerService,
    textRenderService: textRenderService,
    pdfRenderService: pdfRenderService,
    imageRenderService: imageRenderService,
    executionService: printJobExecutionService,
  );
  late final ServerRepository serverRepository;
  final embeddedPrinterApi = EmbeddedPrinterApi(
    authorizationService: appAuthorizationService,
    printersRepository: printersRepository,
    printJobsRepository: printJobsRepository,
    printQueueService: printQueueService,
    printerConnectionTestService: printerConnectionTestService,
    loggerService: loggerService,
    printerAccessScopeService: printerAccessScopeService,
    serverStateReader: () => serverRepository.getState(),
  );
  serverRepository = EmbeddedServerRepository(
    settingsRepository: settingsRepository,
    api: embeddedPrinterApi,
    loggerService: loggerService,
  );
  final initialSettings = await settingsRepository.loadSettings();
  await _configureWindow(
    startInBackground:
        launchMode.isBackgroundLaunch && initialSettings.enableBackgroundMode,
  );
  await appWindowBehaviorService.initialize(
    backgroundModeEnabled: initialSettings.enableBackgroundMode,
  );
  try {
    await appLaunchAtStartupService.initialize(
      enabled: initialSettings.startWithOs,
    );
  } catch (error) {
    await loggerService.logAppError(
      'Failed to sync start-with-OS integration: $error',
    );
  }
  final startupService = AppStartupService(
    settingsRepository: settingsRepository,
    serverRepository: serverRepository,
    printQueueService: printQueueService,
    loggerService: loggerService,
    launchMode: launchMode,
  );

  runApp(
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
    ),
  );
}

Future<void> _configureWindow({required bool startInBackground}) async {
  await windowManager.ensureInitialized();

  const initialSize = Size(1180, 760);
  const minimumSize = Size(1180, 760);
  const maximumSize = Size(1180, 760);

  const options = WindowOptions(
    size: initialSize,
    minimumSize: minimumSize,
    maximumSize: maximumSize,
    center: true,
    backgroundColor: Color(0x00000000),
    titleBarStyle: TitleBarStyle.normal,
  );

  await windowManager.waitUntilReadyToShow(options, () async {
    await windowManager.setMinimumSize(minimumSize);
    await windowManager.setMaximumSize(maximumSize);
    await windowManager.setResizable(false);
    await windowManager.setMaximizable(false);
    await windowManager.setSize(initialSize);
    await windowManager.center();
    if (startInBackground) {
      await windowManager.hide();
      return;
    }
    await windowManager.show();
    await windowManager.focus();
  });
}
