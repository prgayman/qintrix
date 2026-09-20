import 'package:flutter/material.dart';
import 'package:lucide_flutter/lucide_flutter.dart';
import 'package:qintrix/core/widgets/exports.dart';
import 'package:qintrix/features/settings/models/application_diagnostics.dart';
import 'package:qintrix/features/settings/models/server_settings_draft.dart';
import 'package:qintrix/features/settings/widgets/settings_boolean_tile.dart';
import 'package:qintrix/features/settings/widgets/settings_option_group.dart';
import 'package:qintrix/l10n/app_localizations.dart';

class SettingsApplicationSection extends StatelessWidget {
  const SettingsApplicationSection({
    required this.draft,
    required this.isDirty,
    required this.isSaving,
    required this.isLoadingDiagnostics,
    required this.onRefreshDiagnostics,
    required this.onBackgroundModeChanged,
    required this.onStartWithOsChanged,
    required this.onSave,
    this.diagnostics,
    super.key,
  });

  final ServerSettingsDraft draft;
  final bool isDirty;
  final bool isSaving;
  final bool isLoadingDiagnostics;
  final VoidCallback onRefreshDiagnostics;
  final ValueChanged<bool> onBackgroundModeChanged;
  final ValueChanged<bool> onStartWithOsChanged;
  final VoidCallback onSave;
  final ApplicationDiagnostics? diagnostics;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return SettingsOptionGroup(
      icon: LucideIcons.monitorCog,
      title: l10n.settingsApplicationTitle,
      description: l10n.settingsApplicationDescription,
      child: ListView(
        children: [
          SettingsBooleanTile(
            label: l10n.settingsEnableBackgroundMode,
            icon: LucideIcons.monitorCog,
            value: draft.enableBackgroundMode,
            onChanged: onBackgroundModeChanged,
          ),
          SettingsBooleanTile(
            label: l10n.settingsStartWithOs,
            icon: LucideIcons.power,
            value: draft.startWithOs,
            onChanged: onStartWithOsChanged,
          ),
          const SizedBox(height: 10),
          _ApplicationDiagnosticsPanel(
            diagnostics: diagnostics,
            isLoading: isLoadingDiagnostics,
            onRefresh: onRefreshDiagnostics,
          ),
          const SizedBox(height: 20),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: AppButton(
              label: l10n.settingsSaveApplication,
              leading: LucideIcons.save,
              onPressed: isSaving || !isDirty ? null : onSave,
              isLoading: isSaving,
            ),
          ),
        ],
      ),
    );
  }
}

class _ApplicationDiagnosticsPanel extends StatelessWidget {
  const _ApplicationDiagnosticsPanel({
    required this.diagnostics,
    required this.isLoading,
    required this.onRefresh,
  });

  final ApplicationDiagnostics? diagnostics;
  final bool isLoading;
  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: theme.dividerColor.withValues(alpha: 0.8)),
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.28),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.settingsApplicationDiagnosticsTitle,
                      style: theme.textTheme.titleMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      l10n.settingsApplicationDiagnosticsDescription,
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              AppButton(
                label: l10n.dashboardServerRestart,
                leading: LucideIcons.refreshCw,
                onPressed: isLoading ? null : onRefresh,
                isLoading: isLoading,
                variant: AppButtonVariant.secondary,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _DiagnosticsBadge(
                icon: LucideIcons.power,
                label: l10n.settingsApplicationStartWithOsStatus,
                value: diagnostics?.startWithOsRegistered,
              ),
              _DiagnosticsBadge(
                icon: LucideIcons.monitorCog,
                label: l10n.settingsApplicationBackgroundModeStatus,
                value: diagnostics?.backgroundModeEnabled,
              ),
              _DiagnosticsBadge(
                icon: LucideIcons.panelTop,
                label: l10n.settingsApplicationTrayStatus,
                value: diagnostics?.trayActive,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DiagnosticsBadge extends StatelessWidget {
  const _DiagnosticsBadge({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final bool? value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context)!;
    final isEnabled = value == true;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: isEnabled
            ? colorScheme.primary.withValues(alpha: 0.08)
            : colorScheme.surface.withValues(alpha: 0.7),
        border: Border.all(
          color: isEnabled
              ? colorScheme.primary.withValues(alpha: 0.25)
              : theme.dividerColor.withValues(alpha: 0.7),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14,
            color: isEnabled ? colorScheme.primary : theme.colorScheme.outline,
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              '$label  ${value == null ? l10n.loading : (isEnabled ? l10n.dashboardEnabled : l10n.dashboardDisabled)}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.labelMedium?.copyWith(
                color: isEnabled ? colorScheme.primary : colorScheme.outline,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
