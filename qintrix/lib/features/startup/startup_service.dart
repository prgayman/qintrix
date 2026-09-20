import 'dart:io';

import 'package:qintrix/core/services/exports.dart';
import 'package:qintrix/data/repositories/exports.dart';

abstract class StartupService {
  Future<void> initialize();
}

class AppStartupService implements StartupService {
  AppStartupService({
    required SettingsRepository settingsRepository,
    required ServerRepository serverRepository,
    required PrintQueueService printQueueService,
    required LoggerService loggerService,
    this.launchMode = const AppLaunchMode.standard(),
  }) : _settingsRepository = settingsRepository,
       _serverRepository = serverRepository,
       _printQueueService = printQueueService,
       _loggerService = loggerService;

  final SettingsRepository _settingsRepository;
  final ServerRepository _serverRepository;
  final PrintQueueService _printQueueService;
  final LoggerService _loggerService;
  final AppLaunchMode launchMode;

  @override
  Future<void> initialize() async {
    try {
      await _printQueueService.initialize();
    } catch (error) {
      stderr.writeln('Print queue startup initialization failed: $error');
      await _loggerService.logAppError(
        'Print queue startup initialization failed: $error',
      );
    }

    final settings = await _settingsRepository.loadSettings();

    if (settings.autoStartServer ||
        (launchMode.isBackgroundLaunch && settings.enableBackgroundMode)) {
      try {
        await _serverRepository.startServer();
      } catch (error) {
        await _loggerService.logServerError(
          'Auto-start failed during startup: $error',
        );
      }
    }

    await _loggerService.logAppStart();
  }
}
