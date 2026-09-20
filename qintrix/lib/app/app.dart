import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:qintrix/app/app_runtime_signals.dart';
import 'package:qintrix/app/app_router.dart';
import 'package:qintrix/app/locale_cubit.dart';
import 'package:qintrix/app/shell_navigation_cubit.dart';
import 'package:qintrix/app/sidebar_cubit.dart';
import 'package:qintrix/app/theme_mode_cubit.dart';
import 'package:qintrix/core/localization/app_locale_utils.dart';
import 'package:qintrix/core/services/exports.dart';
import 'package:qintrix/data/repositories/exports.dart';
import 'package:qintrix/features/logs/exports.dart';
import 'package:qintrix/features/server/exports.dart';
import 'package:qintrix/features/settings/exports.dart';
import 'package:qintrix/features/startup/exports.dart';
import 'package:qintrix/l10n/app_localizations.dart';
import 'package:qintrix/theme/app_theme.dart';

class QintrixApp extends StatefulWidget {
  final StartupService startupService;
  final AppPreferencesService preferencesService;
  final NetworkInterfaceService networkInterfaceService;
  final AppLaunchAtStartupService appLaunchAtStartupService;
  final AppAuthorizationService appAuthorizationService;
  final AppWindowBehaviorService appWindowBehaviorService;
  final PrinterConnectionTestService printerConnectionTestService;
  final ServerBindValidationService serverBindValidationService;
  final PrintQueueService printQueueService;
  final LoggerService loggerService;
  final SettingsRepository settingsRepository;
  final ServerRepository serverRepository;
  final PrintersRepository printersRepository;
  final AppsRepository appsRepository;
  final PrintJobsRepository printJobsRepository;
  final LogsRepository logsRepository;
  final Duration minimumSplashDuration;

  const QintrixApp({
    required this.startupService,
    required this.preferencesService,
    required this.networkInterfaceService,
    required this.appLaunchAtStartupService,
    required this.appAuthorizationService,
    required this.appWindowBehaviorService,
    required this.printerConnectionTestService,
    required this.serverBindValidationService,
    required this.printQueueService,
    required this.loggerService,
    required this.settingsRepository,
    required this.serverRepository,
    required this.printersRepository,
    required this.appsRepository,
    required this.printJobsRepository,
    required this.logsRepository,
    this.minimumSplashDuration = Duration.zero,
    super.key,
  });

  @override
  State<QintrixApp> createState() => _QintrixAppState();
}

class _QintrixAppState extends State<QintrixApp> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  final AppRuntimeSignals _runtimeSignals = AppRuntimeSignals();

  @override
  void initState() {
    super.initState();
    widget.appWindowBehaviorService.configureTrayActions(
      readServerState: widget.serverRepository.getState,
      startServer: () => _runServerAction(widget.serverRepository.startServer),
      stopServer: () => _runServerAction(widget.serverRepository.stopServer),
      restartServer: () => _runServerAction(widget.serverRepository.restartServer),
      openSettings: () => _openRoute(SettingsPage.routeName),
      openServerOverview: () => _openRoute(ServerPage.routeName),
    );
  }

  @override
  void dispose() {
    _runtimeSignals.dispose();
    super.dispose();
  }

  Future<void> _openRoute(String routeName) async {
    final navigator = _navigatorKey.currentState;
    if (navigator == null) {
      return;
    }

    await navigator.pushNamedAndRemoveUntil(routeName, (_) => false);
  }

  Future<void> _runServerAction(Future<void> Function() action) async {
    await action();
    _runtimeSignals.bumpServer();
  }

  @override
  Widget build(BuildContext context) {
    return Provider<AppRuntimeSignals>.value(
      value: _runtimeSignals,
      child: MultiRepositoryProvider(
        providers: [
          RepositoryProvider.value(value: widget.settingsRepository),
          RepositoryProvider.value(value: widget.serverRepository),
          RepositoryProvider.value(value: widget.printersRepository),
          RepositoryProvider.value(value: widget.appsRepository),
          RepositoryProvider.value(value: widget.printJobsRepository),
          RepositoryProvider.value(value: widget.logsRepository),
          RepositoryProvider.value(value: widget.loggerService),
          RepositoryProvider.value(value: widget.networkInterfaceService),
          RepositoryProvider.value(value: widget.appLaunchAtStartupService),
          RepositoryProvider.value(value: widget.appAuthorizationService),
          RepositoryProvider.value(value: widget.appWindowBehaviorService),
          RepositoryProvider.value(value: widget.printerConnectionTestService),
          RepositoryProvider.value(value: widget.serverBindValidationService),
          RepositoryProvider.value(value: widget.printQueueService),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => StartupCubit(
                startupService: widget.startupService,
                loggerService: widget.loggerService,
                minimumSplashDuration: widget.minimumSplashDuration,
              )..start(),
            ),
            BlocProvider(
              create: (_) =>
                  LocaleCubit(preferencesService: widget.preferencesService),
            ),
            BlocProvider(
              create: (_) => ThemeModeCubit(
                preferencesService: widget.preferencesService,
              ),
            ),
            BlocProvider(
              create: (_) => SettingsCubit(
                settingsRepository: widget.settingsRepository,
              )..load(),
            ),
            BlocProvider(
              create: (_) => LogsCubit(logsRepository: widget.logsRepository),
            ),
            BlocProvider(create: (_) => SidebarCubit()),
            BlocProvider(create: (_) => ShellNavigationCubit()),
          ],
          child: BlocBuilder<LocaleCubit, Locale>(
            builder: (context, locale) {
              return BlocBuilder<ThemeModeCubit, ThemeMode>(
                builder: (context, themeMode) {
                  return MaterialApp(
                    navigatorKey: _navigatorKey,
                    debugShowCheckedModeBanner: false,
                    onGenerateTitle: (context) =>
                        AppLocalizations.of(context)!.appTitle,
                    themeMode: themeMode,
                    locale: locale,
                    supportedLocales: AppLocaleUtils.supportedLocales,
                    localizationsDelegates: [
                      AppLocalizations.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                    ],
                    theme: AppTheme.light(locale),
                    darkTheme: AppTheme.dark(locale),
                    routes: AppRouter.routes,
                    initialRoute: '/',
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
