import 'package:flutter/material.dart';

class SidebarBrand extends StatelessWidget {
  const SidebarBrand({required this.isExpanded, super.key});

  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOutCubic,
      padding: EdgeInsets.symmetric(
        horizontal: isExpanded ? 8 : 0,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: Colors.white.withValues(alpha: 0.04),
        border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
      ),
      child: isExpanded
          ? Row(
              children: [
                _BrandLogo(isExpanded: isExpanded),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Qintrix',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        'Print Agent',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          : const Center(child: _BrandLogo(isExpanded: false)),
    );
  }
}

class _BrandLogo extends StatelessWidget {
  const _BrandLogo({required this.isExpanded});

  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      key: const ValueKey('sidebar-logo'),
      width: 34,
      height: 34,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: const LinearGradient(
            colors: [Color(0xFF0B5ED7), Color(0xFF27C2F3)],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(isExpanded ? 6.5 : 7.5),
          child: Image.asset('assets/logo-trans.png'),
        ),
      ),
    );
  }
}
