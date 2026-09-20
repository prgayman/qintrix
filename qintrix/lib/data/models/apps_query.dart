class AppsQuery {
  const AppsQuery({
    this.search = '',
    this.status = '',
    this.scope = '',
    this.page = 0,
    this.pageSize = 10,
  });

  final String search;
  final String status;
  final String scope;
  final int page;
  final int pageSize;

  int get offset => page * pageSize;

  AppsQuery copyWith({
    String? search,
    String? status,
    String? scope,
    int? page,
    int? pageSize,
  }) {
    return AppsQuery(
      search: search ?? this.search,
      status: status ?? this.status,
      scope: scope ?? this.scope,
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
    );
  }
}
