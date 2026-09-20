class ApplicationDiagnostics {
  const ApplicationDiagnostics({
    required this.startWithOsRegistered,
    required this.backgroundModeEnabled,
    required this.trayActive,
  });

  final bool startWithOsRegistered;
  final bool backgroundModeEnabled;
  final bool trayActive;
}
