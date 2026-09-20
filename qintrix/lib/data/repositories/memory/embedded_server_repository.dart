import 'dart:async';
import 'dart:io';

import 'package:qintrix/core/services/exports.dart';
import 'package:qintrix/data/models/exports.dart';

import '../contracts/server_repository.dart';
import '../contracts/settings_repository.dart';

class EmbeddedServerRepository implements ServerRepository {
  EmbeddedServerRepository({
    required SettingsRepository settingsRepository,
    required EmbeddedPrinterApi api,
    required LoggerService loggerService,
  }) : _settingsRepository = settingsRepository,
       _api = api,
       _loggerService = loggerService;

  final SettingsRepository _settingsRepository;
  final EmbeddedPrinterApi _api;
  final LoggerService _loggerService;

  HttpServer? _server;
  StreamSubscription<HttpRequest>? _subscription;
  ServerStateModel _state = const ServerStateModel(
    isRunning: false,
    lastChangedAt: null,
  );

  @override
  Future<ServerStateModel> getState() async {
    final settings = await _settingsRepository.loadSettings();
    if (_server == null) {
      return _state.copyWith(
        host: _resolveBindHost(settings),
        port: settings.appPort,
      );
    }

    return _state.copyWith(
      host: _state.host ?? _resolveBindHost(settings),
      port: _state.port ?? settings.appPort,
    );
  }

  @override
  Future<void> startServer() async {
    if (_server != null) {
      return;
    }

    final settings = await _settingsRepository.loadSettings();
    final host = _resolveBindHost(settings);
    final port = settings.appPort;

    try {
      await _startWithoutLogging(settings);
      await _loggerService.logServerStart(
        'Embedded server started on $host:${_server!.port}.',
      );
    } catch (error) {
      _state = ServerStateModel(
        isRunning: false,
        host: host,
        port: port,
        startedAt: null,
        lastChangedAt: DateTime.now(),
        lastError: error.toString(),
      );
      await _loggerService.logServerError(
        'Embedded server failed to start on $host:$port: $error',
      );
      rethrow;
    }
  }

  @override
  Future<void> stopServer() async {
    if (_server == null) {
      _state = _state.copyWith(
        isRunning: false,
        startedAt: null,
        lastChangedAt: DateTime.now(),
      );
      return;
    }

    await _subscription?.cancel();
    await _server?.close(force: true);
    _subscription = null;
    _server = null;

    _state = _state.copyWith(
      isRunning: false,
      startedAt: null,
      lastChangedAt: DateTime.now(),
      lastError: null,
    );

    await _loggerService.logServerStop('Embedded server stopped.');
  }

  @override
  Future<void> restartServer() async {
    final settings = await _settingsRepository.loadSettings();
    final host = _resolveBindHost(settings);
    final port = settings.appPort;

    try {
      await _shutdown(logStop: false);
      await _startWithoutLogging(settings);
      await _loggerService.logServerRestart(
        'Embedded server restarted on $host:${_server!.port}.',
      );
    } catch (error) {
      _state = _state.copyWith(
        isRunning: false,
        startedAt: null,
        host: host,
        port: port,
        lastChangedAt: DateTime.now(),
        lastError: error.toString(),
      );
      await _loggerService.logServerError(
        'Embedded server failed to restart on $host:$port: $error',
      );
      rethrow;
    }
  }

  Future<void> _startWithoutLogging(AppSettingsModel settings) async {
    final host = _resolveBindHost(settings);
    final port = settings.appPort;
    final server = await HttpServer.bind(host, port);

    _subscription = server.listen((request) {
      unawaited(_api.handle(request));
    });
    _server = server;

    final now = DateTime.now();
    _state = ServerStateModel(
      isRunning: true,
      host: host,
      port: server.port,
      startedAt: now,
      lastChangedAt: now,
      lastError: null,
    );
  }

  Future<void> _shutdown({required bool logStop}) async {
    if (_server == null) {
      return;
    }

    await _subscription?.cancel();
    await _server?.close(force: true);
    _subscription = null;
    _server = null;

    _state = _state.copyWith(
      isRunning: false,
      startedAt: null,
      lastChangedAt: DateTime.now(),
      lastError: null,
    );

    if (logStop) {
      await _loggerService.logServerStop('Embedded server stopped.');
    }
  }

  String _resolveBindHost(AppSettingsModel settings) {
    if (!settings.allowLanAccess) {
      return InternetAddress.loopbackIPv4.address;
    }

    final configured = settings.bindHost.trim();
    if (configured.isEmpty) {
      return InternetAddress.loopbackIPv4.address;
    }

    return configured;
  }
}
