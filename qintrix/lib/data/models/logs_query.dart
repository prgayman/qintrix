class LogsQuery {
  const LogsQuery({
    this.search = '',
    this.level = '',
    this.eventType = '',
    this.page = 0,
    this.pageSize = 10,
  });

  final String search;
  final String level;
  final String eventType;
  final int page;
  final int pageSize;

  int get offset => page * pageSize;

  LogsQuery copyWith({
    String? search,
    String? level,
    String? eventType,
    int? page,
    int? pageSize,
  }) {
    return LogsQuery(
      search: search ?? this.search,
      level: level ?? this.level,
      eventType: eventType ?? this.eventType,
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
    );
  }
}
