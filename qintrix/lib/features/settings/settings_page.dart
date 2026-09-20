import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qintrix/app/app_runtime_signals.dart';
import 'package:qintrix/app/exports.dart';
import 'package:qintrix/core/services/exports.dart';
import 'package:qintrix/core/widgets/exports.dart';
import 'package:qintrix/data/models/exports.dart';
import 'package:qintrix/data/repositories/exports.dart';
import 'package:qintrix/features/settings/helpers/server_settings_form_logic.dart';
import 'package:qintrix/features/settings/models/application_diagnostics.dart';
import 'package:qintrix/features/settings/models/server_settings_draft.dart';
import 'package:qintrix/features/settings/models/settings_section.dart';
import 'package:qintrix/features/settings/settings_cubit.dart';
import 'package:qintrix/features/settings/settings_state.dart';
import 'package:qintrix/features/settings/widgets/settings_appearance_section.dart';
import 'package:qintrix/features/settings/widgets/settings_application_section.dart';
import 'package:qintrix/features/settings/widgets/settings_jobs_section.dart';
import 'package:qintrix/features/settings/widgets/settings_language_section.dart';
import 'package:qintrix/features/settings/widgets/settings_panel.dart';
import 'package:qintrix/features/settings/widgets/settings_rail.dart';
import 'package:qintrix/features/settings/widgets/settings_server_section.dart';
import 'package:qintrix/l10n/app_localizations.dart';
import 'package:qintrix/theme/tokens/color_tokens.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  static const routeName = '/settings';

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final GlobalKey<FormState> _serverFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _jobsFormKey = GlobalKey<FormState>();
  final TextEditingController _portController = TextEditingController();
  final TextEditingController _bindIpController = TextEditingController();
  final TextEditingController _jobsMaxRetryAttemptsController =
      TextEditingController();
  final TextEditingController _jobsRetryDelayController =
      TextEditingController();
  final TextEditingController _jobsHistoryRetentionController =
      TextEditingController();
  SettingsSection _selectedSection = SettingsSection.appearance;
  ServerSettingsDraft? _serverDraft;
  String? _lastHydratedRevision;
  AutovalidateMode _serverFormAutovalidateMode = AutovalidateMode.disabled;
  AppFloatingToastData? _feedback;
  Timer? _feedbackTimer;
  ApplicationDiagnostics? _applicationDiagnostics;
  bool _isLoadingApplicationDiagnostics = false;

  @override
  void dispose() {
    _feedbackTimer?.cancel();
    _portController.dispose();
    _bindIpController.dispose();
    _jobsMaxRetryAttemptsController.dispose();
    _jobsRetryDelayController.dispose();
    _jobsHistoryRetentionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final locale = context.watch<LocaleCubit>().state;
    final themeMode = context.watch<ThemeModeCubit>().state;

    return BlocConsumer<SettingsCubit, SettingsState>(
      listenWhen: (previous, current) =>
          previous.settings?.updatedAt != current.settings?.updatedAt,
      listener: (context, state) {
        final settings = state.settings;
        if (settings != null) {
          _hydrateDraft(settings);
        }
      },
      builder: (context, state) {
        if (state.status == SettingsStatus.loading ||
            state.status == SettingsStatus.initial) {
          return AppLoadingView(label: l10n.loading);
        }

        if (state.status == SettingsStatus.failure && state.settings == null) {
          return AppErrorState(
            title: l10n.settingsTitle,
            description: state.message ?? l10n.errorDescription,
          );
        }

        final persistedSettings = state.settings!;
        _ensureHydratedDraft(persistedSettings);
        final serverDraft = _serverDraft!;
        final isServerDirty = ServerSettingsFormLogic.isServerDirty(
          persistedSettings,
          serverDraft,
        );
        final isApplicationDirty = ServerSettingsFormLogic.isApplicationDirty(
          persistedSettings,
          serverDraft,
        );
        final isJobsDirty = ServerSettingsFormLogic.isJobsDirty(
          persistedSettings,
          serverDraft,
        );

        return Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 260,
                        child: SettingsRail(
                          selectedSection: _selectedSection,
                          locale: locale,
                          themeMode: themeMode,
                          onSectionSelected: (section) {
                            setState(() {
                              _selectedSection = section;
                            });
                            if (section == SettingsSection.application) {
                              unawaited(_refreshApplicationDiagnostics());
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: SettingsPanel(
                          child: switch (_selectedSection) {
                            SettingsSection.appearance =>
                              SettingsAppearanceSection(themeMode: themeMode),
                            SettingsSection.language => SettingsLanguageSection(
                              locale: locale,
                            ),
                            SettingsSection.application =>
                              SettingsApplicationSection(
                                draft: serverDraft,
                                isDirty: isApplicationDirty,
                                isSaving: state.status == SettingsStatus.saving,
                                diagnostics: _applicationDiagnostics,
                                isLoadingDiagnostics:
                                    _isLoadingApplicationDiagnostics,
                                onRefreshDiagnostics:
                                    _refreshApplicationDiagnostics,
                                onBackgroundModeChanged: (value) {
                                  _updateServerDraft(
                                    ServerSettingsFormLogic.updateBooleans(
                                      serverDraft,
                                      enableBackgroundMode: value,
                                    ),
                                  );
                                },
                                onStartWithOsChanged: (value) {
                                  _updateServerDraft(
                                    ServerSettingsFormLogic.updateBooleans(
                                      serverDraft,
                                      startWithOs: value,
                                    ),
                                  );
                                },
                                onSave: () => _handleSave(
                                  persistedSettings,
                                  serverDraft,
                                  validateServerForm: false,
                                  validateJobsForm: false,
                                  restartRunningServer: false,
                                ),
                              ),
                            SettingsSection.server => SettingsServerSection(
                              draft: serverDraft,
                              portController: _portController,
                              bindIpController: _bindIpController,
                              formKey: _serverFormKey,
                              autovalidateMode: _serverFormAutovalidateMode,
                              isDirty: isServerDirty,
                              isSaving: state.status == SettingsStatus.saving,
                              onPortChanged: (value) {
                                _updateServerDraft(
                                  ServerSettingsFormLogic.updatePort(
                                    serverDraft,
                                    value,
                                  ),
                                );
                              },
                              onBindIpChanged: (value) {
                                _updateServerDraft(
                                  ServerSettingsFormLogic.updateBindIp(
                                    serverDraft,
                                    value,
                                  ),
                                );
                              },
                              onAllowLanAccessChanged: (value) =>
                                  _handleAllowLanAccessChanged(
                                    value,
                                    serverDraft,
                                  ),
                              onAutoStartServerChanged: (value) {
                                _updateServerDraft(
                                  ServerSettingsFormLogic.updateBooleans(
                                    serverDraft,
                                    autoStartServer: value,
                                  ),
                                );
                              },
                              portValidator: (value) =>
                                  _validatePort(value, l10n),
                              bindIpValidator: (value) =>
                                  _validateBindIp(value, l10n),
                              onSave: () => _handleSave(
                                persistedSettings,
                                serverDraft,
                                validateServerForm: true,
                                validateJobsForm: false,
                                restartRunningServer: true,
                              ),
                            ),
                            SettingsSection.jobs => SettingsJobsSection(
                              draft: serverDraft,
                              retryController: _jobsMaxRetryAttemptsController,
                              retryDelayController: _jobsRetryDelayController,
                              retentionController:
                                  _jobsHistoryRetentionController,
                              formKey: _jobsFormKey,
                              autovalidateMode: _serverFormAutovalidateMode,
                              isDirty: isJobsDirty,
                              isSaving: state.status == SettingsStatus.saving,
                              onJobsStartPausedChanged: (value) {
                                _updateServerDraft(
                                  ServerSettingsFormLogic.updateBooleans(
                                    serverDraft,
                                    jobsStartPaused: value,
                                  ),
                                );
                              },
                              onRetryAttemptsChanged: (value) {
                                _updateServerDraft(
                                  ServerSettingsFormLogic.updateJobsField(
                                    serverDraft,
                                    jobsMaxRetryAttempts: value,
                                  ),
                                );
                              },
                              onRetryDelayChanged: (value) {
                                _updateServerDraft(
                                  ServerSettingsFormLogic.updateJobsField(
                                    serverDraft,
                                    jobsRetryDelaySeconds: value,
                                  ),
                                );
                              },
                              onRetentionChanged: (value) {
                                _updateServerDraft(
                                  ServerSettingsFormLogic.updateJobsField(
                                    serverDraft,
                                    jobsHistoryRetentionDays: value,
                                  ),
                                );
                              },
                              integerValidator: (value) =>
                                  _validatePositiveInteger(value, l10n),
                              onSave: () => _handleSave(
                                persistedSettings,
                                serverDraft,
                                validateServerForm: false,
                                validateJobsForm: true,
                                restartRunningServer: false,
                              ),
                            ),
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned.fill(
              child: SafeArea(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 220),
                  switchInCurve: Curves.easeOutCubic,
                  switchOutCurve: Curves.easeInCubic,
                  transitionBuilder: (child, animation) {
                    final slide = Tween<Offset>(
                      begin: const Offset(0, -0.12),
                      end: Offset.zero,
                    ).animate(animation);
                    return FadeTransition(
                      opacity: animation,
                      child: SlideTransition(position: slide, child: child),
                    );
                  },
                  child: _feedback == null
                      ? const SizedBox.shrink()
                      : AppFloatingToast(
                          key: ValueKey(
                            '${_feedback!.tone.name}-${_feedback!.title}-${_feedback!.message}',
                          ),
                          data: _feedback!,
                        ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _hydrateDraft(AppSettingsModel settings) {
    final revision = settings.updatedAt.toIso8601String();
    if (_lastHydratedRevision == revision) {
      return;
    }

    _serverDraft = ServerSettingsFormLogic.hydrate(settings);
    _lastHydratedRevision = revision;
    _portController.text = _serverDraft!.port;
    _bindIpController.text = _serverDraft!.bindIp;
    _jobsMaxRetryAttemptsController.text = _serverDraft!.jobsMaxRetryAttempts;
    _jobsRetryDelayController.text = _serverDraft!.jobsRetryDelaySeconds;
    _jobsHistoryRetentionController.text =
        _serverDraft!.jobsHistoryRetentionDays;
    if (_selectedSection == SettingsSection.application) {
      unawaited(_refreshApplicationDiagnostics());
    }
  }

  void _ensureHydratedDraft(AppSettingsModel settings) {
    if (_serverDraft == null || _lastHydratedRevision == null) {
      _hydrateDraft(settings);
    }
  }

  void _updateServerDraft(ServerSettingsDraft draft) {
    setState(() {
      _serverDraft = draft;
    });
    if (_portController.text != draft.port) {
      _portController.text = draft.port;
    }
    if (_bindIpController.text != draft.bindIp) {
      _bindIpController.text = draft.bindIp;
    }
    if (_jobsMaxRetryAttemptsController.text != draft.jobsMaxRetryAttempts) {
      _jobsMaxRetryAttemptsController.text = draft.jobsMaxRetryAttempts;
    }
    if (_jobsRetryDelayController.text != draft.jobsRetryDelaySeconds) {
      _jobsRetryDelayController.text = draft.jobsRetryDelaySeconds;
    }
    if (_jobsHistoryRetentionController.text !=
        draft.jobsHistoryRetentionDays) {
      _jobsHistoryRetentionController.text = draft.jobsHistoryRetentionDays;
    }
  }

  Future<void> _handleAllowLanAccessChanged(
    bool enabled,
    ServerSettingsDraft draft,
  ) async {
    final l10n = AppLocalizations.of(context)!;
    final resolution = ServerSettingsFormLogic.beginLanToggle(draft, enabled);
    _updateServerDraft(resolution.draft);

    if (!resolution.shouldApplyIp) {
      return;
    }

    final networkService = context.read<NetworkInterfaceService>();
    final lanIp = await networkService.getPreferredLanIpv4Address();
    if (!mounted) {
      return;
    }

    if (lanIp == null) {
      _updateServerDraft(
        ServerSettingsFormLogic.applyMissingLanIp(
          resolution.draft,
          message: l10n.settingsLanIpUnavailable,
        ),
      );
      return;
    }

    _updateServerDraft(
      ServerSettingsFormLogic.applyDetectedLanIp(
        resolution.draft,
        lanIp,
        message: l10n.settingsLanIpAutofilled,
      ),
    );
  }

  Future<void> _handleSave(
    AppSettingsModel persistedSettings,
    ServerSettingsDraft serverDraft, {
    required bool validateServerForm,
    required bool validateJobsForm,
    required bool restartRunningServer,
  }) async {
    final l10n = AppLocalizations.of(context)!;
    final settingsCubit = context.read<SettingsCubit>();
    final appLaunchAtStartupService = context.read<AppLaunchAtStartupService>();
    final appWindowBehaviorService = context.read<AppWindowBehaviorService>();
    final printQueueService = context.read<PrintQueueService>();
    final bindValidationService = context.read<ServerBindValidationService>();
    final serverRepository = context.read<ServerRepository>();
    final runtimeSignals = context.read<AppRuntimeSignals>();
    if (validateServerForm) {
      final formState = _serverFormKey.currentState;
      if (formState == null || !formState.validate()) {
        setState(() {
          _serverFormAutovalidateMode = AutovalidateMode.always;
        });
        _showFeedback(
          AppFloatingToastData(
            tone: AppStatusTone.warning,
            title: l10n.settingsSaveValidationFailed,
          ),
        );
        return;
      }
    }
    if (validateJobsForm) {
      final formState = _jobsFormKey.currentState;
      if (formState == null || !formState.validate()) {
        _showFeedback(
          AppFloatingToastData(
            tone: AppStatusTone.warning,
            title: l10n.settingsSaveValidationFailed,
          ),
        );
        return;
      }
    }

    final candidateSettings = ServerSettingsFormLogic.toSettings(
      persistedSettings,
      serverDraft,
    );
    if (validateServerForm &&
        ServerSettingsFormLogic.hasNetworkBindingChanged(
          persistedSettings,
          candidateSettings,
        )) {
      final bindValidation = await bindValidationService.validate(
        host: candidateSettings.allowLanAccess
            ? candidateSettings.bindHost
            : ServerSettingsFormLogic.defaultLocalIp,
        port: candidateSettings.appPort,
      );
      if (!mounted) {
        return;
      }
      if (!bindValidation.isValid) {
        setState(() {
          _serverFormAutovalidateMode = AutovalidateMode.always;
        });
        _showFeedback(
          AppFloatingToastData(
            tone: AppStatusTone.error,
            title: l10n.settingsBindValidationFailed,
            message: bindValidation.message,
          ),
        );
        return;
      }
    }

    if (validateServerForm) {
      setState(() {
        _serverFormAutovalidateMode = AutovalidateMode.always;
      });
    }
    var didApplyStartWithOs = false;
    var didApplyBackgroundMode = false;
    try {
      if (!validateServerForm &&
          candidateSettings.startWithOs != persistedSettings.startWithOs) {
        await appLaunchAtStartupService.setEnabled(
          candidateSettings.startWithOs,
        );
        didApplyStartWithOs = true;
      }

      if (!validateServerForm &&
          candidateSettings.enableBackgroundMode !=
              persistedSettings.enableBackgroundMode) {
        await appWindowBehaviorService.setBackgroundModeEnabled(
          candidateSettings.enableBackgroundMode,
        );
        didApplyBackgroundMode = true;
      }

      await settingsCubit.save(candidateSettings);

      if (validateJobsForm &&
          candidateSettings.jobsStartPaused !=
              persistedSettings.jobsStartPaused) {
        if (candidateSettings.jobsStartPaused) {
          await printQueueService.pause();
        } else {
          await printQueueService.resume();
        }
        runtimeSignals.bumpQueue();
      }
      if (!validateServerForm) {
        await _refreshApplicationDiagnostics();
      }
      var didRestart = false;
      if (restartRunningServer) {
        final serverState = await serverRepository.getState();
        if (serverState.isRunning) {
          await serverRepository.restartServer();
          runtimeSignals.bumpServer();
          didRestart = true;
        }
      }
      if (!mounted) {
        return;
      }
      _showFeedback(
        AppFloatingToastData(
          tone: AppStatusTone.success,
          title: didRestart
              ? l10n.settingsSaveAndRestartSuccess
              : l10n.settingsSaveSuccess,
        ),
      );
    } catch (error) {
      if (didApplyStartWithOs) {
        unawaited(
          appLaunchAtStartupService.setEnabled(persistedSettings.startWithOs),
        );
      }
      if (didApplyBackgroundMode) {
        unawaited(
          appWindowBehaviorService.setBackgroundModeEnabled(
            persistedSettings.enableBackgroundMode,
          ),
        );
      }
      if (!mounted) {
        return;
      }
      _showFeedback(
        AppFloatingToastData(
          tone: AppStatusTone.error,
          title: l10n.settingsRestartFailed,
          message: error.toString(),
        ),
      );
    }
  }

  String? _validatePort(String? value, AppLocalizations l10n) {
    return switch (ServerSettingsFormLogic.validatePort(value)) {
      'invalid-port' => l10n.settingsInvalidPort,
      _ => null,
    };
  }

  String? _validateBindIp(String? value, AppLocalizations l10n) {
    return switch (ServerSettingsFormLogic.validateBindIp(value)) {
      'invalid-bind-ip' => l10n.settingsInvalidHost,
      _ => null,
    };
  }

  String? _validatePositiveInteger(String? value, AppLocalizations l10n) {
    return switch (ServerSettingsFormLogic.validatePositiveInteger(value)) {
      'invalid-positive-integer' => l10n.settingsSaveValidationFailed,
      _ => null,
    };
  }

  void _showFeedback(AppFloatingToastData feedback) {
    _feedbackTimer?.cancel();
    setState(() {
      _feedback = feedback;
    });
    _feedbackTimer = Timer(const Duration(seconds: 3), () {
      if (!mounted) {
        return;
      }
      setState(() {
        _feedback = null;
      });
    });
  }

  Future<void> _refreshApplicationDiagnostics() async {
    if (!mounted) {
      return;
    }

    setState(() {
      _isLoadingApplicationDiagnostics = true;
    });

    final appLaunchAtStartupService = context.read<AppLaunchAtStartupService>();
    final appWindowBehaviorService = context.read<AppWindowBehaviorService>();

    try {
      final autostartEnabled = await appLaunchAtStartupService.isEnabled();
      final windowStatus = await appWindowBehaviorService.getStatus();
      if (!mounted) {
        return;
      }
      setState(() {
        _applicationDiagnostics = ApplicationDiagnostics(
          startWithOsRegistered: autostartEnabled,
          backgroundModeEnabled: windowStatus.backgroundModeEnabled,
          trayActive: windowStatus.trayActive,
        );
        _isLoadingApplicationDiagnostics = false;
      });
    } catch (_) {
      if (!mounted) {
        return;
      }
      setState(() {
        _isLoadingApplicationDiagnostics = false;
      });
    }
  }
}
