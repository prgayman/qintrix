import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:qintrix/app/exports.dart';
import 'package:qintrix/app/app_runtime_signals.dart';
import 'package:qintrix/core/widgets/exports.dart';
import 'package:qintrix/data/repositories/exports.dart';
import 'package:qintrix/l10n/app_localizations.dart';

import 'server_cubit.dart';
import 'server_state.dart';
import 'widgets/server_hero.dart';
import 'widgets/server_operations_section.dart';
import 'widgets/server_reveal.dart';
import 'widgets/server_top_actions.dart';

class ServerPage extends StatelessWidget {
  const ServerPage({super.key});

  static const routeName = '/server';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ServerCubit(
        serverRepository: context.read<ServerRepository>(),
        settingsRepository: context.read<SettingsRepository>(),
        logsRepository: context.read<LogsRepository>(),
      )..load(),
      child: const _ServerView(),
    );
  }
}

class _ServerView extends StatefulWidget {
  const _ServerView();

  @override
  State<_ServerView> createState() => _ServerViewState();
}

class _ServerViewState extends State<_ServerView> {
  Timer? _ticker;
  DateTime _now = DateTime.now();
  ValueNotifier<int>? _serverStateVersion;

  @override
  void initState() {
    super.initState();
    _ticker = Timer.periodic(const Duration(seconds: 30), (_) {
      if (!mounted) {
        return;
      }
      setState(() {
        _now = DateTime.now();
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final nextNotifier = context.read<AppRuntimeSignals>().server;
    if (!identical(_serverStateVersion, nextNotifier)) {
      _serverStateVersion?.removeListener(_handleExternalServerStateChange);
      _serverStateVersion = nextNotifier;
      _serverStateVersion?.addListener(_handleExternalServerStateChange);
    }
  }

  @override
  void dispose() {
    _ticker?.cancel();
    _serverStateVersion?.removeListener(_handleExternalServerStateChange);
    super.dispose();
  }

  void _handleExternalServerStateChange() {
    if (!mounted) {
      return;
    }
    context.read<ServerCubit>().load(background: true);
  }

  Future<void> _runServerAction(Future<void> Function() action) async {
    await action();
    if (!mounted) {
      return;
    }
    context.read<AppRuntimeSignals>().bumpServer();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocListener<ShellNavigationCubit, AppDestination>(
      listenWhen: (previous, current) =>
          previous != current && current == AppDestination.server,
      listener: (context, state) {
        context.read<ServerCubit>().load();
      },
      child: BlocBuilder<ServerCubit, ServerState>(
        builder: (context, state) {
          if (state.status == ServerStatus.loading ||
              state.status == ServerStatus.initial) {
            return AppLoadingView(label: l10n.dashboardServerLoading);
          }

          if (state.status == ServerStatus.failure && state.settings == null) {
            return AppErrorState(
              title: l10n.serverTitle,
              description: state.message ?? l10n.errorDescription,
              dense: true,
            );
          }

          final settings = state.settings!;
          final runtime = state.serverState;
          final isRunning = runtime.isRunning;
          final isBusy = state.action != ServerAction.none;

          return ListView(
            padding: const EdgeInsets.only(bottom: 28),
            children: [
              ServerReveal(
                child: Align(
                  alignment: AlignmentDirectional.topEnd,
                  child: ServerTopActions(
                    action: state.action,
                    onStart: isRunning || isBusy
                        ? null
                        : () => _runServerAction(
                            context.read<ServerCubit>().startServer,
                          ),
                    onRestart: !isRunning || isBusy
                        ? null
                        : () => _runServerAction(
                            context.read<ServerCubit>().restartServer,
                          ),
                    onStop: !isRunning || isBusy
                        ? null
                        : () => _runServerAction(
                            context.read<ServerCubit>().stopServer,
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              ServerReveal(
                child: ServerHero(
                  title: l10n.serverTitle,
                  subtitle: l10n.serverDescription,
                  statusLabel: isRunning
                      ? l10n.dashboardServerRunning
                      : l10n.dashboardServerStopped,
                  runtimeTitle: l10n.serverMetricRuntime,
                  runtimeValue: _formatUptime(
                    runtime.startedAt,
                    _now,
                    l10n.dashboardUnavailable,
                  ),
                  startedLabel: _formatDateTime(
                    runtime.startedAt,
                    l10n.dashboardUnavailable,
                  ),
                  changedLabel: _formatDateTime(
                    runtime.lastChangedAt,
                    l10n.dashboardUnavailable,
                  ),
                  hostValue: runtime.host ?? settings.bindHost,
                  portValue: '${runtime.port ?? settings.appPort}',
                  isRunning: isRunning,
                ),
              ),
              const SizedBox(height: 14),
              ServerReveal(
                delay: 90,
                child: ServerOperationsSection(
                  settings: settings,
                  logs: state.recentLogs.take(4).toList(growable: false),
                  serverError: runtime.lastError,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  String _formatDateTime(DateTime? value, String fallback) {
    if (value == null) {
      return fallback;
    }
    return DateFormat('yyyy-MM-dd hh:mm a').format(value);
  }

  String _formatUptime(DateTime? startedAt, DateTime now, String fallback) {
    if (startedAt == null) {
      return fallback;
    }
    final duration = now.difference(startedAt);
    if (duration.isNegative) {
      return fallback;
    }
    final hours = duration.inHours.toString().padLeft(2, '0');
    final minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    return '$hours:$minutes'
        'h';
  }
}
