import 'package:drift/drift.dart';

class PrintJobsTable extends Table {
  TextColumn get id => text()();

  TextColumn get printerId => text().nullable()();

  TextColumn get appId => text().nullable()();

  TextColumn get title => text()();

  TextColumn get status => text().withDefault(const Constant('accepted'))();

  TextColumn get contentType => text().nullable()();

  IntColumn get copies => integer().withDefault(const Constant(1))();

  TextColumn get payloadSourceType => text().nullable()();

  TextColumn get payloadSummary => text().nullable()();

  TextColumn get artifactPath => text().nullable()();

  TextColumn get artifactMimeType => text().nullable()();

  IntColumn get artifactSize => integer().nullable()();

  DateTimeColumn get artifactCreatedAt => dateTime().nullable()();

  TextColumn get artifactChecksum => text().nullable()();

  TextColumn get optionsJson => text().nullable()();

  TextColumn get metaJson => text().nullable()();

  TextColumn get referenceType => text().nullable()();

  TextColumn get referenceId => text().nullable()();

  TextColumn get source => text().nullable()();

  TextColumn get idempotencyKey => text().nullable()();

  TextColumn get failureCategory => text().nullable()();

  TextColumn get failureMessage => text().nullable()();

  IntColumn get retryCount => integer().withDefault(const Constant(0))();

  DateTimeColumn get lastRetryAt => dateTime().nullable()();

  DateTimeColumn get nextRetryAt => dateTime().nullable()();

  DateTimeColumn get queuedAt => dateTime().nullable()();

  DateTimeColumn get startedAt => dateTime().nullable()();

  DateTimeColumn get completedAt => dateTime().nullable()();

  DateTimeColumn get canceledAt => dateTime().nullable()();

  DateTimeColumn get createdAt => dateTime()();

  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}
