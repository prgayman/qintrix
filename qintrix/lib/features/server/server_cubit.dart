import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qintrix/data/models/exports.dart';
import 'package:qintrix/data/repositories/exports.dart';

import 'server_state.dart';

class ServerCubit extends Cubit<ServerState> {
  ServerCubit({
    required ServerRepository serverRepository,
    required SettingsRepository settingsRepository,
    required LogsRepository logsRepository,
  }) : _serverRepository = serverRepository,
       _settingsRepository = settingsRepository,
       _logsRepository = logsRepository,
       super(const ServerState.initial());

  final ServerRepository _serverRepository;
  final SettingsRepository _settingsRepository;
  final LogsRepository _logsRepository;

  static const _recentEventTypes = <String>{
    'server_start',
    'server_stop',
    'server_restart',
    'server_error',
    'api_auth_failure',
    'printer_test_result',
  };

  Future<void> load({bool background = false}) async {
    if (!background || state.settings == null) {
      emit(
        state.copyWith(
          status: ServerStatus.loading,
          action: ServerAction.none,
          message: null,
        ),
      );
    } else {
      emit(state.copyWith(action: ServerAction.none, message: null));
    }

    try {
      final results = await Future.wait<dynamic>([
        _serverRepository.getState(),
        _settingsRepository.loadSettings(),
        _logsRepository.getLogs(limit: 40),
      ]);

      final logs = (results[2] as List<AppLogModel>)
          .where((log) => _recentEventTypes.contains(log.eventType))
          .toList(growable: false);

      emit(
        state.copyWith(
          status: ServerStatus.loaded,
          serverState: results[0] as ServerStateModel,
          settings: results[1] as AppSettingsModel,
          recentLogs: logs,
          action: ServerAction.none,
          message: null,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: ServerStatus.failure,
          action: ServerAction.none,
          message: error.toString(),
        ),
      );
    }
  }

  Future<void> startServer() async {
    await _runAction(ServerAction.starting, _serverRepository.startServer);
  }

  Future<void> stopServer() async {
    await _runAction(ServerAction.stopping, _serverRepository.stopServer);
  }

  Future<void> restartServer() async {
    await _runAction(ServerAction.restarting, _serverRepository.restartServer);
  }

  Future<void> _runAction(
    ServerAction action,
    Future<void> Function() operation,
  ) async {
    emit(state.copyWith(action: action, message: null));
    try {
      await operation();
      await load(background: true);
    } catch (error) {
      emit(
        state.copyWith(
          status: ServerStatus.failure,
          action: ServerAction.none,
          message: error.toString(),
        ),
      );
    }
  }
}
