import 'package:drift/drift.dart';

class SettingsTable extends Table {
  IntColumn get id => integer()();

  IntColumn get appPort => integer().withDefault(const Constant(4880))();

  TextColumn get bindHost => text().withDefault(const Constant('127.0.0.1'))();

  BoolColumn get enableBackgroundMode =>
      boolean().withDefault(const Constant(true))();

  BoolColumn get startWithOs => boolean().withDefault(const Constant(true))();

  BoolColumn get allowLanAccess =>
      boolean().withDefault(const Constant(false))();

  BoolColumn get autoStartServer =>
      boolean().withDefault(const Constant(true))();

  BoolColumn get jobsStartPaused =>
      boolean().withDefault(const Constant(false))();

  IntColumn get jobsMaxRetryAttempts =>
      integer().withDefault(const Constant(2))();

  IntColumn get jobsRetryDelaySeconds =>
      integer().withDefault(const Constant(30))();

  IntColumn get jobsHistoryRetentionDays =>
      integer().withDefault(const Constant(7))();

  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}
