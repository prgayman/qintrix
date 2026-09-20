import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_flutter/lucide_flutter.dart';
import 'package:qintrix/app/exports.dart';
import 'package:qintrix/core/localization/app_locale_utils.dart';
import 'package:qintrix/features/settings/widgets/settings_option_group.dart';
import 'package:qintrix/features/settings/widgets/settings_selection_tile.dart';
import 'package:qintrix/l10n/app_localizations.dart';

class SettingsLanguageSection extends StatelessWidget {
  const SettingsLanguageSection({required this.locale, super.key});

  final Locale locale;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return SettingsOptionGroup(
      icon: LucideIcons.languages,
      title: l10n.settingsLanguageTitle,
      description: l10n.settingsLanguageDescription,
      child: Column(
        children: [
          SettingsSelectionTile(
            label: l10n.languageEnglish,
            icon: LucideIcons.languages,
            isSelected:
                locale.languageCode == AppLocaleUtils.english.languageCode,
            onTap: () =>
                context.read<LocaleCubit>().setLocale(AppLocaleUtils.english),
          ),
          const SizedBox(height: 10),
          SettingsSelectionTile(
            label: l10n.languageArabic,
            icon: LucideIcons.languages,
            isSelected:
                locale.languageCode == AppLocaleUtils.arabic.languageCode,
            onTap: () =>
                context.read<LocaleCubit>().setLocale(AppLocaleUtils.arabic),
          ),
        ],
      ),
    );
  }
}
