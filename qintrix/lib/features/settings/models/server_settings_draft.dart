import 'package:qintrix/data/models/exports.dart';

class ServerSettingsDraft {
  const ServerSettingsDraft({
    required this.port,
    required this.bindIp,
    required this.enableBackgroundMode,
    required this.startWithOs,
    required this.allowLanAccess,
    required this.autoStartServer,
    required this.jobsStartPaused,
    required this.jobsMaxRetryAttempts,
    required this.jobsRetryDelaySeconds,
    required this.jobsHistoryRetentionDays,
    this.detectedLanIp,
    this.networkMessage,
    this.isDetectingLanIp = false,
    this.hasManualIpOverride = false,
  });

  final String port;
  final String bindIp;
  final bool enableBackgroundMode;
  final bool startWithOs;
  final bool allowLanAccess;
  final bool autoStartServer;
  final bool jobsStartPaused;
  final String jobsMaxRetryAttempts;
  final String jobsRetryDelaySeconds;
  final String jobsHistoryRetentionDays;
  final String? detectedLanIp;
  final String? networkMessage;
  final bool isDetectingLanIp;
  final bool hasManualIpOverride;

  factory ServerSettingsDraft.fromSettings(AppSettingsModel settings) {
    return ServerSettingsDraft(
      port: settings.appPort.toString(),
      bindIp: settings.bindHost,
      enableBackgroundMode: settings.enableBackgroundMode,
      startWithOs: settings.startWithOs,
      allowLanAccess: settings.allowLanAccess,
      autoStartServer: settings.autoStartServer,
      jobsStartPaused: settings.jobsStartPaused,
      jobsMaxRetryAttempts: settings.jobsMaxRetryAttempts.toString(),
      jobsRetryDelaySeconds: settings.jobsRetryDelaySeconds.toString(),
      jobsHistoryRetentionDays: settings.jobsHistoryRetentionDays.toString(),
      hasManualIpOverride: settings.bindHost != '127.0.0.1',
    );
  }

  ServerSettingsDraft copyWith({
    String? port,
    String? bindIp,
    bool? enableBackgroundMode,
    bool? startWithOs,
    bool? allowLanAccess,
    bool? autoStartServer,
    bool? jobsStartPaused,
    String? jobsMaxRetryAttempts,
    String? jobsRetryDelaySeconds,
    String? jobsHistoryRetentionDays,
    String? detectedLanIp,
    bool clearDetectedLanIp = false,
    String? networkMessage,
    bool clearNetworkMessage = false,
    bool? isDetectingLanIp,
    bool? hasManualIpOverride,
  }) {
    return ServerSettingsDraft(
      port: port ?? this.port,
      bindIp: bindIp ?? this.bindIp,
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
      detectedLanIp: clearDetectedLanIp
          ? null
          : detectedLanIp ?? this.detectedLanIp,
      networkMessage: clearNetworkMessage
          ? null
          : networkMessage ?? this.networkMessage,
      isDetectingLanIp: isDetectingLanIp ?? this.isDetectingLanIp,
      hasManualIpOverride: hasManualIpOverride ?? this.hasManualIpOverride,
    );
  }
}
