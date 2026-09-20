import 'package:qintrix/data/models/exports.dart';
import 'package:qintrix/l10n/app_localizations.dart';

abstract final class AppAccessSummary {
  static String forApp(AppLocalizations l10n, AppModel app) {
    if (app.allowedPrinterIds.isEmpty) {
      return l10n.appsAllPrintersAccess;
    }

    if (app.allowedPrinterNames.isEmpty) {
      return l10n.appsRestrictedPrintersCount(app.allowedPrinterIds.length);
    }

    if (app.allowedPrinterNames.length == 1) {
      return app.allowedPrinterNames.first;
    }

    return l10n.appsRestrictedPrintersCount(app.allowedPrinterNames.length);
  }
}
