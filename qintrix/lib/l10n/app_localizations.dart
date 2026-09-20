import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Qintrix'**
  String get appTitle;

  /// No description provided for @navDashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get navDashboard;

  /// No description provided for @navServer.
  ///
  /// In en, this message translates to:
  /// **'Server'**
  String get navServer;

  /// No description provided for @navPrinters.
  ///
  /// In en, this message translates to:
  /// **'Printers'**
  String get navPrinters;

  /// No description provided for @navJobs.
  ///
  /// In en, this message translates to:
  /// **'Jobs'**
  String get navJobs;

  /// No description provided for @navApps.
  ///
  /// In en, this message translates to:
  /// **'Apps'**
  String get navApps;

  /// No description provided for @navLogs.
  ///
  /// In en, this message translates to:
  /// **'Logs'**
  String get navLogs;

  /// No description provided for @navSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get navSettings;

  /// No description provided for @navAbout.
  ///
  /// In en, this message translates to:
  /// **'About App'**
  String get navAbout;

  /// No description provided for @dashboardDescription.
  ///
  /// In en, this message translates to:
  /// **'View a lightweight operational overview and jump into the main management areas.'**
  String get dashboardDescription;

  /// No description provided for @dashboardServerLoading.
  ///
  /// In en, this message translates to:
  /// **'Loading server status...'**
  String get dashboardServerLoading;

  /// No description provided for @serverTitle.
  ///
  /// In en, this message translates to:
  /// **'Server'**
  String get serverTitle;

  /// No description provided for @serverDescription.
  ///
  /// In en, this message translates to:
  /// **'Manage the embedded API server runtime, controls, and recent server activity.'**
  String get serverDescription;

  /// No description provided for @dashboardServerRunning.
  ///
  /// In en, this message translates to:
  /// **'Running'**
  String get dashboardServerRunning;

  /// No description provided for @dashboardServerStopped.
  ///
  /// In en, this message translates to:
  /// **'Stopped'**
  String get dashboardServerStopped;

  /// No description provided for @dashboardMetricHost.
  ///
  /// In en, this message translates to:
  /// **'Host'**
  String get dashboardMetricHost;

  /// No description provided for @dashboardMetricPort.
  ///
  /// In en, this message translates to:
  /// **'Port'**
  String get dashboardMetricPort;

  /// No description provided for @dashboardMetricLastChanged.
  ///
  /// In en, this message translates to:
  /// **'Last changed'**
  String get dashboardMetricLastChanged;

  /// No description provided for @dashboardMetricStartedAt.
  ///
  /// In en, this message translates to:
  /// **'Started at'**
  String get dashboardMetricStartedAt;

  /// No description provided for @serverMetricRuntime.
  ///
  /// In en, this message translates to:
  /// **'Runtime'**
  String get serverMetricRuntime;

  /// No description provided for @dashboardUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Unavailable'**
  String get dashboardUnavailable;

  /// No description provided for @dashboardServerStart.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get dashboardServerStart;

  /// No description provided for @dashboardServerStop.
  ///
  /// In en, this message translates to:
  /// **'Stop'**
  String get dashboardServerStop;

  /// No description provided for @dashboardServerRestart.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get dashboardServerRestart;

  /// No description provided for @dashboardRuntimeTitle.
  ///
  /// In en, this message translates to:
  /// **'Runtime configuration'**
  String get dashboardRuntimeTitle;

  /// No description provided for @dashboardRuntimeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Current server settings used by startup and manual server controls.'**
  String get dashboardRuntimeSubtitle;

  /// No description provided for @dashboardConfigLanAccess.
  ///
  /// In en, this message translates to:
  /// **'LAN access'**
  String get dashboardConfigLanAccess;

  /// No description provided for @dashboardConfigAutoStart.
  ///
  /// In en, this message translates to:
  /// **'Auto start server'**
  String get dashboardConfigAutoStart;

  /// No description provided for @dashboardConfigBackgroundMode.
  ///
  /// In en, this message translates to:
  /// **'Background mode'**
  String get dashboardConfigBackgroundMode;

  /// No description provided for @dashboardConfigStartWithOs.
  ///
  /// In en, this message translates to:
  /// **'Start with OS'**
  String get dashboardConfigStartWithOs;

  /// No description provided for @dashboardEnabled.
  ///
  /// In en, this message translates to:
  /// **'Enabled'**
  String get dashboardEnabled;

  /// No description provided for @dashboardDisabled.
  ///
  /// In en, this message translates to:
  /// **'Disabled'**
  String get dashboardDisabled;

  /// No description provided for @dashboardRecentActivityTitle.
  ///
  /// In en, this message translates to:
  /// **'Recent activity'**
  String get dashboardRecentActivityTitle;

  /// No description provided for @dashboardRecentActivitySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Latest server lifecycle, authorization, and printer test events.'**
  String get dashboardRecentActivitySubtitle;

  /// No description provided for @dashboardRecentActivityEmpty.
  ///
  /// In en, this message translates to:
  /// **'No server activity has been logged yet.'**
  String get dashboardRecentActivityEmpty;

  /// No description provided for @shellCollapseSidebar.
  ///
  /// In en, this message translates to:
  /// **'Collapse sidebar'**
  String get shellCollapseSidebar;

  /// No description provided for @shellExpandSidebar.
  ///
  /// In en, this message translates to:
  /// **'Expand sidebar'**
  String get shellExpandSidebar;

  /// No description provided for @shellCopyrightText.
  ///
  /// In en, this message translates to:
  /// **'Qintrix © {year} · Crafted by'**
  String shellCopyrightText(int year);

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @languageArabic.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get languageArabic;

  /// No description provided for @themeModeSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get themeModeSystem;

  /// No description provided for @themeModeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeModeLight;

  /// No description provided for @themeModeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeModeDark;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @settingsDescription.
  ///
  /// In en, this message translates to:
  /// **'Control how Qintrix looks and which language it uses when the app reopens.'**
  String get settingsDescription;

  /// No description provided for @settingsAppearanceTitle.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get settingsAppearanceTitle;

  /// No description provided for @settingsAppearanceDescription.
  ///
  /// In en, this message translates to:
  /// **'Choose how the interface handles light and dark themes.'**
  String get settingsAppearanceDescription;

  /// No description provided for @settingsLanguageTitle.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguageTitle;

  /// No description provided for @settingsLanguageDescription.
  ///
  /// In en, this message translates to:
  /// **'Switch the application language instantly and keep the preference saved.'**
  String get settingsLanguageDescription;

  /// No description provided for @settingsApplicationTitle.
  ///
  /// In en, this message translates to:
  /// **'Application'**
  String get settingsApplicationTitle;

  /// No description provided for @settingsApplicationDescription.
  ///
  /// In en, this message translates to:
  /// **'Manage app-level behavior and startup preferences.'**
  String get settingsApplicationDescription;

  /// No description provided for @settingsApplicationDiagnosticsTitle.
  ///
  /// In en, this message translates to:
  /// **'Application diagnostics'**
  String get settingsApplicationDiagnosticsTitle;

  /// No description provided for @settingsApplicationDiagnosticsDescription.
  ///
  /// In en, this message translates to:
  /// **'Verify whether autostart, background mode, and the tray/menu bar integration are active right now.'**
  String get settingsApplicationDiagnosticsDescription;

  /// No description provided for @settingsApplicationStartWithOsStatus.
  ///
  /// In en, this message translates to:
  /// **'Start with OS'**
  String get settingsApplicationStartWithOsStatus;

  /// No description provided for @settingsApplicationBackgroundModeStatus.
  ///
  /// In en, this message translates to:
  /// **'Background mode'**
  String get settingsApplicationBackgroundModeStatus;

  /// No description provided for @settingsApplicationTrayStatus.
  ///
  /// In en, this message translates to:
  /// **'Tray / menu bar'**
  String get settingsApplicationTrayStatus;

  /// No description provided for @settingsServerTitle.
  ///
  /// In en, this message translates to:
  /// **'Server'**
  String get settingsServerTitle;

  /// No description provided for @settingsServerDescription.
  ///
  /// In en, this message translates to:
  /// **'Manage local server and agent runtime settings.'**
  String get settingsServerDescription;

  /// No description provided for @settingsJobsTitle.
  ///
  /// In en, this message translates to:
  /// **'Jobs'**
  String get settingsJobsTitle;

  /// No description provided for @settingsJobsDescription.
  ///
  /// In en, this message translates to:
  /// **'Manage queue startup behavior, retry policy, and job retention defaults.'**
  String get settingsJobsDescription;

  /// No description provided for @settingsAppPort.
  ///
  /// In en, this message translates to:
  /// **'App port'**
  String get settingsAppPort;

  /// No description provided for @settingsBindHost.
  ///
  /// In en, this message translates to:
  /// **'Bind IP'**
  String get settingsBindHost;

  /// No description provided for @settingsEnableBackgroundMode.
  ///
  /// In en, this message translates to:
  /// **'Enable background mode'**
  String get settingsEnableBackgroundMode;

  /// No description provided for @settingsStartWithOs.
  ///
  /// In en, this message translates to:
  /// **'Start with OS'**
  String get settingsStartWithOs;

  /// No description provided for @settingsAllowLanAccess.
  ///
  /// In en, this message translates to:
  /// **'Allow LAN access'**
  String get settingsAllowLanAccess;

  /// No description provided for @settingsAutoStartServer.
  ///
  /// In en, this message translates to:
  /// **'Auto start server'**
  String get settingsAutoStartServer;

  /// No description provided for @settingsSaveApplication.
  ///
  /// In en, this message translates to:
  /// **'Save application settings'**
  String get settingsSaveApplication;

  /// No description provided for @settingsSaveServer.
  ///
  /// In en, this message translates to:
  /// **'Save server settings'**
  String get settingsSaveServer;

  /// No description provided for @settingsSaveJobs.
  ///
  /// In en, this message translates to:
  /// **'Save jobs settings'**
  String get settingsSaveJobs;

  /// No description provided for @settingsJobsStartPaused.
  ///
  /// In en, this message translates to:
  /// **'Start queue in paused mode'**
  String get settingsJobsStartPaused;

  /// No description provided for @settingsJobsMaxRetries.
  ///
  /// In en, this message translates to:
  /// **'Max retry attempts'**
  String get settingsJobsMaxRetries;

  /// No description provided for @settingsJobsRetryDelaySeconds.
  ///
  /// In en, this message translates to:
  /// **'Retry delay (seconds)'**
  String get settingsJobsRetryDelaySeconds;

  /// No description provided for @settingsJobsHistoryRetentionDays.
  ///
  /// In en, this message translates to:
  /// **'History retention (days)'**
  String get settingsJobsHistoryRetentionDays;

  /// No description provided for @settingsInvalidPort.
  ///
  /// In en, this message translates to:
  /// **'Port must be a number between 1 and 65535.'**
  String get settingsInvalidPort;

  /// No description provided for @settingsInvalidHost.
  ///
  /// In en, this message translates to:
  /// **'Enter a local IPv4 address only, such as 127.0.0.1 or 192.168.1.20.'**
  String get settingsInvalidHost;

  /// No description provided for @settingsLanIpDetecting.
  ///
  /// In en, this message translates to:
  /// **'Detecting available LAN IP...'**
  String get settingsLanIpDetecting;

  /// No description provided for @settingsLanIpAutofilled.
  ///
  /// In en, this message translates to:
  /// **'A LAN IP was detected and filled automatically.'**
  String get settingsLanIpAutofilled;

  /// No description provided for @settingsLanIpUnavailable.
  ///
  /// In en, this message translates to:
  /// **'No LAN IP is currently available. Keeping the current IP.'**
  String get settingsLanIpUnavailable;

  /// No description provided for @settingsSaveSuccess.
  ///
  /// In en, this message translates to:
  /// **'Server settings saved successfully.'**
  String get settingsSaveSuccess;

  /// No description provided for @settingsSaveAndRestartSuccess.
  ///
  /// In en, this message translates to:
  /// **'Server settings saved and the server restarted.'**
  String get settingsSaveAndRestartSuccess;

  /// No description provided for @settingsRestartFailed.
  ///
  /// In en, this message translates to:
  /// **'Settings were saved, but the server could not restart.'**
  String get settingsRestartFailed;

  /// No description provided for @settingsSaveValidationFailed.
  ///
  /// In en, this message translates to:
  /// **'Please fix the highlighted fields before saving.'**
  String get settingsSaveValidationFailed;

  /// No description provided for @settingsBindValidationFailed.
  ///
  /// In en, this message translates to:
  /// **'The selected host or port cannot be used to run the server.'**
  String get settingsBindValidationFailed;

  /// No description provided for @aboutTitle.
  ///
  /// In en, this message translates to:
  /// **'About App'**
  String get aboutTitle;

  /// No description provided for @aboutHeading.
  ///
  /// In en, this message translates to:
  /// **'A desktop print bridge for modern operational teams'**
  String get aboutHeading;

  /// No description provided for @aboutDescription.
  ///
  /// In en, this message translates to:
  /// **'Qintrix connects websites, systems, and internal tools to local printers through one controlled desktop workspace. It is built to keep printing reliable, visible, and easy to manage for operators.'**
  String get aboutDescription;

  /// No description provided for @aboutHeroEyebrow.
  ///
  /// In en, this message translates to:
  /// **'Application Overview'**
  String get aboutHeroEyebrow;

  /// No description provided for @aboutHeroPillLocalBridge.
  ///
  /// In en, this message translates to:
  /// **'Local print bridge'**
  String get aboutHeroPillLocalBridge;

  /// No description provided for @aboutHeroPillSecureApps.
  ///
  /// In en, this message translates to:
  /// **'Secure app access'**
  String get aboutHeroPillSecureApps;

  /// No description provided for @aboutHeroPillOperationalControl.
  ///
  /// In en, this message translates to:
  /// **'Operational control'**
  String get aboutHeroPillOperationalControl;

  /// No description provided for @aboutHeroMetricJobs.
  ///
  /// In en, this message translates to:
  /// **'Jobs handled'**
  String get aboutHeroMetricJobs;

  /// No description provided for @aboutHeroMetricPrinters.
  ///
  /// In en, this message translates to:
  /// **'Enabled printers'**
  String get aboutHeroMetricPrinters;

  /// No description provided for @aboutHeroMetricApps.
  ///
  /// In en, this message translates to:
  /// **'Enabled apps'**
  String get aboutHeroMetricApps;

  /// No description provided for @aboutHeroMetricSuccessRate.
  ///
  /// In en, this message translates to:
  /// **'Success rate'**
  String get aboutHeroMetricSuccessRate;

  /// No description provided for @aboutAnalyticsTitle.
  ///
  /// In en, this message translates to:
  /// **'Live application snapshot'**
  String get aboutAnalyticsTitle;

  /// No description provided for @aboutAnalyticsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'A quick read of workload, availability, and active alerts.'**
  String get aboutAnalyticsSubtitle;

  /// No description provided for @aboutMetricTotalJobs.
  ///
  /// In en, this message translates to:
  /// **'Total jobs'**
  String get aboutMetricTotalJobs;

  /// No description provided for @aboutMetricCompletionRate.
  ///
  /// In en, this message translates to:
  /// **'Completion rate'**
  String get aboutMetricCompletionRate;

  /// No description provided for @aboutMetricEnabledPrinters.
  ///
  /// In en, this message translates to:
  /// **'Enabled printers'**
  String get aboutMetricEnabledPrinters;

  /// No description provided for @aboutMetricEnabledApps.
  ///
  /// In en, this message translates to:
  /// **'Enabled apps'**
  String get aboutMetricEnabledApps;

  /// No description provided for @aboutMetricQueuedJobs.
  ///
  /// In en, this message translates to:
  /// **'Queued jobs'**
  String get aboutMetricQueuedJobs;

  /// No description provided for @aboutMetricRecentAlerts.
  ///
  /// In en, this message translates to:
  /// **'Recent alerts'**
  String get aboutMetricRecentAlerts;

  /// No description provided for @aboutTrendTitle.
  ///
  /// In en, this message translates to:
  /// **'Jobs over the last 7 days'**
  String get aboutTrendTitle;

  /// No description provided for @aboutTrendSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Daily incoming print activity across the workspace.'**
  String get aboutTrendSubtitle;

  /// No description provided for @dashboardTrendTotalLabel.
  ///
  /// In en, this message translates to:
  /// **'Total volume'**
  String get dashboardTrendTotalLabel;

  /// No description provided for @dashboardTrendPeakDayLabel.
  ///
  /// In en, this message translates to:
  /// **'Peak day'**
  String get dashboardTrendPeakDayLabel;

  /// No description provided for @dashboardAllTimeLabel.
  ///
  /// In en, this message translates to:
  /// **'All time'**
  String get dashboardAllTimeLabel;

  /// No description provided for @aboutStatusMixTitle.
  ///
  /// In en, this message translates to:
  /// **'Job status mix'**
  String get aboutStatusMixTitle;

  /// No description provided for @aboutStatusMixSubtitle.
  ///
  /// In en, this message translates to:
  /// **'How the current workload is distributed.'**
  String get aboutStatusMixSubtitle;

  /// No description provided for @aboutConnectionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Connection footprint'**
  String get aboutConnectionsTitle;

  /// No description provided for @aboutConnectionsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Configured printer connection types in the current setup.'**
  String get aboutConnectionsSubtitle;

  /// No description provided for @aboutContentTypesTitle.
  ///
  /// In en, this message translates to:
  /// **'Content type mix'**
  String get aboutContentTypesTitle;

  /// No description provided for @aboutContentTypesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'What the system is receiving most often from connected clients.'**
  String get aboutContentTypesSubtitle;

  /// No description provided for @aboutPurposeTitle.
  ///
  /// In en, this message translates to:
  /// **'What Qintrix does'**
  String get aboutPurposeTitle;

  /// No description provided for @aboutPurposeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'One place to receive, process, and monitor printing work.'**
  String get aboutPurposeSubtitle;

  /// No description provided for @aboutPurposeBody.
  ///
  /// In en, this message translates to:
  /// **'Qintrix acts as the link between API-driven requests and the printers available on the local machine or network. Instead of wiring each printer directly into an external system, teams can manage printers, apps, queue behavior, server runtime, and diagnostics from one interface.'**
  String get aboutPurposeBody;

  /// No description provided for @aboutAudienceTitle.
  ///
  /// In en, this message translates to:
  /// **'Who it is for'**
  String get aboutAudienceTitle;

  /// No description provided for @aboutAudienceBody.
  ///
  /// In en, this message translates to:
  /// **'It fits operations that need stable receipt, label, ticket, or workstation printing while keeping access rules, retries, and troubleshooting visible to both operators and support teams.'**
  String get aboutAudienceBody;

  /// No description provided for @aboutWorkflowTitle.
  ///
  /// In en, this message translates to:
  /// **'How the workflow works'**
  String get aboutWorkflowTitle;

  /// No description provided for @aboutWorkflowSubtitle.
  ///
  /// In en, this message translates to:
  /// **'A simple path from incoming request to completed print output.'**
  String get aboutWorkflowSubtitle;

  /// No description provided for @aboutWorkflowStepConnectTitle.
  ///
  /// In en, this message translates to:
  /// **'Connect printers and apps'**
  String get aboutWorkflowStepConnectTitle;

  /// No description provided for @aboutWorkflowStepConnectDescription.
  ///
  /// In en, this message translates to:
  /// **'Register printers, choose the right connection type, and control which client apps are allowed to send jobs.'**
  String get aboutWorkflowStepConnectDescription;

  /// No description provided for @aboutWorkflowStepProcessTitle.
  ///
  /// In en, this message translates to:
  /// **'Accept, queue, and execute jobs'**
  String get aboutWorkflowStepProcessTitle;

  /// No description provided for @aboutWorkflowStepProcessDescription.
  ///
  /// In en, this message translates to:
  /// **'Incoming jobs are validated, prepared, queued, and executed through the configured printer connection with the right options and retries.'**
  String get aboutWorkflowStepProcessDescription;

  /// No description provided for @aboutWorkflowStepObserveTitle.
  ///
  /// In en, this message translates to:
  /// **'Monitor status and fix issues quickly'**
  String get aboutWorkflowStepObserveTitle;

  /// No description provided for @aboutWorkflowStepObserveDescription.
  ///
  /// In en, this message translates to:
  /// **'Track server health, job progress, queue state, and logs in real time so operators can respond before small issues become downtime.'**
  String get aboutWorkflowStepObserveDescription;

  /// No description provided for @aboutModulesTitle.
  ///
  /// In en, this message translates to:
  /// **'Main areas of the workspace'**
  String get aboutModulesTitle;

  /// No description provided for @aboutModulesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Each module focuses on one part of the printing operation so the interface stays easy to scan.'**
  String get aboutModulesSubtitle;

  /// No description provided for @aboutHighlightsTitle.
  ///
  /// In en, this message translates to:
  /// **'Why teams use it'**
  String get aboutHighlightsTitle;

  /// No description provided for @aboutHighlightsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Designed to reduce print friction without hiding technical detail.'**
  String get aboutHighlightsSubtitle;

  /// No description provided for @aboutHighlightSecureTitle.
  ///
  /// In en, this message translates to:
  /// **'Controlled access'**
  String get aboutHighlightSecureTitle;

  /// No description provided for @aboutHighlightSecureDescription.
  ///
  /// In en, this message translates to:
  /// **'Client apps authenticate with API keys, can be enabled or disabled individually, and can be scoped to selected printers.'**
  String get aboutHighlightSecureDescription;

  /// No description provided for @aboutHighlightReliableTitle.
  ///
  /// In en, this message translates to:
  /// **'Reliable job handling'**
  String get aboutHighlightReliableTitle;

  /// No description provided for @aboutHighlightReliableDescription.
  ///
  /// In en, this message translates to:
  /// **'Jobs move through clear states with queue controls, retries, artifacts, and history that make print failures easier to diagnose.'**
  String get aboutHighlightReliableDescription;

  /// No description provided for @aboutHighlightFlexibleTitle.
  ///
  /// In en, this message translates to:
  /// **'Flexible connection support'**
  String get aboutHighlightFlexibleTitle;

  /// No description provided for @aboutHighlightFlexibleDescription.
  ///
  /// In en, this message translates to:
  /// **'Qintrix supports system spooler, network TCP, and raw ESC/POS-oriented workflows while keeping one consistent operational interface.'**
  String get aboutHighlightFlexibleDescription;

  /// No description provided for @aboutVersionLabel.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get aboutVersionLabel;

  /// No description provided for @aboutVersionDescription.
  ///
  /// In en, this message translates to:
  /// **'Current application build'**
  String get aboutVersionDescription;

  /// No description provided for @aboutVersionNote.
  ///
  /// In en, this message translates to:
  /// **'This build packages the server, printers, jobs, apps, logs, and settings experience into a single desktop control surface for production print operations.'**
  String get aboutVersionNote;

  /// No description provided for @aboutAttributionTitle.
  ///
  /// In en, this message translates to:
  /// **'Design & development by Tenvoro'**
  String get aboutAttributionTitle;

  /// No description provided for @aboutAttributionSubtitle.
  ///
  /// In en, this message translates to:
  /// **'This application experience, interface, and implementation were crafted by Tenvoro.'**
  String get aboutAttributionSubtitle;

  /// No description provided for @aboutAttributionAction.
  ///
  /// In en, this message translates to:
  /// **'View publisher'**
  String get aboutAttributionAction;

  /// No description provided for @logsTitle.
  ///
  /// In en, this message translates to:
  /// **'Logs'**
  String get logsTitle;

  /// No description provided for @logsDescription.
  ///
  /// In en, this message translates to:
  /// **'Persistent application events, server activity, and job lifecycle updates.'**
  String get logsDescription;

  /// No description provided for @printersTitle.
  ///
  /// In en, this message translates to:
  /// **'Printers'**
  String get printersTitle;

  /// No description provided for @printersDescription.
  ///
  /// In en, this message translates to:
  /// **'Manage printer definitions, connection types, and device-specific settings.'**
  String get printersDescription;

  /// No description provided for @jobsTitle.
  ///
  /// In en, this message translates to:
  /// **'Jobs'**
  String get jobsTitle;

  /// No description provided for @jobsDescription.
  ///
  /// In en, this message translates to:
  /// **'Track print jobs, retries, queue activity, and execution state.'**
  String get jobsDescription;

  /// No description provided for @appsTitle.
  ///
  /// In en, this message translates to:
  /// **'Apps'**
  String get appsTitle;

  /// No description provided for @appsDescription.
  ///
  /// In en, this message translates to:
  /// **'Manage client apps, API keys, and printer access rules.'**
  String get appsDescription;

  /// No description provided for @jobsSearchPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Search jobs'**
  String get jobsSearchPlaceholder;

  /// No description provided for @jobsResetFilters.
  ///
  /// In en, this message translates to:
  /// **'Reset filters'**
  String get jobsResetFilters;

  /// No description provided for @jobsFilterStatus.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get jobsFilterStatus;

  /// No description provided for @jobsAllStatuses.
  ///
  /// In en, this message translates to:
  /// **'All statuses'**
  String get jobsAllStatuses;

  /// No description provided for @jobsFilterContentType.
  ///
  /// In en, this message translates to:
  /// **'Content type'**
  String get jobsFilterContentType;

  /// No description provided for @jobsAllContentTypes.
  ///
  /// In en, this message translates to:
  /// **'All content types'**
  String get jobsAllContentTypes;

  /// No description provided for @jobsStatusAccepted.
  ///
  /// In en, this message translates to:
  /// **'Accepted'**
  String get jobsStatusAccepted;

  /// No description provided for @jobsStatusRendering.
  ///
  /// In en, this message translates to:
  /// **'Rendering'**
  String get jobsStatusRendering;

  /// No description provided for @jobsStatusQueued.
  ///
  /// In en, this message translates to:
  /// **'Queued'**
  String get jobsStatusQueued;

  /// No description provided for @jobsStatusProcessing.
  ///
  /// In en, this message translates to:
  /// **'Processing'**
  String get jobsStatusProcessing;

  /// No description provided for @jobsStatusCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get jobsStatusCompleted;

  /// No description provided for @jobsStatusFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed'**
  String get jobsStatusFailed;

  /// No description provided for @jobsStatusCanceled.
  ///
  /// In en, this message translates to:
  /// **'Canceled'**
  String get jobsStatusCanceled;

  /// No description provided for @jobsStatusRetryScheduled.
  ///
  /// In en, this message translates to:
  /// **'Retry scheduled'**
  String get jobsStatusRetryScheduled;

  /// No description provided for @jobsEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No jobs yet'**
  String get jobsEmptyTitle;

  /// No description provided for @jobsEmptyDescription.
  ///
  /// In en, this message translates to:
  /// **'Accepted print jobs will appear here after they are created through the API.'**
  String get jobsEmptyDescription;

  /// No description provided for @jobsRetrySuccess.
  ///
  /// In en, this message translates to:
  /// **'Job queued for retry.'**
  String get jobsRetrySuccess;

  /// No description provided for @jobsCancelSuccess.
  ///
  /// In en, this message translates to:
  /// **'Job canceled successfully.'**
  String get jobsCancelSuccess;

  /// No description provided for @jobsColumnId.
  ///
  /// In en, this message translates to:
  /// **'Job ID'**
  String get jobsColumnId;

  /// No description provided for @jobsColumnPrinter.
  ///
  /// In en, this message translates to:
  /// **'Printer'**
  String get jobsColumnPrinter;

  /// No description provided for @jobsColumnContentType.
  ///
  /// In en, this message translates to:
  /// **'Content type'**
  String get jobsColumnContentType;

  /// No description provided for @jobsColumnStatus.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get jobsColumnStatus;

  /// No description provided for @jobsColumnReference.
  ///
  /// In en, this message translates to:
  /// **'Reference'**
  String get jobsColumnReference;

  /// No description provided for @jobsColumnCreatedAt.
  ///
  /// In en, this message translates to:
  /// **'Created at'**
  String get jobsColumnCreatedAt;

  /// No description provided for @jobsBackToJobs.
  ///
  /// In en, this message translates to:
  /// **'Back to jobs'**
  String get jobsBackToJobs;

  /// No description provided for @jobsArtifactLabel.
  ///
  /// In en, this message translates to:
  /// **'Artifact'**
  String get jobsArtifactLabel;

  /// No description provided for @jobsFailureLabel.
  ///
  /// In en, this message translates to:
  /// **'Failure'**
  String get jobsFailureLabel;

  /// No description provided for @jobsQueuePausedTitle.
  ///
  /// In en, this message translates to:
  /// **'Queue paused'**
  String get jobsQueuePausedTitle;

  /// No description provided for @jobsQueuePausedDescription.
  ///
  /// In en, this message translates to:
  /// **'New jobs can still be accepted, but no queued work will start until the queue is resumed.'**
  String get jobsQueuePausedDescription;

  /// No description provided for @jobsQueuePausedBadge.
  ///
  /// In en, this message translates to:
  /// **'Paused'**
  String get jobsQueuePausedBadge;

  /// No description provided for @jobsQueueResumeAction.
  ///
  /// In en, this message translates to:
  /// **'Resume'**
  String get jobsQueueResumeAction;

  /// No description provided for @jobsQueueRunningTitle.
  ///
  /// In en, this message translates to:
  /// **'Queue running'**
  String get jobsQueueRunningTitle;

  /// No description provided for @jobsQueueRunningDescription.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0 {No active workers right now. Queued jobs will start automatically when available.} =1 {1 worker is currently processing jobs.} other {{count} workers are currently processing jobs.}}'**
  String jobsQueueRunningDescription(int count);

  /// No description provided for @jobsQueueRunningBadge.
  ///
  /// In en, this message translates to:
  /// **'Running'**
  String get jobsQueueRunningBadge;

  /// No description provided for @printersCreateAction.
  ///
  /// In en, this message translates to:
  /// **'Create printer'**
  String get printersCreateAction;

  /// No description provided for @printersEditAction.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get printersEditAction;

  /// No description provided for @printersShowAction.
  ///
  /// In en, this message translates to:
  /// **'Show'**
  String get printersShowAction;

  /// No description provided for @printersDeleteAction.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get printersDeleteAction;

  /// No description provided for @printersDeletedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Printer deleted successfully.'**
  String get printersDeletedSuccess;

  /// No description provided for @printersBulkDeletedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Selected printers deleted successfully.'**
  String get printersBulkDeletedSuccess;

  /// No description provided for @printersSaveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save changes'**
  String get printersSaveChanges;

  /// No description provided for @printersBulkDeleteAction.
  ///
  /// In en, this message translates to:
  /// **'Delete selected'**
  String get printersBulkDeleteAction;

  /// No description provided for @printersBackToIndex.
  ///
  /// In en, this message translates to:
  /// **'Back to printers'**
  String get printersBackToIndex;

  /// No description provided for @printersDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete printer'**
  String get printersDeleteTitle;

  /// No description provided for @printersDeleteDescription.
  ///
  /// In en, this message translates to:
  /// **'Delete {name} permanently?'**
  String printersDeleteDescription(String name);

  /// No description provided for @printersBulkDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete selected printers'**
  String get printersBulkDeleteTitle;

  /// No description provided for @printersBulkDeleteDescription.
  ///
  /// In en, this message translates to:
  /// **'Delete {count} selected printers permanently?'**
  String printersBulkDeleteDescription(int count);

  /// No description provided for @printersSelectedCount.
  ///
  /// In en, this message translates to:
  /// **'{count} selected'**
  String printersSelectedCount(int count);

  /// No description provided for @printersEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No printers yet'**
  String get printersEmptyTitle;

  /// No description provided for @printersEmptyDescription.
  ///
  /// In en, this message translates to:
  /// **'Create a printer definition to start routing future print jobs.'**
  String get printersEmptyDescription;

  /// No description provided for @printersColumnName.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get printersColumnName;

  /// No description provided for @printersColumnIdentifier.
  ///
  /// In en, this message translates to:
  /// **'Identifier'**
  String get printersColumnIdentifier;

  /// No description provided for @printersColumnConnectionType.
  ///
  /// In en, this message translates to:
  /// **'Connection type'**
  String get printersColumnConnectionType;

  /// No description provided for @printersColumnConnectionSummary.
  ///
  /// In en, this message translates to:
  /// **'Connection summary'**
  String get printersColumnConnectionSummary;

  /// No description provided for @printersColumnEnabled.
  ///
  /// In en, this message translates to:
  /// **'Enabled'**
  String get printersColumnEnabled;

  /// No description provided for @printersColumnLastStatus.
  ///
  /// In en, this message translates to:
  /// **'Last status'**
  String get printersColumnLastStatus;

  /// No description provided for @printersColumnLastStatusMessage.
  ///
  /// In en, this message translates to:
  /// **'Status message'**
  String get printersColumnLastStatusMessage;

  /// No description provided for @printersColumnUpdatedAt.
  ///
  /// In en, this message translates to:
  /// **'Updated'**
  String get printersColumnUpdatedAt;

  /// No description provided for @printersColumnActions.
  ///
  /// In en, this message translates to:
  /// **'Actions'**
  String get printersColumnActions;

  /// No description provided for @printersSearchPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Search printers'**
  String get printersSearchPlaceholder;

  /// No description provided for @printersFilterConnectionType.
  ///
  /// In en, this message translates to:
  /// **'Connection type'**
  String get printersFilterConnectionType;

  /// No description provided for @printersFilterAllTypes.
  ///
  /// In en, this message translates to:
  /// **'All types'**
  String get printersFilterAllTypes;

  /// No description provided for @printersFilterStatus.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get printersFilterStatus;

  /// No description provided for @printersFilterAllStatuses.
  ///
  /// In en, this message translates to:
  /// **'All statuses'**
  String get printersFilterAllStatuses;

  /// No description provided for @printersStatusEnabled.
  ///
  /// In en, this message translates to:
  /// **'Enabled'**
  String get printersStatusEnabled;

  /// No description provided for @printersStatusDisabled.
  ///
  /// In en, this message translates to:
  /// **'Disabled'**
  String get printersStatusDisabled;

  /// No description provided for @printersLastStatusTestSuccess.
  ///
  /// In en, this message translates to:
  /// **'Test succeeded'**
  String get printersLastStatusTestSuccess;

  /// No description provided for @printersLastStatusTestFailure.
  ///
  /// In en, this message translates to:
  /// **'Test failed'**
  String get printersLastStatusTestFailure;

  /// No description provided for @printersLastStatusTestNotSupported.
  ///
  /// In en, this message translates to:
  /// **'Test not supported'**
  String get printersLastStatusTestNotSupported;

  /// No description provided for @printersLastStatusPrintSuccess.
  ///
  /// In en, this message translates to:
  /// **'Print succeeded'**
  String get printersLastStatusPrintSuccess;

  /// No description provided for @printersLastStatusPrintFailure.
  ///
  /// In en, this message translates to:
  /// **'Print failed'**
  String get printersLastStatusPrintFailure;

  /// No description provided for @printersLastStatusRenderFailure.
  ///
  /// In en, this message translates to:
  /// **'Render failed'**
  String get printersLastStatusRenderFailure;

  /// No description provided for @printersTypeTcp.
  ///
  /// In en, this message translates to:
  /// **'Network Terminal Printer (TCP/IP)'**
  String get printersTypeTcp;

  /// No description provided for @printersTypeSystem.
  ///
  /// In en, this message translates to:
  /// **'USB / System Printer (Spooler)'**
  String get printersTypeSystem;

  /// No description provided for @printersTypeUsbRaw.
  ///
  /// In en, this message translates to:
  /// **'USB Raw ESC/POS Printer'**
  String get printersTypeUsbRaw;

  /// No description provided for @printersTypeTcpShort.
  ///
  /// In en, this message translates to:
  /// **'TCP/IP'**
  String get printersTypeTcpShort;

  /// No description provided for @printersTypeSystemShort.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get printersTypeSystemShort;

  /// No description provided for @printersTypeUsbRawShort.
  ///
  /// In en, this message translates to:
  /// **'USB Raw'**
  String get printersTypeUsbRawShort;

  /// No description provided for @printersFormOverviewTitle.
  ///
  /// In en, this message translates to:
  /// **'Printer overview'**
  String get printersFormOverviewTitle;

  /// No description provided for @printersBasicSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Basic settings'**
  String get printersBasicSectionTitle;

  /// No description provided for @printersAdvancedSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Advanced settings'**
  String get printersAdvancedSectionTitle;

  /// No description provided for @printersConnectionDetailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Connection details'**
  String get printersConnectionDetailsTitle;

  /// No description provided for @printersUniqueKeyHelper.
  ///
  /// In en, this message translates to:
  /// **'This identifier is generated automatically and used later by the API.'**
  String get printersUniqueKeyHelper;

  /// No description provided for @printersDescriptionHint.
  ///
  /// In en, this message translates to:
  /// **'Optional internal description'**
  String get printersDescriptionHint;

  /// No description provided for @printersBooleanYes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get printersBooleanYes;

  /// No description provided for @printersBooleanNo.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get printersBooleanNo;

  /// No description provided for @printersFieldName.
  ///
  /// In en, this message translates to:
  /// **'Printer name'**
  String get printersFieldName;

  /// No description provided for @printersFieldIdentifier.
  ///
  /// In en, this message translates to:
  /// **'Identifier'**
  String get printersFieldIdentifier;

  /// No description provided for @printersCopyIdentifierAction.
  ///
  /// In en, this message translates to:
  /// **'Copy identifier'**
  String get printersCopyIdentifierAction;

  /// No description provided for @printersIdentifierCopied.
  ///
  /// In en, this message translates to:
  /// **'Identifier copied.'**
  String get printersIdentifierCopied;

  /// No description provided for @printersCreatedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Printer created successfully.'**
  String get printersCreatedSuccess;

  /// No description provided for @printersUpdatedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Printer updated successfully.'**
  String get printersUpdatedSuccess;

  /// No description provided for @printersTestConnectionAction.
  ///
  /// In en, this message translates to:
  /// **'Test connection'**
  String get printersTestConnectionAction;

  /// No description provided for @printersTestConnectionSuccess.
  ///
  /// In en, this message translates to:
  /// **'Connection test succeeded. {message}'**
  String printersTestConnectionSuccess(String message);

  /// No description provided for @printersTestConnectionFailure.
  ///
  /// In en, this message translates to:
  /// **'Connection test failed. {message}'**
  String printersTestConnectionFailure(String message);

  /// No description provided for @printersTestConnectionNotSupported.
  ///
  /// In en, this message translates to:
  /// **'Connection test is not supported yet. {message}'**
  String printersTestConnectionNotSupported(String message);

  /// No description provided for @printersTestTcpMissingConfig.
  ///
  /// In en, this message translates to:
  /// **'Host and port are required before testing the TCP connection.'**
  String get printersTestTcpMissingConfig;

  /// No description provided for @printersTestTcpSuccess.
  ///
  /// In en, this message translates to:
  /// **'TCP connection to {host}:{port} succeeded.'**
  String printersTestTcpSuccess(String host, String port);

  /// No description provided for @printersTestTcpTimeout.
  ///
  /// In en, this message translates to:
  /// **'TCP connection to {host}:{port} timed out.'**
  String printersTestTcpTimeout(String host, String port);

  /// No description provided for @printersTestTcpFailure.
  ///
  /// In en, this message translates to:
  /// **'TCP connection to {host}:{port} failed. {error}'**
  String printersTestTcpFailure(String host, String port, String error);

  /// No description provided for @printersTestSystemMissingConfig.
  ///
  /// In en, this message translates to:
  /// **'Printer name or queue name is required before testing the system spooler connection.'**
  String get printersTestSystemMissingConfig;

  /// No description provided for @printersTestSystemSuccess.
  ///
  /// In en, this message translates to:
  /// **'System printer \"{name}\" is available.'**
  String printersTestSystemSuccess(String name);

  /// No description provided for @printersTestSystemFailure.
  ///
  /// In en, this message translates to:
  /// **'System printer \"{name}\" was not found.'**
  String printersTestSystemFailure(String name);

  /// No description provided for @printersTestUsbMissingConfig.
  ///
  /// In en, this message translates to:
  /// **'Vendor ID and product ID are required before testing the USB raw connection.'**
  String get printersTestUsbMissingConfig;

  /// No description provided for @printersTestUsbSuccess.
  ///
  /// In en, this message translates to:
  /// **'USB raw device {vendorId}:{productId} is available.'**
  String printersTestUsbSuccess(String vendorId, String productId);

  /// No description provided for @printersTestUsbFailure.
  ///
  /// In en, this message translates to:
  /// **'USB raw device {vendorId}:{productId} was not found.'**
  String printersTestUsbFailure(String vendorId, String productId);

  /// No description provided for @printersTestCommandUnavailable.
  ///
  /// In en, this message translates to:
  /// **'The local command \"{command}\" is not available on this system.'**
  String printersTestCommandUnavailable(String command);

  /// No description provided for @printersTestUnsupportedPlatform.
  ///
  /// In en, this message translates to:
  /// **'This connection test is not supported on the current platform.'**
  String get printersTestUnsupportedPlatform;

  /// No description provided for @printersFieldDescription.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get printersFieldDescription;

  /// No description provided for @printersFieldConnectionType.
  ///
  /// In en, this message translates to:
  /// **'Connection type'**
  String get printersFieldConnectionType;

  /// No description provided for @printersFieldEnabled.
  ///
  /// In en, this message translates to:
  /// **'Enabled'**
  String get printersFieldEnabled;

  /// No description provided for @printersFieldHost.
  ///
  /// In en, this message translates to:
  /// **'Host'**
  String get printersFieldHost;

  /// No description provided for @printersFieldPort.
  ///
  /// In en, this message translates to:
  /// **'Port'**
  String get printersFieldPort;

  /// No description provided for @printersFieldConnectTimeout.
  ///
  /// In en, this message translates to:
  /// **'Connect timeout (ms)'**
  String get printersFieldConnectTimeout;

  /// No description provided for @printersFieldWriteTimeout.
  ///
  /// In en, this message translates to:
  /// **'Write timeout (ms)'**
  String get printersFieldWriteTimeout;

  /// No description provided for @printersFieldReadTimeout.
  ///
  /// In en, this message translates to:
  /// **'Read timeout (ms)'**
  String get printersFieldReadTimeout;

  /// No description provided for @printersFieldAutoReconnect.
  ///
  /// In en, this message translates to:
  /// **'Auto reconnect'**
  String get printersFieldAutoReconnect;

  /// No description provided for @printersFieldReconnectDelay.
  ///
  /// In en, this message translates to:
  /// **'Reconnect delay (ms)'**
  String get printersFieldReconnectDelay;

  /// No description provided for @printersFieldEncoding.
  ///
  /// In en, this message translates to:
  /// **'Encoding'**
  String get printersFieldEncoding;

  /// No description provided for @printersFieldCodePage.
  ///
  /// In en, this message translates to:
  /// **'Code page'**
  String get printersFieldCodePage;

  /// No description provided for @printersFieldLineEnding.
  ///
  /// In en, this message translates to:
  /// **'Line ending'**
  String get printersFieldLineEnding;

  /// No description provided for @printersFieldKeepAlive.
  ///
  /// In en, this message translates to:
  /// **'Keep alive'**
  String get printersFieldKeepAlive;

  /// No description provided for @printersFieldNoDelay.
  ///
  /// In en, this message translates to:
  /// **'No delay'**
  String get printersFieldNoDelay;

  /// No description provided for @printersFieldLinger.
  ///
  /// In en, this message translates to:
  /// **'Linger (s)'**
  String get printersFieldLinger;

  /// No description provided for @printersFieldPrinterName.
  ///
  /// In en, this message translates to:
  /// **'Printer name'**
  String get printersFieldPrinterName;

  /// No description provided for @printersFieldPaperSize.
  ///
  /// In en, this message translates to:
  /// **'Paper size'**
  String get printersFieldPaperSize;

  /// No description provided for @printersFieldDefaultCopies.
  ///
  /// In en, this message translates to:
  /// **'Default copies'**
  String get printersFieldDefaultCopies;

  /// No description provided for @printersFieldColorEnabled.
  ///
  /// In en, this message translates to:
  /// **'Color enabled'**
  String get printersFieldColorEnabled;

  /// No description provided for @printersFieldDuplexMode.
  ///
  /// In en, this message translates to:
  /// **'Duplex mode'**
  String get printersFieldDuplexMode;

  /// No description provided for @printersFieldOrientation.
  ///
  /// In en, this message translates to:
  /// **'Orientation'**
  String get printersFieldOrientation;

  /// No description provided for @printersFieldJobTimeout.
  ///
  /// In en, this message translates to:
  /// **'Job timeout (ms)'**
  String get printersFieldJobTimeout;

  /// No description provided for @printersFieldNotes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get printersFieldNotes;

  /// No description provided for @printersFieldDriverName.
  ///
  /// In en, this message translates to:
  /// **'Driver name'**
  String get printersFieldDriverName;

  /// No description provided for @printersFieldQueueName.
  ///
  /// In en, this message translates to:
  /// **'Queue name'**
  String get printersFieldQueueName;

  /// No description provided for @printersFieldSpoolFormat.
  ///
  /// In en, this message translates to:
  /// **'Spool format'**
  String get printersFieldSpoolFormat;

  /// No description provided for @printersFieldUseRawSpool.
  ///
  /// In en, this message translates to:
  /// **'Use raw spool'**
  String get printersFieldUseRawSpool;

  /// No description provided for @printersFieldVendorId.
  ///
  /// In en, this message translates to:
  /// **'Vendor ID'**
  String get printersFieldVendorId;

  /// No description provided for @printersFieldProductId.
  ///
  /// In en, this message translates to:
  /// **'Product ID'**
  String get printersFieldProductId;

  /// No description provided for @printersFieldSerialNumber.
  ///
  /// In en, this message translates to:
  /// **'Serial number'**
  String get printersFieldSerialNumber;

  /// No description provided for @printersFieldInterfaceNumber.
  ///
  /// In en, this message translates to:
  /// **'Interface number'**
  String get printersFieldInterfaceNumber;

  /// No description provided for @printersFieldOutEndpoint.
  ///
  /// In en, this message translates to:
  /// **'Out endpoint'**
  String get printersFieldOutEndpoint;

  /// No description provided for @printersFieldInEndpoint.
  ///
  /// In en, this message translates to:
  /// **'In endpoint'**
  String get printersFieldInEndpoint;

  /// No description provided for @printersFieldTimeout.
  ///
  /// In en, this message translates to:
  /// **'Timeout (ms)'**
  String get printersFieldTimeout;

  /// No description provided for @printersFieldCharacterTable.
  ///
  /// In en, this message translates to:
  /// **'Character table'**
  String get printersFieldCharacterTable;

  /// No description provided for @printersFieldStatusMonitoring.
  ///
  /// In en, this message translates to:
  /// **'Status monitoring enabled'**
  String get printersFieldStatusMonitoring;

  /// No description provided for @printersFieldAutoCutEnabled.
  ///
  /// In en, this message translates to:
  /// **'Auto cut enabled'**
  String get printersFieldAutoCutEnabled;

  /// No description provided for @printersFieldCutMode.
  ///
  /// In en, this message translates to:
  /// **'Cut mode'**
  String get printersFieldCutMode;

  /// No description provided for @printersFieldCashDrawerEnabled.
  ///
  /// In en, this message translates to:
  /// **'Cash drawer enabled'**
  String get printersFieldCashDrawerEnabled;

  /// No description provided for @printersFieldDrawerPin.
  ///
  /// In en, this message translates to:
  /// **'Drawer pin'**
  String get printersFieldDrawerPin;

  /// No description provided for @printersFieldManufacturer.
  ///
  /// In en, this message translates to:
  /// **'Manufacturer'**
  String get printersFieldManufacturer;

  /// No description provided for @printersFieldProductName.
  ///
  /// In en, this message translates to:
  /// **'Product name'**
  String get printersFieldProductName;

  /// No description provided for @printersFieldAlternateSetting.
  ///
  /// In en, this message translates to:
  /// **'Alternate setting'**
  String get printersFieldAlternateSetting;

  /// No description provided for @printersFieldPacketDelay.
  ///
  /// In en, this message translates to:
  /// **'Packet delay (ms)'**
  String get printersFieldPacketDelay;

  /// No description provided for @printersFieldRawGraphicsMode.
  ///
  /// In en, this message translates to:
  /// **'Raw graphics mode'**
  String get printersFieldRawGraphicsMode;

  /// No description provided for @printersRawGraphicsModeModern.
  ///
  /// In en, this message translates to:
  /// **'Modern graphics'**
  String get printersRawGraphicsModeModern;

  /// No description provided for @printersRawGraphicsModeLegacy.
  ///
  /// In en, this message translates to:
  /// **'Legacy raster'**
  String get printersRawGraphicsModeLegacy;

  /// No description provided for @printersValidationRequired.
  ///
  /// In en, this message translates to:
  /// **'This field is required.'**
  String get printersValidationRequired;

  /// No description provided for @printersValidationTooLong.
  ///
  /// In en, this message translates to:
  /// **'This value is too long.'**
  String get printersValidationTooLong;

  /// No description provided for @printersValidationInvalidHost.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid IPv4, IPv6, or hostname.'**
  String get printersValidationInvalidHost;

  /// No description provided for @printersValidationIntegerOnly.
  ///
  /// In en, this message translates to:
  /// **'Enter numbers only.'**
  String get printersValidationIntegerOnly;

  /// No description provided for @printersValidationTooSmall.
  ///
  /// In en, this message translates to:
  /// **'The value is below the allowed minimum.'**
  String get printersValidationTooSmall;

  /// No description provided for @printersValidationTooLarge.
  ///
  /// In en, this message translates to:
  /// **'The value is above the allowed maximum.'**
  String get printersValidationTooLarge;

  /// No description provided for @printersValidationUsbId.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid 4-digit hexadecimal USB ID.'**
  String get printersValidationUsbId;

  /// No description provided for @printersValidationUsbEndpoint.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid USB endpoint value.'**
  String get printersValidationUsbEndpoint;

  /// No description provided for @printersValidationDistinctEndpoints.
  ///
  /// In en, this message translates to:
  /// **'In endpoint must not match out endpoint.'**
  String get printersValidationDistinctEndpoints;

  /// No description provided for @printersValidationDrawerPin.
  ///
  /// In en, this message translates to:
  /// **'Drawer pin must be 2 or 5.'**
  String get printersValidationDrawerPin;

  /// No description provided for @printersValidationUniqueKey.
  ///
  /// In en, this message translates to:
  /// **'The generated identifier already exists. Try again.'**
  String get printersValidationUniqueKey;

  /// No description provided for @printersValidationSpoolFormat.
  ///
  /// In en, this message translates to:
  /// **'Raw spool should use RAW spool format or leave it empty.'**
  String get printersValidationSpoolFormat;

  /// No description provided for @appsCreateAction.
  ///
  /// In en, this message translates to:
  /// **'Create app'**
  String get appsCreateAction;

  /// No description provided for @appsEditAction.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get appsEditAction;

  /// No description provided for @appsShowAction.
  ///
  /// In en, this message translates to:
  /// **'Show'**
  String get appsShowAction;

  /// No description provided for @appsDeleteAction.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get appsDeleteAction;

  /// No description provided for @appsSaveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save changes'**
  String get appsSaveChanges;

  /// No description provided for @appsBackToIndex.
  ///
  /// In en, this message translates to:
  /// **'Back to apps'**
  String get appsBackToIndex;

  /// No description provided for @appsOverviewTitle.
  ///
  /// In en, this message translates to:
  /// **'App overview'**
  String get appsOverviewTitle;

  /// No description provided for @appsAccessTitle.
  ///
  /// In en, this message translates to:
  /// **'Printer access'**
  String get appsAccessTitle;

  /// No description provided for @appsEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No apps yet'**
  String get appsEmptyTitle;

  /// No description provided for @appsEmptyDescription.
  ///
  /// In en, this message translates to:
  /// **'Create an app to start issuing API keys and restricting printer access.'**
  String get appsEmptyDescription;

  /// No description provided for @appsDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete app'**
  String get appsDeleteTitle;

  /// No description provided for @appsDeleteDescription.
  ///
  /// In en, this message translates to:
  /// **'Delete {name} permanently?'**
  String appsDeleteDescription(String name);

  /// No description provided for @appsBulkDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete selected apps'**
  String get appsBulkDeleteTitle;

  /// No description provided for @appsBulkDeleteAction.
  ///
  /// In en, this message translates to:
  /// **'Delete selected'**
  String get appsBulkDeleteAction;

  /// No description provided for @appsBulkDeleteDescription.
  ///
  /// In en, this message translates to:
  /// **'Delete {count} selected apps?'**
  String appsBulkDeleteDescription(int count);

  /// No description provided for @appsSelectedCount.
  ///
  /// In en, this message translates to:
  /// **'{count} selected'**
  String appsSelectedCount(int count);

  /// No description provided for @appsCreatedSuccess.
  ///
  /// In en, this message translates to:
  /// **'App created successfully.'**
  String get appsCreatedSuccess;

  /// No description provided for @appsUpdatedSuccess.
  ///
  /// In en, this message translates to:
  /// **'App updated successfully.'**
  String get appsUpdatedSuccess;

  /// No description provided for @appsDeletedSuccess.
  ///
  /// In en, this message translates to:
  /// **'App deleted successfully.'**
  String get appsDeletedSuccess;

  /// No description provided for @appsBulkDeletedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Selected apps deleted successfully.'**
  String get appsBulkDeletedSuccess;

  /// No description provided for @appsSearchPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Search apps'**
  String get appsSearchPlaceholder;

  /// No description provided for @appsFilterStatus.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get appsFilterStatus;

  /// No description provided for @appsFilterPrinterScope.
  ///
  /// In en, this message translates to:
  /// **'Printer scope'**
  String get appsFilterPrinterScope;

  /// No description provided for @appsFilterAllStatuses.
  ///
  /// In en, this message translates to:
  /// **'All statuses'**
  String get appsFilterAllStatuses;

  /// No description provided for @appsFilterAllScopes.
  ///
  /// In en, this message translates to:
  /// **'All scopes'**
  String get appsFilterAllScopes;

  /// No description provided for @appsStatusEnabled.
  ///
  /// In en, this message translates to:
  /// **'Enabled'**
  String get appsStatusEnabled;

  /// No description provided for @appsStatusDisabled.
  ///
  /// In en, this message translates to:
  /// **'Disabled'**
  String get appsStatusDisabled;

  /// No description provided for @appsFieldName.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get appsFieldName;

  /// No description provided for @appsFieldEnabled.
  ///
  /// In en, this message translates to:
  /// **'Enabled'**
  String get appsFieldEnabled;

  /// No description provided for @appsFieldDescription.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get appsFieldDescription;

  /// No description provided for @appsFieldApiKey.
  ///
  /// In en, this message translates to:
  /// **'API key'**
  String get appsFieldApiKey;

  /// No description provided for @appsFieldUpdatedAt.
  ///
  /// In en, this message translates to:
  /// **'Updated at'**
  String get appsFieldUpdatedAt;

  /// No description provided for @appsDescriptionHint.
  ///
  /// In en, this message translates to:
  /// **'Optional internal description'**
  String get appsDescriptionHint;

  /// No description provided for @appsApiKeyHelper.
  ///
  /// In en, this message translates to:
  /// **'This API key is generated automatically for this app.'**
  String get appsApiKeyHelper;

  /// No description provided for @appsCopyApiKeyAction.
  ///
  /// In en, this message translates to:
  /// **'Copy API key'**
  String get appsCopyApiKeyAction;

  /// No description provided for @appsApiKeyCopied.
  ///
  /// In en, this message translates to:
  /// **'API key copied.'**
  String get appsApiKeyCopied;

  /// No description provided for @appsAllPrintersNote.
  ///
  /// In en, this message translates to:
  /// **'No printers selected means all printers are allowed.'**
  String get appsAllPrintersNote;

  /// No description provided for @appsNoPrintersAvailable.
  ///
  /// In en, this message translates to:
  /// **'No printers are available yet.'**
  String get appsNoPrintersAvailable;

  /// No description provided for @appsAllPrintersAccess.
  ///
  /// In en, this message translates to:
  /// **'All printers'**
  String get appsAllPrintersAccess;

  /// No description provided for @appsRestrictedPrintersLabel.
  ///
  /// In en, this message translates to:
  /// **'Restricted printers'**
  String get appsRestrictedPrintersLabel;

  /// No description provided for @appsAllowedPrintersLabel.
  ///
  /// In en, this message translates to:
  /// **'Allowed printers'**
  String get appsAllowedPrintersLabel;

  /// No description provided for @appsRestrictedPrintersCount.
  ///
  /// In en, this message translates to:
  /// **'{count} printers'**
  String appsRestrictedPrintersCount(int count);

  /// No description provided for @appsColumnName.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get appsColumnName;

  /// No description provided for @appsColumnApiKey.
  ///
  /// In en, this message translates to:
  /// **'API key'**
  String get appsColumnApiKey;

  /// No description provided for @appsColumnPrinters.
  ///
  /// In en, this message translates to:
  /// **'Printers'**
  String get appsColumnPrinters;

  /// No description provided for @appsColumnEnabled.
  ///
  /// In en, this message translates to:
  /// **'Enabled'**
  String get appsColumnEnabled;

  /// No description provided for @appsColumnUpdatedAt.
  ///
  /// In en, this message translates to:
  /// **'Updated at'**
  String get appsColumnUpdatedAt;

  /// No description provided for @appsColumnActions.
  ///
  /// In en, this message translates to:
  /// **'Actions'**
  String get appsColumnActions;

  /// No description provided for @appsValidationRequired.
  ///
  /// In en, this message translates to:
  /// **'This field is required.'**
  String get appsValidationRequired;

  /// No description provided for @appsValidationMaxLength.
  ///
  /// In en, this message translates to:
  /// **'This value is too long.'**
  String get appsValidationMaxLength;

  /// No description provided for @appsValidationDuplicateApiKey.
  ///
  /// In en, this message translates to:
  /// **'The generated API key already exists. Try again.'**
  String get appsValidationDuplicateApiKey;

  /// No description provided for @appsRegenerateApiKeyAction.
  ///
  /// In en, this message translates to:
  /// **'Regenerate API key'**
  String get appsRegenerateApiKeyAction;

  /// No description provided for @appsRegenerateApiKeyTitle.
  ///
  /// In en, this message translates to:
  /// **'Regenerate API key'**
  String get appsRegenerateApiKeyTitle;

  /// No description provided for @appsRegenerateApiKeyDescription.
  ///
  /// In en, this message translates to:
  /// **'Generate a new API key for {name}? Existing integrations will need the new key.'**
  String appsRegenerateApiKeyDescription(String name);

  /// No description provided for @appsRegeneratedApiKeySuccess.
  ///
  /// In en, this message translates to:
  /// **'API key regenerated successfully.'**
  String get appsRegeneratedApiKeySuccess;

  /// No description provided for @logsLoading.
  ///
  /// In en, this message translates to:
  /// **'Loading logs'**
  String get logsLoading;

  /// No description provided for @logsEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No logs yet'**
  String get logsEmptyTitle;

  /// No description provided for @logsEmptyDescription.
  ///
  /// In en, this message translates to:
  /// **'The logger will store app, server, and print events here.'**
  String get logsEmptyDescription;

  /// No description provided for @logsSearchPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Search logs'**
  String get logsSearchPlaceholder;

  /// No description provided for @logsFilterLevel.
  ///
  /// In en, this message translates to:
  /// **'Level'**
  String get logsFilterLevel;

  /// No description provided for @logsFilterEventType.
  ///
  /// In en, this message translates to:
  /// **'Event type'**
  String get logsFilterEventType;

  /// No description provided for @logsFilterAllLevels.
  ///
  /// In en, this message translates to:
  /// **'All levels'**
  String get logsFilterAllLevels;

  /// No description provided for @logsFilterAllEventTypes.
  ///
  /// In en, this message translates to:
  /// **'All events'**
  String get logsFilterAllEventTypes;

  /// No description provided for @logsResetFilters.
  ///
  /// In en, this message translates to:
  /// **'Reset filters'**
  String get logsResetFilters;

  /// No description provided for @logsColumnTime.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get logsColumnTime;

  /// No description provided for @logsColumnTitle.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get logsColumnTitle;

  /// No description provided for @logsColumnMessage.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get logsColumnMessage;

  /// No description provided for @logsColumnEvent.
  ///
  /// In en, this message translates to:
  /// **'Event'**
  String get logsColumnEvent;

  /// No description provided for @logsColumnLevel.
  ///
  /// In en, this message translates to:
  /// **'Level'**
  String get logsColumnLevel;

  /// No description provided for @logsShowAction.
  ///
  /// In en, this message translates to:
  /// **'Show details'**
  String get logsShowAction;

  /// No description provided for @logsBackToLogs.
  ///
  /// In en, this message translates to:
  /// **'Back to logs'**
  String get logsBackToLogs;

  /// No description provided for @logsMetadataTitle.
  ///
  /// In en, this message translates to:
  /// **'Metadata'**
  String get logsMetadataTitle;

  /// No description provided for @tableRowsPerPage.
  ///
  /// In en, this message translates to:
  /// **'{count} / page'**
  String tableRowsPerPage(int count);

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading'**
  String get loading;

  /// No description provided for @splashLoading.
  ///
  /// In en, this message translates to:
  /// **'Preparing Qintrix'**
  String get splashLoading;

  /// No description provided for @splashErrorTitle.
  ///
  /// In en, this message translates to:
  /// **'Startup failed'**
  String get splashErrorTitle;

  /// No description provided for @splashErrorDescription.
  ///
  /// In en, this message translates to:
  /// **'The app could not finish startup tasks.'**
  String get splashErrorDescription;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @errorDescription.
  ///
  /// In en, this message translates to:
  /// **'Reusable error state ready for future modules.'**
  String get errorDescription;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
