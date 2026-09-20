import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qintrix/app/exports.dart';
import 'package:qintrix/core/services/exports.dart';
import 'package:qintrix/core/widgets/exports.dart';
import 'package:qintrix/data/models/exports.dart';
import 'package:qintrix/data/repositories/exports.dart';
import 'package:qintrix/features/printers/printers_cubit.dart';
import 'package:qintrix/features/printers/printers_state.dart';
import 'package:qintrix/features/printers/widgets/printer_editor_view.dart';
import 'package:qintrix/features/printers/widgets/printer_show_view.dart';
import 'package:qintrix/features/printers/widgets/printers_index_view.dart';
import 'package:qintrix/l10n/app_localizations.dart';

class PrintersPage extends StatelessWidget {
  const PrintersPage({super.key});

  static const routeName = '/printers';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PrintersCubit(
        repository: context.read<PrintersRepository>(),
        connectionTestService: context.read<PrinterConnectionTestService>(),
        logger: context.read<LoggerService>(),
      )..load(),
      child: const _PrintersView(),
    );
  }
}

class _PrintersView extends StatelessWidget {
  const _PrintersView();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocListener<ShellNavigationCubit, AppDestination>(
      listenWhen: (previous, current) =>
          previous != AppDestination.printers &&
          current == AppDestination.printers,
      listener: (context, state) {
        context.read<PrintersCubit>().load(reset: true);
      },
      child: BlocBuilder<PrintersCubit, PrintersState>(
        builder: (context, state) {
          if ((state.status == PrintersStatus.initial ||
                  state.status == PrintersStatus.loading) &&
              state.printers.isEmpty) {
            return AppLoadingView(label: l10n.loading);
          }

          if (state.status == PrintersStatus.failure &&
              state.printers.isEmpty) {
            return AppErrorState(
              title: l10n.printersTitle,
              description: state.errorMessage ?? l10n.errorDescription,
            );
          }

          final content = switch (state.mode) {
            PrintersViewMode.listing => PrintersIndexView(
              printers: state.printers,
              query: state.query,
              totalCount: state.totalCount,
              selectedIds: state.selectedIds,
              onToggleSelection: context.read<PrintersCubit>().toggleSelection,
              onCreate: context.read<PrintersCubit>().showCreate,
              onDeleteSelected: () => _confirmDeleteSelected(context),
              onCopyIdentifier: (identifier) =>
                  _copyIdentifier(context, identifier),
              onSearchChanged: context.read<PrintersCubit>().updateSearch,
              onTypeChanged: context.read<PrintersCubit>().updateConnectionType,
              onStatusChanged: context.read<PrintersCubit>().updateStatus,
              onResetFilters: context.read<PrintersCubit>().resetFilters,
              onPageSelected: context.read<PrintersCubit>().updatePage,
              onRowsPerPageChanged:
                  context.read<PrintersCubit>().updateRowsPerPage,
              onShow: context.read<PrintersCubit>().showPrinter,
              onEdit: context.read<PrintersCubit>().editPrinter,
              onTestConnection: (printer) =>
                  context.read<PrintersCubit>().testConnection(printer, l10n),
              onDelete: (printer) => _confirmDeleteOne(context, printer),
            ),
            PrintersViewMode.create => Stack(
              children: [
                PrinterEditorView(
                  modeLabel: l10n.printersCreateAction,
                  onCancel: context.read<PrintersCubit>().backToIndex,
                  onSubmit: (printer) =>
                      context.read<PrintersCubit>().savePrinter(printer, l10n),
                  onTestConnection: (printer) => context
                      .read<PrintersCubit>()
                      .testConnection(printer, l10n),
                  onCopyIdentifier: (identifier) =>
                      _copyIdentifier(context, identifier),
                ),
                if (state.status == PrintersStatus.saving)
                  Positioned.fill(child: AppLoadingView(label: l10n.loading)),
              ],
            ),
            PrintersViewMode.edit => Stack(
              children: [
                PrinterEditorView(
                  modeLabel: l10n.printersSaveChanges,
                  initialPrinter: state.activePrinter,
                  onCancel: context.read<PrintersCubit>().backToShow,
                  onSubmit: (printer) =>
                      context.read<PrintersCubit>().savePrinter(printer, l10n),
                  onTestConnection: (printer) => context
                      .read<PrintersCubit>()
                      .testConnection(printer, l10n),
                  onCopyIdentifier: (identifier) =>
                      _copyIdentifier(context, identifier),
                ),
                if (state.status == PrintersStatus.saving)
                  Positioned.fill(child: AppLoadingView(label: l10n.loading)),
              ],
            ),
            PrintersViewMode.show =>
              state.activePrinter == null
                  ? AppEmptyState(
                      title: l10n.printersEmptyTitle,
                      description: l10n.printersEmptyDescription,
                    )
                  : PrinterShowView(
                      printer: state.activePrinter!,
                      onBack: context.read<PrintersCubit>().backToIndex,
                      onEdit: () => context.read<PrintersCubit>().editPrinter(
                        state.activePrinter!,
                      ),
                      onTestConnection: () => context
                          .read<PrintersCubit>()
                          .testConnection(state.activePrinter!, l10n),
                      onCopyIdentifier: (identifier) =>
                          _copyIdentifier(context, identifier),
                      onDelete: () =>
                          _confirmDeleteOne(context, state.activePrinter!),
                    ),
          };

          return Stack(
            children: [
              content,
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

  Future<void> _confirmDeleteOne(
    BuildContext context,
    PrinterModel printer,
  ) async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AppConfirmDialog(
        title: l10n.printersDeleteTitle,
        description: l10n.printersDeleteDescription(printer.name),
        confirmLabel: l10n.printersDeleteAction,
        cancelLabel: l10n.cancel,
      ),
    );
    if (confirmed == true && context.mounted) {
      await context.read<PrintersCubit>().deletePrinter(printer, l10n);
    }
  }

  Future<void> _confirmDeleteSelected(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
    final selectedCount = context
        .read<PrintersCubit>()
        .state
        .selectedIds
        .length;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AppConfirmDialog(
        title: l10n.printersBulkDeleteTitle,
        description: l10n.printersBulkDeleteDescription(selectedCount),
        confirmLabel: l10n.printersBulkDeleteAction,
        cancelLabel: l10n.cancel,
      ),
    );
    if (confirmed == true && context.mounted) {
      await context.read<PrintersCubit>().deleteSelected(l10n);
    }
  }

  Future<void> _copyIdentifier(BuildContext context, String identifier) async {
    await Clipboard.setData(ClipboardData(text: identifier));
    if (!context.mounted) {
      return;
    }
    context.read<PrintersCubit>().notifyIdentifierCopied(
      AppLocalizations.of(context)!,
    );
  }
}
