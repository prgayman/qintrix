import 'package:flutter/material.dart';
import 'package:lucide_flutter/lucide_flutter.dart';
import 'package:qintrix/core/widgets/exports.dart';
import 'package:qintrix/data/models/exports.dart';
import 'package:qintrix/features/printers/helpers/printer_connection_summary.dart';
import 'package:qintrix/features/printers/helpers/printer_status_localizer.dart';
import 'package:qintrix/l10n/app_localizations.dart';
import 'package:qintrix/theme/tokens/color_tokens.dart';

class PrinterShowView extends StatelessWidget {
  const PrinterShowView({
    required this.printer,
    required this.onBack,
    required this.onEdit,
    required this.onTestConnection,
    required this.onCopyIdentifier,
    required this.onDelete,
    super.key,
  });

  final PrinterModel printer;
  final VoidCallback onBack;
  final VoidCallback onEdit;
  final VoidCallback onTestConnection;
  final ValueChanged<String> onCopyIdentifier;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return ListView(
      children: [
        Row(
          children: [
            AppButton(
              label: l10n.printersBackToIndex,
              variant: AppButtonVariant.secondary,
              leading: LucideIcons.arrowLeft,
              onPressed: onBack,
            ),
            const Spacer(),
            AppButton(
              label: l10n.printersEditAction,
              variant: AppButtonVariant.secondary,
              leading: LucideIcons.squarePen,
              onPressed: onEdit,
            ),
            const SizedBox(width: 10),
            AppButton(
              label: l10n.printersTestConnectionAction,
              variant: AppButtonVariant.secondary,
              leading: LucideIcons.plugZap,
              onPressed: onTestConnection,
            ),
            const SizedBox(width: 10),
            AppButton(
              label: l10n.printersDeleteAction,
              leading: LucideIcons.trash2,
              onPressed: onDelete,
            ),
          ],
        ),
        const SizedBox(height: 18),
        AppSectionCard(
          title: printer.name,
          subtitle: PrinterConnectionSummary.forPrinter(printer),
          actions: [
            StatusBadge(
              label: printer.isEnabled
                  ? l10n.printersStatusEnabled
                  : l10n.printersStatusDisabled,
              tone: printer.isEnabled
                  ? AppStatusTone.success
                  : AppStatusTone.info,
              size: StatusBadgeSize.small,
            ),
          ],
          child: Column(
            children: [
              _DetailRow(
                label: l10n.printersColumnIdentifier,
                value: printer.uniqueKey,
                trailing: IconButton(
                  tooltip: l10n.printersCopyIdentifierAction,
                  onPressed: () => onCopyIdentifier(printer.uniqueKey),
                  icon: const Icon(LucideIcons.copy, size: 16),
                  visualDensity: VisualDensity.compact,
                ),
              ),
              _DetailRow(
                label: l10n.printersColumnConnectionType,
                value: _connectionTypeLabel(l10n, printer.connectionType),
              ),
              _DetailRow(
                label: l10n.printersColumnLastStatus,
                value: printerStatusSummary(l10n, printer),
              ),
              _DetailRow(
                label: l10n.printersColumnLastStatusMessage,
                value: printer.lastStatusMessage ?? printer.lastStatus ?? '-',
              ),
              if (printer.description != null &&
                  printer.description!.isNotEmpty)
                _DetailRow(
                  label: l10n.printersFieldDescription,
                  value: printer.description!,
                ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        AppSectionCard(
          title: l10n.printersConnectionDetailsTitle,
          child: Column(
            children: _connectionRows(l10n)
                .map((row) => _DetailRow(label: row.$1, value: row.$2))
                .toList(growable: false),
          ),
        ),
      ],
    );
  }

  List<(String, String)> _connectionRows(AppLocalizations l10n) {
    return switch (printer.connectionType) {
      PrinterConnectionType.networkTcp => [
        (l10n.printersFieldHost, printer.tcpHost ?? '-'),
        (l10n.printersFieldPort, '${printer.tcpPort ?? '-'}'),
        (
          l10n.printersFieldConnectTimeout,
          '${printer.tcpConnectTimeoutMs ?? '-'}',
        ),
        (l10n.printersFieldWriteTimeout, '${printer.tcpWriteTimeoutMs ?? '-'}'),
        (l10n.printersFieldReadTimeout, '${printer.tcpReadTimeoutMs ?? '-'}'),
        (
          l10n.printersFieldAutoReconnect,
          _boolLabel(l10n, printer.tcpAutoReconnect),
        ),
        (
          l10n.printersFieldReconnectDelay,
          '${printer.tcpReconnectDelayMs ?? '-'}',
        ),
        (l10n.printersFieldEncoding, printer.tcpEncoding ?? '-'),
        (l10n.printersFieldCodePage, printer.tcpCodePage ?? '-'),
        (l10n.printersFieldLineEnding, printer.tcpLineEnding ?? '-'),
        (
          l10n.printersFieldAutoCutEnabled,
          _boolLabel(l10n, printer.usbAutoCutEnabled),
        ),
        (l10n.printersFieldCutMode, printer.usbCutMode ?? '-'),
        (
          l10n.printersFieldCashDrawerEnabled,
          _boolLabel(l10n, printer.usbCashDrawerEnabled),
        ),
        (l10n.printersFieldDrawerPin, '${printer.usbDrawerPin ?? '-'}'),
        (l10n.printersFieldKeepAlive, _boolLabel(l10n, printer.tcpKeepAlive)),
        (l10n.printersFieldNoDelay, _boolLabel(l10n, printer.tcpNoDelay)),
        (l10n.printersFieldLinger, '${printer.tcpLingerSeconds ?? '-'}'),
        (
          l10n.printersFieldRawGraphicsMode,
          _rawGraphicsModeLabel(l10n, printer.rawGraphicsMode),
        ),
      ],
      PrinterConnectionType.systemSpooler => [
        (l10n.printersFieldPrinterName, printer.systemPrinterName ?? '-'),
        (l10n.printersFieldPaperSize, printer.systemPaperSize ?? '-'),
        (l10n.printersFieldDefaultCopies, '${printer.systemDefaultCopies}'),
        (
          l10n.printersFieldColorEnabled,
          _boolLabel(l10n, printer.systemColorEnabled),
        ),
        (l10n.printersFieldDuplexMode, printer.systemDuplexMode ?? '-'),
        (l10n.printersFieldOrientation, printer.systemOrientation ?? '-'),
        (l10n.printersFieldJobTimeout, '${printer.systemJobTimeoutMs ?? '-'}'),
        (l10n.printersFieldNotes, printer.systemNotes ?? '-'),
        (l10n.printersFieldDriverName, printer.systemDriverName ?? '-'),
        (l10n.printersFieldQueueName, printer.systemQueueName ?? '-'),
        (l10n.printersFieldSpoolFormat, printer.systemSpoolFormat ?? '-'),
        (
          l10n.printersFieldUseRawSpool,
          _boolLabel(l10n, printer.systemUseRawSpool),
        ),
      ],
      PrinterConnectionType.usbRawEscPos => [
        (l10n.printersFieldVendorId, printer.usbVendorId ?? '-'),
        (l10n.printersFieldProductId, printer.usbProductId ?? '-'),
        (l10n.printersFieldSerialNumber, printer.usbSerialNumber ?? '-'),
        (
          l10n.printersFieldInterfaceNumber,
          '${printer.usbInterfaceNumber ?? '-'}',
        ),
        (l10n.printersFieldOutEndpoint, '${printer.usbOutEndpoint ?? '-'}'),
        (l10n.printersFieldInEndpoint, '${printer.usbInEndpoint ?? '-'}'),
        (l10n.printersFieldTimeout, '${printer.usbTimeoutMs ?? '-'}'),
        (l10n.printersFieldEncoding, printer.usbEncoding ?? '-'),
        (l10n.printersFieldCodePage, printer.usbCodePage ?? '-'),
        (l10n.printersFieldCharacterTable, printer.usbCharacterTable ?? '-'),
        (
          l10n.printersFieldStatusMonitoring,
          _boolLabel(l10n, printer.usbStatusMonitoringEnabled),
        ),
        (
          l10n.printersFieldAutoCutEnabled,
          _boolLabel(l10n, printer.usbAutoCutEnabled),
        ),
        (l10n.printersFieldCutMode, printer.usbCutMode ?? '-'),
        (
          l10n.printersFieldCashDrawerEnabled,
          _boolLabel(l10n, printer.usbCashDrawerEnabled),
        ),
        (l10n.printersFieldDrawerPin, '${printer.usbDrawerPin ?? '-'}'),
        (l10n.printersFieldManufacturer, printer.usbManufacturer ?? '-'),
        (l10n.printersFieldProductName, printer.usbProductName ?? '-'),
        (
          l10n.printersFieldAlternateSetting,
          '${printer.usbAlternateSetting ?? '-'}',
        ),
        (l10n.printersFieldPacketDelay, '${printer.usbPacketDelayMs ?? '-'}'),
        (
          l10n.printersFieldRawGraphicsMode,
          _rawGraphicsModeLabel(l10n, printer.rawGraphicsMode),
        ),
      ],
    };
  }

  String _connectionTypeLabel(
    AppLocalizations l10n,
    PrinterConnectionType type,
  ) {
    return switch (type) {
      PrinterConnectionType.networkTcp => l10n.printersTypeTcp,
      PrinterConnectionType.systemSpooler => l10n.printersTypeSystem,
      PrinterConnectionType.usbRawEscPos => l10n.printersTypeUsbRaw,
    };
  }

  String _boolLabel(AppLocalizations l10n, bool value) {
    return value ? l10n.printersBooleanYes : l10n.printersBooleanNo;
  }

  String _rawGraphicsModeLabel(AppLocalizations l10n, String? value) {
    return switch (value) {
      'legacy' => l10n.printersRawGraphicsModeLegacy,
      'modern' => l10n.printersRawGraphicsModeModern,
      _ => '-',
    };
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value, this.trailing});

  final String label;
  final String value;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 180,
            child: Text(label, style: theme.textTheme.labelLarge),
          ),
          const SizedBox(width: 12),
          Expanded(child: Text(value, style: theme.textTheme.bodyMedium)),
          if (trailing != null) ...[const SizedBox(width: 8), trailing!],
        ],
      ),
    );
  }
}
