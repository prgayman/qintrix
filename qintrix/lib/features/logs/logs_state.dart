import 'package:qintrix/data/models/exports.dart';

enum LogsStatus { initial, loading, loaded, failure }

class LogsState {
  const LogsState({
    required this.status,
    this.logs = const [],
    this.message,
    this.query = const LogsQuery(),
    this.totalCount = 0,
  });

  const LogsState.initial() : this(status: LogsStatus.initial);

  final LogsStatus status;
  final List<AppLogModel> logs;
  final String? message;
  final LogsQuery query;
  final int totalCount;

  LogsState copyWith({
    LogsStatus? status,
    List<AppLogModel>? logs,
    String? message,
    LogsQuery? query,
    int? totalCount,
  }) {
    return LogsState(
      status: status ?? this.status,
      logs: logs ?? this.logs,
      message: message ?? this.message,
      query: query ?? this.query,
      totalCount: totalCount ?? this.totalCount,
    );
  }
}
