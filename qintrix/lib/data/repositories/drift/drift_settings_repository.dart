import 'package:drift/drift.dart';
import 'package:qintrix/data/database/app_database.dart';
import 'package:qintrix/data/models/exports.dart';

import '../contracts/settings_repository.dart';

class DriftSettingsRepository implements SettingsRepository {
  DriftSettingsRepository(this._database);

  static const _settingsId = 1;

  final AppDatabase _database;

  @override
  Future<AppSettingsModel> loadSettings() async {
    final row = await (_database.select(
      _database.settingsTable,
    )..where((table) => table.id.equals(_settingsId))).getSingleOrNull();

    if (row != null) {
      return _mapSettings(row);
    }

    final now = DateTime.now();
    final companion = SettingsTableCompanion.insert(
      id: const Value(_settingsId),
      updatedAt: now,
    );
    await _database.into(_database.settingsTable).insert(companion);

    final inserted = await (_database.select(
      _database.settingsTable,
    )..where((table) => table.id.equals(_settingsId))).getSingle();

    return _mapSettings(inserted);
  }

  @override
  Future<AppSettingsModel> saveSettings(AppSettingsModel settings) async {
    final updated = settings.copyWith(updatedAt: DateTime.now());
    await _database
        .into(_database.settingsTable)
        .insertOnConflictUpdate(
          SettingsTableCompanion(
            id: const Value(_settingsId),
            appPort: Value(updated.appPort),
            bindHost: Value(updated.bindHost),
            enableBackgroundMode: Value(updated.enableBackgroundMode),
            startWithOs: Value(updated.startWithOs),
            allowLanAccess: Value(updated.allowLanAccess),
            autoStartServer: Value(updated.autoStartServer),
            jobsStartPaused: Value(updated.jobsStartPaused),
            jobsMaxRetryAttempts: Value(updated.jobsMaxRetryAttempts),
            jobsRetryDelaySeconds: Value(updated.jobsRetryDelaySeconds),
            jobsHistoryRetentionDays: Value(updated.jobsHistoryRetentionDays),
            updatedAt: Value(updated.updatedAt),
          ),
        );
    return updated;
  }

  AppSettingsModel _mapSettings(SettingsTableData row) {
    return AppSettingsModel(
      appPort: row.appPort,
      bindHost: row.bindHost,
      enableBackgroundMode: row.enableBackgroundMode,
      startWithOs: row.startWithOs,
      allowLanAccess: row.allowLanAccess,
      autoStartServer: row.autoStartServer,
      jobsStartPaused: row.jobsStartPaused,
      jobsMaxRetryAttempts: row.jobsMaxRetryAttempts,
      jobsRetryDelaySeconds: row.jobsRetryDelaySeconds,
      jobsHistoryRetentionDays: row.jobsHistoryRetentionDays,
      updatedAt: row.updatedAt,
    );
  }
}
