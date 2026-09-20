part of '../app_database.dart';

@DriftAccessor(tables: [AppsTable, AppPrintersTable])
class AppsDao extends DatabaseAccessor<AppDatabase>
    with _$AppsDaoMixin {
  AppsDao(super.db);

  Future<List<AppsTableData>> getApps() {
    return (select(
      appsTable,
    )..orderBy([(table) => OrderingTerm.asc(table.name)])).get();
  }

  Future<List<AppsTableData>> queryApps(AppsQuery filters) {
    final search = filters.search.trim().toLowerCase();
    final sqlBuffer = StringBuffer()
      ..writeln('SELECT a.* FROM apps_table a')
      ..writeln('WHERE 1 = 1');
    final variables = <Variable<Object>>[];

    if (filters.status == 'enabled') {
      sqlBuffer.writeln('AND a.is_enabled = 1');
    } else if (filters.status == 'disabled') {
      sqlBuffer.writeln('AND a.is_enabled = 0');
    }

    if (filters.scope == 'all') {
      sqlBuffer.writeln(
        'AND NOT EXISTS (SELECT 1 FROM app_printers_table ap WHERE ap.app_id = a.id)',
      );
    } else if (filters.scope == 'restricted') {
      sqlBuffer.writeln(
        'AND EXISTS (SELECT 1 FROM app_printers_table ap WHERE ap.app_id = a.id)',
      );
    }

    if (search.isNotEmpty) {
      sqlBuffer.writeln(
        'AND (LOWER(a.name) LIKE ? OR LOWER(a.api_key) LIKE ?)',
      );
      final like = '%$search%';
      variables.add(Variable<String>(like));
      variables.add(Variable<String>(like));
    }

    sqlBuffer.writeln('ORDER BY a.name ASC');
    sqlBuffer.writeln('LIMIT ? OFFSET ?');
    variables.add(Variable<int>(filters.pageSize));
    variables.add(Variable<int>(filters.offset));

    return customSelect(
      sqlBuffer.toString(),
      variables: variables,
      readsFrom: {appsTable, appPrintersTable},
    ).map((row) => appsTable.map(row.data)).get();
  }

  Future<int> countApps(AppsQuery filters) async {
    final search = filters.search.trim().toLowerCase();
    final sqlBuffer = StringBuffer()
      ..writeln('SELECT COUNT(*) AS count FROM apps_table a')
      ..writeln('WHERE 1 = 1');
    final variables = <Variable<Object>>[];

    if (filters.status == 'enabled') {
      sqlBuffer.writeln('AND a.is_enabled = 1');
    } else if (filters.status == 'disabled') {
      sqlBuffer.writeln('AND a.is_enabled = 0');
    }

    if (filters.scope == 'all') {
      sqlBuffer.writeln(
        'AND NOT EXISTS (SELECT 1 FROM app_printers_table ap WHERE ap.app_id = a.id)',
      );
    } else if (filters.scope == 'restricted') {
      sqlBuffer.writeln(
        'AND EXISTS (SELECT 1 FROM app_printers_table ap WHERE ap.app_id = a.id)',
      );
    }

    if (search.isNotEmpty) {
      sqlBuffer.writeln(
        'AND (LOWER(a.name) LIKE ? OR LOWER(a.api_key) LIKE ?)',
      );
      final like = '%$search%';
      variables.add(Variable<String>(like));
      variables.add(Variable<String>(like));
    }

    final row = await customSelect(
      sqlBuffer.toString(),
      variables: variables,
      readsFrom: {appsTable, appPrintersTable},
    ).getSingle();

    return row.read<int>('count');
  }

  Future<AppsTableData?> getAppById(String id) {
    return (select(
      appsTable,
    )..where((table) => table.id.equals(id))).getSingleOrNull();
  }

  Future<AppsTableData?> getAppByApiKey(String apiKey) {
    return (select(
      appsTable,
    )..where((table) => table.apiKey.equals(apiKey))).getSingleOrNull();
  }

  Future<List<AppPrintersTableData>> getPrinterAssignmentsForApps(
    Iterable<String> appIds,
  ) {
    final ids = appIds.toList(growable: false);
    if (ids.isEmpty) {
      return Future.value(const <AppPrintersTableData>[]);
    }

    return (select(appPrintersTable)
      ..where((table) => table.appId.isIn(ids))).get();
  }

  Future<void> upsertApp(
    AppsTableCompanion app,
    List<String> printerIds,
  ) {
    return transaction(() async {
      await into(appsTable).insertOnConflictUpdate(app);
      final appId = app.id.value;
      await (delete(
        appPrintersTable,
      )..where((table) => table.appId.equals(appId))).go();

      if (printerIds.isNotEmpty) {
        await batch((batch) {
          batch.insertAll(
            appPrintersTable,
            printerIds
                .map(
                  (printerId) => AppPrintersTableCompanion.insert(
                    appId: appId,
                    printerId: printerId,
                  ),
                )
                .toList(growable: false),
          );
        });
      }
    });
  }

  Future<void> deleteApp(String id) {
    return (delete(
      appsTable,
    )..where((table) => table.id.equals(id))).go();
  }

  Future<void> deleteApps(List<String> ids) async {
    if (ids.isEmpty) {
      return;
    }

    await (delete(appsTable)..where((table) => table.id.isIn(ids)))
        .go();
  }

  Future<bool> apiKeyExists(String apiKey, {String? excludingId}) async {
    final query = select(appsTable)
      ..where((table) => table.apiKey.equals(apiKey));
    if (excludingId != null) {
      query.where((table) => table.id.isNotValue(excludingId));
    }

    return (await query.getSingleOrNull()) != null;
  }
}
