import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lucide_flutter/lucide_flutter.dart';
import 'package:qintrix/app/exports.dart';
import 'package:qintrix/core/services/exports.dart';
import 'package:qintrix/core/widgets/exports.dart';
import 'package:qintrix/data/models/exports.dart';
import 'package:qintrix/data/repositories/exports.dart';
import 'package:qintrix/l10n/app_localizations.dart';
import 'package:qintrix/theme/tokens/color_tokens.dart';

import 'jobs_cubit.dart';
import 'jobs_state.dart';

class JobsPage extends StatelessWidget {
  const JobsPage({super.key});

  static const routeName = '/jobs';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => JobsCubit(
        repository: context.read<PrintJobsRepository>(),
        printersRepository: context.read<PrintersRepository>(),
        printQueueService: context.read<PrintQueueService>(),
      )..load(reset: true),
      child: const _JobsView(),
    );
  }
}

class _JobsView extends StatelessWidget {
  const _JobsView();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocListener<ShellNavigationCubit, AppDestination>(
      listenWhen: (previous, current) =>
          previous != AppDestination.jobs && current == AppDestination.jobs,
      listener: (context, state) {
        context.read<JobsCubit>().load(reset: true);
      },
      child: BlocBuilder<JobsCubit, JobsState>(
        builder: (context, state) {
          if (state.status == JobsStatus.loading && state.jobs.isEmpty) {
            return AppLoadingView(label: l10n.loading);
          }

          if (state.status == JobsStatus.failure && state.jobs.isEmpty) {
            return AppErrorState(
              title: l10n.jobsTitle,
              description: state.message ?? l10n.errorDescription,
            );
          }

          if (state.activeJob != null) {
            return _JobDetailsView(
              job: state.activeJob!,
              printerLabel:
                  state.printerNamesById[state.activeJob!.printerId] ??
                  _shortId(state.activeJob!.printerId),
              onBack: context.read<JobsCubit>().closeJob,
              onRetry: state.activeJob!.isRetryable
                  ? () => context.read<JobsCubit>().retryJob(
                      state.activeJob!.id,
                      l10n,
                    )
                  : null,
              onCancel: state.activeJob!.isCancelable
                  ? () => context.read<JobsCubit>().cancelJob(
                      state.activeJob!.id,
                      l10n,
                    )
                  : null,
            );
          }

          return Stack(
            children: [
              AppDataTable<PrintJobModel>(
                rows: state.jobs,
                searchFieldWidth: 164,
                searchValue: state.query.search,
                onSearchChanged: context.read<JobsCubit>().updateSearch,
                searchHintText: l10n.jobsSearchPlaceholder,
                currentPage: state.query.page,
                totalRows: state.totalCount,
                rowsPerPage: state.query.pageSize,
                onPageSelected: context.read<JobsCubit>().updatePage,
                onRowsPerPageChanged: context
                    .read<JobsCubit>()
                    .updateRowsPerPage,
                hasActiveFilters:
                    state.query.search.isNotEmpty ||
                    state.query.status.isNotEmpty ||
                    state.query.printerId.isNotEmpty ||
                    state.query.contentType.isNotEmpty,
                onResetFilters: context.read<JobsCubit>().resetFilters,
                resetFiltersLabel: l10n.jobsResetFilters,
                filters: [
                  SizedBox(
                    width: 164,
                    child: AppDropdownField<String>(
                      label: l10n.jobsFilterStatus,
                      value: state.query.status.isEmpty
                          ? null
                          : state.query.status,
                      isDense: true,
                      onChanged: (value) =>
                          context.read<JobsCubit>().updateStatus(value ?? ''),
                      items: [
                        DropdownMenuItem(
                          value: null,
                          child: Text(l10n.jobsAllStatuses),
                        ),
                        ...PrintJobStatus.values.map(
                          (status) => DropdownMenuItem(
                            value: status.value,
                            child: Text(_jobStatusLabel(l10n, status)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 164,
                    child: AppDropdownField<String>(
                      label: l10n.jobsFilterContentType,
                      value: state.query.contentType.isEmpty
                          ? null
                          : state.query.contentType,
                      isDense: true,
                      onChanged: (value) => context
                          .read<JobsCubit>()
                          .updateContentType(value ?? ''),
                      items: [
                        DropdownMenuItem(
                          value: null,
                          child: Text(l10n.jobsAllContentTypes),
                        ),
                        const DropdownMenuItem(
                          value: 'text',
                          child: Text('Text'),
                        ),
                        const DropdownMenuItem(
                          value: 'pdf',
                          child: Text('PDF'),
                        ),
                        const DropdownMenuItem(
                          value: 'image',
                          child: Text('Image'),
                        ),
                      ],
                    ),
                  ),
                ],
                emptyTitle: l10n.jobsEmptyTitle,
                emptyDescription: l10n.jobsEmptyDescription,
                columns: [
                  AppDataTableColumn<PrintJobModel>(
                    label: l10n.jobsColumnId,
                    cellBuilder: (context, row) => _JobPrimaryCell(job: row),
                  ),
                  AppDataTableColumn<PrintJobModel>(
                    label: l10n.jobsColumnPrinter,
                    width: 120,
                    cellBuilder: (context, row) => _InlineInfoChip(
                      label:
                          state.printerNamesById[row.printerId] ??
                          _shortId(row.printerId),
                      icon: LucideIcons.printer,
                    ),
                  ),
                  AppDataTableColumn<PrintJobModel>(
                    label: l10n.jobsColumnContentType,
                    width: 110,
                    cellBuilder: (context, row) => _JobContentCell(job: row),
                  ),
                  AppDataTableColumn<PrintJobModel>(
                    label: l10n.jobsColumnStatus,
                    width: 92,
                    cellBuilder: (context, row) => StatusBadge(
                      label: _jobStatusLabel(l10n, row.status),
                      tone: switch (row.status) {
                        PrintJobStatus.completed => AppStatusTone.success,
                        PrintJobStatus.failed => AppStatusTone.error,
                        PrintJobStatus.canceled => AppStatusTone.warning,
                        PrintJobStatus.processing => AppStatusTone.info,
                        _ => AppStatusTone.info,
                      },
                      size: StatusBadgeSize.small,
                    ),
                  ),
                  AppDataTableColumn<PrintJobModel>(
                    label: l10n.jobsColumnCreatedAt,
                    width: 108,
                    cellBuilder: (context, row) => Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(DateFormat('yyyy-MM-dd').format(row.createdAt)),
                        const SizedBox(height: 2),
                        Text(
                          DateFormat('hh:mm a').format(row.createdAt),
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.color
                                    ?.withValues(alpha: 0.62),
                              ),
                        ),
                      ],
                    ),
                  ),
                  AppDataTableColumn<PrintJobModel>(
                    label: l10n.printersColumnActions,
                    width: 44,
                    alignment: AlignmentDirectional.center,
                    cellBuilder: (context, row) => _JobActionsMenu(job: row),
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
                    child: state.feedback == null
                        ? const SizedBox.shrink()
                        : AppFloatingToast(
                            key: ValueKey(state.feedback!.id),
                            data: AppFloatingToastData(
                              title: state.feedback!.title,
                              message: state.feedback!.message,
                              tone: state.feedback!.tone,
                            ),
                          ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _JobActionsMenu extends StatelessWidget {
  const _JobActionsMenu({required this.job});

  final PrintJobModel job;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final cubit = context.read<JobsCubit>();

    return PopupMenuButton<_JobAction>(
      tooltip: l10n.printersColumnActions,
      padding: EdgeInsets.zero,
      splashRadius: 18,
      icon: Icon(
        LucideIcons.ellipsis,
        size: 16,
        color: Theme.of(
          context,
        ).textTheme.bodySmall?.color?.withValues(alpha: 0.82),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 10,
      position: PopupMenuPosition.under,
      onSelected: (action) {
        switch (action) {
          case _JobAction.view:
            cubit.openJob(job.id);
            break;
          case _JobAction.retry:
            cubit.retryJob(job.id, l10n);
            break;
          case _JobAction.cancel:
            cubit.cancelJob(job.id, l10n);
            break;
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem<_JobAction>(
          value: _JobAction.view,
          height: 36,
          child: _ActionMenuItem(
            icon: LucideIcons.eye,
            label: l10n.printersShowAction,
          ),
        ),
        if (job.isRetryable)
          PopupMenuItem<_JobAction>(
            value: _JobAction.retry,
            height: 36,
            child: _ActionMenuItem(
              icon: LucideIcons.rotateCw,
              label: l10n.retry,
            ),
          ),
        if (job.isCancelable)
          PopupMenuItem<_JobAction>(
            value: _JobAction.cancel,
            height: 36,
            child: _ActionMenuItem(
              icon: LucideIcons.circleOff,
              label: l10n.cancel,
              destructive: true,
            ),
          ),
      ],
    );
  }
}

enum _JobAction { view, retry, cancel }

class _JobPrimaryCell extends StatelessWidget {
  const _JobPrimaryCell({required this.job});

  final PrintJobModel job;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          job.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          _shortId(job.id),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.66),
          ),
        ),
      ],
    );
  }
}

class _JobContentCell extends StatelessWidget {
  const _JobContentCell({required this.job});

  final PrintJobModel job;

  @override
  Widget build(BuildContext context) {
    final contentType = job.contentType?.toLowerCase().trim();
    final label = (contentType ?? '-').toUpperCase();
    final suffix = job.copies > 1 ? ' x${job.copies}' : '';
    final icon = switch (contentType) {
      'pdf' => LucideIcons.fileText,
      'image' => LucideIcons.image,
      'text' => LucideIcons.type,
      _ => LucideIcons.file,
    };
    final color = switch (contentType) {
      'pdf' => AppColorTokens.error,
      'image' => AppColorTokens.supportCyan,
      'text' => AppColorTokens.gradientBlueMid,
      _ => Theme.of(context).colorScheme.primary,
    };

    return _InlineInfoChip(label: '$label$suffix', icon: icon, color: color);
  }
}

class _InlineInfoChip extends StatelessWidget {
  const _InlineInfoChip({required this.label, required this.icon, this.color});

  final String label;
  final IconData icon;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accentColor = color ?? theme.colorScheme.primary;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9),
        border: Border.all(color: accentColor.withValues(alpha: 0.18)),
        color: accentColor.withValues(alpha: 0.06),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: accentColor),
          const SizedBox(width: 5),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: accentColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionMenuItem extends StatelessWidget {
  const _ActionMenuItem({
    required this.icon,
    required this.label,
    this.destructive = false,
  });

  final IconData icon;
  final String label;
  final bool destructive;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = destructive
        ? theme.colorScheme.error
        : theme.textTheme.bodyMedium?.color;

    return Row(
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 10),
        Text(
          label,
          style: TextStyle(color: color, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}

String _jobStatusLabel(AppLocalizations l10n, PrintJobStatus status) {
  return switch (status) {
    PrintJobStatus.accepted => l10n.jobsStatusAccepted,
    PrintJobStatus.rendering => l10n.jobsStatusRendering,
    PrintJobStatus.queued => l10n.jobsStatusQueued,
    PrintJobStatus.processing => l10n.jobsStatusProcessing,
    PrintJobStatus.completed => l10n.jobsStatusCompleted,
    PrintJobStatus.failed => l10n.jobsStatusFailed,
    PrintJobStatus.canceled => l10n.jobsStatusCanceled,
    PrintJobStatus.retryScheduled => l10n.jobsStatusRetryScheduled,
  };
}

String _shortId(String? value) {
  if (value == null || value.trim().isEmpty) {
    return '-';
  }
  if (value.length <= 12) {
    return value;
  }
  return value.substring(0, 12);
}

class _JobDetailsView extends StatelessWidget {
  const _JobDetailsView({
    required this.job,
    required this.printerLabel,
    required this.onBack,
    required this.onRetry,
    required this.onCancel,
  });

  final PrintJobModel job;
  final String printerLabel;
  final VoidCallback onBack;
  final VoidCallback? onRetry;
  final VoidCallback? onCancel;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return ListView(
      children: [
        Row(
          children: [
            AppButton(
              label: l10n.jobsBackToJobs,
              variant: AppButtonVariant.secondary,
              leading: LucideIcons.arrowLeft,
              onPressed: onBack,
            ),
            const Spacer(),
            if (onRetry != null)
              AppButton(
                label: l10n.retry,
                variant: AppButtonVariant.secondary,
                leading: LucideIcons.rotateCw,
                onPressed: onRetry,
              ),
            if (onRetry != null && onCancel != null) const SizedBox(width: 8),
            if (onCancel != null)
              AppButton(
                label: l10n.cancel,
                variant: AppButtonVariant.secondary,
                leading: LucideIcons.circleOff,
                onPressed: onCancel,
              ),
          ],
        ),
        const SizedBox(height: 16),
        AppSectionCard(
          title: job.title,
          subtitle: job.id,
          child: Column(
            children: [
              _DetailRow(
                label: l10n.jobsColumnStatus,
                value: _jobStatusLabel(l10n, job.status),
              ),
              _DetailRow(
                label: l10n.jobsColumnPrinter,
                value: printerLabel,
              ),
              _DetailRow(
                label: l10n.jobsColumnContentType,
                value: job.contentType ?? '-',
              ),
              _DetailRow(
                label: l10n.jobsColumnReference,
                value: '${job.referenceType ?? '-'}:${job.referenceId ?? '-'}',
              ),
              _DetailRow(
                label: l10n.jobsArtifactLabel,
                value: job.artifactPath ?? '-',
              ),
              _DetailRow(
                label: l10n.jobsFailureLabel,
                value: job.failureMessage ?? '-',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          SizedBox(
            width: 160,
            child: Text(
              label,
              style: theme.textTheme.labelMedium?.copyWith(
                color: theme.colorScheme.outline,
              ),
            ),
          ),
          Expanded(child: SelectableText(value)),
        ],
      ),
    );
  }
}
