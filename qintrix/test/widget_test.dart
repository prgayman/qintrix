import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lucide_flutter/lucide_flutter.dart';
import 'package:qintrix/app/exports.dart';
import 'package:qintrix/core/services/exports.dart';
import 'package:qintrix/core/widgets/exports.dart';
import 'package:qintrix/data/models/exports.dart';
import 'package:qintrix/data/repositories/exports.dart';
import 'package:qintrix/features/settings/exports.dart';
import 'package:qintrix/features/settings/helpers/server_settings_form_logic.dart';
import 'package:qintrix/features/settings/models/server_settings_draft.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'helpers/pump_app.dart';

class FakeNetworkInterfaceService extends NetworkInterfaceService {
  const FakeNetworkInterfaceService(this.preferredIp);

  final String? preferredIp;

  @override
  Future<String?> getPreferredLanIpv4Address() async => preferredIp;
}

class FakePrinterConnectionTestService extends PrinterConnectionTestService {
  const FakePrinterConnectionTestService(this.result);

  final PrinterConnectionTestResult result;

  @override
  Future<PrinterConnectionTestResult> testConnection(
    PrinterModel printer,
  ) async {
    return result;
  }
}

void main() {
  testWidgets('shows splash then navigates into the shell dashboard', (
    WidgetTester tester,
  ) async {
    final completer = Completer<void>();

    await pumpQintrixApp(
      tester,
      startupService: ControlledStartupService(completer),
    );

    expect(find.text('Preparing Qintrix'), findsOneWidget);

    completer.complete();
    await tester.pumpAndSettle();

    expect(find.text('Dashboard'), findsWidgets);
    expect(find.byType(AppShell), findsOneWidget);
    expect(find.text('Jobs over the last 7 days'), findsOneWidget);
  });

  testWidgets('keeps the shell mounted while switching pages from the sidebar', (
    WidgetTester tester,
  ) async {
    final completer = Completer<void>()..complete();

    await pumpQintrixApp(
      tester,
      startupService: ControlledStartupService(completer),
    );
    await tester.pumpAndSettle();

    final shellElement = tester.element(find.byType(AppShell));
    await tester.tap(find.text('Settings').first);
    await tester.pumpAndSettle();

    expect(find.byType(AppShell), findsOneWidget);
    expect(
      identical(shellElement, tester.element(find.byType(AppShell))),
      isTrue,
    );
    expect(
      find.text(
        'Control how Qintrix looks and which language it uses when the app reopens.',
      ),
      findsOneWidget,
    );
    expect(find.text('Saved preferences'), findsNothing);
  });

  testWidgets('logs subtitle appears in shell header and not page body', (
    WidgetTester tester,
  ) async {
    final completer = Completer<void>()..complete();

    await pumpQintrixApp(
      tester,
      startupService: ControlledStartupService(completer),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Logs').first);
    await tester.pumpAndSettle();

    expect(
      find.text(
        'Persistent application events, server activity, and job lifecycle updates.',
      ),
      findsOneWidget,
    );
    expect(find.text('Logs'), findsWidgets);
    expect(find.byType(AppDataTable<AppLogModel>), findsOneWidget);
  });

  testWidgets('switches to the server module from shell navigation', (
    WidgetTester tester,
  ) async {
    final completer = Completer<void>()..complete();

    await pumpQintrixApp(
      tester,
      startupService: ControlledStartupService(completer),
    );
    await tester.pumpAndSettle();

    final context = tester.element(find.byType(AppShell));
    context.read<ShellNavigationCubit>().setDestination(AppDestination.server);
    await tester.pumpAndSettle();

    expect(
      find.text(
        'Manage the embedded API server runtime, controls, and recent server activity.',
      ),
      findsWidgets,
    );
  });

  testWidgets('opens printers module and create form', (
    WidgetTester tester,
  ) async {
    final completer = Completer<void>()..complete();

    await pumpQintrixApp(
      tester,
      startupService: ControlledStartupService(completer),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Printers').first);
    await tester.pumpAndSettle();

    expect(
      find.text(
        'Manage printer definitions, connection types, and device-specific settings.',
      ),
      findsOneWidget,
    );
    expect(find.text('Create printer'), findsOneWidget);

    await tester.tap(find.widgetWithText(FilledButton, 'Create printer'));
    await tester.pumpAndSettle();

    expect(find.text('Printer overview'), findsOneWidget);
    expect(find.byType(AppSwitchField), findsWidgets);
    expect(find.byType(SwitchListTile), findsNothing);

    final richTexts = tester.widgetList<RichText>(find.byType(RichText));
    final hasRequiredNameLabel = richTexts.any(
      (widget) => widget.text.toPlainText().contains('Printer name *'),
    );
    final hasUniqueKeyLabel = richTexts.any(
      (widget) => widget.text.toPlainText().contains('Identifier *'),
    );
    expect(hasRequiredNameLabel, isTrue);
    expect(hasUniqueKeyLabel, isTrue);
  });

  testWidgets('opens apps module and create form', (WidgetTester tester) async {
    final completer = Completer<void>()..complete();

    await pumpQintrixApp(
      tester,
      startupService: ControlledStartupService(completer),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Apps').first);
    await tester.pumpAndSettle();

    expect(
      find.text(
        'Manage client apps, API keys, and printer access rules.',
      ),
      findsOneWidget,
    );
    expect(find.text('Create app'), findsOneWidget);

    await tester.tap(find.widgetWithText(FilledButton, 'Create app'));
    await tester.pumpAndSettle();

    expect(find.text('App overview'), findsOneWidget);
    final richTexts = tester.widgetList<RichText>(find.byType(RichText));
    final hasApiKeyLabel = richTexts.any(
      (widget) => widget.text.toPlainText().contains('API key *'),
    );
    expect(hasApiKeyLabel, isTrue);
  });

  testWidgets('dashboard shows analytics overview for clients', (
    WidgetTester tester,
  ) async {
    final completer = Completer<void>()..complete();

    await pumpQintrixApp(
      tester,
      startupService: ControlledStartupService(completer),
    );
    await tester.pumpAndSettle();

    expect(find.text('Jobs over the last 7 days'), findsOneWidget);
  });

  testWidgets('restores persisted arabic locale and dark theme on reopen', (
    WidgetTester tester,
  ) async {
    final completer = Completer<void>()..complete();

    await pumpQintrixApp(
      tester,
      startupService: ControlledStartupService(completer),
      preferenceValues: const {'app.locale': 'ar', 'app.themeMode': 'dark'},
    );
    await tester.pumpAndSettle();

    expect(find.text('لوحة التحكم'), findsWidgets);
    expect(find.text('المهام خلال آخر 7 أيام'), findsOneWidget);

    final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
    expect(materialApp.themeMode, ThemeMode.dark);
  });

  testWidgets('persists settings changes through shared preferences', (
    WidgetTester tester,
  ) async {
    final completer = Completer<void>()..complete();

    await pumpQintrixApp(
      tester,
      startupService: ControlledStartupService(completer),
    );
    await tester.pumpAndSettle();

    final context = tester.element(find.byType(AppShell));
    context.read<ThemeModeCubit>().setThemeMode(ThemeMode.dark);
    await tester.pumpAndSettle();

    final preferences = await SharedPreferences.getInstance();
    expect(preferences.getString('app.themeMode'), 'dark');
  });

  testWidgets(
    'updates locale to arabic from settings inside the static shell',
    (WidgetTester tester) async {
      final completer = Completer<void>()..complete();

      await pumpQintrixApp(
        tester,
        startupService: ControlledStartupService(completer),
      );
      await tester.pumpAndSettle();

      final context = tester.element(find.byType(AppShell));
      context.read<LocaleCubit>().setLocale(const Locale('ar'));
      await tester.pumpAndSettle();

      expect(find.text('لوحة التحكم'), findsWidgets);
    },
  );

  testWidgets('centers the logo when the sidebar is collapsed', (
    WidgetTester tester,
  ) async {
    final completer = Completer<void>()..complete();

    await pumpQintrixApp(
      tester,
      startupService: ControlledStartupService(completer),
    );
    await tester.pumpAndSettle();

    final sidebarFinder = find.byKey(const ValueKey('app-sidebar'));
    final logoFinder = find.byKey(const ValueKey('sidebar-logo'));

    await tester.tap(find.byTooltip('Collapse sidebar'));
    await tester.pumpAndSettle();

    final sidebarCenter = tester.getCenter(sidebarFinder);
    final logoCenter = tester.getCenter(logoFinder);

    expect((sidebarCenter.dx - logoCenter.dx).abs(), lessThan(1));
  });

  testWidgets('server settings stay unchanged until save is called', (
    WidgetTester tester,
  ) async {
    final completer = Completer<void>()..complete();

    await pumpQintrixApp(
      tester,
      startupService: ControlledStartupService(completer),
    );
    await tester.pumpAndSettle();

    final context = tester.element(find.byType(AppShell));
    final settingsRepository = context.read<SettingsRepository>();
    final settingsCubit = context.read<SettingsCubit>();
    final persisted = await settingsRepository.loadSettings();
    final draft = ServerSettingsFormLogic.updatePort(
      ServerSettingsFormLogic.hydrate(persisted),
      '4999',
    );

    expect(ServerSettingsFormLogic.isDirty(persisted, draft), isTrue);
    expect((await settingsRepository.loadSettings()).appPort, persisted.appPort);

    await settingsCubit.save(ServerSettingsFormLogic.toSettings(persisted, draft));

    expect((await settingsRepository.loadSettings()).appPort, 4999);
  });

  test('server settings reject url addresses', () {
    expect(
      ServerSettingsFormLogic.validateBindIp('https://example.com'),
      'invalid-bind-ip',
    );
  });

  test('enabling lan access autofills the preferred lan ip', () {
    final base = _serverDraft();
    final resolution = ServerSettingsFormLogic.beginLanToggle(base, true);
    final updated = ServerSettingsFormLogic.applyDetectedLanIp(
      resolution.draft,
      '192.168.1.20',
      message: 'A LAN IP was detected and filled automatically.',
    );

    expect(resolution.shouldApplyIp, isTrue);
    expect(updated.bindIp, '192.168.1.20');
    expect(updated.networkMessage, 'A LAN IP was detected and filled automatically.');
  });

  test('disabling lan access resets bind ip to default local ip', () {
    final base = _serverDraft().copyWith(
      allowLanAccess: true,
      bindIp: '192.168.1.20',
      detectedLanIp: '192.168.1.20',
    );
    final resolution = ServerSettingsFormLogic.beginLanToggle(base, false);

    expect(resolution.draft.bindIp, ServerSettingsFormLogic.defaultLocalIp);
    expect(resolution.draft.allowLanAccess, isFalse);
  });

  test('hydrate normalizes bind host when lan access is disabled', () {
    final settings = _serverDraftSettings().copyWith(
      allowLanAccess: false,
      bindHost: '192.168.1.98',
    );

    final draft = ServerSettingsFormLogic.hydrate(settings);

    expect(draft.bindIp, ServerSettingsFormLogic.defaultLocalIp);
    expect(draft.allowLanAccess, isFalse);
  });

  test('saving server settings normalizes host to loopback when lan access is disabled', () {
    final persisted = _serverDraftSettings();
    final draft = ServerSettingsFormLogic.hydrate(
      persisted.copyWith(
        allowLanAccess: false,
        bindHost: '192.168.1.98',
      ),
    ).copyWith(bindIp: '192.168.1.98');

    final updated = ServerSettingsFormLogic.toSettings(persisted, draft);

    expect(updated.allowLanAccess, isFalse);
    expect(updated.bindHost, ServerSettingsFormLogic.defaultLocalIp);
  });

  testWidgets('logs page shows searchable table with badges', (
    WidgetTester tester,
  ) async {
    final completer = Completer<void>()..complete();

    await pumpQintrixApp(
      tester,
      startupService: ControlledStartupService(completer),
      seedDatabase: (database) async {
        final logsRepository = DriftLogsRepository(database.logsDao);
        await logsRepository.addLog(
          AppLogModel(
            id: '1',
            level: 'info',
            eventType: 'app_start',
            title: 'App start',
            message: 'Startup complete',
            createdAt: DateTime(2026, 3, 16, 10, 0),
          ),
        );
        await logsRepository.addLog(
          AppLogModel(
            id: '2',
            level: 'error',
            eventType: 'app_error',
            title: 'App error',
            message: 'Printer queue failed',
            createdAt: DateTime(2026, 3, 16, 11, 0),
          ),
        );
      },
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Logs').first);
    await tester.pumpAndSettle();

    expect(find.byType(AppDataTable<AppLogModel>), findsOneWidget);
    expect(find.text('App Start'), findsOneWidget);
    expect(find.text('INFO'), findsOneWidget);
    expect(find.text('ERROR'), findsOneWidget);
    expect(find.text('Reset filters'), findsOneWidget);

    await tester.enterText(find.byType(TextField).first, 'queue');
    await tester.pumpAndSettle();

    expect(find.text('Printer queue failed'), findsOneWidget);
    expect(find.text('Startup complete'), findsNothing);

    await tester.tap(find.text('Reset filters'));
    await tester.pumpAndSettle();

    expect(find.text('Printer queue failed'), findsOneWidget);
    expect(find.text('Startup complete'), findsOneWidget);
  });

  testWidgets(
    'printers page supports filters, actions menu, and aligned actions',
    (WidgetTester tester) async {
      final completer = Completer<void>()..complete();

      await pumpQintrixApp(
        tester,
        startupService: ControlledStartupService(completer),
        printerConnectionTestService: const FakePrinterConnectionTestService(
          PrinterConnectionTestResult(
            status: PrinterConnectionTestStatus.success,
            message: 'TCP connection to 192.168.1.50:9100 succeeded.',
          ),
        ),
        seedDatabase: (database) async {
          final printersRepository = DriftPrintersRepository(
            database.printersDao,
          );
          await printersRepository.savePrinter(
            PrinterModel(
              id: 'printer-1',
              uniqueKey: 'PRN-A1B2C3',
              name: 'Front Desk',
              connectionType: PrinterConnectionType.networkTcp,
              isEnabled: true,
              tcpHost: '192.168.1.50',
              tcpPort: 9100,
              createdAt: DateTime(2026, 3, 16, 10),
              updatedAt: DateTime(2026, 3, 16, 10),
            ),
          );
          await printersRepository.savePrinter(
            PrinterModel(
              id: 'printer-2',
              uniqueKey: 'PRN-D4E5F6',
              name: 'USB Counter',
              connectionType: PrinterConnectionType.usbRawEscPos,
              isEnabled: false,
              usbVendorId: '04B8',
              usbProductId: '0202',
              createdAt: DateTime(2026, 3, 16, 11),
              updatedAt: DateTime(2026, 3, 16, 11),
            ),
          );
        },
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Printers').first);
      await tester.pumpAndSettle();

      expect(find.text('PRN-A1B2C3'), findsOneWidget);
      expect(find.text('PRN-D4E5F6'), findsOneWidget);
      expect(find.text('Identifier'), findsWidgets);
      expect(find.text('2026-03-16 10:00 AM'), findsOneWidget);

      final deleteButton = find.widgetWithText(
        OutlinedButton,
        'Delete selected',
      );
      final createButton = find.widgetWithText(FilledButton, 'Create printer');
      expect(
        tester.getCenter(createButton).dx,
        greaterThan(tester.getCenter(deleteButton).dx),
      );

      await tester.enterText(find.byType(TextField).first, 'front');
      await tester.pumpAndSettle();
      expect(find.text('Front Desk'), findsOneWidget);
      expect(find.text('USB Counter'), findsNothing);
      expect(find.text('Connection type'), findsOneWidget);
      expect(find.text('Reset filters'), findsOneWidget);

      await tester.tap(find.text('Reset filters'));
      await tester.pumpAndSettle();
      expect(find.text('Front Desk'), findsOneWidget);
      expect(find.text('USB Counter'), findsOneWidget);

      await tester.tap(find.byIcon(LucideIcons.ellipsis).first);
      await tester.pumpAndSettle();
      expect(find.text('Show'), findsOneWidget);
      expect(find.text('Edit'), findsOneWidget);
      expect(find.text('Test connection'), findsOneWidget);
      expect(find.text('Delete'), findsWidgets);

      await tester.tap(find.text('Show'));
      await tester.pumpAndSettle();
      expect(find.text('Connection details'), findsOneWidget);
      expect(find.widgetWithText(OutlinedButton, 'Test connection'), findsOneWidget);

      await tester.tap(find.widgetWithText(OutlinedButton, 'Test connection'));
      await tester.pumpAndSettle();
      expect(
        find.text(
          'Connection test succeeded. TCP connection to 192.168.1.50:9100 succeeded.',
        ),
        findsOneWidget,
      );

      await tester.tap(find.widgetWithText(OutlinedButton, 'Back to printers'));
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(LucideIcons.ellipsis).first);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Test connection'));
      await tester.pumpAndSettle();
      expect(
        find.text(
          'Connection test succeeded. TCP connection to 192.168.1.50:9100 succeeded.',
        ),
        findsOneWidget,
      );

      await tester.tap(find.byIcon(LucideIcons.ellipsis).first);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Delete').first);
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(FilledButton, 'Delete'));
      await tester.pumpAndSettle();
      expect(find.text('Printer deleted successfully.'), findsOneWidget);
    },
  );
}

ServerSettingsDraft _serverDraft() {
  return ServerSettingsDraft.fromSettings(_serverDraftSettings());
}

AppSettingsModel _serverDraftSettings() {
  return AppSettingsModel(
    appPort: 4000,
    bindHost: ServerSettingsFormLogic.defaultLocalIp,
    enableBackgroundMode: false,
    startWithOs: false,
    allowLanAccess: false,
    autoStartServer: false,
    jobsStartPaused: false,
    jobsMaxRetryAttempts: 2,
    jobsRetryDelaySeconds: 30,
    jobsHistoryRetentionDays: 7,
    updatedAt: DateTime(2026, 3, 19),
  );
}
