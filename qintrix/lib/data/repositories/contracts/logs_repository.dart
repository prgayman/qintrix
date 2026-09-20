import 'package:qintrix/data/models/exports.dart';

abstract class LogsRepository {
  Future<void> addLog(AppLogModel log);

  Future<List<AppLogModel>> getLogs({int? limit});

  Future<PagedResult<AppLogModel>> queryLogs(LogsQuery query);
}
