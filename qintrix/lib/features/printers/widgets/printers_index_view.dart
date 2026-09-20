import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lucide_flutter/lucide_flutter.dart';
import 'package:qintrix/core/widgets/exports.dart';
import 'package:qintrix/data/models/exports.dart';
import 'package:qintrix/features/printers/helpers/printer_status_localizer.dart';
import 'package:qintrix/l10n/app_localizations.dart';
import 'package:qintrix/theme/tokens/color_tokens.dart';

class PrintersIndexView extends StatelessWidget {
  const PrintersIndexView({
    required this.printers,
    required this.query,
    required this.totalCount,
    required this.selectedIds,
    required this.onToggleSelection,
    required this.onCreate,
    required this.onDeleteSelected,
    required this.onCopyIdentifier,
    required this.onSearchChanged,
    required this.onTypeChanged,
    required this.onStatusChanged,
    required this.onResetFilters,
    required this.onPageSelected,
    required this.onRowsPerPageChanged,
    required this.onShow,
    required this.onEdit,
    required this.onTestConnection,
    required this.onDelete,
    super.key,
  });

  final List<PrinterModel> printers;
  final PrintersQuery query;
  final int totalCount;
  final Set<String> selectedIds;
  final ValueChanged<String> onToggleSelection;
  final VoidCallback onCreate;
  final VoidCallback onDeleteSelected;
  final ValueChanged<String> onCopyIdentifier;
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<String> onTypeChanged;
  final ValueChanged<String> onStatusChanged;
  final VoidCallback onResetFilters;
  final ValueChanged<int> onPageSelected;
  final ValueChanged<int> onRowsPerPageChanged;
  final ValueChanged<PrinterModel> onShow;
  final ValueChanged<PrinterModel> onEdit;
  final ValueChanged<PrinterModel> onTestConnection;
  final ValueChanged<PrinterModel> onDelete;

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
                  label: l10n.printersBulkDeleteAction,
                  leading: LucideIcons.trash2,
                  variant: AppButtonVariant.secondary,
                  onPressed: selectedIds.isEmpty
                      ? null
                      : onDeleteSelected,
                ),
                const SizedBox(width: 12),
                if (selectedIds.isNotEmpty)
                  Text(
                    l10n.printersSelectedCount(selectedIds.length),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
              ],
            );

            final createButton = AppButton(
              label: l10n.printersCreateAction,
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
          child: AppDataTable<PrinterModel>(
            rows: printers,
            searchFieldWidth: 164,
            searchValue: query.search,
            onSearchChanged: onSearchChanged,
            searchHintText: l10n.printersSearchPlaceholder,
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
                width: 164,
                child: AppDropdownField<String>(
                  label: l10n.printersFilterConnectionType,
                  value: query.connectionType.isEmpty
                      ? null
                      : query.connectionType,
                  isDense: true,
                  onChanged: (value) => onTypeChanged(value ?? ''),
                  items: [
                    DropdownMenuItem<String>(
                      value: null,
                      child: _PrinterFilterOptionRow(
                        icon: LucideIcons.slidersHorizontal,
                        label: l10n.printersFilterAllTypes,
                      ),
                    ),
                    DropdownMenuItem<String>(
                      value: PrinterConnectionType.networkTcp.value,
                      child: _PrinterFilterOptionRow(
                        icon: LucideIcons.network,
                        label: l10n.printersTypeTcp,
                      ),
                    ),
                    DropdownMenuItem<String>(
                      value: PrinterConnectionType.systemSpooler.value,
                      child: _PrinterFilterOptionRow(
                        icon: LucideIcons.printer,
                        label: l10n.printersTypeSystem,
                      ),
                    ),
                    DropdownMenuItem<String>(
                      value: PrinterConnectionType.usbRawEscPos.value,
                      child: _PrinterFilterOptionRow(
                        icon: LucideIcons.usb,
                        label: l10n.printersTypeUsbRaw,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 164,
                child: AppDropdownField<String>(
                  label: l10n.printersFilterStatus,
                  value: query.status.isEmpty ? null : query.status,
                  isDense: true,
                  onChanged: (value) => onStatusChanged(value ?? ''),
                  items: [
                    DropdownMenuItem<String>(
                      value: null,
                      child: _PrinterFilterOptionRow(
                        icon: LucideIcons.listFilter,
                        label: l10n.printersFilterAllStatuses,
                      ),
                    ),
                    DropdownMenuItem<String>(
                      value: 'enabled',
                      child: _PrinterFilterOptionRow(
                        icon: LucideIcons.badgeCheck,
                        label: l10n.printersStatusEnabled,
                      ),
                    ),
                    DropdownMenuItem<String>(
                      value: 'disabled',
                      child: _PrinterFilterOptionRow(
                        icon: LucideIcons.circleOff,
                        label: l10n.printersStatusDisabled,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            emptyTitle: l10n.printersEmptyTitle,
            emptyDescription: l10n.printersEmptyDescription,
            columns: [
              AppDataTableColumn<PrinterModel>(
                label: '',
                width: 44,
                alignment: AlignmentDirectional.center,
                cellBuilder: (context, printer) => Transform.scale(
                  scale: 0.92,
                  child: Checkbox(
                    value: selectedIds.contains(printer.id),
                    onChanged: (_) => onToggleSelection(printer.id),
                  ),
                ),
              ),
              AppDataTableColumn<PrinterModel>(
                label: l10n.printersColumnName,
                cellBuilder: (context, printer) => Text(
                  printer.name,
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w700),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              AppDataTableColumn<PrinterModel>(
                label: l10n.printersColumnIdentifier,
                width: 150,
                cellBuilder: (context, printer) => InkWell(
                  onTap: () => onCopyIdentifier(printer.uniqueKey),
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
                            printer.uniqueKey,
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
              AppDataTableColumn<PrinterModel>(
                label: l10n.printersColumnConnectionType,
                width: 112,
                cellBuilder: (context, printer) => StatusBadge(
                  label: _connectionTypeTableLabel(
                    l10n,
                    printer.connectionType,
                  ),
                  tone: AppStatusTone.info,
                  size: StatusBadgeSize.small,
                ),
              ),
              AppDataTableColumn<PrinterModel>(
                label: l10n.printersColumnEnabled,
                width: 96,
                cellBuilder: (context, printer) => StatusBadge(
                  label: printer.isEnabled
                      ? l10n.printersStatusEnabled
                      : l10n.printersStatusDisabled,
                  tone: printer.isEnabled
                      ? AppStatusTone.success
                      : AppStatusTone.info,
                  size: StatusBadgeSize.small,
                ),
              ),
              AppDataTableColumn<PrinterModel>(
                label: l10n.printersColumnLastStatus,
                width: 110,
                cellBuilder: (context, printer) => Text(
                  printerStatusSummary(l10n, printer),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: printer.lastStatusKey == null &&
                            printer.lastStatus == null
                        ? Theme.of(
                            context,
                          ).textTheme.bodySmall?.color?.withValues(alpha: 0.55)
                        : null,
                  ),
                ),
              ),
              AppDataTableColumn<PrinterModel>(
                label: l10n.printersColumnUpdatedAt,
                width: 134,
                cellBuilder: (context, printer) =>
                    Text(_dateLabel(printer.updatedAt)),
              ),
              AppDataTableColumn<PrinterModel>(
                label: l10n.printersColumnActions,
                width: 48,
                alignment: AlignmentDirectional.center,
                cellBuilder: (context, printer) => _PrinterRowActionsMenu(
                  tooltip: l10n.printersColumnActions,
                  showLabel: l10n.printersShowAction,
                  editLabel: l10n.printersEditAction,
                  testConnectionLabel: l10n.printersTestConnectionAction,
                  deleteLabel: l10n.printersDeleteAction,
                  onShow: () => onShow(printer),
                  onEdit: () => onEdit(printer),
                  onTestConnection: () => onTestConnection(printer),
                  onDelete: () => onDelete(printer),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  bool get _hasActiveFilters =>
      query.search.isNotEmpty ||
      query.connectionType.isNotEmpty ||
      query.status.isNotEmpty;

  String _dateLabel(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd hh:mm a').format(dateTime);
  }

  String _connectionTypeTableLabel(
    AppLocalizations l10n,
    PrinterConnectionType type,
  ) {
    return switch (type) {
      PrinterConnectionType.networkTcp => l10n.printersTypeTcpShort,
      PrinterConnectionType.systemSpooler => l10n.printersTypeSystemShort,
      PrinterConnectionType.usbRawEscPos => l10n.printersTypeUsbRawShort,
    };
  }
}

class _PrinterFilterOptionRow extends StatelessWidget {
  const _PrinterFilterOptionRow({required this.icon, required this.label});

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

enum _PrinterRowAction { show, edit, testConnection, delete }

class _PrinterRowActionsMenu extends StatelessWidget {
  const _PrinterRowActionsMenu({
    required this.tooltip,
    required this.showLabel,
    required this.editLabel,
    required this.testConnectionLabel,
    required this.deleteLabel,
    required this.onShow,
    required this.onEdit,
    required this.onTestConnection,
    required this.onDelete,
  });

  final String tooltip;
  final String showLabel;
  final String editLabel;
  final String testConnectionLabel;
  final String deleteLabel;
  final VoidCallback onShow;
  final VoidCallback onEdit;
  final VoidCallback onTestConnection;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return PopupMenuButton<_PrinterRowAction>(
      tooltip: tooltip,
      padding: EdgeInsets.zero,
      splashRadius: 18,
      icon: Icon(
        LucideIcons.ellipsis,
        size: 16,
        color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.82),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 10,
      position: PopupMenuPosition.under,
      onSelected: (action) {
        switch (action) {
          case _PrinterRowAction.show:
            onShow();
          case _PrinterRowAction.edit:
            onEdit();
          case _PrinterRowAction.testConnection:
            onTestConnection();
          case _PrinterRowAction.delete:
            onDelete();
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem<_PrinterRowAction>(
          height: 36,
          value: _PrinterRowAction.show,
          child: _ActionMenuItem(icon: LucideIcons.eye, label: showLabel),
        ),
        PopupMenuItem<_PrinterRowAction>(
          height: 36,
          value: _PrinterRowAction.edit,
          child: _ActionMenuItem(icon: LucideIcons.squarePen, label: editLabel),
        ),
        PopupMenuItem<_PrinterRowAction>(
          height: 36,
          value: _PrinterRowAction.testConnection,
          child: _ActionMenuItem(
            icon: LucideIcons.plugZap,
            label: testConnectionLabel,
          ),
        ),
        PopupMenuItem<_PrinterRowAction>(
          height: 36,
          value: _PrinterRowAction.delete,
          child: _ActionMenuItem(
            icon: LucideIcons.trash2,
            label: deleteLabel,
            destructive: true,
          ),
        ),
      ],
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
