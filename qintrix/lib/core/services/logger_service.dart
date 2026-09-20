import 'package:uuid/uuid.dart';
import 'package:qintrix/data/models/exports.dart';
import 'package:qintrix/data/repositories/exports.dart';

enum LogLevelType {
  info('info'),
  warning('warning'),
  error('error');

  const LogLevelType(this.value);

  final String value;
}

enum LogEventType {
  appStart('app_start'),
  appError('app_error'),
  serverStart('server_start'),
  serverStop('server_stop'),
  serverRestart('server_restart'),
  serverError('server_error'),
  apiAuthFailure('api_auth_failure'),
  printJobCreated('print_job_created'),
  printerTestResult('printer_test_result');

  const LogEventType(this.value);

  final String value;
}

class LoggerService {
  LoggerService(this._logsRepository);

  static const _uuid = Uuid();

  final LogsRepository _logsRepository;

  Future<void> log({
    required LogLevelType level,
    required LogEventType eventType,
    required String title,
    required String message,
    String? metadata,
  }) {
    return _logsRepository.addLog(
      AppLogModel(
        id: _uuid.v4(),
        level: level.value,
        eventType: eventType.value,
        title: title,
        message: message,
        metadata: metadata,
        createdAt: DateTime.now(),
      ),
    );
  }

  Future<void> logAppStart() {
    return log(
      level: LogLevelType.info,
      eventType: LogEventType.appStart,
      title: 'App start',
      message: 'Qintrix startup sequence completed.',
    );
  }

  Future<void> logAppError(String message) {
    return log(
      level: LogLevelType.error,
      eventType: LogEventType.appError,
      title: 'App error',
      message: message,
    );
  }

  Future<void> logServerStart([String? message]) {
    return log(
      level: LogLevelType.info,
      eventType: LogEventType.serverStart,
      title: 'Server start',
      message: message ?? 'Local server start was requested.',
    );
  }

  Future<void> logServerStop([String? message]) {
    return log(
      level: LogLevelType.info,
      eventType: LogEventType.serverStop,
      title: 'Server stop',
      message: message ?? 'Local server stop was requested.',
    );
  }

  Future<void> logServerRestart([String? message]) {
    return log(
      level: LogLevelType.info,
      eventType: LogEventType.serverRestart,
      title: 'Server restart',
      message: message ?? 'Local server restart was requested.',
    );
  }

  Future<void> logServerError(String message) {
    return log(
      level: LogLevelType.error,
      eventType: LogEventType.serverError,
      title: 'Server error',
      message: message,
    );
  }

  Future<void> logApiAuthFailure(String message) {
    return log(
      level: LogLevelType.warning,
      eventType: LogEventType.apiAuthFailure,
      title: 'API authentication failed',
      message: message,
    );
  }

  Future<void> logPrintJobCreated(String title) {
    return log(
      level: LogLevelType.info,
      eventType: LogEventType.printJobCreated,
      title: 'Print job created',
      message: title,
    );
  }

  Future<void> logPrinterTestResult(String message) {
    return log(
      level: LogLevelType.info,
      eventType: LogEventType.printerTestResult,
      title: 'Printer test result',
      message: message,
    );
  }
}
