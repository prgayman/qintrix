import 'package:flutter/widgets.dart';
import 'package:lucide_flutter/lucide_flutter.dart';
import 'package:qintrix/l10n/app_localizations.dart';

enum AppDestination {
  dashboard('/dashboard', LucideIcons.layoutDashboard),
  server('/server', LucideIcons.server),
  printers('/printers', LucideIcons.printer),
  jobs('/jobs', LucideIcons.fileClock),
  apps('/apps', LucideIcons.shieldCheck),
  logs('/logs', LucideIcons.fileText),
  settings('/settings', LucideIcons.slidersHorizontal),
  about('/about', LucideIcons.badgeInfo);

  const AppDestination(this.routeName, this.icon);

  final String routeName;
  final IconData icon;

  static AppDestination fromRouteName(String? routeName) {
    return AppDestination.values.firstWhere(
      (destination) => destination.routeName == routeName,
      orElse: () => AppDestination.dashboard,
    );
  }

  String label(AppLocalizations l10n) {
    return switch (this) {
      AppDestination.dashboard => l10n.navDashboard,
      AppDestination.server => l10n.navServer,
      AppDestination.printers => l10n.navPrinters,
      AppDestination.jobs => l10n.navJobs,
      AppDestination.apps => l10n.navApps,
      AppDestination.logs => l10n.navLogs,
      AppDestination.settings => l10n.navSettings,
      AppDestination.about => l10n.navAbout,
    };
  }

  String? subtitle(AppLocalizations l10n) {
    return switch (this) {
      AppDestination.dashboard => l10n.dashboardDescription,
      AppDestination.server => l10n.serverDescription,
      AppDestination.printers => l10n.printersDescription,
      AppDestination.jobs => l10n.jobsDescription,
      AppDestination.apps => l10n.appsDescription,
      AppDestination.logs => l10n.logsDescription,
      AppDestination.settings => l10n.settingsDescription,
      _ => null,
    };
  }
}
