import 'package:flutter/material.dart';
import 'package:qintrix/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class AppCopyrightFooter extends StatelessWidget {
  const AppCopyrightFooter({super.key});

  static final Uri _tenvoroPublisherUri = Uri.parse(
    'https://codecanyon.net/user/tenvoro',
  );

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final year = DateTime.now().year;

    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 2,
        children: [
          Text(
            l10n.shellCopyrightText(year),
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.6),
              fontWeight: FontWeight.w600,
            ),
          ),
          TextButton(
            onPressed: () => launchUrl(
              _tenvoroPublisherUri,
              mode: LaunchMode.externalApplication,
            ),
            style: TextButton.styleFrom(
              visualDensity: VisualDensity.compact,
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              'Tenvoro',
              style: theme.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w800,
                color: theme.colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
