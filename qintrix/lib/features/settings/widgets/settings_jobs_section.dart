import 'package:flutter/material.dart';
import 'package:lucide_flutter/lucide_flutter.dart';
import 'package:qintrix/core/widgets/exports.dart';
import 'package:qintrix/features/settings/models/server_settings_draft.dart';
import 'package:qintrix/features/settings/widgets/settings_boolean_tile.dart';
import 'package:qintrix/features/settings/widgets/settings_option_group.dart';
import 'package:qintrix/l10n/app_localizations.dart';

class SettingsJobsSection extends StatelessWidget {
  const SettingsJobsSection({
    required this.draft,
    required this.retryController,
    required this.retryDelayController,
    required this.retentionController,
    required this.formKey,
    required this.autovalidateMode,
    required this.isDirty,
    required this.isSaving,
    required this.onJobsStartPausedChanged,
    required this.onRetryAttemptsChanged,
    required this.onRetryDelayChanged,
    required this.onRetentionChanged,
    required this.integerValidator,
    required this.onSave,
    super.key,
  });

  final ServerSettingsDraft draft;
  final TextEditingController retryController;
  final TextEditingController retryDelayController;
  final TextEditingController retentionController;
  final GlobalKey<FormState> formKey;
  final AutovalidateMode autovalidateMode;
  final bool isDirty;
  final bool isSaving;
  final ValueChanged<bool> onJobsStartPausedChanged;
  final ValueChanged<String> onRetryAttemptsChanged;
  final ValueChanged<String> onRetryDelayChanged;
  final ValueChanged<String> onRetentionChanged;
  final String? Function(String?) integerValidator;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return SettingsOptionGroup(
      icon: LucideIcons.fileClock,
      title: l10n.settingsJobsTitle,
      description: l10n.settingsJobsDescription,
      child: Form(
        key: formKey,
        autovalidateMode: autovalidateMode,
        child: ListView(
          children: [
            SettingsBooleanTile(
              label: l10n.settingsJobsStartPaused,
              icon: LucideIcons.pause,
              value: draft.jobsStartPaused,
              onChanged: onJobsStartPausedChanged,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: AppTextField(
                    label: l10n.settingsJobsMaxRetries,
                    controller: retryController,
                    keyboardType: TextInputType.number,
                    validator: integerValidator,
                    onChanged: onRetryAttemptsChanged,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: AppTextField(
                    label: l10n.settingsJobsRetryDelaySeconds,
                    controller: retryDelayController,
                    keyboardType: TextInputType.number,
                    validator: integerValidator,
                    onChanged: onRetryDelayChanged,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            AppTextField(
              label: l10n.settingsJobsHistoryRetentionDays,
              controller: retentionController,
              keyboardType: TextInputType.number,
              validator: integerValidator,
              onChanged: onRetentionChanged,
            ),
            const SizedBox(height: 20),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: AppButton(
                label: l10n.settingsSaveJobs,
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
