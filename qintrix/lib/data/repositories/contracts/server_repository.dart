class ServerStateModel {
  const ServerStateModel({
    required this.isRunning,
    this.host,
    this.port,
    this.startedAt,
    required this.lastChangedAt,
    this.lastError,
  });

  final bool isRunning;
  final String? host;
  final int? port;
  final DateTime? startedAt;
  final DateTime? lastChangedAt;
  final String? lastError;

  ServerStateModel copyWith({
    bool? isRunning,
    String? host,
    int? port,
    DateTime? startedAt,
    DateTime? lastChangedAt,
    String? lastError,
  }) {
    return ServerStateModel(
      isRunning: isRunning ?? this.isRunning,
      host: host ?? this.host,
      port: port ?? this.port,
      startedAt: startedAt ?? this.startedAt,
      lastChangedAt: lastChangedAt ?? this.lastChangedAt,
      lastError: lastError ?? this.lastError,
    );
  }
}

abstract class ServerRepository {
  Future<ServerStateModel> getState();

  Future<void> startServer();

  Future<void> stopServer();

  Future<void> restartServer();
}
