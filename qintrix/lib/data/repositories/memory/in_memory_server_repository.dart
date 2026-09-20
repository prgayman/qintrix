import '../contracts/server_repository.dart';

class InMemoryServerRepository implements ServerRepository {
  ServerStateModel _state = const ServerStateModel(
    isRunning: false,
    host: '127.0.0.1',
    port: 4000,
    startedAt: null,
    lastChangedAt: null,
  );

  @override
  Future<ServerStateModel> getState() async => _state;

  @override
  Future<void> startServer() async {
    final now = DateTime.now();
    _state = _state.copyWith(
      isRunning: true,
      startedAt: now,
      lastChangedAt: now,
      lastError: null,
    );
  }

  @override
  Future<void> stopServer() async {
    _state = _state.copyWith(
      isRunning: false,
      lastChangedAt: DateTime.now(),
      startedAt: null,
      lastError: null,
    );
  }

  @override
  Future<void> restartServer() async {
    final now = DateTime.now();
    _state = _state.copyWith(
      isRunning: true,
      startedAt: now,
      lastChangedAt: now,
      lastError: null,
    );
  }
}
