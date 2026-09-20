import 'package:flutter_test/flutter_test.dart';
import 'package:qintrix/data/database/app_database.dart';
import 'package:qintrix/data/models/exports.dart';
import 'package:qintrix/data/repositories/exports.dart';

void main() {
  test('logs repository returns all logs when no limit is provided', () async {
    final database = AppDatabase.forTest();
    final repository = DriftLogsRepository(database.logsDao);

    for (var index = 0; index < 250; index++) {
      await repository.addLog(
        AppLogModel(
          id: 'log-$index',
          level: 'info',
          eventType: 'app_start',
          title: 'Log $index',
          message: 'Message $index',
          createdAt: DateTime(2026, 3, 19, 12, 0, index % 60, index),
        ),
      );
    }

    final allLogs = await repository.getLogs();
    final limitedLogs = await repository.getLogs(limit: 40);

    expect(allLogs, hasLength(250));
    expect(limitedLogs, hasLength(40));
  });
}
