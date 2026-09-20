import 'package:flutter/material.dart';
import 'package:lucide_flutter/lucide_flutter.dart';
import 'package:qintrix/features/settings/models/settings_section.dart';
import 'package:qintrix/l10n/app_localizations.dart';

class SettingsRail extends StatelessWidget {
  const SettingsRail({
    required this.selectedSection,
    required this.locale,
    required this.themeMode,
    required this.onSectionSelected,
    super.key,
  });

  final SettingsSection selectedSection;
  final Locale locale;
  final ThemeMode themeMode;
  final ValueChanged<SettingsSection> onSectionSelected;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        color: theme.cardColor,
        border: Border.all(color: theme.dividerColor.withValues(alpha: 0.85)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.settingsTitle, style: theme.textTheme.titleMedium),
            const SizedBox(height: 4),
            Text(
              '${locale.languageCode == 'ar' ? l10n.languageArabic : l10n.languageEnglish} • ${switch (themeMode) {
                ThemeMode.system => l10n.themeModeSystem,
                ThemeMode.light => l10n.themeModeLight,
                ThemeMode.dark => l10n.themeModeDark,
              }}',
              style: theme.textTheme.bodySmall,
            ),
            const SizedBox(height: 14),
            SettingsRailItem(
              icon: LucideIcons.sunMoon,
              title: l10n.settingsAppearanceTitle,
              subtitle: l10n.settingsAppearanceDescription,
              isSelected: selectedSection == SettingsSection.appearance,
              onTap: () => onSectionSelected(SettingsSection.appearance),
            ),
            const SizedBox(height: 10),
            SettingsRailItem(
              icon: LucideIcons.languages,
              title: l10n.settingsLanguageTitle,
              subtitle: l10n.settingsLanguageDescription,
              isSelected: selectedSection == SettingsSection.language,
              onTap: () => onSectionSelected(SettingsSection.language),
            ),
            const SizedBox(height: 10),
            SettingsRailItem(
              icon: LucideIcons.monitorCog,
              title: l10n.settingsApplicationTitle,
              subtitle: l10n.settingsApplicationDescription,
              isSelected: selectedSection == SettingsSection.application,
              onTap: () => onSectionSelected(SettingsSection.application),
            ),
            const SizedBox(height: 10),
            SettingsRailItem(
              icon: LucideIcons.server,
              title: l10n.settingsServerTitle,
              subtitle: l10n.settingsServerDescription,
              isSelected: selectedSection == SettingsSection.server,
              onTap: () => onSectionSelected(SettingsSection.server),
            ),
            const SizedBox(height: 10),
            SettingsRailItem(
              icon: LucideIcons.fileClock,
              title: l10n.settingsJobsTitle,
              subtitle: l10n.settingsJobsDescription,
              isSelected: selectedSection == SettingsSection.jobs,
              onTap: () => onSectionSelected(SettingsSection.jobs),
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsRailItem extends StatelessWidget {
  const SettingsRailItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: isSelected
              ? theme.colorScheme.primary.withValues(alpha: 0.06)
              : Colors.transparent,
          border: Border.all(
            color: isSelected
                ? theme.colorScheme.primary.withValues(alpha: 0.2)
                : theme.dividerColor.withValues(alpha: 0.7),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: theme.colorScheme.primary.withValues(alpha: 0.08),
            ),
            child: Icon(icon, size: 14, color: theme.colorScheme.primary),
          ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: theme.textTheme.labelLarge),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
