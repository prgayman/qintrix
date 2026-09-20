import 'package:flutter/material.dart';
import 'package:lucide_flutter/lucide_flutter.dart';
import 'package:qintrix/core/widgets/exports.dart';
import 'package:qintrix/data/models/exports.dart';
import 'package:qintrix/features/apps/helpers/app_access_summary.dart';
import 'package:qintrix/l10n/app_localizations.dart';
import 'package:qintrix/theme/tokens/color_tokens.dart';

class AppShowView extends StatelessWidget {
  const AppShowView({
    required this.app,
    required this.onBack,
    required this.onEdit,
    required this.onCopyApiKey,
    required this.onDelete,
    super.key,
  });

  final AppModel app;
  final VoidCallback onBack;
  final VoidCallback onEdit;
  final ValueChanged<String> onCopyApiKey;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return ListView(
      children: [
        Row(
          children: [
            AppButton(
              label: l10n.appsBackToIndex,
              variant: AppButtonVariant.secondary,
              leading: LucideIcons.arrowLeft,
              onPressed: onBack,
            ),
            const Spacer(),
            AppButton(
              label: l10n.appsEditAction,
              variant: AppButtonVariant.secondary,
              leading: LucideIcons.squarePen,
              onPressed: onEdit,
            ),
            const SizedBox(width: 10),
            AppButton(
              label: l10n.appsDeleteAction,
              leading: LucideIcons.trash2,
              onPressed: onDelete,
            ),
          ],
        ),
        const SizedBox(height: 18),
        AppSectionCard(
          title: app.name,
          actions: [
            StatusBadge(
              label: app.isEnabled ? l10n.appsStatusEnabled : l10n.appsStatusDisabled,
              tone: app.isEnabled ? AppStatusTone.success : AppStatusTone.info,
              size: StatusBadgeSize.small,
            ),
          ],
          child: Column(
            children: [
              _DetailRow(
                label: l10n.appsFieldApiKey,
                value: app.apiKey,
                trailing: AppCopyButton(
                  tooltip: l10n.appsCopyApiKeyAction,
                  onPressed: () => onCopyApiKey(app.apiKey),
                ),
              ),
              _DetailRow(
                label: l10n.appsColumnPrinters,
                value: AppAccessSummary.forApp(l10n, app),
              ),
              if (app.allowedPrinterNames.isNotEmpty)
                _DetailRow(
                  label: l10n.appsAllowedPrintersLabel,
                  value: app.allowedPrinterNames.join(', '),
                ),
              if (app.description != null && app.description!.isNotEmpty)
                _DetailRow(
                  label: l10n.appsFieldDescription,
                  value: app.description!,
                ),
              _DetailRow(
                label: l10n.appsFieldUpdatedAt,
                value: '${app.updatedAt}',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value, this.trailing});

  final String label;
  final String value;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 180,
            child: Text(label, style: Theme.of(context).textTheme.labelLarge),
          ),
          const SizedBox(width: 12),
          Expanded(child: Text(value, style: Theme.of(context).textTheme.bodyMedium)),
          if (trailing != null) ...[const SizedBox(width: 8), trailing!],
        ],
      ),
    );
  }
}
