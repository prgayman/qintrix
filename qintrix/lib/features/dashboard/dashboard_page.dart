import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_flutter/lucide_flutter.dart';
import 'package:qintrix/app/exports.dart';
import 'package:qintrix/core/widgets/exports.dart';
import 'package:qintrix/data/repositories/exports.dart';
import 'package:qintrix/features/dashboard/dashboard_cubit.dart';
import 'package:qintrix/features/dashboard/dashboard_state.dart';
import 'package:qintrix/features/dashboard/widgets/dashboard_analytics_cards.dart';
import 'package:qintrix/l10n/app_localizations.dart';
import 'package:qintrix/theme/tokens/color_tokens.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  static const routeName = '/dashboard';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DashboardCubit(
        serverRepository: context.read<ServerRepository>(),
        printersRepository: context.read<PrintersRepository>(),
        appsRepository: context.read<AppsRepository>(),
        printJobsRepository: context.read<PrintJobsRepository>(),
        logsRepository: context.read<LogsRepository>(),
      )..load(),
      child: const _DashboardAnalyticsView(),
    );
  }
}

class _DashboardAnalyticsView extends StatelessWidget {
  const _DashboardAnalyticsView();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocListener<ShellNavigationCubit, AppDestination>(
      listenWhen: (previous, current) =>
          previous != AppDestination.dashboard &&
          current == AppDestination.dashboard,
      listener: (context, state) {
        context.read<DashboardCubit>().load();
      },
      child: BlocBuilder<DashboardCubit, DashboardState>(
        builder: (context, state) {
          if ((state.status == DashboardStatus.initial ||
                  state.status == DashboardStatus.loading) &&
              state.snapshot == null) {
            return AppLoadingView(label: l10n.loading);
          }

          if (state.status == DashboardStatus.failure &&
              state.snapshot == null) {
            return AppErrorState(
              title: l10n.navDashboard,
              description: state.errorMessage ?? l10n.errorDescription,
            );
          }

          final snapshot = state.snapshot!;

          return LayoutBuilder(
            builder: (context, constraints) {
              final isCompact = constraints.maxWidth < 760;

              return ListView(
                children: [
                  DashboardMetricsGrid(snapshot: snapshot),
                  const SizedBox(height: 14),
                  DashboardJobsTrendCard(snapshot: snapshot),
                  const SizedBox(height: 14),
                  if (isCompact) ...[
                    DashboardDoughnutCard(
                      title: l10n.aboutStatusMixTitle,
                      subtitle: l10n.aboutStatusMixSubtitle,
                      headerIcon: LucideIcons.badgeCheck,
                      items: snapshot.statusBreakdown,
                      labelBuilder: (key) => _statusLabel(l10n, key),
                      colorBuilder: _statusColor,
                    ),
                    const SizedBox(height: 14),
                    DashboardBreakdownCard(
                      title: l10n.aboutConnectionsTitle,
                      subtitle: l10n.aboutConnectionsSubtitle,
                      headerIcon: LucideIcons.printerCheck,
                      items: snapshot.connectionBreakdown,
                      labelBuilder: (key) => _connectionLabel(l10n, key),
                      colorBuilder: _connectionColor,
                    ),
                    const SizedBox(height: 14),
                    DashboardBreakdownCard(
                      title: l10n.aboutContentTypesTitle,
                      subtitle: l10n.aboutContentTypesSubtitle,
                      headerIcon: LucideIcons.fileText,
                      items: snapshot.contentBreakdown,
                      labelBuilder: _contentLabel,
                      colorBuilder: _contentColor,
                    ),
                  ] else ...[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: DashboardDoughnutCard(
                            title: l10n.aboutStatusMixTitle,
                            subtitle: l10n.aboutStatusMixSubtitle,
                            headerIcon: LucideIcons.badgeCheck,
                            items: snapshot.statusBreakdown,
                            labelBuilder: (key) => _statusLabel(l10n, key),
                            colorBuilder: _statusColor,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: DashboardBreakdownCard(
                            title: l10n.aboutConnectionsTitle,
                            subtitle: l10n.aboutConnectionsSubtitle,
                            headerIcon: LucideIcons.printerCheck,
                            items: snapshot.connectionBreakdown,
                            labelBuilder: (key) => _connectionLabel(l10n, key),
                            colorBuilder: _connectionColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: DashboardBreakdownCard(
                            title: l10n.aboutContentTypesTitle,
                            subtitle: l10n.aboutContentTypesSubtitle,
                            headerIcon: LucideIcons.fileText,
                            items: snapshot.contentBreakdown,
                            labelBuilder: _contentLabel,
                            colorBuilder: _contentColor,
                          ),
                        ),
                        const SizedBox(width: 14),
                        const Expanded(child: SizedBox()),
                      ],
                    ),
                  ],
                ],
              );
            },
          );
        },
      ),
    );
  }

  String _statusLabel(AppLocalizations l10n, String key) {
    return switch (key) {
      'completed' => l10n.jobsStatusCompleted,
      'processing' => l10n.jobsStatusProcessing,
      'failed' => l10n.jobsStatusFailed,
      _ => l10n.jobsStatusQueued,
    };
  }

  Color _statusColor(String key) {
    return switch (key) {
      'completed' => AppColorTokens.success,
      'processing' => AppColorTokens.info,
      'failed' => AppColorTokens.error,
      _ => AppColorTokens.warning,
    };
  }

  String _connectionLabel(AppLocalizations l10n, String key) {
    return switch (key) {
      'network_tcp' => l10n.printersTypeTcpShort,
      'usb_raw_esc_pos' => l10n.printersTypeUsbRawShort,
      _ => l10n.printersTypeSystemShort,
    };
  }

  Color _connectionColor(String key) {
    return switch (key) {
      'network_tcp' => AppColorTokens.gradientBlueMid,
      'usb_raw_esc_pos' => AppColorTokens.gradientOrange,
      _ => AppColorTokens.gradientCyan,
    };
  }

  String _contentLabel(String key) {
    return switch (key) {
      'text' => 'Text',
      'pdf' => 'PDF',
      'image' => 'Image',
      _ => key.toUpperCase(),
    };
  }

  Color _contentColor(String key) {
    return switch (key) {
      'text' => AppColorTokens.info,
      'pdf' => AppColorTokens.gradientBlueMid,
      'image' => AppColorTokens.gradientOrange,
      _ => AppColorTokens.highlightYellow,
    };
  }
}
