import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lucide_flutter/lucide_flutter.dart';
import 'package:qintrix/core/widgets/exports.dart';
import 'package:qintrix/data/models/exports.dart';
import 'package:qintrix/features/apps/helpers/app_access_summary.dart';
import 'package:qintrix/l10n/app_localizations.dart';
import 'package:qintrix/theme/tokens/color_tokens.dart';

class AppsIndexView extends StatelessWidget {
  const AppsIndexView({
    required this.apps,
    required this.query,
    required this.totalCount,
    required this.selectedIds,
    required this.onToggleSelection,
    required this.onCreate,
    required this.onDeleteSelected,
    required this.onCopyApiKey,
    required this.onSearchChanged,
    required this.onStatusChanged,
    required this.onScopeChanged,
    required this.onResetFilters,
    required this.onPageSelected,
    required this.onRowsPerPageChanged,
    required this.onShow,
    required this.onEdit,
    required this.onRegenerateApiKey,
    required this.onDelete,
    super.key,
  });

  final List<AppModel> apps;
  final AppsQuery query;
  final int totalCount;
  final Set<String> selectedIds;
  final ValueChanged<String> onToggleSelection;
  final VoidCallback onCreate;
  final VoidCallback onDeleteSelected;
  final ValueChanged<String> onCopyApiKey;
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<String> onStatusChanged;
  final ValueChanged<String> onScopeChanged;
  final VoidCallback onResetFilters;
  final ValueChanged<int> onPageSelected;
  final ValueChanged<int> onRowsPerPageChanged;
  final ValueChanged<AppModel> onShow;
  final ValueChanged<AppModel> onEdit;
  final ValueChanged<AppModel> onRegenerateApiKey;
  final ValueChanged<AppModel> onDelete;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            final bulkActions = Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppButton(
                  label: l10n.appsBulkDeleteAction,
                  leading: LucideIcons.trash2,
                  variant: AppButtonVariant.secondary,
                  onPressed: selectedIds.isEmpty ? null : onDeleteSelected,
                ),
                const SizedBox(width: 12),
                if (selectedIds.isNotEmpty)
                  Text(
                    l10n.appsSelectedCount(selectedIds.length),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
              ],
            );

            final createButton = AppButton(
              label: l10n.appsCreateAction,
              leading: LucideIcons.plus,
              onPressed: onCreate,
            );

            if (constraints.maxWidth < 860) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  bulkActions,
                  const SizedBox(height: 12),
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: createButton,
                  ),
                ],
              );
            }

            return Row(children: [bulkActions, const Spacer(), createButton]);
          },
        ),
        const SizedBox(height: 14),
        Expanded(
          child: AppDataTable<AppModel>(
            rows: apps,
            searchValue: query.search,
            onSearchChanged: onSearchChanged,
            searchHintText: l10n.appsSearchPlaceholder,
            hasActiveFilters: _hasActiveFilters,
            resetFiltersLabel: l10n.logsResetFilters,
            onResetFilters: onResetFilters,
            currentPage: query.page,
            totalRows: totalCount,
            rowsPerPage: query.pageSize,
            onPageSelected: onPageSelected,
            onRowsPerPageChanged: onRowsPerPageChanged,
            filters: [
              SizedBox(
                width: 180,
                child: AppDropdownField<String>(
                  label: l10n.appsFilterStatus,
                  value: query.status.isEmpty ? null : query.status,
                  isDense: true,
                  onChanged: (value) => onStatusChanged(value ?? ''),
                  items: [
                    DropdownMenuItem<String>(
                      value: null,
                      child: Text(l10n.appsFilterAllStatuses),
                    ),
                    DropdownMenuItem<String>(
                      value: 'enabled',
                      child: Text(l10n.appsStatusEnabled),
                    ),
                    DropdownMenuItem<String>(
                      value: 'disabled',
                      child: Text(l10n.appsStatusDisabled),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 200,
                child: AppDropdownField<String>(
                  label: l10n.appsFilterPrinterScope,
                  value: query.scope.isEmpty ? null : query.scope,
                  isDense: true,
                  onChanged: (value) => onScopeChanged(value ?? ''),
                  items: [
                    DropdownMenuItem<String>(
                      value: null,
                      child: Text(l10n.appsFilterAllScopes),
                    ),
                    DropdownMenuItem<String>(
                      value: 'all',
                      child: Text(l10n.appsAllPrintersAccess),
                    ),
                    DropdownMenuItem<String>(
                      value: 'restricted',
                      child: Text(l10n.appsRestrictedPrintersLabel),
                    ),
                  ],
                ),
              ),
            ],
            emptyTitle: l10n.appsEmptyTitle,
            emptyDescription: l10n.appsEmptyDescription,
            columns: [
              AppDataTableColumn<AppModel>(
                label: '',
                width: 44,
                alignment: AlignmentDirectional.center,
                cellBuilder: (context, app) => Transform.scale(
                  scale: 0.92,
                  child: Checkbox(
                    value: selectedIds.contains(app.id),
                    onChanged: (_) => onToggleSelection(app.id),
                  ),
                ),
              ),
              AppDataTableColumn<AppModel>(
                label: l10n.appsColumnName,
                width: 180,
                cellBuilder: (context, app) => Text(
                  app.name,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              AppDataTableColumn<AppModel>(
                label: l10n.appsColumnApiKey,
                width: 180,
                cellBuilder: (context, app) => InkWell(
                  onTap: () => onCopyApiKey(app.apiKey),
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Theme.of(
                          context,
                        ).dividerColor.withValues(alpha: 0.65),
                      ),
                      color: Theme.of(
                        context,
                      ).colorScheme.surface.withValues(alpha: 0.6),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Text(
                            _apiKeyPreview(app.apiKey),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(fontWeight: FontWeight.w700),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Icon(
                          LucideIcons.copy,
                          size: 14,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              AppDataTableColumn<AppModel>(
                label: l10n.appsColumnPrinters,
                cellBuilder: (context, app) => Text(
                  AppAccessSummary.forApp(l10n, app),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.color
                        ?.withValues(alpha: 0.84),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              AppDataTableColumn<AppModel>(
                label: l10n.appsColumnEnabled,
                width: 112,
                cellBuilder: (context, app) => StatusBadge(
                  label: app.isEnabled ? l10n.appsStatusEnabled : l10n.appsStatusDisabled,
                  tone: app.isEnabled ? AppStatusTone.success : AppStatusTone.info,
                  size: StatusBadgeSize.small,
                ),
              ),
              AppDataTableColumn<AppModel>(
                label: l10n.appsColumnUpdatedAt,
                width: 148,
                cellBuilder: (context, app) => Text(
                  DateFormat('yyyy-MM-dd hh:mm a').format(app.updatedAt),
                ),
              ),
              AppDataTableColumn<AppModel>(
                label: l10n.appsColumnActions,
                width: 56,
                alignment: AlignmentDirectional.center,
                cellBuilder: (context, app) => PopupMenuButton<_AppRowAction>(
                  tooltip: l10n.appsColumnActions,
                  padding: EdgeInsets.zero,
                  splashRadius: 18,
                  icon: Icon(
                    LucideIcons.ellipsis,
                    size: 16,
                    color: Theme.of(context).textTheme.bodySmall?.color?.withValues(alpha: 0.82),
                  ),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 10,
                  position: PopupMenuPosition.under,
                  onSelected: (action) {
                    switch (action) {
                      case _AppRowAction.show:
                        onShow(app);
                      case _AppRowAction.edit:
                        onEdit(app);
                      case _AppRowAction.regenerateApiKey:
                        onRegenerateApiKey(app);
                      case _AppRowAction.delete:
                        onDelete(app);
                    }
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem<_AppRowAction>(
                      value: _AppRowAction.show,
                      height: 36,
                      child: _ActionMenuItem(
                        icon: LucideIcons.eye,
                        label: l10n.appsShowAction,
                      ),
                    ),
                    PopupMenuItem<_AppRowAction>(
                      value: _AppRowAction.edit,
                      height: 36,
                      child: _ActionMenuItem(
                        icon: LucideIcons.squarePen,
                        label: l10n.appsEditAction,
                      ),
                    ),
                    PopupMenuItem<_AppRowAction>(
                      value: _AppRowAction.regenerateApiKey,
                      height: 36,
                      child: _ActionMenuItem(
                        icon: LucideIcons.refreshCw,
                        label: l10n.appsRegenerateApiKeyAction,
                      ),
                    ),
                    PopupMenuItem<_AppRowAction>(
                      value: _AppRowAction.delete,
                      height: 36,
                      child: _ActionMenuItem(
                        icon: LucideIcons.trash2,
                        label: l10n.appsDeleteAction,
                        destructive: true,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  bool get _hasActiveFilters =>
      query.search.isNotEmpty || query.status.isNotEmpty || query.scope.isNotEmpty;

  String _apiKeyPreview(String apiKey) {
    if (apiKey.length <= 14) {
      return apiKey;
    }

    return '${apiKey.substring(0, 10)}...';
  }
}

enum _AppRowAction { show, edit, regenerateApiKey, delete }

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
    final color = destructive ? theme.colorScheme.error : theme.textTheme.bodyMedium?.color;

    return Row(
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 10),
        Text(label, style: TextStyle(color: color, fontWeight: FontWeight.w600)),
      ],
    );
  }
}
