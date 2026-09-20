part of '../app_database.dart';

@DriftAccessor(tables: [PrintersTable])
class PrintersDao extends DatabaseAccessor<AppDatabase>
    with _$PrintersDaoMixin {
  PrintersDao(super.db);

  Future<List<PrintersTableData>> getPrinters() {
    return (select(
      printersTable,
    )..orderBy([(table) => OrderingTerm.asc(table.name)])).get();
  }

  Future<List<PrintersTableData>> queryPrinters(PrintersQuery filters) {
    final query = select(printersTable)
      ..orderBy([(table) => OrderingTerm.asc(table.name)]);

    if (filters.connectionType.isNotEmpty) {
      query.where((table) => table.connectionType.equals(filters.connectionType));
    }
    if (filters.status == 'enabled') {
      query.where((table) => table.isEnabled.equals(true));
    } else if (filters.status == 'disabled') {
      query.where((table) => table.isEnabled.equals(false));
    }
    final search = filters.search.trim().toLowerCase();
    if (search.isNotEmpty) {
      query.where((table) {
        return table.name.lower().like('%$search%') |
            table.uniqueKey.lower().like('%$search%');
      });
    }

    query.limit(filters.pageSize, offset: filters.offset);
    return query.get();
  }

  Future<int> countPrinters(PrintersQuery filters) async {
    final query = selectOnly(printersTable)
      ..addColumns([printersTable.id.count()]);

    if (filters.connectionType.isNotEmpty) {
      query.where(printersTable.connectionType.equals(filters.connectionType));
    }
    if (filters.status == 'enabled') {
      query.where(printersTable.isEnabled.equals(true));
    } else if (filters.status == 'disabled') {
      query.where(printersTable.isEnabled.equals(false));
    }
    final search = filters.search.trim().toLowerCase();
    if (search.isNotEmpty) {
      query.where(
        printersTable.name.lower().like('%$search%') |
            printersTable.uniqueKey.lower().like('%$search%'),
      );
    }

    final row = await query.getSingle();
    return row.read(printersTable.id.count()) ?? 0;
  }

  Future<void> upsertPrinter(PrintersTableCompanion printer) {
    return into(printersTable).insertOnConflictUpdate(printer);
  }

  Future<PrintersTableData?> getPrinterById(String id) {
    return (select(
      printersTable,
    )..where((table) => table.id.equals(id))).getSingleOrNull();
  }

  Future<void> deletePrinter(String id) {
    return (delete(
      printersTable,
    )..where((table) => table.id.equals(id))).go();
  }

  Future<void> deletePrinters(List<String> ids) async {
    if (ids.isEmpty) {
      return;
    }

    await (delete(printersTable)..where((table) => table.id.isIn(ids))).go();
  }

  Future<bool> uniqueKeyExists(String uniqueKey, {String? excludingId}) async {
    final query = select(printersTable)
      ..where((table) => table.uniqueKey.equals(uniqueKey));
    if (excludingId != null) {
      query.where((table) => table.id.isNotValue(excludingId));
    }

    final row = await query.getSingleOrNull();
    return row != null;
  }
}
