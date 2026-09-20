import 'package:flutter_test/flutter_test.dart';
import 'package:qintrix/core/services/logger_service.dart';
import 'package:qintrix/data/database/app_database.dart';
import 'package:qintrix/data/repositories/exports.dart';

void main() {
  test('writes required log events to the logs repository', () async {
    final database = AppDatabase.forTest();
    final repository = DriftLogsRepository(database.logsDao);
    final logger = LoggerService(repository);

    await logger.logAppStart();
    await logger.logServerStart();
    await logger.logPrintJobCreated('Job #1');

    final logs = await repository.getLogs();
    final titles = logs.map((log) => log.title).toList(growable: false);
    final eventTypes = logs.map((log) => log.eventType).toList(growable: false);

    expect(logs, hasLength(3));
    expect(titles, contains('Print job created'));
    expect(eventTypes, contains(LogEventType.appStart.value));
  });
}
