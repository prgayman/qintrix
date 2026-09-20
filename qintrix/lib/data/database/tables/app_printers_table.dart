import 'package:drift/drift.dart';

import 'apps_table.dart';
import 'printers_table.dart';

class AppPrintersTable extends Table {
  TextColumn get appId =>
      text().references(AppsTable, #id, onDelete: KeyAction.cascade)();

  TextColumn get printerId =>
      text().references(PrintersTable, #id, onDelete: KeyAction.cascade)();

  @override
  Set<Column<Object>>? get primaryKey => {appId, printerId};
}
