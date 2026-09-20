import 'package:qintrix/data/models/exports.dart';
import 'package:qintrix/data/repositories/exports.dart';

enum ServerStatus { initial, loading, loaded, failure }

enum ServerAction { none, starting, stopping, restarting }

class ServerState {
  const ServerState({
    required this.status,
    required this.serverState,
    required this.settings,
    required this.recentLogs,
    required this.action,
    this.message,
  });

  const ServerState.initial()
    : this(
        status: ServerStatus.initial,
        serverState: const ServerStateModel(isRunning: false, lastChangedAt: null),
        settings: null,
        recentLogs: const <AppLogModel>[],
        action: ServerAction.none,
      );

  final ServerStatus status;
  final ServerStateModel serverState;
  final AppSettingsModel? settings;
  final List<AppLogModel> recentLogs;
  final ServerAction action;
  final String? message;

  ServerState copyWith({
    ServerStatus? status,
    ServerStateModel? serverState,
    AppSettingsModel? settings,
    List<AppLogModel>? recentLogs,
    ServerAction? action,
    String? message,
  }) {
    return ServerState(
      status: status ?? this.status,
      serverState: serverState ?? this.serverState,
      settings: settings ?? this.settings,
      recentLogs: recentLogs ?? this.recentLogs,
      action: action ?? this.action,
      message: message,
    );
  }
}
