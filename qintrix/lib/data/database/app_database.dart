import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:qintrix/data/models/exports.dart';

import 'tables/app_printers_table.dart';
import 'tables/apps_table.dart';
import 'tables/logs_table.dart';
import 'tables/print_jobs_table.dart';
import 'tables/printers_table.dart';
import 'tables/settings_table.dart';

part 'app_database.g.dart';
part 'daos/apps_dao.dart';
part 'daos/logs_dao.dart';
part 'daos/print_jobs_dao.dart';
part 'daos/printers_dao.dart';

@DriftDatabase(
  tables: [
    SettingsTable,
    PrintersTable,
    AppsTable,
    AppPrintersTable,
    PrintJobsTable,
    LogsTable,
  ],
  daos: [PrintersDao, AppsDao, PrintJobsDao, LogsDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase._(super.executor);

  factory AppDatabase.forTest() => AppDatabase._(NativeDatabase.memory());

  static Future<AppDatabase> create() async {
    final directory = await getApplicationSupportDirectory();
    await directory.create(recursive: true);
    final file = File(p.join(directory.path, 'qintrix.sqlite'));
    return AppDatabase._(NativeDatabase.createInBackground(file));
  }

  @override
  int get schemaVersion => 8;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (migrator) => migrator.createAll(),
    onUpgrade: (migrator, from, to) async {
      if (from < 2) {
        await migrator.addColumn(printersTable, printersTable.uniqueKey);
        await migrator.addColumn(printersTable, printersTable.description);
        await migrator.addColumn(printersTable, printersTable.tcpHost);
        await migrator.addColumn(printersTable, printersTable.tcpPort);
        await migrator.addColumn(
          printersTable,
          printersTable.tcpConnectTimeoutMs,
        );
        await migrator.addColumn(
          printersTable,
          printersTable.tcpWriteTimeoutMs,
        );
        await migrator.addColumn(printersTable, printersTable.tcpReadTimeoutMs);
        await migrator.addColumn(printersTable, printersTable.tcpAutoReconnect);
        await migrator.addColumn(
          printersTable,
          printersTable.tcpReconnectDelayMs,
        );
        await migrator.addColumn(printersTable, printersTable.tcpEncoding);
        await migrator.addColumn(printersTable, printersTable.tcpCodePage);
        await migrator.addColumn(printersTable, printersTable.tcpLineEnding);
        await migrator.addColumn(printersTable, printersTable.tcpKeepAlive);
        await migrator.addColumn(printersTable, printersTable.tcpNoDelay);
        await migrator.addColumn(printersTable, printersTable.tcpLingerSeconds);
        await migrator.addColumn(
          printersTable,
          printersTable.systemPrinterName,
        );
        await migrator.addColumn(printersTable, printersTable.systemPaperSize);
        await migrator.addColumn(
          printersTable,
          printersTable.systemDefaultCopies,
        );
        await migrator.addColumn(
          printersTable,
          printersTable.systemColorEnabled,
        );
        await migrator.addColumn(printersTable, printersTable.systemDuplexMode);
        await migrator.addColumn(
          printersTable,
          printersTable.systemOrientation,
        );
        await migrator.addColumn(
          printersTable,
          printersTable.systemJobTimeoutMs,
        );
        await migrator.addColumn(printersTable, printersTable.systemNotes);
        await migrator.addColumn(printersTable, printersTable.systemDriverName);
        await migrator.addColumn(printersTable, printersTable.systemQueueName);
        await migrator.addColumn(
          printersTable,
          printersTable.systemSpoolFormat,
        );
        await migrator.addColumn(
          printersTable,
          printersTable.systemUseRawSpool,
        );
        await migrator.addColumn(printersTable, printersTable.usbVendorId);
        await migrator.addColumn(printersTable, printersTable.usbProductId);
        await migrator.addColumn(printersTable, printersTable.usbSerialNumber);
        await migrator.addColumn(
          printersTable,
          printersTable.usbInterfaceNumber,
        );
        await migrator.addColumn(printersTable, printersTable.usbOutEndpoint);
        await migrator.addColumn(printersTable, printersTable.usbInEndpoint);
        await migrator.addColumn(printersTable, printersTable.usbTimeoutMs);
        await migrator.addColumn(printersTable, printersTable.usbEncoding);
        await migrator.addColumn(printersTable, printersTable.usbCodePage);
        await migrator.addColumn(
          printersTable,
          printersTable.usbCharacterTable,
        );
        await migrator.addColumn(
          printersTable,
          printersTable.usbAutoCutEnabled,
        );
        await migrator.addColumn(printersTable, printersTable.usbCutMode);
        await migrator.addColumn(
          printersTable,
          printersTable.usbCashDrawerEnabled,
        );
        await migrator.addColumn(printersTable, printersTable.usbDrawerPin);
        await migrator.addColumn(
          printersTable,
          printersTable.usbStatusMonitoringEnabled,
        );
        await migrator.addColumn(printersTable, printersTable.usbManufacturer);
        await migrator.addColumn(printersTable, printersTable.usbProductName);
        await migrator.addColumn(
          printersTable,
          printersTable.usbAlternateSetting,
        );
        await migrator.addColumn(printersTable, printersTable.usbPacketDelayMs);
        await customStatement(
          "UPDATE printers_table SET unique_key = id WHERE unique_key = '' OR unique_key IS NULL",
        );
        await customStatement(
          "UPDATE printers_table SET tcp_host = address WHERE connection_type = 'tcp' AND address IS NOT NULL AND tcp_host IS NULL",
        );
      }

      if (from < 3) {
        await migrator.createTable(appsTable);
        await migrator.createTable(appPrintersTable);

        await customStatement('''
          CREATE TABLE settings_table_new (
            id INTEGER NOT NULL PRIMARY KEY,
            app_port INTEGER NOT NULL DEFAULT 4880,
            bind_host TEXT NOT NULL DEFAULT '127.0.0.1',
            enable_background_mode INTEGER NOT NULL DEFAULT 0,
            start_with_os INTEGER NOT NULL DEFAULT 0,
            allow_lan_access INTEGER NOT NULL DEFAULT 0,
            auto_start_server INTEGER NOT NULL DEFAULT 0,
            updated_at INTEGER NOT NULL
          )
        ''');

        await customStatement('''
          INSERT INTO settings_table_new (
            id,
            app_port,
            bind_host,
            enable_background_mode,
            start_with_os,
            allow_lan_access,
            auto_start_server,
            updated_at
          )
          SELECT
            id,
            app_port,
            bind_host,
            enable_background_mode,
            start_with_os,
            allow_lan_access,
            auto_start_server,
            updated_at
          FROM settings_table
        ''');

        await customStatement('DROP TABLE settings_table');
        await customStatement(
          'ALTER TABLE settings_table_new RENAME TO settings_table',
        );
      }

      if (from < 4) {
        await customStatement('''
          CREATE TABLE apps_table (
            id TEXT NOT NULL PRIMARY KEY,
            name TEXT NOT NULL,
            is_enabled INTEGER NOT NULL DEFAULT 1,
            description TEXT NULL,
            api_key TEXT NOT NULL UNIQUE,
            created_at INTEGER NOT NULL,
            updated_at INTEGER NOT NULL
          )
        ''');

        await customStatement('''
          INSERT INTO apps_table (
            id,
            name,
            is_enabled,
            description,
            api_key,
            created_at,
            updated_at
          )
          SELECT
            id,
            name,
            is_enabled,
            description,
            api_key,
            created_at,
            updated_at
          FROM host_whitelist_table
        ''');

        await customStatement('''
          CREATE TABLE app_printers_table (
            app_id TEXT NOT NULL REFERENCES apps_table (id) ON DELETE CASCADE,
            printer_id TEXT NOT NULL REFERENCES printers_table (id) ON DELETE CASCADE,
            PRIMARY KEY (app_id, printer_id)
          )
        ''');

        await customStatement('''
          INSERT INTO app_printers_table (app_id, printer_id)
          SELECT host_id, printer_id
          FROM host_whitelist_printers_table
        ''');

        await customStatement('DROP TABLE host_whitelist_printers_table');
        await customStatement('DROP TABLE host_whitelist_table');
      }

      if (from < 8) {
        await migrator.addColumn(printersTable, printersTable.rawGraphicsMode);
      }

      if (from < 5) {
        await _ensureAppsTablesExist();
      }

      if (from < 6) {
        await migrator.addColumn(settingsTable, settingsTable.jobsStartPaused);
        await migrator.addColumn(
          settingsTable,
          settingsTable.jobsMaxRetryAttempts,
        );
        await migrator.addColumn(
          settingsTable,
          settingsTable.jobsRetryDelaySeconds,
        );
        await migrator.addColumn(
          settingsTable,
          settingsTable.jobsHistoryRetentionDays,
        );

        await customStatement('''
          CREATE TABLE print_jobs_table_new (
            id TEXT NOT NULL PRIMARY KEY,
            printer_id TEXT NULL,
            app_id TEXT NULL,
            title TEXT NOT NULL,
            status TEXT NOT NULL DEFAULT 'accepted',
            content_type TEXT NULL,
            copies INTEGER NOT NULL DEFAULT 1,
            payload_source_type TEXT NULL,
            payload_summary TEXT NULL,
            artifact_path TEXT NULL,
            artifact_mime_type TEXT NULL,
            artifact_size INTEGER NULL,
            artifact_created_at INTEGER NULL,
            artifact_checksum TEXT NULL,
            options_json TEXT NULL,
            meta_json TEXT NULL,
            reference_type TEXT NULL,
            reference_id TEXT NULL,
            source TEXT NULL,
            idempotency_key TEXT NULL,
            failure_category TEXT NULL,
            failure_message TEXT NULL,
            retry_count INTEGER NOT NULL DEFAULT 0,
            last_retry_at INTEGER NULL,
            next_retry_at INTEGER NULL,
            queued_at INTEGER NULL,
            started_at INTEGER NULL,
            completed_at INTEGER NULL,
            canceled_at INTEGER NULL,
            created_at INTEGER NOT NULL,
            updated_at INTEGER NOT NULL
          )
        ''');

        await customStatement('''
          INSERT INTO print_jobs_table_new (
            id,
            printer_id,
            title,
            status,
            content_type,
            created_at,
            updated_at
          )
          SELECT
            id,
            printer_id,
            title,
            status,
            content_type,
            created_at,
            updated_at
          FROM print_jobs_table
        ''');

        await customStatement('DROP TABLE print_jobs_table');
        await customStatement(
          'ALTER TABLE print_jobs_table_new RENAME TO print_jobs_table',
        );
      }

      if (from < 7) {
        await migrator.addColumn(printersTable, printersTable.lastStatusKey);
        await migrator.addColumn(
          printersTable,
          printersTable.lastStatusMessage,
        );
        await customStatement('''
          UPDATE printers_table
          SET last_status_message = last_status
          WHERE last_status IS NOT NULL
            AND TRIM(last_status) != ''
            AND (last_status_message IS NULL OR TRIM(last_status_message) = '')
        ''');
      }
    },
    beforeOpen: (details) async {
      await _ensureAppsTablesExist();
    },
  );

  Future<void> _ensureAppsTablesExist() async {
    final legacyAppsTable = await customSelect(
      "SELECT name FROM sqlite_master WHERE type = 'table' AND name = 'host_whitelist_table'",
    ).getSingleOrNull();
    final currentAppsTable = await customSelect(
      "SELECT name FROM sqlite_master WHERE type = 'table' AND name = 'apps_table'",
    ).getSingleOrNull();
    final currentAppPrintersTable = await customSelect(
      "SELECT name FROM sqlite_master WHERE type = 'table' AND name = 'app_printers_table'",
    ).getSingleOrNull();
    final legacyAppPrintersTable = await customSelect(
      "SELECT name FROM sqlite_master WHERE type = 'table' AND name = 'host_whitelist_printers_table'",
    ).getSingleOrNull();

    if (currentAppsTable == null) {
      await customStatement('''
        CREATE TABLE apps_table (
          id TEXT NOT NULL PRIMARY KEY,
          name TEXT NOT NULL,
          is_enabled INTEGER NOT NULL DEFAULT 1,
          description TEXT NULL,
          api_key TEXT NOT NULL UNIQUE,
          created_at INTEGER NOT NULL,
          updated_at INTEGER NOT NULL
        )
      ''');

      if (legacyAppsTable != null) {
        await customStatement('''
          INSERT INTO apps_table (
            id,
            name,
            is_enabled,
            description,
            api_key,
            created_at,
            updated_at
          )
          SELECT
            id,
            name,
            is_enabled,
            description,
            api_key,
            created_at,
            updated_at
          FROM host_whitelist_table
        ''');
      }
    }

    if (currentAppPrintersTable == null) {
      await customStatement('''
        CREATE TABLE app_printers_table (
          app_id TEXT NOT NULL REFERENCES apps_table (id) ON DELETE CASCADE,
          printer_id TEXT NOT NULL REFERENCES printers_table (id) ON DELETE CASCADE,
          PRIMARY KEY (app_id, printer_id)
        )
      ''');

      if (legacyAppPrintersTable != null) {
        await customStatement('''
          INSERT INTO app_printers_table (app_id, printer_id)
          SELECT host_id, printer_id
          FROM host_whitelist_printers_table
        ''');
      }
    }

    if (legacyAppPrintersTable != null) {
      await customStatement('DROP TABLE host_whitelist_printers_table');
    }
    if (legacyAppsTable != null) {
      await customStatement('DROP TABLE host_whitelist_table');
    }
  }
}
