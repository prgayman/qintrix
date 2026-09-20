import 'package:flutter/material.dart';
import 'package:lucide_flutter/lucide_flutter.dart';
import 'package:qintrix/core/widgets/exports.dart';
import 'package:qintrix/features/settings/models/server_settings_draft.dart';
import 'package:qintrix/features/settings/widgets/settings_boolean_tile.dart';
import 'package:qintrix/features/settings/widgets/settings_option_group.dart';
import 'package:qintrix/l10n/app_localizations.dart';

class SettingsServerSection extends StatelessWidget {
  const SettingsServerSection({
    required this.draft,
    required this.portController,
    required this.bindIpController,
    required this.formKey,
    required this.autovalidateMode,
    required this.isDirty,
    required this.isSaving,
    required this.onPortChanged,
    required this.onBindIpChanged,
    required this.onAllowLanAccessChanged,
    required this.onAutoStartServerChanged,
    required this.portValidator,
    required this.bindIpValidator,
    required this.onSave,
    super.key,
  });

  final ServerSettingsDraft draft;
  final TextEditingController portController;
  final TextEditingController bindIpController;
  final GlobalKey<FormState> formKey;
  final AutovalidateMode autovalidateMode;
  final bool isDirty;
  final bool isSaving;
  final ValueChanged<String> onPortChanged;
  final ValueChanged<String> onBindIpChanged;
  final ValueChanged<bool> onAllowLanAccessChanged;
  final ValueChanged<bool> onAutoStartServerChanged;
  final String? Function(String?) portValidator;
  final String? Function(String?) bindIpValidator;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return SettingsOptionGroup(
      icon: LucideIcons.server,
      title: l10n.settingsServerTitle,
      description: l10n.settingsServerDescription,
      child: Form(
        key: formKey,
        autovalidateMode: autovalidateMode,
        child: ListView(
          children: [
            Row(
              children: [
                Expanded(
                  child: AppTextField(
                    label: l10n.settingsAppPort,
                    controller: portController,
                    keyboardType: TextInputType.number,
                    validator: portValidator,
                    onChanged: onPortChanged,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: AppTextField(
                    label: l10n.settingsBindHost,
                    controller: bindIpController,
                    validator: bindIpValidator,
                    helperText: draft.isDetectingLanIp
                        ? l10n.settingsLanIpDetecting
                        : draft.networkMessage,
                    onChanged: onBindIpChanged,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            SettingsBooleanTile(
              label: l10n.settingsAllowLanAccess,
              icon: LucideIcons.network,
              value: draft.allowLanAccess,
              onChanged: onAllowLanAccessChanged,
            ),
            SettingsBooleanTile(
              label: l10n.settingsAutoStartServer,
              icon: LucideIcons.play,
              value: draft.autoStartServer,
              onChanged: onAutoStartServerChanged,
            ),
            const SizedBox(height: 20),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: AppButton(
                label: l10n.settingsSaveServer,
                leading: LucideIcons.save,
                onPressed: isSaving || !isDirty ? null : onSave,
                isLoading: isSaving,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
