import 'package:drift/drift.dart';
import 'package:qintrix/data/database/app_database.dart';
import 'package:qintrix/data/models/exports.dart';

import '../contracts/logs_repository.dart';

class DriftLogsRepository implements LogsRepository {
  DriftLogsRepository(this._logsDao);

  final LogsDao _logsDao;

  @override
  Future<void> addLog(AppLogModel log) {
    return _logsDao.insertLog(
      LogsTableCompanion.insert(
        id: log.id,
        level: log.level,
        eventType: log.eventType,
        title: log.title,
        message: log.message,
        metadata: Value(log.metadata),
        createdAt: log.createdAt,
      ),
    );
  }

  @override
  Future<List<AppLogModel>> getLogs({int? limit}) async {
    final rows = await _logsDao.getLogs(limit: limit);
    return rows.map(_mapLog).toList(growable: false);
  }

  @override
  Future<PagedResult<AppLogModel>> queryLogs(LogsQuery query) async {
    final results = await Future.wait([
      _logsDao.queryLogs(query),
      _logsDao.countLogs(query),
    ]);

    final rows = results[0] as List<LogsTableData>;
    final totalCount = results[1] as int;

    return PagedResult<AppLogModel>(
      items: rows.map(_mapLog).toList(growable: false),
      totalCount: totalCount,
      page: query.page,
      pageSize: query.pageSize,
    );
  }

  AppLogModel _mapLog(LogsTableData row) {
    return AppLogModel(
      id: row.id,
      level: row.level,
      eventType: row.eventType,
      title: row.title,
      message: row.message,
      metadata: row.metadata,
      createdAt: row.createdAt,
    );
  }
}
