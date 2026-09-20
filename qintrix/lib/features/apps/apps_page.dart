import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qintrix/app/exports.dart';
import 'package:qintrix/core/widgets/exports.dart';
import 'package:qintrix/data/models/exports.dart';
import 'package:qintrix/data/repositories/exports.dart';
import 'package:qintrix/l10n/app_localizations.dart';

import 'apps_cubit.dart';
import 'apps_state.dart';
import 'widgets/app_editor_view.dart';
import 'widgets/app_show_view.dart';
import 'widgets/apps_index_view.dart';

class AppsPage extends StatelessWidget {
  const AppsPage({super.key});

  static const routeName = '/apps';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppsCubit(
        repository: context.read<AppsRepository>(),
        printersRepository: context.read<PrintersRepository>(),
      )..load(),
      child: const _AppsView(),
    );
  }
}

class _AppsView extends StatelessWidget {
  const _AppsView();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocListener<ShellNavigationCubit, AppDestination>(
      listenWhen: (previous, current) =>
          previous != AppDestination.apps && current == AppDestination.apps,
      listener: (context, state) {
        context.read<AppsCubit>().load(reset: true);
      },
      child: BlocBuilder<AppsCubit, AppsState>(
        builder: (context, state) {
          if ((state.status == AppsStatus.initial ||
                  state.status == AppsStatus.loading) &&
              state.apps.isEmpty) {
            return AppLoadingView(label: l10n.loading);
          }

          if (state.status == AppsStatus.failure && state.apps.isEmpty) {
            return AppErrorState(
              title: l10n.appsTitle,
              description: state.errorMessage ?? l10n.errorDescription,
            );
          }

          final content = switch (state.mode) {
            AppsViewMode.listing => AppsIndexView(
              apps: state.apps,
              query: state.query,
              totalCount: state.totalCount,
              selectedIds: state.selectedIds,
              onToggleSelection: context.read<AppsCubit>().toggleSelection,
              onCreate: context.read<AppsCubit>().showCreate,
              onDeleteSelected: () => _confirmDeleteSelected(context),
              onCopyApiKey: (apiKey) => _copyApiKey(context, apiKey),
              onSearchChanged: context.read<AppsCubit>().updateSearch,
              onStatusChanged: context.read<AppsCubit>().updateStatus,
              onScopeChanged: context.read<AppsCubit>().updateScope,
              onResetFilters: context.read<AppsCubit>().resetFilters,
              onPageSelected: context.read<AppsCubit>().updatePage,
              onRowsPerPageChanged: context.read<AppsCubit>().updateRowsPerPage,
              onShow: context.read<AppsCubit>().showApp,
              onEdit: context.read<AppsCubit>().editApp,
              onRegenerateApiKey: (app) => _confirmRegenerateApiKey(context, app),
              onDelete: (app) => _confirmDeleteOne(context, app),
            ),
            AppsViewMode.create => Stack(
              children: [
                AppEditorView(
                  modeLabel: l10n.appsCreateAction,
                  availablePrinters: state.availablePrinters,
                  onCancel: context.read<AppsCubit>().backToIndex,
                  onSubmit: (app) => context.read<AppsCubit>().saveApp(app, l10n),
                  onCopyApiKey: (apiKey) => _copyApiKey(context, apiKey),
                ),
                if (state.status == AppsStatus.saving)
                  Positioned.fill(child: AppLoadingView(label: l10n.loading)),
              ],
            ),
            AppsViewMode.edit => Stack(
              children: [
                AppEditorView(
                  modeLabel: l10n.appsSaveChanges,
                  initialApp: state.activeApp,
                  availablePrinters: state.availablePrinters,
                  onCancel: context.read<AppsCubit>().backToShow,
                  onSubmit: (app) => context.read<AppsCubit>().saveApp(app, l10n),
                  onCopyApiKey: (apiKey) => _copyApiKey(context, apiKey),
                ),
                if (state.status == AppsStatus.saving)
                  Positioned.fill(child: AppLoadingView(label: l10n.loading)),
              ],
            ),
            AppsViewMode.show => state.activeApp == null
                ? AppEmptyState(
                    title: l10n.appsEmptyTitle,
                    description: l10n.appsEmptyDescription,
                  )
                : AppShowView(
                    app: state.activeApp!,
                    onBack: context.read<AppsCubit>().backToIndex,
                    onEdit: () =>
                        context.read<AppsCubit>().editApp(state.activeApp!),
                    onCopyApiKey: (apiKey) => _copyApiKey(context, apiKey),
                    onDelete: () => _confirmDeleteOne(context, state.activeApp!),
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

  Future<void> _confirmDeleteOne(BuildContext context, AppModel app) async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AppConfirmDialog(
        title: l10n.appsDeleteTitle,
        description: l10n.appsDeleteDescription(app.name),
        confirmLabel: l10n.appsDeleteAction,
        cancelLabel: l10n.cancel,
      ),
    );
    if (confirmed == true && context.mounted) {
      await context.read<AppsCubit>().deleteApp(app, l10n);
    }
  }

  Future<void> _confirmDeleteSelected(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
    final selectedCount = context.read<AppsCubit>().state.selectedIds.length;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AppConfirmDialog(
        title: l10n.appsBulkDeleteTitle,
        description: l10n.appsBulkDeleteDescription(selectedCount),
        confirmLabel: l10n.appsBulkDeleteAction,
        cancelLabel: l10n.cancel,
      ),
    );
    if (confirmed == true && context.mounted) {
      await context.read<AppsCubit>().deleteSelected(l10n);
    }
  }

  Future<void> _confirmRegenerateApiKey(BuildContext context, AppModel app) async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AppConfirmDialog(
        title: l10n.appsRegenerateApiKeyTitle,
        description: l10n.appsRegenerateApiKeyDescription(app.name),
        confirmLabel: l10n.appsRegenerateApiKeyAction,
        cancelLabel: l10n.cancel,
      ),
    );
    if (confirmed == true && context.mounted) {
      await context.read<AppsCubit>().regenerateApiKey(app, l10n);
    }
  }

  Future<void> _copyApiKey(BuildContext context, String apiKey) async {
    await Clipboard.setData(ClipboardData(text: apiKey));
    if (!context.mounted) {
      return;
    }
    context.read<AppsCubit>().notifyApiKeyCopied(AppLocalizations.of(context)!);
  }
}
