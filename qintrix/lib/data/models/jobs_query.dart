class JobsQuery {
  const JobsQuery({
    this.search = '',
    this.status = '',
    this.printerId = '',
    this.contentType = '',
    this.referenceType = '',
    this.referenceId = '',
    this.sortBy = 'createdAt',
    this.sortDirection = 'desc',
    this.page = 0,
    this.pageSize = 10,
  });

  final String search;
  final String status;
  final String printerId;
  final String contentType;
  final String referenceType;
  final String referenceId;
  final String sortBy;
  final String sortDirection;
  final int page;
  final int pageSize;

  int get offset => page * pageSize;

  JobsQuery copyWith({
    String? search,
    String? status,
    String? printerId,
    String? contentType,
    String? referenceType,
    String? referenceId,
    String? sortBy,
    String? sortDirection,
    int? page,
    int? pageSize,
  }) {
    return JobsQuery(
      search: search ?? this.search,
      status: status ?? this.status,
      printerId: printerId ?? this.printerId,
      contentType: contentType ?? this.contentType,
      referenceType: referenceType ?? this.referenceType,
      referenceId: referenceId ?? this.referenceId,
      sortBy: sortBy ?? this.sortBy,
      sortDirection: sortDirection ?? this.sortDirection,
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
    );
  }
}
