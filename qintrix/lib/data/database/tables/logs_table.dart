import 'package:drift/drift.dart';

class LogsTable extends Table {
  TextColumn get id => text()();

  TextColumn get level => text()();

  TextColumn get eventType => text()();

  TextColumn get title => text()();

  TextColumn get message => text()();

  TextColumn get metadata => text().nullable()();

  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}
