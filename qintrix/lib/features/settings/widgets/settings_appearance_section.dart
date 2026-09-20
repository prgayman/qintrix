import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_flutter/lucide_flutter.dart';
import 'package:qintrix/app/exports.dart';
import 'package:qintrix/features/settings/widgets/settings_option_group.dart';
import 'package:qintrix/features/settings/widgets/settings_selection_tile.dart';
import 'package:qintrix/l10n/app_localizations.dart';

class SettingsAppearanceSection extends StatelessWidget {
  const SettingsAppearanceSection({required this.themeMode, super.key});

  final ThemeMode themeMode;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return SettingsOptionGroup(
      icon: LucideIcons.sunMoon,
      title: l10n.settingsAppearanceTitle,
      description: l10n.settingsAppearanceDescription,
      child: Column(
        children: [
          SettingsSelectionTile(
            label: l10n.themeModeSystem,
            icon: LucideIcons.monitor,
            isSelected: themeMode == ThemeMode.system,
            onTap: () =>
                context.read<ThemeModeCubit>().setThemeMode(ThemeMode.system),
          ),
          const SizedBox(height: 10),
          SettingsSelectionTile(
            label: l10n.themeModeLight,
            icon: LucideIcons.sun,
            isSelected: themeMode == ThemeMode.light,
            onTap: () =>
                context.read<ThemeModeCubit>().setThemeMode(ThemeMode.light),
          ),
          const SizedBox(height: 10),
          SettingsSelectionTile(
            label: l10n.themeModeDark,
            icon: LucideIcons.moonStar,
            isSelected: themeMode == ThemeMode.dark,
            onTap: () =>
                context.read<ThemeModeCubit>().setThemeMode(ThemeMode.dark),
          ),
        ],
      ),
    );
  }
}
