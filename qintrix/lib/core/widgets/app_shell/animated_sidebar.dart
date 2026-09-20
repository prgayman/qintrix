import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_flutter/lucide_flutter.dart';
import 'package:qintrix/app/exports.dart';
import 'package:qintrix/core/widgets/app_shell/sidebar_brand.dart';
import 'package:qintrix/core/widgets/app_shell/sidebar_item.dart';
import 'package:qintrix/l10n/app_localizations.dart';
import 'package:qintrix/theme/tokens/color_tokens.dart';
import 'package:qintrix/theme/tokens/radius_tokens.dart';
import 'package:qintrix/theme/tokens/shadow_tokens.dart';

class AnimatedSidebar extends StatelessWidget {
  const AnimatedSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return BlocBuilder<SidebarCubit, bool>(
      builder: (context, isExpanded) {
        return AnimatedContainer(
          key: const ValueKey('app-sidebar'),
          duration: const Duration(milliseconds: 280),
          curve: Curves.easeOutCubic,
          width: isExpanded ? 204 : 64,
          padding: const EdgeInsets.fromLTRB(8, 10, 8, 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadiusTokens.xl),
            color: theme.brightness == Brightness.dark
                ? AppColorTokens.darkSurface.withValues(alpha: 0.96)
                : const Color(0xFF12203A).withValues(alpha: 0.985),
            border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
            boxShadow: [
              ...AppShadowTokens.soft(Colors.black),
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.18),
                blurRadius: 26,
                offset: const Offset(0, 14),
              ),
            ],
          ),
          child: Column(
            children: [
              SidebarBrand(isExpanded: isExpanded),
              const SizedBox(height: 14),
              Expanded(
                child: BlocBuilder<ShellNavigationCubit, AppDestination>(
                  builder: (context, currentDestination) {
                    return Column(
                      children: [
                        for (final destination in AppDestination.values)
                          SidebarItem(
                            destination: destination,
                            isExpanded: isExpanded,
                            isSelected: currentDestination == destination,
                          ),
                      ],
                    );
                  },
                ),
              ),
              Align(
                alignment: AlignmentDirectional.center,
                child: IconButton(
                  tooltip: isExpanded
                      ? l10n.shellCollapseSidebar
                      : l10n.shellExpandSidebar,
                  onPressed: () => context.read<SidebarCubit>().toggle(),
                  style: IconButton.styleFrom(
                    fixedSize: const Size(36, 36),
                    backgroundColor: Colors.white.withValues(alpha: 0.06),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadiusTokens.md),
                    ),
                  ),
                  icon: Icon(
                    isExpanded
                        ? LucideIcons.chevronLeft
                        : LucideIcons.chevronRight,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
