class AppSettingsModel {
  const AppSettingsModel({
    required this.appPort,
    required this.bindHost,
    required this.enableBackgroundMode,
    required this.startWithOs,
    required this.allowLanAccess,
    required this.autoStartServer,
    required this.jobsStartPaused,
    required this.jobsMaxRetryAttempts,
    required this.jobsRetryDelaySeconds,
    required this.jobsHistoryRetentionDays,
    required this.updatedAt,
  });

  final int appPort;
  final String bindHost;
  final bool enableBackgroundMode;
  final bool startWithOs;
  final bool allowLanAccess;
  final bool autoStartServer;
  final bool jobsStartPaused;
  final int jobsMaxRetryAttempts;
  final int jobsRetryDelaySeconds;
  final int jobsHistoryRetentionDays;
  final DateTime updatedAt;

  AppSettingsModel copyWith({
    int? appPort,
    String? bindHost,
    bool? enableBackgroundMode,
    bool? startWithOs,
    bool? allowLanAccess,
    bool? autoStartServer,
    bool? jobsStartPaused,
    int? jobsMaxRetryAttempts,
    int? jobsRetryDelaySeconds,
    int? jobsHistoryRetentionDays,
    DateTime? updatedAt,
  }) {
    return AppSettingsModel(
      appPort: appPort ?? this.appPort,
      bindHost: bindHost ?? this.bindHost,
      enableBackgroundMode: enableBackgroundMode ?? this.enableBackgroundMode,
      startWithOs: startWithOs ?? this.startWithOs,
      allowLanAccess: allowLanAccess ?? this.allowLanAccess,
      autoStartServer: autoStartServer ?? this.autoStartServer,
      jobsStartPaused: jobsStartPaused ?? this.jobsStartPaused,
      jobsMaxRetryAttempts:
          jobsMaxRetryAttempts ?? this.jobsMaxRetryAttempts,
      jobsRetryDelaySeconds:
          jobsRetryDelaySeconds ?? this.jobsRetryDelaySeconds,
      jobsHistoryRetentionDays:
          jobsHistoryRetentionDays ?? this.jobsHistoryRetentionDays,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
