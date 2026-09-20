enum StartupStatus { initial, loading, ready, failure }

class StartupState {
  const StartupState({required this.status, this.message});

  const StartupState.initial() : this(status: StartupStatus.initial);

  final StartupStatus status;
  final String? message;
}
