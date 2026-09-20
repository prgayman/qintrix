part of '../app_database.dart';

@DriftAccessor(tables: [LogsTable])
class LogsDao extends DatabaseAccessor<AppDatabase> with _$LogsDaoMixin {
  LogsDao(super.db);

  Future<void> insertLog(LogsTableCompanion log) {
    return into(logsTable).insert(log);
  }

  Future<List<LogsTableData>> getLogs({int? limit}) {
    final query = select(logsTable)
      ..orderBy([(table) => OrderingTerm.desc(table.createdAt)]);

    if (limit != null) {
      query.limit(limit);
    }

    return query.get();
  }

  Future<List<LogsTableData>> queryLogs(LogsQuery filters) {
    final query = select(logsTable)
      ..orderBy([(table) => OrderingTerm.desc(table.createdAt)]);

    if (filters.level.isNotEmpty) {
      query.where((table) => table.level.equals(filters.level));
    }
    if (filters.eventType.isNotEmpty) {
      query.where((table) => table.eventType.equals(filters.eventType));
    }
    final search = filters.search.trim().toLowerCase();
    if (search.isNotEmpty) {
      query.where((table) {
        return table.title.lower().like('%$search%') |
            table.message.lower().like('%$search%') |
            table.eventType.lower().like('%$search%');
      });
    }

    query.limit(filters.pageSize, offset: filters.offset);
    return query.get();
  }

  Future<int> countLogs(LogsQuery filters) async {
    final query = selectOnly(logsTable)..addColumns([logsTable.id.count()]);

    if (filters.level.isNotEmpty) {
      query.where(logsTable.level.equals(filters.level));
    }
    if (filters.eventType.isNotEmpty) {
      query.where(logsTable.eventType.equals(filters.eventType));
    }
    final search = filters.search.trim().toLowerCase();
    if (search.isNotEmpty) {
      query.where(
        logsTable.title.lower().like('%$search%') |
            logsTable.message.lower().like('%$search%') |
            logsTable.eventType.lower().like('%$search%'),
      );
    }

    final row = await query.getSingle();
    return row.read(logsTable.id.count()) ?? 0;
  }
}
