import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_flutter/lucide_flutter.dart';
import 'package:provider/provider.dart';
import 'package:qintrix/app/app_runtime_signals.dart';
import 'package:qintrix/app/exports.dart';
import 'package:qintrix/core/services/exports.dart';
import 'package:qintrix/data/models/exports.dart';
import 'package:qintrix/data/repositories/exports.dart';
import 'package:qintrix/features/jobs/jobs_page.dart';
import 'package:qintrix/features/server/server_page.dart';
import 'package:qintrix/features/settings/settings_cubit.dart';
import 'package:qintrix/l10n/app_localizations.dart';
import 'package:qintrix/theme/tokens/color_tokens.dart';

class ShellHeader extends StatelessWidget {
  const ShellHeader({required this.destination, super.key});

  final AppDestination destination;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final subtitle = destination.subtitle(l10n);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: theme.colorScheme.primary.withValues(alpha: 0.075),
              border: Border.all(
                color: theme.colorScheme.primary.withValues(alpha: 0.12),
              ),
            ),
              child: Icon(
              destination.icon,
              color: theme.colorScheme.primary,
              size: 16,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  destination.label(l10n),
                  style: theme.textTheme.headlineSmall?.copyWith(height: 1.05),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 1),
                  Text(
                    subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.textTheme.bodySmall?.color?.withValues(
                        alpha: 0.72,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: 8),
          const _ShellQueueEntry(),
          const SizedBox(width: 8),
          const _ShellServerEntry(),
        ],
      ),
    );
  }
}

class _ShellQueueEntry extends StatefulWidget {
  const _ShellQueueEntry();

  @override
  State<_ShellQueueEntry> createState() => _ShellQueueEntryState();
}

class _ShellQueueEntryState extends State<_ShellQueueEntry> {
  late final Timer _refreshTimer;
  bool _isResuming = false;

  @override
  void initState() {
    super.initState();
    _refreshTimer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _refreshTimer.cancel();
    super.dispose();
  }

  Future<void> _openJobs() async {
    context.read<ShellNavigationCubit>().setDestination(AppDestination.jobs);
    final modalRoute = ModalRoute.of(context)?.settings.name;
    if (modalRoute != JobsPage.routeName) {
      await Navigator.of(context).pushReplacementNamed(JobsPage.routeName);
    }
  }

  Future<void> _resumeQueue() async {
    final printQueueService = context.read<PrintQueueService>();
    final settingsRepository = context.read<SettingsRepository>();
    final settingsCubit = context.read<SettingsCubit>();
    final runtimeSignals = context.read<AppRuntimeSignals>();
    setState(() {
      _isResuming = true;
    });
    try {
      await printQueueService.resume();
      final persistedSettings = await settingsRepository.loadSettings();
      if (persistedSettings.jobsStartPaused) {
        await settingsRepository.saveSettings(
          persistedSettings.copyWith(jobsStartPaused: false),
        );
        if (mounted) {
          await settingsCubit.load();
        }
      }
      if (!mounted) {
        return;
      }
      runtimeSignals.bumpQueue();
    } finally {
      if (mounted) {
        setState(() {
          _isResuming = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final runtimeSignals = context.read<AppRuntimeSignals>();

    return ValueListenableBuilder<int>(
      valueListenable: runtimeSignals.queue,
      builder: (context, _, child) => FutureBuilder<QueueStatusModel>(
        future: context.read<PrintQueueService>().getQueueStatus(),
        builder: (context, snapshot) {
        final queueStatus = snapshot.data;
        final paused = queueStatus?.state == QueueRunState.paused;
        final queueLabel = paused
            ? l10n.jobsQueuePausedBadge
            : l10n.jobsQueueRunningBadge;
        final accentColor = paused
            ? AppColorTokens.secondaryOrange
            : AppColorTokens.supportCyan;

        return InkWell(
          onTap: _openJobs,
          borderRadius: BorderRadius.circular(18),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 220),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              gradient: LinearGradient(
                colors: [
                  accentColor.withValues(alpha: 0.1),
                  accentColor.withValues(alpha: 0.04),
                ],
              ),
              border: Border.all(color: accentColor.withValues(alpha: 0.14)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: accentColor.withValues(alpha: 0.14),
                  ),
                  child: Icon(
                    paused ? LucideIcons.pause : LucideIcons.play,
                    size: 14,
                    color: accentColor,
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      l10n.jobsTitle,
                      style: theme.textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      queueLabel,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: accentColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                if (paused) ...[
                  const SizedBox(width: 8),
                  FilledButton.tonalIcon(
                    onPressed: _isResuming ? null : _resumeQueue,
                    icon: _isResuming
                        ? const SizedBox(
                            width: 14,
                            height: 14,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(LucideIcons.play, size: 16),
                    label: Text(l10n.jobsQueueResumeAction),
                  ),
                ] else ...[
                  const SizedBox(width: 8),
                  Icon(
                    LucideIcons.arrowUpRight,
                    size: 14,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                  ),
                ],
              ],
            ),
          ),
        );
      },
      ),
    );
  }
}

class _ShellServerEntry extends StatefulWidget {
  const _ShellServerEntry();

  @override
  State<_ShellServerEntry> createState() => _ShellServerEntryState();
}

class _ShellServerEntryState extends State<_ShellServerEntry> {
  late final Timer _refreshTimer;
  bool _isStarting = false;

  @override
  void initState() {
    super.initState();
    _refreshTimer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _refreshTimer.cancel();
    super.dispose();
  }

  Future<void> _openServer() async {
    context.read<ShellNavigationCubit>().setDestination(AppDestination.server);
    final modalRoute = ModalRoute.of(context)?.settings.name;
    if (modalRoute != ServerPage.routeName) {
      await Navigator.of(context).pushReplacementNamed(ServerPage.routeName);
    }
  }

  Future<void> _startServer() async {
    setState(() {
      _isStarting = true;
    });
    try {
      await context.read<ServerRepository>().startServer();
    } finally {
      if (mounted) {
        context.read<AppRuntimeSignals>().bumpServer();
        setState(() {
          _isStarting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final runtimeSignals = context.read<AppRuntimeSignals>();

    return ValueListenableBuilder<int>(
      valueListenable: runtimeSignals.server,
      builder: (context, _, _) => FutureBuilder<ServerStateModel>(
        future: context.read<ServerRepository>().getState(),
        builder: (context, snapshot) {
          final serverState = snapshot.data;
          final isRunning = serverState?.isRunning ?? false;
          final statusLabel = isRunning
              ? l10n.dashboardServerRunning
              : l10n.dashboardServerStopped;
          final accentColor = isRunning
              ? theme.colorScheme.primary
              : theme.colorScheme.tertiary;

          return InkWell(
            onTap: _openServer,
            borderRadius: BorderRadius.circular(18),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                gradient: LinearGradient(
                  colors: [
                    accentColor.withValues(alpha: 0.1),
                    accentColor.withValues(alpha: 0.04),
                  ],
                ),
                border: Border.all(color: accentColor.withValues(alpha: 0.14)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: accentColor.withValues(alpha: 0.14),
                    ),
                    child: Icon(
                      isRunning
                          ? LucideIcons.activity
                          : LucideIcons.serverCrash,
                      size: 16,
                      color: accentColor,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        l10n.navServer,
                        style: theme.textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        statusLabel,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: accentColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  if (!isRunning) ...[
                    const SizedBox(width: 10),
                    FilledButton.tonalIcon(
                      onPressed: _isStarting ? null : _startServer,
                      icon: _isStarting
                          ? const SizedBox(
                              width: 14,
                              height: 14,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(LucideIcons.play, size: 16),
                      label: Text(l10n.dashboardServerStart),
                    ),
                  ] else ...[
                    const SizedBox(width: 10),
                    Icon(
                      LucideIcons.arrowUpRight,
                      size: 16,
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
