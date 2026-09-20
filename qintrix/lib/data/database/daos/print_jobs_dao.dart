part of '../app_database.dart';

@DriftAccessor(tables: [PrintJobsTable])
class PrintJobsDao extends DatabaseAccessor<AppDatabase>
    with _$PrintJobsDaoMixin {
  PrintJobsDao(super.db);

  Future<List<PrintJobsTableData>> getPrintJobs() {
    return (select(
      printJobsTable,
    )..orderBy([(table) => OrderingTerm.desc(table.createdAt)])).get();
  }

  Future<List<PrintJobsTableData>> queryPrintJobs(JobsQuery filters) {
    final search = filters.search.trim().toLowerCase();
    final buffer = StringBuffer()
      ..writeln('SELECT j.* FROM print_jobs_table j')
      ..writeln('WHERE 1 = 1');
    final variables = <Variable<Object>>[];

    if (filters.status.isNotEmpty) {
      buffer.writeln('AND j.status = ?');
      variables.add(Variable<String>(filters.status));
    }

    if (filters.printerId.isNotEmpty) {
      buffer.writeln('AND j.printer_id = ?');
      variables.add(Variable<String>(filters.printerId));
    }

    if (filters.contentType.isNotEmpty) {
      buffer.writeln('AND j.content_type = ?');
      variables.add(Variable<String>(filters.contentType));
    }

    if (filters.referenceType.isNotEmpty) {
      buffer.writeln('AND j.reference_type = ?');
      variables.add(Variable<String>(filters.referenceType));
    }

    if (filters.referenceId.isNotEmpty) {
      buffer.writeln('AND j.reference_id = ?');
      variables.add(Variable<String>(filters.referenceId));
    }

    if (search.isNotEmpty) {
      final like = '%$search%';
      buffer.writeln(
        'AND (LOWER(j.id) LIKE ? OR LOWER(j.title) LIKE ? OR LOWER(COALESCE(j.payload_summary, \'\')) LIKE ? OR LOWER(COALESCE(j.reference_id, \'\')) LIKE ?)',
      );
      variables.add(Variable<String>(like));
      variables.add(Variable<String>(like));
      variables.add(Variable<String>(like));
      variables.add(Variable<String>(like));
    }

    final sortColumn = switch (filters.sortBy) {
      'updatedAt' => 'j.updated_at',
      'status' => 'j.status',
      'contentType' => 'j.content_type',
      _ => 'j.created_at',
    };
    final sortDirection = filters.sortDirection.toLowerCase() == 'asc'
        ? 'ASC'
        : 'DESC';

    buffer.writeln('ORDER BY $sortColumn $sortDirection');
    buffer.writeln('LIMIT ? OFFSET ?');
    variables.add(Variable<int>(filters.pageSize));
    variables.add(Variable<int>(filters.offset));

    return customSelect(
      buffer.toString(),
      variables: variables,
      readsFrom: {printJobsTable},
    ).map((row) => printJobsTable.map(row.data)).get();
  }

  Future<int> countPrintJobs(JobsQuery filters) async {
    final search = filters.search.trim().toLowerCase();
    final buffer = StringBuffer()
      ..writeln('SELECT COUNT(*) AS count FROM print_jobs_table j')
      ..writeln('WHERE 1 = 1');
    final variables = <Variable<Object>>[];

    if (filters.status.isNotEmpty) {
      buffer.writeln('AND j.status = ?');
      variables.add(Variable<String>(filters.status));
    }

    if (filters.printerId.isNotEmpty) {
      buffer.writeln('AND j.printer_id = ?');
      variables.add(Variable<String>(filters.printerId));
    }

    if (filters.contentType.isNotEmpty) {
      buffer.writeln('AND j.content_type = ?');
      variables.add(Variable<String>(filters.contentType));
    }

    if (filters.referenceType.isNotEmpty) {
      buffer.writeln('AND j.reference_type = ?');
      variables.add(Variable<String>(filters.referenceType));
    }

    if (filters.referenceId.isNotEmpty) {
      buffer.writeln('AND j.reference_id = ?');
      variables.add(Variable<String>(filters.referenceId));
    }

    if (search.isNotEmpty) {
      final like = '%$search%';
      buffer.writeln(
        'AND (LOWER(j.id) LIKE ? OR LOWER(j.title) LIKE ? OR LOWER(COALESCE(j.payload_summary, \'\')) LIKE ? OR LOWER(COALESCE(j.reference_id, \'\')) LIKE ?)',
      );
      variables.add(Variable<String>(like));
      variables.add(Variable<String>(like));
      variables.add(Variable<String>(like));
      variables.add(Variable<String>(like));
    }

    final row = await customSelect(
      buffer.toString(),
      variables: variables,
      readsFrom: {printJobsTable},
    ).getSingle();
    return row.read<int>('count');
  }

  Future<PrintJobsTableData?> getPrintJobById(String id) {
    return (select(
      printJobsTable,
    )..where((table) => table.id.equals(id))).getSingleOrNull();
  }

  Future<PrintJobsTableData?> getPrintJobByIdempotencyKey(
    String appId,
    String idempotencyKey,
  ) {
    return (select(printJobsTable)
      ..where((table) => table.appId.equals(appId))
      ..where((table) => table.idempotencyKey.equals(idempotencyKey))
      ..orderBy([(table) => OrderingTerm.desc(table.createdAt)])).getSingleOrNull();
  }

  Future<List<PrintJobsTableData>> getPendingPrintJobs() {
    return (select(printJobsTable)
      ..where(
        (table) => table.status.isIn(
          const ['queued', 'retry_scheduled', 'processing'],
        ),
      )
      ..orderBy([(table) => OrderingTerm.asc(table.createdAt)])).get();
  }

  Future<void> upsertPrintJob(PrintJobsTableCompanion printJob) {
    return into(printJobsTable).insertOnConflictUpdate(printJob);
  }

  Future<void> deletePrintJobs(List<String> ids) async {
    if (ids.isEmpty) {
      return;
    }

    await (delete(printJobsTable)..where((table) => table.id.isIn(ids))).go();
  }
}
