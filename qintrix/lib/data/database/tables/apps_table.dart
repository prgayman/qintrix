import 'package:drift/drift.dart';

class AppsTable extends Table {
  TextColumn get id => text()();

  TextColumn get name => text()();

  BoolColumn get isEnabled => boolean().withDefault(const Constant(true))();

  TextColumn get description => text().nullable()();

  TextColumn get apiKey => text().unique()();

  DateTimeColumn get createdAt => dateTime()();

  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}
