import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qintrix/app/exports.dart';
import 'package:qintrix/l10n/app_localizations.dart';

class SidebarItem extends StatelessWidget {
  const SidebarItem({
    required this.destination,
    required this.isExpanded,
    required this.isSelected,
    super.key,
  });

  final AppDestination destination;
  final bool isExpanded;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final labelStyle = Theme.of(context).textTheme.labelMedium?.copyWith(
      color: Colors.white,
      fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
    );
    final item = Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () =>
            context.read<ShellNavigationCubit>().setDestination(destination),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOutCubic,
          height: 40,
          padding: EdgeInsets.symmetric(horizontal: isExpanded ? 10 : 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: isSelected
                ? Colors.white.withValues(alpha: 0.08)
                : Colors.transparent,
            border: Border.all(
              color: isSelected
                  ? Colors.white.withValues(alpha: 0.1)
                  : Colors.transparent,
            ),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              if (!isExpanded || constraints.maxWidth <= 56) {
                return Center(
                  child: _SidebarIconChip(
                    icon: destination.icon,
                    isSelected: isSelected,
                  ),
                );
              }

              return Row(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    curve: Curves.easeOutCubic,
                    width: 3,
                    height: 18,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(999),
                      color: isSelected
                          ? const Color(0xFF27C2F3)
                          : Colors.transparent,
                    ),
                  ),
                  const SizedBox(width: 8),
                  _SidebarIconChip(
                    icon: destination.icon,
                    isSelected: isSelected,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      destination.label(l10n),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: labelStyle,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );

    if (!isExpanded) {
      return Tooltip(
        message: destination.label(l10n),
        waitDuration: const Duration(milliseconds: 350),
        child: item,
      );
    }

    return item;
  }
}

class _SidebarIconChip extends StatelessWidget {
  const _SidebarIconChip({required this.icon, required this.isSelected});

  final IconData icon;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: isSelected
            ? const Color(0xFF27C2F3).withValues(alpha: 0.18)
            : Colors.white.withValues(alpha: 0.05),
      ),
      child: Icon(
        icon,
        color: isSelected ? Colors.white : Colors.white70,
        size: 16,
      ),
    );
  }
}
