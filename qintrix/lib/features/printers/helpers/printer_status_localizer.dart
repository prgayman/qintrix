import 'package:qintrix/data/models/exports.dart';
import 'package:qintrix/l10n/app_localizations.dart';

String localizePrinterStatusKey(AppLocalizations l10n, String? statusKey) {
  return switch (statusKey) {
    'test_success' => l10n.printersLastStatusTestSuccess,
    'test_failure' => l10n.printersLastStatusTestFailure,
    'test_not_supported' => l10n.printersLastStatusTestNotSupported,
    'print_success' => l10n.printersLastStatusPrintSuccess,
    'print_failure' => l10n.printersLastStatusPrintFailure,
    'render_failure' => l10n.printersLastStatusRenderFailure,
    null || '' => '-',
    _ => statusKey,
  };
}

String printerStatusSummary(AppLocalizations l10n, PrinterModel printer) {
  if (printer.lastStatusKey != null && printer.lastStatusKey!.isNotEmpty) {
    return localizePrinterStatusKey(l10n, printer.lastStatusKey);
  }
  return printer.lastStatus ?? '-';
}
