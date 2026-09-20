import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_flutter/lucide_flutter.dart';
import 'package:qintrix/core/widgets/app_field_wrapper.dart';
import 'package:qintrix/core/widgets/filter_bar_control_style.dart';
import 'package:qintrix/core/widgets/form_control_style.dart';

class _ToggleDropdownIntent extends Intent {
  const _ToggleDropdownIntent();
}

class _MoveDropdownIntent extends Intent {
  const _MoveDropdownIntent(this.offset);

  final int offset;
}

class _SelectDropdownIntent extends Intent {
  const _SelectDropdownIntent();
}

class _DismissDropdownIntent extends Intent {
  const _DismissDropdownIntent();
}

class AppDropdownField<T> extends StatefulWidget {
  const AppDropdownField({
    required this.label,
    required this.items,
    required this.value,
    this.onChanged,
    this.isDense = false,
    this.required = false,
    super.key,
  });

  final String label;
  final List<DropdownMenuItem<T>> items;
  final T? value;
  final ValueChanged<T?>? onChanged;
  final bool isDense;
  final bool required;

  @override
  State<AppDropdownField<T>> createState() => _AppDropdownFieldState<T>();
}

class _AppDropdownFieldState<T> extends State<AppDropdownField<T>> {
  final LayerLink _layerLink = LayerLink();
  final GlobalKey _triggerKey = GlobalKey();
  final FocusNode _focusNode = FocusNode(debugLabel: 'AppDropdownField');
  static const double _overlayGap = 2;
  static const double _panelMaxHeight = 260;
  static const double _panelPadding = 6;
  static const double _itemSeparatorHeight = 2;
  OverlayEntry? _overlayEntry;
  bool _isOpen = false;
  int? _highlightedIndex;

  @override
  void dispose() {
    _removeOverlay(updateState: false);
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final selectedItem = _selectedItem;
    final selectedIndex = _selectedIndex;
    final isEnabled = widget.onChanged != null;
    final trigger = CompositedTransformTarget(
      link: _layerLink,
      child: FocusableActionDetector(
        focusNode: _focusNode,
        enabled: isEnabled,
        mouseCursor: isEnabled ? SystemMouseCursors.click : MouseCursor.defer,
        shortcuts: <ShortcutActivator, Intent>{
          const SingleActivator(LogicalKeyboardKey.enter):
              const _ToggleDropdownIntent(),
          const SingleActivator(LogicalKeyboardKey.space):
              const _ToggleDropdownIntent(),
          const SingleActivator(LogicalKeyboardKey.arrowDown):
              const _MoveDropdownIntent(1),
          const SingleActivator(LogicalKeyboardKey.arrowUp):
              const _MoveDropdownIntent(-1),
          const SingleActivator(LogicalKeyboardKey.escape):
              const _DismissDropdownIntent(),
        },
        actions: <Type, Action<Intent>>{
          _ToggleDropdownIntent: CallbackAction<_ToggleDropdownIntent>(
            onInvoke: (_) {
              if (isEnabled) {
                _toggleOverlay();
              }
              return null;
            },
          ),
          _MoveDropdownIntent: CallbackAction<_MoveDropdownIntent>(
            onInvoke: (intent) {
              if (!isEnabled) {
                return null;
              }
              _moveHighlight(intent.offset, selectedIndex);
              return null;
            },
          ),
          _SelectDropdownIntent: CallbackAction<_SelectDropdownIntent>(
            onInvoke: (_) {
              _selectHighlightedItem();
              return null;
            },
          ),
          _DismissDropdownIntent: CallbackAction<_DismissDropdownIntent>(
            onInvoke: (_) {
              _removeOverlay();
              return null;
            },
          ),
        },
        child: Semantics(
          button: true,
          focused: _focusNode.hasFocus,
          label: widget.label,
          child: InkWell(
            key: _triggerKey,
            onTap: isEnabled ? _toggleOverlay : null,
            borderRadius: FilterBarControlStyle.controlRadius,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 160),
              curve: Curves.easeOut,
              height: widget.isDense
                  ? FilterBarControlStyle.controlHeight
                  : FormControlStyle.controlHeight,
              padding: widget.isDense
                  ? FilterBarControlStyle.controlPadding
                  : FormControlStyle.controlPadding,
              decoration: BoxDecoration(
                borderRadius: widget.isDense
                    ? FilterBarControlStyle.controlRadius
                    : FormControlStyle.controlRadius,
                color: widget.isDense
                    ? FilterBarControlStyle.controlFillColor(theme)
                    : theme.inputDecorationTheme.fillColor,
                border: Border.fromBorderSide(
                  widget.isDense
                      ? FilterBarControlStyle.controlBorder(
                          theme,
                          focused: _isOpen || _focusNode.hasFocus,
                        )
                      : _standardControlBorder(
                          theme,
                          focused: _isOpen || _focusNode.hasFocus,
                        ),
                ),
                boxShadow: widget.isDense
                    ? FilterBarControlStyle.controlShadow(
                        theme,
                        focused: _isOpen || _focusNode.hasFocus,
                      )
                    : const [],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: DefaultTextStyle(
                      style: theme.textTheme.bodySmall!.copyWith(
                        color: selectedItem == null
                            ? theme.textTheme.bodySmall!.color?.withValues(
                                alpha: 0.7,
                              )
                            : theme.textTheme.bodySmall!.color,
                        fontWeight: selectedItem == null
                            ? FontWeight.w500
                            : FontWeight.w600,
                      ),
                      child: Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: selectedItem?.child ?? Text(widget.label),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    _isOpen ? LucideIcons.chevronUp : LucideIcons.chevronDown,
                    size: FilterBarControlStyle.iconSize,
                    color: theme.colorScheme.primary.withValues(
                      alpha: isEnabled ? 0.85 : 0.4,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    if (widget.isDense) {
      return trigger;
    }

    return AppFieldWrapper(
      label: widget.label,
      required: widget.required,
      child: trigger,
    );
  }

  DropdownMenuItem<T>? get _selectedItem {
    for (final item in widget.items) {
      if (item.value == widget.value) {
        return item;
      }
    }

    return null;
  }

  int get _selectedIndex {
    for (var index = 0; index < widget.items.length; index++) {
      if (widget.items[index].value == widget.value) {
        return index;
      }
    }

    return 0;
  }

  BorderSide _standardControlBorder(ThemeData theme, {required bool focused}) {
    final enabledBorder = theme.inputDecorationTheme.enabledBorder;
    final focusedBorder = theme.inputDecorationTheme.focusedBorder;
    if (focused && focusedBorder is OutlineInputBorder) {
      return focusedBorder.borderSide;
    }
    if (enabledBorder is OutlineInputBorder) {
      return enabledBorder.borderSide;
    }

    return BorderSide(
      color: theme.dividerColor.withValues(alpha: focused ? 0.95 : 0.86),
      width: focused ? 1.25 : 1,
    );
  }

  void _toggleOverlay() {
    if (_isOpen) {
      _removeOverlay();
      return;
    }

    _showOverlay();
  }

  void _showOverlay() {
    final overlay = Overlay.of(context);
    final triggerContext = _triggerKey.currentContext;
    if (triggerContext == null) {
      return;
    }

    final renderBox = triggerContext.findRenderObject() as RenderBox;
    final triggerSize = renderBox.size;
    final triggerOffset = renderBox.localToGlobal(Offset.zero);
    final screenSize = MediaQuery.sizeOf(context);
    final estimatedMenuHeight = _estimateMenuHeight();
    final spaceBelow =
        screenSize.height - (triggerOffset.dy + triggerSize.height);
    final spaceAbove = triggerOffset.dy;
    final openUpward =
        spaceBelow < estimatedMenuHeight + _overlayGap &&
        spaceAbove > spaceBelow;
    final textDirection = Directionality.of(context);
    final targetAnchor = openUpward
        ? (textDirection == TextDirection.rtl
              ? Alignment.topRight
              : Alignment.topLeft)
        : (textDirection == TextDirection.rtl
              ? Alignment.bottomRight
              : Alignment.bottomLeft);
    final followerAnchor = openUpward
        ? (textDirection == TextDirection.rtl
              ? Alignment.bottomRight
              : Alignment.bottomLeft)
        : (textDirection == TextDirection.rtl
              ? Alignment.topRight
              : Alignment.topLeft);
    final followerOffset = Offset(0, openUpward ? -_overlayGap : _overlayGap);

    _overlayEntry = OverlayEntry(
      builder: (context) {
        final theme = Theme.of(context);

        return Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: _removeOverlay,
              ),
            ),
            CompositedTransformFollower(
              link: _layerLink,
              showWhenUnlinked: false,
              targetAnchor: targetAnchor,
              followerAnchor: followerAnchor,
              offset: followerOffset,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: triggerSize.width,
                  constraints: const BoxConstraints(maxHeight: _panelMaxHeight),
                  decoration: FilterBarControlStyle.panelDecoration(theme),
                  child: ClipRRect(
                    borderRadius: FilterBarControlStyle.panelRadius,
                    child: ListView.separated(
                      padding: const EdgeInsets.all(_panelPadding),
                      shrinkWrap: true,
                      itemCount: widget.items.length,
                      separatorBuilder: (_, _) =>
                          const SizedBox(height: _itemSeparatorHeight),
                      itemBuilder: (context, index) {
                        final item = widget.items[index];
                        final isSelected = item.value == widget.value;
                        final isHighlighted = index == _highlightedIndex;

                        return MouseRegion(
                          onEnter: (_) {
                            if (_highlightedIndex != index) {
                              setState(() {
                                _highlightedIndex = index;
                              });
                              _overlayEntry?.markNeedsBuild();
                            }
                          },
                          child: InkWell(
                            borderRadius: FilterBarControlStyle.itemRadius,
                            onTap: () {
                              widget.onChanged?.call(item.value);
                              _removeOverlay();
                            },
                            child: Container(
                              height: FilterBarControlStyle.menuItemHeight,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: FilterBarControlStyle.itemRadius,
                                color: FilterBarControlStyle.menuItemBackground(
                                  theme,
                                  selected: isSelected,
                                  highlighted: isHighlighted,
                                ),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: DefaultTextStyle(
                                      style: theme.textTheme.bodySmall!
                                          .copyWith(
                                            fontWeight: isSelected
                                                ? FontWeight.w600
                                                : FontWeight.w500,
                                            color: isSelected
                                                ? theme.colorScheme.primary
                                                : theme
                                                      .textTheme
                                                      .bodySmall!
                                                      .color,
                                          ),
                                      child: item.child,
                                    ),
                                  ),
                                  if (isSelected) ...[
                                    const SizedBox(width: 8),
                                    Icon(
                                      LucideIcons.check,
                                      size: FilterBarControlStyle.iconSize,
                                      color: theme.colorScheme.primary,
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );

    overlay.insert(_overlayEntry!);
    if (mounted) {
      setState(() {
        _isOpen = true;
        _highlightedIndex = _selectedIndex;
      });
    }
  }

  void _removeOverlay({bool updateState = true}) {
    _overlayEntry?.remove();
    _overlayEntry = null;
    if (updateState && mounted && _isOpen) {
      setState(() {
        _isOpen = false;
        _highlightedIndex = null;
      });
      return;
    }

    _isOpen = false;
    _highlightedIndex = null;
  }

  void _moveHighlight(int offset, int fallbackIndex) {
    if (!_isOpen) {
      _showOverlay();
      return;
    }

    final nextIndex = ((_highlightedIndex ?? fallbackIndex) + offset).clamp(
      0,
      widget.items.length - 1,
    );
    setState(() {
      _highlightedIndex = nextIndex;
    });
    _overlayEntry?.markNeedsBuild();
  }

  void _selectHighlightedItem() {
    if (!_isOpen) {
      _showOverlay();
      return;
    }

    final index = _highlightedIndex ?? _selectedIndex;
    widget.onChanged?.call(widget.items[index].value);
    _removeOverlay();
  }

  double _estimateMenuHeight() {
    if (widget.items.isEmpty) {
      return 0;
    }

    final totalHeight =
        (widget.items.length * FilterBarControlStyle.menuItemHeight) +
        (_panelPadding * 2) +
        ((widget.items.length - 1) * _itemSeparatorHeight);

    return totalHeight.clamp(0, _panelMaxHeight).toDouble();
  }
}
