import 'package:flutter/material.dart';

class FormGrid extends StatelessWidget {
  const FormGrid({
    required this.children,
    this.minColumnWidth = 360,
    this.spacing = 14,
    this.runSpacing = 14,
    super.key,
  });

  final List<Widget> children;
  final double minColumnWidth;
  final double spacing;
  final double runSpacing;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columnWidth =
            constraints.maxWidth < (minColumnWidth * 2 + spacing)
            ? constraints.maxWidth
            : (constraints.maxWidth - spacing) / 2;

        return Wrap(
          spacing: spacing,
          runSpacing: runSpacing,
          children: [
            for (final child in children)
              SizedBox(width: columnWidth, child: child),
          ],
        );
      },
    );
  }
}
