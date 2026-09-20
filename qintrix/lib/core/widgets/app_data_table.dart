import 'package:flutter/material.dart';
import 'package:lucide_flutter/lucide_flutter.dart';
import 'package:qintrix/core/widgets/exports.dart';
import 'package:qintrix/core/widgets/filter_bar_control_style.dart';
import 'package:qintrix/l10n/app_localizations.dart';

typedef AppTableCellBuilder<T> = Widget Function(BuildContext context, T row);

class AppDataTableColumn<T> {
  const AppDataTableColumn({
    required this.label,
    required this.cellBuilder,
    this.width,
    this.alignment = AlignmentDirectional.centerStart,
  });

  final String label;
  final AppTableCellBuilder<T> cellBuilder;
  final double? width;
  final AlignmentGeometry alignment;
}

class AppDataTable<T> extends StatefulWidget {
  const AppDataTable({
    required this.columns,
    required this.rows,
    this.emptyTitle,
    this.emptyDescription,
    this.searchValue,
    this.onSearchChanged,
    this.searchHintText,
    this.searchFieldWidth = FilterBarControlStyle.compactWidth,
    this.filters = const [],
    this.hasActiveFilters = false,
    this.onResetFilters,
    this.resetFiltersLabel,
    this.initialRowsPerPage = 10,
    this.rowsPerPageOptions = const [10, 20, 50],
    this.currentPage,
    this.totalRows,
    this.rowsPerPage,
    this.onPageSelected,
    this.onRowsPerPageChanged,
    super.key,
  });

  final List<AppDataTableColumn<T>> columns;
  final List<T> rows;
  final String? emptyTitle;
  final String? emptyDescription;
  final String? searchValue;
  final ValueChanged<String>? onSearchChanged;
  final String? searchHintText;
  final double searchFieldWidth;
  final List<Widget> filters;
  final bool hasActiveFilters;
  final VoidCallback? onResetFilters;
  final String? resetFiltersLabel;
  final int initialRowsPerPage;
  final List<int> rowsPerPageOptions;
  final int? currentPage;
  final int? totalRows;
  final int? rowsPerPage;
  final ValueChanged<int>? onPageSelected;
  final ValueChanged<int>? onRowsPerPageChanged;

  @override
  State<AppDataTable<T>> createState() => _AppDataTableState<T>();
}

class _AppDataTableState<T> extends State<AppDataTable<T>> {
  late int _rowsPerPage;
  int _page = 0;

  bool get _isControlled =>
      widget.currentPage != null &&
      widget.totalRows != null &&
      widget.rowsPerPage != null &&
      widget.onPageSelected != null &&
      widget.onRowsPerPageChanged != null;

  @override
  void initState() {
    super.initState();
    _rowsPerPage = widget.initialRowsPerPage;
  }

  @override
  void didUpdateWidget(covariant AppDataTable<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_isControlled) {
      return;
    }
    if (widget.rows.length != oldWidget.rows.length) {
      final maxPage = _maxPage;
      if (_page > maxPage) {
        _page = maxPage;
      }
    }
  }

  int get _maxPage {
    final totalRows = _isControlled ? widget.totalRows! : widget.rows.length;
    final rowsPerPage = _isControlled ? widget.rowsPerPage! : _rowsPerPage;
    if (totalRows == 0) {
      return 0;
    }

    return ((totalRows - 1) / rowsPerPage).floor();
  }

  List<T> get _visibleRows {
    if (_isControlled) {
      return widget.rows;
    }
    final start = _page * _rowsPerPage;
    final end = (start + _rowsPerPage).clamp(0, widget.rows.length);
    if (start >= widget.rows.length) {
      return const [];
    }

    return widget.rows.sublist(start, end);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currentPage = _isControlled ? widget.currentPage! : _page;
    final rowsPerPage = _isControlled ? widget.rowsPerPage! : _rowsPerPage;
    final totalRows = _isControlled ? widget.totalRows! : widget.rows.length;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: theme.cardColor,
        border: Border.all(color: theme.dividerColor.withValues(alpha: 0.85)),
      ),
      child: Column(
        children: [
          _AppTableToolbar(
            searchValue: widget.searchValue,
            onSearchChanged: widget.onSearchChanged,
            searchHintText: widget.searchHintText,
            searchFieldWidth: widget.searchFieldWidth,
            filters: widget.filters,
            hasActiveFilters: widget.hasActiveFilters,
            resetFiltersLabel: widget.resetFiltersLabel,
            onResetFilters: widget.onResetFilters == null
                ? null
                : () {
                    setState(() {
                      _page = 0;
                    });
                    widget.onResetFilters!.call();
                  },
          ),
          Expanded(
            child: widget.rows.isEmpty
                ? AppEmptyState(
                    title: widget.emptyTitle ?? 'No rows available',
                    description:
                        widget.emptyDescription ?? 'There is nothing to show.',
                    dense: true,
                  )
                : Column(
                    children: [
                      _AppTableHeader<T>(columns: widget.columns),
                      Expanded(
                        child: ListView.separated(
                          itemCount: _visibleRows.length,
                          separatorBuilder: (_, _) => Divider(
                            height: 1,
                            color: theme.dividerColor.withValues(alpha: 0.65),
                          ),
                          itemBuilder: (context, index) {
                            return _AppTableRow<T>(
                              row: _visibleRows[index],
                              columns: widget.columns,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
          ),
          if (widget.rows.isNotEmpty)
            _AppTablePagination(
              totalRows: totalRows,
              currentPage: currentPage,
              rowsPerPage: rowsPerPage,
              rowsPerPageOptions: widget.rowsPerPageOptions,
              onPageSelected: (page) {
                if (_isControlled) {
                  widget.onPageSelected!(page);
                  return;
                }
                setState(() {
                  _page = page;
                });
              },
              onPreviousPage: currentPage == 0
                  ? null
                  : () {
                      if (_isControlled) {
                        widget.onPageSelected!(currentPage - 1);
                        return;
                      }
                      setState(() {
                        _page -= 1;
                      });
                    },
              onNextPage: currentPage >= _maxPage
                  ? null
                  : () {
                      if (_isControlled) {
                        widget.onPageSelected!(currentPage + 1);
                        return;
                      }
                      setState(() {
                        _page += 1;
                      });
                    },
              onRowsPerPageChanged: (value) {
                if (value == null) {
                  return;
                }
                if (_isControlled) {
                  widget.onRowsPerPageChanged!(value);
                  return;
                }
                setState(() {
                  _rowsPerPage = value;
                  _page = 0;
                });
              },
            ),
        ],
      ),
    );
  }
}

class _AppTableToolbar extends StatelessWidget {
  const _AppTableToolbar({
    required this.searchValue,
    required this.onSearchChanged,
    required this.searchHintText,
    required this.searchFieldWidth,
    required this.filters,
    required this.hasActiveFilters,
    required this.onResetFilters,
    required this.resetFiltersLabel,
  });

  final String? searchValue;
  final ValueChanged<String>? onSearchChanged;
  final String? searchHintText;
  final double searchFieldWidth;
  final List<Widget> filters;
  final bool hasActiveFilters;
  final VoidCallback? onResetFilters;
  final String? resetFiltersLabel;

  @override
  Widget build(BuildContext context) {
    if (onSearchChanged == null && filters.isEmpty && onResetFilters == null) {
      return const SizedBox.shrink();
    }

    final baseTheme = Theme.of(context);
    final compactTheme = baseTheme.copyWith(
      inputDecorationTheme: baseTheme.inputDecorationTheme.copyWith(
        fillColor: FilterBarControlStyle.controlFillColor(baseTheme),
        contentPadding: FilterBarControlStyle.controlPadding,
        border: OutlineInputBorder(
          borderRadius: FilterBarControlStyle.controlRadius,
          borderSide: FilterBarControlStyle.controlBorder(
            baseTheme,
            focused: false,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: FilterBarControlStyle.controlRadius,
          borderSide: FilterBarControlStyle.controlBorder(
            baseTheme,
            focused: false,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: FilterBarControlStyle.controlRadius,
          borderSide: FilterBarControlStyle.controlBorder(
            baseTheme,
            focused: true,
          ),
        ),
      ),
    );

    final searchField = onSearchChanged == null
        ? const SizedBox.shrink()
        : SizedBox(
            width: searchFieldWidth,
            child: SizedBox(
              height: FilterBarControlStyle.controlHeight,
              child: TextField(
                controller: TextEditingController.fromValue(
                  TextEditingValue(
                    text: searchValue ?? '',
                    selection: TextSelection.collapsed(
                      offset: (searchValue ?? '').length,
                    ),
                  ),
                ),
                onChanged: onSearchChanged,
                style: baseTheme.textTheme.bodySmall,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  hintText: searchHintText,
                  prefixIcon: const Padding(
                    padding: EdgeInsetsDirectional.only(start: 10, end: 4),
                    child: Icon(
                      LucideIcons.search,
                      size: FilterBarControlStyle.iconSize,
                    ),
                  ),
                  prefixIconConstraints: const BoxConstraints(
                    minWidth: 30,
                    minHeight: 30,
                  ),
                ),
              ),
            ),
          );

    final rightChildren = <Widget>[
      ...filters,
      if (onResetFilters != null)
        _ResetFiltersButton(
          label: resetFiltersLabel ?? 'Reset filters',
          enabled: hasActiveFilters,
          onPressed: hasActiveFilters ? onResetFilters : null,
        ),
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 8),
      child: Theme(
        data: compactTheme,
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth < 720) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (onSearchChanged != null) searchField,
                  if (onSearchChanged != null && rightChildren.isNotEmpty)
                    const SizedBox(height: 6),
                  if (rightChildren.isNotEmpty)
                    Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        alignment: WrapAlignment.end,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: rightChildren,
                      ),
                    ),
                ],
              );
            }

            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (onSearchChanged != null) searchField,
                if (onSearchChanged != null && rightChildren.isNotEmpty)
                  const SizedBox(width: 8),
                if (rightChildren.isNotEmpty)
                  Expanded(
                    child: Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        alignment: WrapAlignment.end,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: rightChildren,
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _ResetFiltersButton extends StatelessWidget {
  const _ResetFiltersButton({
    required this.label,
    required this.enabled,
    required this.onPressed,
  });

  final String label;
  final bool enabled;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextButton.icon(
      onPressed: onPressed,
      icon: Icon(
        LucideIcons.rotateCcw,
        size: 15,
        color: enabled ? theme.colorScheme.primary : theme.disabledColor,
      ),
      label: Text(label),
      style: TextButton.styleFrom(
        padding: FilterBarControlStyle.controlPadding,
        foregroundColor: enabled
            ? theme.colorScheme.primary
            : theme.disabledColor,
        shape: const RoundedRectangleBorder(
          borderRadius: FilterBarControlStyle.controlRadius,
        ),
        backgroundColor: enabled
            ? theme.colorScheme.primary.withValues(alpha: 0.06)
            : theme.dividerColor.withValues(alpha: 0.12),
        textStyle: theme.textTheme.labelSmall?.copyWith(
          fontWeight: FontWeight.w600,
        ),
        minimumSize: const Size(0, FilterBarControlStyle.controlHeight),
      ),
    );
  }
}

class _AppTableHeader<T> extends StatelessWidget {
  const _AppTableHeader({required this.columns});

  final List<AppDataTableColumn<T>> columns;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withValues(alpha: 0.04),
        border: Border(
          top: BorderSide(color: theme.dividerColor.withValues(alpha: 0.65)),
          bottom: BorderSide(color: theme.dividerColor.withValues(alpha: 0.65)),
        ),
      ),
      child: Row(
        children: [
          for (final column in columns)
            _AppTableCell(
              width: column.width,
              alignment: column.alignment,
              child: Text(
                column.label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _AppTableRow<T> extends StatelessWidget {
  const _AppTableRow({required this.row, required this.columns});

  final T row;
  final List<AppDataTableColumn<T>> columns;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Row(
        children: [
          for (final column in columns)
            _AppTableCell(
              width: column.width,
              alignment: column.alignment,
              child: column.cellBuilder(context, row),
            ),
        ],
      ),
    );
  }
}

class _AppTableCell extends StatelessWidget {
  const _AppTableCell({
    required this.child,
    this.width,
    this.alignment = AlignmentDirectional.centerStart,
  });

  final Widget child;
  final double? width;
  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) {
    final content = Align(alignment: alignment, child: child);
    if (width != null) {
      return SizedBox(width: width, child: content);
    }

    return Expanded(child: content);
  }
}

class _AppTablePagination extends StatelessWidget {
  const _AppTablePagination({
    required this.totalRows,
    required this.currentPage,
    required this.rowsPerPage,
    required this.rowsPerPageOptions,
    required this.onPageSelected,
    required this.onPreviousPage,
    required this.onNextPage,
    required this.onRowsPerPageChanged,
  });

  final int totalRows;
  final int currentPage;
  final int rowsPerPage;
  final List<int> rowsPerPageOptions;
  final ValueChanged<int> onPageSelected;
  final VoidCallback? onPreviousPage;
  final VoidCallback? onNextPage;
  final ValueChanged<int?> onRowsPerPageChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = Localizations.of<AppLocalizations>(context, AppLocalizations);
    final start = totalRows == 0 ? 0 : currentPage * rowsPerPage + 1;
    final end = ((currentPage + 1) * rowsPerPage).clamp(0, totalRows);
    final totalPages = totalRows == 0
        ? 1
        : ((totalRows - 1) / rowsPerPage).floor() + 1;
    final visiblePages = _visiblePageIndexes(
      totalPages: totalPages,
      currentPage: currentPage,
      windowSize: 5,
    );

    return Container(
      padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: theme.dividerColor.withValues(alpha: 0.65)),
        ),
      ),
      child: Row(
        children: [
          Text('$start-$end of $totalRows', style: theme.textTheme.bodySmall),
          const Spacer(),
          SizedBox(
            width: FilterBarControlStyle.compactWidth / 1.5,
            child: AppDropdownField<int>(
              label: _rowsPerPageLabel(rowsPerPage, l10n),
              value: rowsPerPage,
              isDense: true,
              onChanged: onRowsPerPageChanged,
              items: rowsPerPageOptions
                  .map(
                    (value) => DropdownMenuItem<int>(
                      value: value,
                      child: Text(_rowsPerPageLabel(value, l10n)),
                    ),
                  )
                  .toList(growable: false),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            onPressed: onPreviousPage,
            icon: const Icon(LucideIcons.chevronLeft, size: 18),
          ),
          ...visiblePages.map(
            (pageIndex) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: _PageNumberButton(
                pageNumber: pageIndex + 1,
                isActive: pageIndex == currentPage,
                onTap: () => onPageSelected(pageIndex),
              ),
            ),
          ),
          IconButton(
            onPressed: onNextPage,
            icon: const Icon(LucideIcons.chevronRight, size: 18),
          ),
        ],
      ),
    );
  }

  String _rowsPerPageLabel(int value, AppLocalizations? l10n) {
    return l10n?.tableRowsPerPage(value) ?? '$value / page';
  }
}

List<int> _visiblePageIndexes({
  required int totalPages,
  required int currentPage,
  required int windowSize,
}) {
  if (totalPages <= windowSize) {
    return List<int>.generate(totalPages, (index) => index);
  }

  final halfWindow = windowSize ~/ 2;
  var start = currentPage - halfWindow;
  var end = start + windowSize - 1;

  if (start < 0) {
    start = 0;
    end = windowSize - 1;
  }

  if (end >= totalPages) {
    end = totalPages - 1;
    start = end - windowSize + 1;
  }

  return List<int>.generate(end - start + 1, (index) => start + index);
}

class _PageNumberButton extends StatelessWidget {
  const _PageNumberButton({
    required this.pageNumber,
    required this.isActive,
    required this.onTap,
  });

  final int pageNumber;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: isActive
          ? theme.colorScheme.primary.withValues(alpha: 0.12)
          : Colors.transparent,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: SizedBox(
          width: 32,
          height: 32,
          child: Center(
            child: Text(
              '$pageNumber',
              style: theme.textTheme.labelMedium?.copyWith(
                fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                color: isActive ? theme.colorScheme.primary : null,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
