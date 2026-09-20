import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lucide_flutter/lucide_flutter.dart';
import 'package:qintrix/app/exports.dart';
import 'package:qintrix/core/widgets/exports.dart';
import 'package:qintrix/data/models/exports.dart';
import 'package:qintrix/features/logs/log_badge_mapper.dart';
import 'package:qintrix/features/logs/logs_cubit.dart';
import 'package:qintrix/features/logs/logs_state.dart';
import 'package:qintrix/l10n/app_localizations.dart';

class LogsPage extends StatefulWidget {
  const LogsPage({super.key});

  static const routeName = '/logs';

  @override
  State<LogsPage> createState() => _LogsPageState();
}

class _LogsPageState extends State<LogsPage> {
  AppLogModel? _activeLog;

  @override
  void initState() {
    super.initState();
    context.read<LogsCubit>().load(reset: true);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ShellNavigationCubit, AppDestination>(
      listenWhen: (previous, current) =>
          previous != AppDestination.logs && current == AppDestination.logs,
      listener: (context, state) {
        setState(() {
          _activeLog = null;
        });
        context.read<LogsCubit>().load(reset: true);
      },
      child: BlocBuilder<LogsCubit, LogsState>(
        builder: (context, state) {
          final l10n = AppLocalizations.of(context)!;

          if (state.status == LogsStatus.loading ||
              state.status == LogsStatus.initial) {
            return AppLoadingView(label: l10n.logsLoading);
          }

          if (state.status == LogsStatus.failure) {
            return AppErrorState(
              title: l10n.logsTitle,
              description: state.message ?? l10n.errorDescription,
              dense: true,
            );
          }

          if (_activeLog != null) {
            return _LogDetailsView(
              log: _activeLog!,
              onBack: () => setState(() {
                _activeLog = null;
              }),
            );
          }

          final eventTypeOptions =
              state.logs
                  .map((log) => log.eventType)
                  .toSet()
                  .toList(growable: false)
                ..sort();

          return AppDataTable<AppLogModel>(
            rows: state.logs,
            searchValue: state.query.search,
            onSearchChanged: context.read<LogsCubit>().updateSearch,
            searchHintText: l10n.logsSearchPlaceholder,
            hasActiveFilters: _hasActiveFilters(state),
            resetFiltersLabel: l10n.logsResetFilters,
            onResetFilters: context.read<LogsCubit>().resetFilters,
            currentPage: state.query.page,
            totalRows: state.totalCount,
            rowsPerPage: state.query.pageSize,
            onPageSelected: context.read<LogsCubit>().updatePage,
            onRowsPerPageChanged: context.read<LogsCubit>().updateRowsPerPage,
            filters: [
              SizedBox(
                width: 188,
                child: AppDropdownField<String>(
                  label: l10n.logsFilterLevel,
                  value: state.query.level.isEmpty ? null : state.query.level,
                  isDense: true,
                  onChanged: (value) =>
                      context.read<LogsCubit>().updateLevel(value ?? ''),
                  items: [
                    DropdownMenuItem(
                      value: null,
                      child: _FilterOptionRow(
                        icon: LucideIcons.slidersHorizontal,
                        label: l10n.logsFilterAllLevels,
                      ),
                    ),
                    DropdownMenuItem(
                      value: 'info',
                      child: _FilterOptionRow(
                        icon: LogBadgeMapper.levelIcon('info'),
                        label: 'Info',
                      ),
                    ),
                    DropdownMenuItem(
                      value: 'warning',
                      child: _FilterOptionRow(
                        icon: LogBadgeMapper.levelIcon('warning'),
                        label: 'Warning',
                      ),
                    ),
                    DropdownMenuItem(
                      value: 'error',
                      child: _FilterOptionRow(
                        icon: LogBadgeMapper.levelIcon('error'),
                        label: 'Error',
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 188,
                child: AppDropdownField<String>(
                  label: l10n.logsFilterEventType,
                  value: state.query.eventType.isEmpty
                      ? null
                      : state.query.eventType,
                  isDense: true,
                  onChanged: (value) =>
                      context.read<LogsCubit>().updateEventType(value ?? ''),
                  items: [
                    DropdownMenuItem(
                      value: null,
                      child: _FilterOptionRow(
                        icon: LucideIcons.listFilter,
                        label: l10n.logsFilterAllEventTypes,
                      ),
                    ),
                    ...eventTypeOptions.map(
                      (eventType) => DropdownMenuItem(
                        value: eventType,
                        child: _FilterOptionRow(
                          icon: LogBadgeMapper.eventIcon(eventType),
                          label: LogBadgeMapper.humanize(eventType),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            emptyTitle: l10n.logsEmptyTitle,
            emptyDescription: l10n.logsEmptyDescription,
            columns: [
              AppDataTableColumn<AppLogModel>(
                label: l10n.logsColumnTime,
                width: 150,
                cellBuilder: (context, row) => Text(
                  DateFormat('yyyy-MM-dd hh:mm a').format(row.createdAt),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              AppDataTableColumn<AppLogModel>(
                label: l10n.logsColumnTitle,
                width: 180,
                cellBuilder: (context, row) => InkWell(
                  onTap: () => setState(() {
                    _activeLog = row;
                  }),
                  borderRadius: BorderRadius.circular(8),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      row.title,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        decoration: TextDecoration.underline,
                        decorationColor: Theme.of(
                          context,
                        ).colorScheme.primary.withValues(alpha: 0.35),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
              AppDataTableColumn<AppLogModel>(
                label: l10n.logsColumnMessage,
                cellBuilder: (context, row) => Text(
                  row.message,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              AppDataTableColumn<AppLogModel>(
                label: l10n.logsColumnEvent,
                width: 150,
                cellBuilder: (context, row) => StatusBadge(
                  label: LogBadgeMapper.humanize(row.eventType),
                  tone: LogBadgeMapper.eventTone(row.eventType),
                  size: StatusBadgeSize.small,
                  icon: LogBadgeMapper.eventIcon(row.eventType),
                ),
              ),
              AppDataTableColumn<AppLogModel>(
                label: l10n.logsColumnLevel,
                width: 110,
                cellBuilder: (context, row) => StatusBadge(
                  label: row.level,
                  tone: LogBadgeMapper.levelTone(row.level),
                  size: StatusBadgeSize.small,
                  uppercase: true,
                  icon: LogBadgeMapper.levelIcon(row.level),
                ),
              ),
              AppDataTableColumn<AppLogModel>(
                label: l10n.printersColumnActions,
                width: 56,
                alignment: AlignmentDirectional.center,
                cellBuilder: (context, row) => IconButton(
                  tooltip: l10n.logsShowAction,
                  onPressed: () => setState(() {
                    _activeLog = row;
                  }),
                  icon: const Icon(LucideIcons.eye, size: 16),
                  visualDensity: VisualDensity.compact,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  bool _hasActiveFilters(LogsState state) =>
      state.query.search.isNotEmpty ||
      state.query.level.isNotEmpty ||
      state.query.eventType.isNotEmpty;
}

class _LogDetailsView extends StatelessWidget {
  const _LogDetailsView({required this.log, required this.onBack});

  final AppLogModel log;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final timestamp = DateFormat('yyyy-MM-dd hh:mm a').format(log.createdAt);

    return ListView(
      children: [
        Row(
          children: [
            AppButton(
              label: l10n.logsBackToLogs,
              variant: AppButtonVariant.secondary,
              leading: LucideIcons.arrowLeft,
              onPressed: onBack,
            ),
          ],
        ),
        const SizedBox(height: 16),
        AppSectionCard(
          title: log.title,
          subtitle: timestamp,
          actions: [
            StatusBadge(
              label: LogBadgeMapper.humanize(log.eventType),
              tone: LogBadgeMapper.eventTone(log.eventType),
              size: StatusBadgeSize.small,
              icon: LogBadgeMapper.eventIcon(log.eventType),
            ),
            const SizedBox(width: 8),
            StatusBadge(
              label: log.level,
              tone: LogBadgeMapper.levelTone(log.level),
              size: StatusBadgeSize.small,
              uppercase: true,
              icon: LogBadgeMapper.levelIcon(log.level),
            ),
          ],
          child: Column(
            children: [
              _LogDetailRow(label: l10n.logsColumnTime, value: timestamp),
              _LogDetailRow(
                label: l10n.logsFilterEventType,
                value: LogBadgeMapper.humanize(log.eventType),
              ),
              _LogDetailRow(label: l10n.logsColumnLevel, value: log.level),
            ],
          ),
        ),
        const SizedBox(height: 16),
        AppSectionCard(
          title: l10n.logsColumnMessage,
          child: SelectableText(
            log.message,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(height: 1.45),
          ),
        ),
        if (log.metadata != null && log.metadata!.trim().isNotEmpty) ...[
          const SizedBox(height: 16),
          AppSectionCard(
            title: l10n.logsMetadataTitle,
            child: SelectableText(
              log.metadata!,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(height: 1.5),
            ),
          ),
        ],
      ],
    );
  }
}

class _LogDetailRow extends StatelessWidget {
  const _LogDetailRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 9),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.textTheme.bodySmall?.color?.withValues(
                  alpha: 0.72,
                ),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              value,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterOptionRow extends StatelessWidget {
  const _FilterOptionRow({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.8),
        ),
        const SizedBox(width: 8),
        Expanded(child: Text(label, overflow: TextOverflow.ellipsis)),
      ],
    );
  }
}
