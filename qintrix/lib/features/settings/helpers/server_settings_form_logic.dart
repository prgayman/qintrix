import 'package:qintrix/core/services/exports.dart';
import 'package:qintrix/data/models/exports.dart';
import 'package:qintrix/features/settings/models/server_settings_draft.dart';

class ServerLanResolution {
  const ServerLanResolution({required this.draft, this.shouldApplyIp = false});

  final ServerSettingsDraft draft;
  final bool shouldApplyIp;
}

abstract final class ServerSettingsFormLogic {
  static const defaultLocalIp = '127.0.0.1';

  static ServerSettingsDraft hydrate(AppSettingsModel settings) {
    final effectiveBindHost = settings.allowLanAccess
        ? settings.bindHost
        : defaultLocalIp;

    return ServerSettingsDraft.fromSettings(
      settings.copyWith(bindHost: effectiveBindHost),
    );
  }

  static ServerSettingsDraft updatePort(
    ServerSettingsDraft draft,
    String port,
  ) {
    return draft.copyWith(port: port, clearNetworkMessage: true);
  }

  static ServerSettingsDraft updateBindIp(
    ServerSettingsDraft draft,
    String bindIp,
  ) {
    final trimmed = bindIp.trim();
    final hasManualOverride =
        trimmed.isNotEmpty &&
        trimmed != draft.detectedLanIp &&
        trimmed != defaultLocalIp;

    return draft.copyWith(
      bindIp: bindIp,
      hasManualIpOverride: hasManualOverride,
      clearNetworkMessage: true,
    );
  }

  static ServerSettingsDraft updateBooleans(
    ServerSettingsDraft draft, {
    bool? enableBackgroundMode,
    bool? startWithOs,
    bool? autoStartServer,
    bool? jobsStartPaused,
  }) {
    return draft.copyWith(
      enableBackgroundMode: enableBackgroundMode,
      startWithOs: startWithOs,
      autoStartServer: autoStartServer,
      jobsStartPaused: jobsStartPaused,
    );
  }

  static ServerSettingsDraft updateJobsField(
    ServerSettingsDraft draft, {
    String? jobsMaxRetryAttempts,
    String? jobsRetryDelaySeconds,
    String? jobsHistoryRetentionDays,
  }) {
    return draft.copyWith(
      jobsMaxRetryAttempts: jobsMaxRetryAttempts,
      jobsRetryDelaySeconds: jobsRetryDelaySeconds,
      jobsHistoryRetentionDays: jobsHistoryRetentionDays,
    );
  }

  static ServerLanResolution beginLanToggle(
    ServerSettingsDraft draft,
    bool enabled,
  ) {
    if (!enabled) {
      return ServerLanResolution(
        draft: draft.copyWith(
          allowLanAccess: false,
          bindIp: defaultLocalIp,
          isDetectingLanIp: false,
          clearDetectedLanIp: true,
          clearNetworkMessage: true,
          hasManualIpOverride: false,
        ),
      );
    }

    return ServerLanResolution(
      shouldApplyIp: true,
      draft: draft.copyWith(
        allowLanAccess: true,
        isDetectingLanIp: true,
        clearNetworkMessage: true,
      ),
    );
  }

  static ServerSettingsDraft applyDetectedLanIp(
    ServerSettingsDraft draft,
    String detectedLanIp, {
    required String message,
  }) {
    final shouldReplaceCurrent =
        !draft.hasManualIpOverride ||
        draft.bindIp == defaultLocalIp ||
        draft.bindIp == draft.detectedLanIp;

    return draft.copyWith(
      allowLanAccess: true,
      bindIp: shouldReplaceCurrent ? detectedLanIp : draft.bindIp,
      detectedLanIp: detectedLanIp,
      networkMessage: message,
      isDetectingLanIp: false,
      hasManualIpOverride: shouldReplaceCurrent
          ? false
          : draft.hasManualIpOverride,
    );
  }

  static ServerSettingsDraft applyMissingLanIp(
    ServerSettingsDraft draft, {
    required String message,
  }) {
    return draft.copyWith(
      allowLanAccess: true,
      networkMessage: message,
      isDetectingLanIp: false,
      clearDetectedLanIp: true,
    );
  }

  static bool isDirty(
    AppSettingsModel persistedSettings,
    ServerSettingsDraft draft,
  ) {
    final normalizedPort = int.tryParse(draft.port.trim());
    final normalizedIp = draft.bindIp.trim();

    return normalizedPort != persistedSettings.appPort ||
        normalizedIp != persistedSettings.bindHost ||
        draft.enableBackgroundMode != persistedSettings.enableBackgroundMode ||
        draft.startWithOs != persistedSettings.startWithOs ||
        draft.allowLanAccess != persistedSettings.allowLanAccess ||
        draft.autoStartServer != persistedSettings.autoStartServer ||
        draft.jobsStartPaused != persistedSettings.jobsStartPaused ||
        int.tryParse(draft.jobsMaxRetryAttempts.trim()) !=
            persistedSettings.jobsMaxRetryAttempts ||
        int.tryParse(draft.jobsRetryDelaySeconds.trim()) !=
            persistedSettings.jobsRetryDelaySeconds ||
        int.tryParse(draft.jobsHistoryRetentionDays.trim()) !=
            persistedSettings.jobsHistoryRetentionDays;
  }

  static bool isServerDirty(
    AppSettingsModel persistedSettings,
    ServerSettingsDraft draft,
  ) {
    final normalizedPort = int.tryParse(draft.port.trim());
    final normalizedIp = draft.bindIp.trim();

    return normalizedPort != persistedSettings.appPort ||
        normalizedIp != persistedSettings.bindHost ||
        draft.allowLanAccess != persistedSettings.allowLanAccess ||
        draft.autoStartServer != persistedSettings.autoStartServer;
  }

  static bool isApplicationDirty(
    AppSettingsModel persistedSettings,
    ServerSettingsDraft draft,
  ) {
    return draft.enableBackgroundMode != persistedSettings.enableBackgroundMode ||
        draft.startWithOs != persistedSettings.startWithOs;
  }

  static bool isJobsDirty(
    AppSettingsModel persistedSettings,
    ServerSettingsDraft draft,
  ) {
    return draft.jobsStartPaused != persistedSettings.jobsStartPaused ||
        int.tryParse(draft.jobsMaxRetryAttempts.trim()) !=
            persistedSettings.jobsMaxRetryAttempts ||
        int.tryParse(draft.jobsRetryDelaySeconds.trim()) !=
            persistedSettings.jobsRetryDelaySeconds ||
        int.tryParse(draft.jobsHistoryRetentionDays.trim()) !=
            persistedSettings.jobsHistoryRetentionDays;
  }

  static bool hasNetworkBindingChanged(
    AppSettingsModel persistedSettings,
    AppSettingsModel candidateSettings,
  ) {
    final previousHost = persistedSettings.allowLanAccess
        ? persistedSettings.bindHost.trim()
        : defaultLocalIp;
    final nextHost = candidateSettings.allowLanAccess
        ? candidateSettings.bindHost.trim()
        : defaultLocalIp;

    return previousHost != nextHost ||
        persistedSettings.appPort != candidateSettings.appPort;
  }

  static String? validatePort(String? value) {
    final trimmed = value?.trim() ?? '';
    final parsed = int.tryParse(trimmed);

    if (parsed == null || parsed < 1 || parsed > 65535) {
      return 'invalid-port';
    }

    return null;
  }

  static String? validateBindIp(String? value) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty ||
        !NetworkInterfaceService.isValidBindableAddress(trimmed)) {
      return 'invalid-bind-ip';
    }

    return null;
  }

  static AppSettingsModel toSettings(
    AppSettingsModel base,
    ServerSettingsDraft draft,
  ) {
    final effectiveBindHost = draft.allowLanAccess
        ? (draft.bindIp.trim().isEmpty ? base.bindHost : draft.bindIp.trim())
        : defaultLocalIp;

    return base.copyWith(
      appPort: int.tryParse(draft.port.trim()) ?? base.appPort,
      bindHost: effectiveBindHost,
      enableBackgroundMode: draft.enableBackgroundMode,
      startWithOs: draft.startWithOs,
      allowLanAccess: draft.allowLanAccess,
      autoStartServer: draft.autoStartServer,
      jobsStartPaused: draft.jobsStartPaused,
      jobsMaxRetryAttempts:
          int.tryParse(draft.jobsMaxRetryAttempts.trim()) ??
          base.jobsMaxRetryAttempts,
      jobsRetryDelaySeconds:
          int.tryParse(draft.jobsRetryDelaySeconds.trim()) ??
          base.jobsRetryDelaySeconds,
      jobsHistoryRetentionDays:
          int.tryParse(draft.jobsHistoryRetentionDays.trim()) ??
          base.jobsHistoryRetentionDays,
    );
  }

  static String? validatePositiveInteger(String? value) {
    final parsed = int.tryParse((value ?? '').trim());
    if (parsed == null || parsed < 0) {
      return 'invalid-positive-integer';
    }
    return null;
  }
}
