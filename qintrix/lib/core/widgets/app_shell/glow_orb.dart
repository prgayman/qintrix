import 'package:flutter/material.dart';

class GlowOrb extends StatelessWidget {
  const GlowOrb({required this.color, required this.size, super.key});

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              color,
              color.withValues(alpha: color.a * 0.2),
              color.withValues(alpha: 0),
            ],
          ),
        ),
      ),
    );
  }
}
