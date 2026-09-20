import 'package:flutter/material.dart';
import 'package:qintrix/app/app_destination.dart';
import 'package:qintrix/core/widgets/exports.dart';
import 'package:qintrix/features/about/exports.dart';
import 'package:qintrix/features/dashboard/exports.dart';
import 'package:qintrix/features/apps/exports.dart';
import 'package:qintrix/features/jobs/exports.dart';
import 'package:qintrix/features/logs/exports.dart';
import 'package:qintrix/features/printers/exports.dart';
import 'package:qintrix/features/server/exports.dart';
import 'package:qintrix/features/settings/exports.dart';
import 'package:qintrix/features/splash/exports.dart';

abstract final class AppRouter {
  static Map<String, WidgetBuilder> routes = {
    SplashPage.routeName: (_) => const SplashPage(),
    DashboardPage.routeName: (_) =>
        const AppShell(initialDestination: AppDestination.dashboard),
    ServerPage.routeName: (_) =>
        const AppShell(initialDestination: AppDestination.server),
    PrintersPage.routeName: (_) =>
        const AppShell(initialDestination: AppDestination.printers),
    JobsPage.routeName: (_) =>
        const AppShell(initialDestination: AppDestination.jobs),
    AppsPage.routeName: (_) =>
        const AppShell(initialDestination: AppDestination.apps),
    LogsPage.routeName: (_) =>
        const AppShell(initialDestination: AppDestination.logs),
    SettingsPage.routeName: (_) =>
        const AppShell(initialDestination: AppDestination.settings),
    AboutPage.routeName: (_) =>
        const AppShell(initialDestination: AppDestination.about),
  };
}
