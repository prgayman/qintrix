import 'package:flutter/material.dart';

class AppLoadingView extends StatelessWidget {
  const AppLoadingView({required this.label, this.dense = false, super.key});

  final String label;
  final bool dense;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        return _StateViewport(
          constraints: constraints,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: dense ? 320 : 380),
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: dense ? 26 : 30,
                  height: dense ? 26 : 30,
                  child: const CircularProgressIndicator(strokeWidth: 2.4),
                ),
                Padding(
                  padding: EdgeInsets.only(top: dense ? 54 : 60),
                  child: Text(
                    label,
                    style: theme.textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class AppEmptyState extends StatelessWidget {
  const AppEmptyState({
    required this.title,
    required this.description,
    this.dense = false,
    super.key,
  });

  final String title;
  final String description;
  final bool dense;

  @override
  Widget build(BuildContext context) {
    return _StateContainer(
      icon: Icons.inbox_rounded,
      title: title,
      description: description,
      dense: dense,
    );
  }
}

class AppErrorState extends StatelessWidget {
  const AppErrorState({
    required this.title,
    required this.description,
    this.action,
    this.dense = false,
    super.key,
  });

  final String title;
  final String description;
  final Widget? action;
  final bool dense;

  @override
  Widget build(BuildContext context) {
    return _StateContainer(
      icon: Icons.error_outline_rounded,
      title: title,
      description: description,
      action: action,
      dense: dense,
    );
  }
}

class _StateContainer extends StatelessWidget {
  const _StateContainer({
    required this.icon,
    required this.title,
    required this.description,
    this.action,
    required this.dense,
  });

  final IconData icon;
  final String title;
  final String description;
  final Widget? action;
  final bool dense;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        return _StateViewport(
          constraints: constraints,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: dense ? 360 : 420),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  size: dense ? 36 : 44,
                  color: theme.colorScheme.primary,
                ),
                SizedBox(height: dense ? 12 : 16),
                Text(
                  title,
                  style: dense
                      ? theme.textTheme.titleMedium
                      : theme.textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: theme.textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                if (action != null) ...[const SizedBox(height: 16), action!],
              ],
            ),
          ),
        );
      },
    );
  }
}

class _StateViewport extends StatelessWidget {
  const _StateViewport({required this.constraints, required this.child});

  final BoxConstraints constraints;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final hasBoundedHeight = constraints.hasBoundedHeight;
    final hasBoundedWidth = constraints.hasBoundedWidth;

    final centeredChild = Center(child: child);

    if (!hasBoundedHeight && !hasBoundedWidth) {
      return centeredChild;
    }

    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: hasBoundedWidth ? constraints.maxWidth : 0,
        minHeight: hasBoundedHeight ? constraints.maxHeight : 0,
      ),
      child: centeredChild,
    );
  }
}
