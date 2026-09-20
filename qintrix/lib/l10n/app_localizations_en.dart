// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Qintrix';

  @override
  String get navDashboard => 'Dashboard';

  @override
  String get navServer => 'Server';

  @override
  String get navPrinters => 'Printers';

  @override
  String get navJobs => 'Jobs';

  @override
  String get navApps => 'Apps';

  @override
  String get navLogs => 'Logs';

  @override
  String get navSettings => 'Settings';

  @override
  String get navAbout => 'About App';

  @override
  String get dashboardDescription =>
      'View a lightweight operational overview and jump into the main management areas.';

  @override
  String get dashboardServerLoading => 'Loading server status...';

  @override
  String get serverTitle => 'Server';

  @override
  String get serverDescription =>
      'Manage the embedded API server runtime, controls, and recent server activity.';

  @override
  String get dashboardServerRunning => 'Running';

  @override
  String get dashboardServerStopped => 'Stopped';

  @override
  String get dashboardMetricHost => 'Host';

  @override
  String get dashboardMetricPort => 'Port';

  @override
  String get dashboardMetricLastChanged => 'Last changed';

  @override
  String get dashboardMetricStartedAt => 'Started at';

  @override
  String get serverMetricRuntime => 'Runtime';

  @override
  String get dashboardUnavailable => 'Unavailable';

  @override
  String get dashboardServerStart => 'Start';

  @override
  String get dashboardServerStop => 'Stop';

  @override
  String get dashboardServerRestart => 'Refresh';

  @override
  String get dashboardRuntimeTitle => 'Runtime configuration';

  @override
  String get dashboardRuntimeSubtitle =>
      'Current server settings used by startup and manual server controls.';

  @override
  String get dashboardConfigLanAccess => 'LAN access';

  @override
  String get dashboardConfigAutoStart => 'Auto start server';

  @override
  String get dashboardConfigBackgroundMode => 'Background mode';

  @override
  String get dashboardConfigStartWithOs => 'Start with OS';

  @override
  String get dashboardEnabled => 'Enabled';

  @override
  String get dashboardDisabled => 'Disabled';

  @override
  String get dashboardRecentActivityTitle => 'Recent activity';

  @override
  String get dashboardRecentActivitySubtitle =>
      'Latest server lifecycle, authorization, and printer test events.';

  @override
  String get dashboardRecentActivityEmpty =>
      'No server activity has been logged yet.';

  @override
  String get shellCollapseSidebar => 'Collapse sidebar';

  @override
  String get shellExpandSidebar => 'Expand sidebar';

  @override
  String shellCopyrightText(int year) {
    return 'Qintrix © $year · Crafted by';
  }

  @override
  String get languageEnglish => 'English';

  @override
  String get languageArabic => 'Arabic';

  @override
  String get themeModeSystem => 'System';

  @override
  String get themeModeLight => 'Light';

  @override
  String get themeModeDark => 'Dark';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsDescription =>
      'Control how Qintrix looks and which language it uses when the app reopens.';

  @override
  String get settingsAppearanceTitle => 'Appearance';

  @override
  String get settingsAppearanceDescription =>
      'Choose how the interface handles light and dark themes.';

  @override
  String get settingsLanguageTitle => 'Language';

  @override
  String get settingsLanguageDescription =>
      'Switch the application language instantly and keep the preference saved.';

  @override
  String get settingsApplicationTitle => 'Application';

  @override
  String get settingsApplicationDescription =>
      'Manage app-level behavior and startup preferences.';

  @override
  String get settingsApplicationDiagnosticsTitle => 'Application diagnostics';

  @override
  String get settingsApplicationDiagnosticsDescription =>
      'Verify whether autostart, background mode, and the tray/menu bar integration are active right now.';

  @override
  String get settingsApplicationStartWithOsStatus => 'Start with OS';

  @override
  String get settingsApplicationBackgroundModeStatus => 'Background mode';

  @override
  String get settingsApplicationTrayStatus => 'Tray / menu bar';

  @override
  String get settingsServerTitle => 'Server';

  @override
  String get settingsServerDescription =>
      'Manage local server and agent runtime settings.';

  @override
  String get settingsJobsTitle => 'Jobs';

  @override
  String get settingsJobsDescription =>
      'Manage queue startup behavior, retry policy, and job retention defaults.';

  @override
  String get settingsAppPort => 'App port';

  @override
  String get settingsBindHost => 'Bind IP';

  @override
  String get settingsEnableBackgroundMode => 'Enable background mode';

  @override
  String get settingsStartWithOs => 'Start with OS';

  @override
  String get settingsAllowLanAccess => 'Allow LAN access';

  @override
  String get settingsAutoStartServer => 'Auto start server';

  @override
  String get settingsSaveApplication => 'Save application settings';

  @override
  String get settingsSaveServer => 'Save server settings';

  @override
  String get settingsSaveJobs => 'Save jobs settings';

  @override
  String get settingsJobsStartPaused => 'Start queue in paused mode';

  @override
  String get settingsJobsMaxRetries => 'Max retry attempts';

  @override
  String get settingsJobsRetryDelaySeconds => 'Retry delay (seconds)';

  @override
  String get settingsJobsHistoryRetentionDays => 'History retention (days)';

  @override
  String get settingsInvalidPort =>
      'Port must be a number between 1 and 65535.';

  @override
  String get settingsInvalidHost =>
      'Enter a local IPv4 address only, such as 127.0.0.1 or 192.168.1.20.';

  @override
  String get settingsLanIpDetecting => 'Detecting available LAN IP...';

  @override
  String get settingsLanIpAutofilled =>
      'A LAN IP was detected and filled automatically.';

  @override
  String get settingsLanIpUnavailable =>
      'No LAN IP is currently available. Keeping the current IP.';

  @override
  String get settingsSaveSuccess => 'Server settings saved successfully.';

  @override
  String get settingsSaveAndRestartSuccess =>
      'Server settings saved and the server restarted.';

  @override
  String get settingsRestartFailed =>
      'Settings were saved, but the server could not restart.';

  @override
  String get settingsSaveValidationFailed =>
      'Please fix the highlighted fields before saving.';

  @override
  String get settingsBindValidationFailed =>
      'The selected host or port cannot be used to run the server.';

  @override
  String get aboutTitle => 'About App';

  @override
  String get aboutHeading =>
      'A desktop print bridge for modern operational teams';

  @override
  String get aboutDescription =>
      'Qintrix connects websites, systems, and internal tools to local printers through one controlled desktop workspace. It is built to keep printing reliable, visible, and easy to manage for operators.';

  @override
  String get aboutHeroEyebrow => 'Application Overview';

  @override
  String get aboutHeroPillLocalBridge => 'Local print bridge';

  @override
  String get aboutHeroPillSecureApps => 'Secure app access';

  @override
  String get aboutHeroPillOperationalControl => 'Operational control';

  @override
  String get aboutHeroMetricJobs => 'Jobs handled';

  @override
  String get aboutHeroMetricPrinters => 'Enabled printers';

  @override
  String get aboutHeroMetricApps => 'Enabled apps';

  @override
  String get aboutHeroMetricSuccessRate => 'Success rate';

  @override
  String get aboutAnalyticsTitle => 'Live application snapshot';

  @override
  String get aboutAnalyticsSubtitle =>
      'A quick read of workload, availability, and active alerts.';

  @override
  String get aboutMetricTotalJobs => 'Total jobs';

  @override
  String get aboutMetricCompletionRate => 'Completion rate';

  @override
  String get aboutMetricEnabledPrinters => 'Enabled printers';

  @override
  String get aboutMetricEnabledApps => 'Enabled apps';

  @override
  String get aboutMetricQueuedJobs => 'Queued jobs';

  @override
  String get aboutMetricRecentAlerts => 'Recent alerts';

  @override
  String get aboutTrendTitle => 'Jobs over the last 7 days';

  @override
  String get aboutTrendSubtitle =>
      'Daily incoming print activity across the workspace.';

  @override
  String get dashboardTrendTotalLabel => 'Total volume';

  @override
  String get dashboardTrendPeakDayLabel => 'Peak day';

  @override
  String get dashboardAllTimeLabel => 'All time';

  @override
  String get aboutStatusMixTitle => 'Job status mix';

  @override
  String get aboutStatusMixSubtitle =>
      'How the current workload is distributed.';

  @override
  String get aboutConnectionsTitle => 'Connection footprint';

  @override
  String get aboutConnectionsSubtitle =>
      'Configured printer connection types in the current setup.';

  @override
  String get aboutContentTypesTitle => 'Content type mix';

  @override
  String get aboutContentTypesSubtitle =>
      'What the system is receiving most often from connected clients.';

  @override
  String get aboutPurposeTitle => 'What Qintrix does';

  @override
  String get aboutPurposeSubtitle =>
      'One place to receive, process, and monitor printing work.';

  @override
  String get aboutPurposeBody =>
      'Qintrix acts as the link between API-driven requests and the printers available on the local machine or network. Instead of wiring each printer directly into an external system, teams can manage printers, apps, queue behavior, server runtime, and diagnostics from one interface.';

  @override
  String get aboutAudienceTitle => 'Who it is for';

  @override
  String get aboutAudienceBody =>
      'It fits operations that need stable receipt, label, ticket, or workstation printing while keeping access rules, retries, and troubleshooting visible to both operators and support teams.';

  @override
  String get aboutWorkflowTitle => 'How the workflow works';

  @override
  String get aboutWorkflowSubtitle =>
      'A simple path from incoming request to completed print output.';

  @override
  String get aboutWorkflowStepConnectTitle => 'Connect printers and apps';

  @override
  String get aboutWorkflowStepConnectDescription =>
      'Register printers, choose the right connection type, and control which client apps are allowed to send jobs.';

  @override
  String get aboutWorkflowStepProcessTitle => 'Accept, queue, and execute jobs';

  @override
  String get aboutWorkflowStepProcessDescription =>
      'Incoming jobs are validated, prepared, queued, and executed through the configured printer connection with the right options and retries.';

  @override
  String get aboutWorkflowStepObserveTitle =>
      'Monitor status and fix issues quickly';

  @override
  String get aboutWorkflowStepObserveDescription =>
      'Track server health, job progress, queue state, and logs in real time so operators can respond before small issues become downtime.';

  @override
  String get aboutModulesTitle => 'Main areas of the workspace';

  @override
  String get aboutModulesSubtitle =>
      'Each module focuses on one part of the printing operation so the interface stays easy to scan.';

  @override
  String get aboutHighlightsTitle => 'Why teams use it';

  @override
  String get aboutHighlightsSubtitle =>
      'Designed to reduce print friction without hiding technical detail.';

  @override
  String get aboutHighlightSecureTitle => 'Controlled access';

  @override
  String get aboutHighlightSecureDescription =>
      'Client apps authenticate with API keys, can be enabled or disabled individually, and can be scoped to selected printers.';

  @override
  String get aboutHighlightReliableTitle => 'Reliable job handling';

  @override
  String get aboutHighlightReliableDescription =>
      'Jobs move through clear states with queue controls, retries, artifacts, and history that make print failures easier to diagnose.';

  @override
  String get aboutHighlightFlexibleTitle => 'Flexible connection support';

  @override
  String get aboutHighlightFlexibleDescription =>
      'Qintrix supports system spooler, network TCP, and raw ESC/POS-oriented workflows while keeping one consistent operational interface.';

  @override
  String get aboutVersionLabel => 'Version';

  @override
  String get aboutVersionDescription => 'Current application build';

  @override
  String get aboutVersionNote =>
      'This build packages the server, printers, jobs, apps, logs, and settings experience into a single desktop control surface for production print operations.';

  @override
  String get aboutAttributionTitle => 'Design & development by Tenvoro';

  @override
  String get aboutAttributionSubtitle =>
      'This application experience, interface, and implementation were crafted by Tenvoro.';

  @override
  String get aboutAttributionAction => 'View publisher';

  @override
  String get logsTitle => 'Logs';

  @override
  String get logsDescription =>
      'Persistent application events, server activity, and job lifecycle updates.';

  @override
  String get printersTitle => 'Printers';

  @override
  String get printersDescription =>
      'Manage printer definitions, connection types, and device-specific settings.';

  @override
  String get jobsTitle => 'Jobs';

  @override
  String get jobsDescription =>
      'Track print jobs, retries, queue activity, and execution state.';

  @override
  String get appsTitle => 'Apps';

  @override
  String get appsDescription =>
      'Manage client apps, API keys, and printer access rules.';

  @override
  String get jobsSearchPlaceholder => 'Search jobs';

  @override
  String get jobsResetFilters => 'Reset filters';

  @override
  String get jobsFilterStatus => 'Status';

  @override
  String get jobsAllStatuses => 'All statuses';

  @override
  String get jobsFilterContentType => 'Content type';

  @override
  String get jobsAllContentTypes => 'All content types';

  @override
  String get jobsStatusAccepted => 'Accepted';

  @override
  String get jobsStatusRendering => 'Rendering';

  @override
  String get jobsStatusQueued => 'Queued';

  @override
  String get jobsStatusProcessing => 'Processing';

  @override
  String get jobsStatusCompleted => 'Completed';

  @override
  String get jobsStatusFailed => 'Failed';

  @override
  String get jobsStatusCanceled => 'Canceled';

  @override
  String get jobsStatusRetryScheduled => 'Retry scheduled';

  @override
  String get jobsEmptyTitle => 'No jobs yet';

  @override
  String get jobsEmptyDescription =>
      'Accepted print jobs will appear here after they are created through the API.';

  @override
  String get jobsRetrySuccess => 'Job queued for retry.';

  @override
  String get jobsCancelSuccess => 'Job canceled successfully.';

  @override
  String get jobsColumnId => 'Job ID';

  @override
  String get jobsColumnPrinter => 'Printer';

  @override
  String get jobsColumnContentType => 'Content type';

  @override
  String get jobsColumnStatus => 'Status';

  @override
  String get jobsColumnReference => 'Reference';

  @override
  String get jobsColumnCreatedAt => 'Created at';

  @override
  String get jobsBackToJobs => 'Back to jobs';

  @override
  String get jobsArtifactLabel => 'Artifact';

  @override
  String get jobsFailureLabel => 'Failure';

  @override
  String get jobsQueuePausedTitle => 'Queue paused';

  @override
  String get jobsQueuePausedDescription =>
      'New jobs can still be accepted, but no queued work will start until the queue is resumed.';

  @override
  String get jobsQueuePausedBadge => 'Paused';

  @override
  String get jobsQueueResumeAction => 'Resume';

  @override
  String get jobsQueueRunningTitle => 'Queue running';

  @override
  String jobsQueueRunningDescription(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count workers are currently processing jobs.',
      one: '1 worker is currently processing jobs.',
      zero:
          'No active workers right now. Queued jobs will start automatically when available.',
    );
    return '$_temp0';
  }

  @override
  String get jobsQueueRunningBadge => 'Running';

  @override
  String get printersCreateAction => 'Create printer';

  @override
  String get printersEditAction => 'Edit';

  @override
  String get printersShowAction => 'Show';

  @override
  String get printersDeleteAction => 'Delete';

  @override
  String get printersDeletedSuccess => 'Printer deleted successfully.';

  @override
  String get printersBulkDeletedSuccess =>
      'Selected printers deleted successfully.';

  @override
  String get printersSaveChanges => 'Save changes';

  @override
  String get printersBulkDeleteAction => 'Delete selected';

  @override
  String get printersBackToIndex => 'Back to printers';

  @override
  String get printersDeleteTitle => 'Delete printer';

  @override
  String printersDeleteDescription(String name) {
    return 'Delete $name permanently?';
  }

  @override
  String get printersBulkDeleteTitle => 'Delete selected printers';

  @override
  String printersBulkDeleteDescription(int count) {
    return 'Delete $count selected printers permanently?';
  }

  @override
  String printersSelectedCount(int count) {
    return '$count selected';
  }

  @override
  String get printersEmptyTitle => 'No printers yet';

  @override
  String get printersEmptyDescription =>
      'Create a printer definition to start routing future print jobs.';

  @override
  String get printersColumnName => 'Name';

  @override
  String get printersColumnIdentifier => 'Identifier';

  @override
  String get printersColumnConnectionType => 'Connection type';

  @override
  String get printersColumnConnectionSummary => 'Connection summary';

  @override
  String get printersColumnEnabled => 'Enabled';

  @override
  String get printersColumnLastStatus => 'Last status';

  @override
  String get printersColumnLastStatusMessage => 'Status message';

  @override
  String get printersColumnUpdatedAt => 'Updated';

  @override
  String get printersColumnActions => 'Actions';

  @override
  String get printersSearchPlaceholder => 'Search printers';

  @override
  String get printersFilterConnectionType => 'Connection type';

  @override
  String get printersFilterAllTypes => 'All types';

  @override
  String get printersFilterStatus => 'Status';

  @override
  String get printersFilterAllStatuses => 'All statuses';

  @override
  String get printersStatusEnabled => 'Enabled';

  @override
  String get printersStatusDisabled => 'Disabled';

  @override
  String get printersLastStatusTestSuccess => 'Test succeeded';

  @override
  String get printersLastStatusTestFailure => 'Test failed';

  @override
  String get printersLastStatusTestNotSupported => 'Test not supported';

  @override
  String get printersLastStatusPrintSuccess => 'Print succeeded';

  @override
  String get printersLastStatusPrintFailure => 'Print failed';

  @override
  String get printersLastStatusRenderFailure => 'Render failed';

  @override
  String get printersTypeTcp => 'Network Terminal Printer (TCP/IP)';

  @override
  String get printersTypeSystem => 'USB / System Printer (Spooler)';

  @override
  String get printersTypeUsbRaw => 'USB Raw ESC/POS Printer';

  @override
  String get printersTypeTcpShort => 'TCP/IP';

  @override
  String get printersTypeSystemShort => 'System';

  @override
  String get printersTypeUsbRawShort => 'USB Raw';

  @override
  String get printersFormOverviewTitle => 'Printer overview';

  @override
  String get printersBasicSectionTitle => 'Basic settings';

  @override
  String get printersAdvancedSectionTitle => 'Advanced settings';

  @override
  String get printersConnectionDetailsTitle => 'Connection details';

  @override
  String get printersUniqueKeyHelper =>
      'This identifier is generated automatically and used later by the API.';

  @override
  String get printersDescriptionHint => 'Optional internal description';

  @override
  String get printersBooleanYes => 'Yes';

  @override
  String get printersBooleanNo => 'No';

  @override
  String get printersFieldName => 'Printer name';

  @override
  String get printersFieldIdentifier => 'Identifier';

  @override
  String get printersCopyIdentifierAction => 'Copy identifier';

  @override
  String get printersIdentifierCopied => 'Identifier copied.';

  @override
  String get printersCreatedSuccess => 'Printer created successfully.';

  @override
  String get printersUpdatedSuccess => 'Printer updated successfully.';

  @override
  String get printersTestConnectionAction => 'Test connection';

  @override
  String printersTestConnectionSuccess(String message) {
    return 'Connection test succeeded. $message';
  }

  @override
  String printersTestConnectionFailure(String message) {
    return 'Connection test failed. $message';
  }

  @override
  String printersTestConnectionNotSupported(String message) {
    return 'Connection test is not supported yet. $message';
  }

  @override
  String get printersTestTcpMissingConfig =>
      'Host and port are required before testing the TCP connection.';

  @override
  String printersTestTcpSuccess(String host, String port) {
    return 'TCP connection to $host:$port succeeded.';
  }

  @override
  String printersTestTcpTimeout(String host, String port) {
    return 'TCP connection to $host:$port timed out.';
  }

  @override
  String printersTestTcpFailure(String host, String port, String error) {
    return 'TCP connection to $host:$port failed. $error';
  }

  @override
  String get printersTestSystemMissingConfig =>
      'Printer name or queue name is required before testing the system spooler connection.';

  @override
  String printersTestSystemSuccess(String name) {
    return 'System printer \"$name\" is available.';
  }

  @override
  String printersTestSystemFailure(String name) {
    return 'System printer \"$name\" was not found.';
  }

  @override
  String get printersTestUsbMissingConfig =>
      'Vendor ID and product ID are required before testing the USB raw connection.';

  @override
  String printersTestUsbSuccess(String vendorId, String productId) {
    return 'USB raw device $vendorId:$productId is available.';
  }

  @override
  String printersTestUsbFailure(String vendorId, String productId) {
    return 'USB raw device $vendorId:$productId was not found.';
  }

  @override
  String printersTestCommandUnavailable(String command) {
    return 'The local command \"$command\" is not available on this system.';
  }

  @override
  String get printersTestUnsupportedPlatform =>
      'This connection test is not supported on the current platform.';

  @override
  String get printersFieldDescription => 'Description';

  @override
  String get printersFieldConnectionType => 'Connection type';

  @override
  String get printersFieldEnabled => 'Enabled';

  @override
  String get printersFieldHost => 'Host';

  @override
  String get printersFieldPort => 'Port';

  @override
  String get printersFieldConnectTimeout => 'Connect timeout (ms)';

  @override
  String get printersFieldWriteTimeout => 'Write timeout (ms)';

  @override
  String get printersFieldReadTimeout => 'Read timeout (ms)';

  @override
  String get printersFieldAutoReconnect => 'Auto reconnect';

  @override
  String get printersFieldReconnectDelay => 'Reconnect delay (ms)';

  @override
  String get printersFieldEncoding => 'Encoding';

  @override
  String get printersFieldCodePage => 'Code page';

  @override
  String get printersFieldLineEnding => 'Line ending';

  @override
  String get printersFieldKeepAlive => 'Keep alive';

  @override
  String get printersFieldNoDelay => 'No delay';

  @override
  String get printersFieldLinger => 'Linger (s)';

  @override
  String get printersFieldPrinterName => 'Printer name';

  @override
  String get printersFieldPaperSize => 'Paper size';

  @override
  String get printersFieldDefaultCopies => 'Default copies';

  @override
  String get printersFieldColorEnabled => 'Color enabled';

  @override
  String get printersFieldDuplexMode => 'Duplex mode';

  @override
  String get printersFieldOrientation => 'Orientation';

  @override
  String get printersFieldJobTimeout => 'Job timeout (ms)';

  @override
  String get printersFieldNotes => 'Notes';

  @override
  String get printersFieldDriverName => 'Driver name';

  @override
  String get printersFieldQueueName => 'Queue name';

  @override
  String get printersFieldSpoolFormat => 'Spool format';

  @override
  String get printersFieldUseRawSpool => 'Use raw spool';

  @override
  String get printersFieldVendorId => 'Vendor ID';

  @override
  String get printersFieldProductId => 'Product ID';

  @override
  String get printersFieldSerialNumber => 'Serial number';

  @override
  String get printersFieldInterfaceNumber => 'Interface number';

  @override
  String get printersFieldOutEndpoint => 'Out endpoint';

  @override
  String get printersFieldInEndpoint => 'In endpoint';

  @override
  String get printersFieldTimeout => 'Timeout (ms)';

  @override
  String get printersFieldCharacterTable => 'Character table';

  @override
  String get printersFieldStatusMonitoring => 'Status monitoring enabled';

  @override
  String get printersFieldAutoCutEnabled => 'Auto cut enabled';

  @override
  String get printersFieldCutMode => 'Cut mode';

  @override
  String get printersFieldCashDrawerEnabled => 'Cash drawer enabled';

  @override
  String get printersFieldDrawerPin => 'Drawer pin';

  @override
  String get printersFieldManufacturer => 'Manufacturer';

  @override
  String get printersFieldProductName => 'Product name';

  @override
  String get printersFieldAlternateSetting => 'Alternate setting';

  @override
  String get printersFieldPacketDelay => 'Packet delay (ms)';

  @override
  String get printersFieldRawGraphicsMode => 'Raw graphics mode';

  @override
  String get printersRawGraphicsModeModern => 'Modern graphics';

  @override
  String get printersRawGraphicsModeLegacy => 'Legacy raster';

  @override
  String get printersValidationRequired => 'This field is required.';

  @override
  String get printersValidationTooLong => 'This value is too long.';

  @override
  String get printersValidationInvalidHost =>
      'Enter a valid IPv4, IPv6, or hostname.';

  @override
  String get printersValidationIntegerOnly => 'Enter numbers only.';

  @override
  String get printersValidationTooSmall =>
      'The value is below the allowed minimum.';

  @override
  String get printersValidationTooLarge =>
      'The value is above the allowed maximum.';

  @override
  String get printersValidationUsbId =>
      'Enter a valid 4-digit hexadecimal USB ID.';

  @override
  String get printersValidationUsbEndpoint =>
      'Enter a valid USB endpoint value.';

  @override
  String get printersValidationDistinctEndpoints =>
      'In endpoint must not match out endpoint.';

  @override
  String get printersValidationDrawerPin => 'Drawer pin must be 2 or 5.';

  @override
  String get printersValidationUniqueKey =>
      'The generated identifier already exists. Try again.';

  @override
  String get printersValidationSpoolFormat =>
      'Raw spool should use RAW spool format or leave it empty.';

  @override
  String get appsCreateAction => 'Create app';

  @override
  String get appsEditAction => 'Edit';

  @override
  String get appsShowAction => 'Show';

  @override
  String get appsDeleteAction => 'Delete';

  @override
  String get appsSaveChanges => 'Save changes';

  @override
  String get appsBackToIndex => 'Back to apps';

  @override
  String get appsOverviewTitle => 'App overview';

  @override
  String get appsAccessTitle => 'Printer access';

  @override
  String get appsEmptyTitle => 'No apps yet';

  @override
  String get appsEmptyDescription =>
      'Create an app to start issuing API keys and restricting printer access.';

  @override
  String get appsDeleteTitle => 'Delete app';

  @override
  String appsDeleteDescription(String name) {
    return 'Delete $name permanently?';
  }

  @override
  String get appsBulkDeleteTitle => 'Delete selected apps';

  @override
  String get appsBulkDeleteAction => 'Delete selected';

  @override
  String appsBulkDeleteDescription(int count) {
    return 'Delete $count selected apps?';
  }

  @override
  String appsSelectedCount(int count) {
    return '$count selected';
  }

  @override
  String get appsCreatedSuccess => 'App created successfully.';

  @override
  String get appsUpdatedSuccess => 'App updated successfully.';

  @override
  String get appsDeletedSuccess => 'App deleted successfully.';

  @override
  String get appsBulkDeletedSuccess => 'Selected apps deleted successfully.';

  @override
  String get appsSearchPlaceholder => 'Search apps';

  @override
  String get appsFilterStatus => 'Status';

  @override
  String get appsFilterPrinterScope => 'Printer scope';

  @override
  String get appsFilterAllStatuses => 'All statuses';

  @override
  String get appsFilterAllScopes => 'All scopes';

  @override
  String get appsStatusEnabled => 'Enabled';

  @override
  String get appsStatusDisabled => 'Disabled';

  @override
  String get appsFieldName => 'Name';

  @override
  String get appsFieldEnabled => 'Enabled';

  @override
  String get appsFieldDescription => 'Description';

  @override
  String get appsFieldApiKey => 'API key';

  @override
  String get appsFieldUpdatedAt => 'Updated at';

  @override
  String get appsDescriptionHint => 'Optional internal description';

  @override
  String get appsApiKeyHelper =>
      'This API key is generated automatically for this app.';

  @override
  String get appsCopyApiKeyAction => 'Copy API key';

  @override
  String get appsApiKeyCopied => 'API key copied.';

  @override
  String get appsAllPrintersNote =>
      'No printers selected means all printers are allowed.';

  @override
  String get appsNoPrintersAvailable => 'No printers are available yet.';

  @override
  String get appsAllPrintersAccess => 'All printers';

  @override
  String get appsRestrictedPrintersLabel => 'Restricted printers';

  @override
  String get appsAllowedPrintersLabel => 'Allowed printers';

  @override
  String appsRestrictedPrintersCount(int count) {
    return '$count printers';
  }

  @override
  String get appsColumnName => 'Name';

  @override
  String get appsColumnApiKey => 'API key';

  @override
  String get appsColumnPrinters => 'Printers';

  @override
  String get appsColumnEnabled => 'Enabled';

  @override
  String get appsColumnUpdatedAt => 'Updated at';

  @override
  String get appsColumnActions => 'Actions';

  @override
  String get appsValidationRequired => 'This field is required.';

  @override
  String get appsValidationMaxLength => 'This value is too long.';

  @override
  String get appsValidationDuplicateApiKey =>
      'The generated API key already exists. Try again.';

  @override
  String get appsRegenerateApiKeyAction => 'Regenerate API key';

  @override
  String get appsRegenerateApiKeyTitle => 'Regenerate API key';

  @override
  String appsRegenerateApiKeyDescription(String name) {
    return 'Generate a new API key for $name? Existing integrations will need the new key.';
  }

  @override
  String get appsRegeneratedApiKeySuccess =>
      'API key regenerated successfully.';

  @override
  String get logsLoading => 'Loading logs';

  @override
  String get logsEmptyTitle => 'No logs yet';

  @override
  String get logsEmptyDescription =>
      'The logger will store app, server, and print events here.';

  @override
  String get logsSearchPlaceholder => 'Search logs';

  @override
  String get logsFilterLevel => 'Level';

  @override
  String get logsFilterEventType => 'Event type';

  @override
  String get logsFilterAllLevels => 'All levels';

  @override
  String get logsFilterAllEventTypes => 'All events';

  @override
  String get logsResetFilters => 'Reset filters';

  @override
  String get logsColumnTime => 'Time';

  @override
  String get logsColumnTitle => 'Title';

  @override
  String get logsColumnMessage => 'Message';

  @override
  String get logsColumnEvent => 'Event';

  @override
  String get logsColumnLevel => 'Level';

  @override
  String get logsShowAction => 'Show details';

  @override
  String get logsBackToLogs => 'Back to logs';

  @override
  String get logsMetadataTitle => 'Metadata';

  @override
  String tableRowsPerPage(int count) {
    return '$count / page';
  }

  @override
  String get retry => 'Retry';

  @override
  String get loading => 'Loading';

  @override
  String get splashLoading => 'Preparing Qintrix';

  @override
  String get splashErrorTitle => 'Startup failed';

  @override
  String get splashErrorDescription =>
      'The app could not finish startup tasks.';

  @override
  String get cancel => 'Cancel';

  @override
  String get errorDescription =>
      'Reusable error state ready for future modules.';
}
