class PrintersQuery {
  const PrintersQuery({
    this.search = '',
    this.connectionType = '',
    this.status = '',
    this.page = 0,
    this.pageSize = 10,
  });

  final String search;
  final String connectionType;
  final String status;
  final int page;
  final int pageSize;

  int get offset => page * pageSize;

  PrintersQuery copyWith({
    String? search,
    String? connectionType,
    String? status,
    int? page,
    int? pageSize,
  }) {
    return PrintersQuery(
      search: search ?? this.search,
      connectionType: connectionType ?? this.connectionType,
      status: status ?? this.status,
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
    );
  }
}
