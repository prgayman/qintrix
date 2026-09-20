import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qintrix/data/models/exports.dart';
import 'package:qintrix/data/repositories/exports.dart';

import 'logs_state.dart';

class LogsCubit extends Cubit<LogsState> {
  LogsCubit({required LogsRepository logsRepository})
    : _logsRepository = logsRepository,
      super(const LogsState.initial());

  final LogsRepository _logsRepository;

  Future<void> load({bool reset = false}) async {
    final query = reset ? const LogsQuery() : state.query;
    emit(
      state.copyWith(
        status: LogsStatus.loading,
        message: null,
        query: query,
      ),
    );

    try {
      final result = await _logsRepository.queryLogs(query);
      emit(
        state.copyWith(
          status: LogsStatus.loaded,
          logs: result.items,
          totalCount: result.totalCount,
          query: query,
          message: null,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(status: LogsStatus.failure, message: error.toString()),
      );
    }
  }

  Future<void> updateSearch(String value) {
    return _loadQuery(state.query.copyWith(search: value, page: 0));
  }

  Future<void> updateLevel(String value) {
    return _loadQuery(state.query.copyWith(level: value, page: 0));
  }

  Future<void> updateEventType(String value) {
    return _loadQuery(state.query.copyWith(eventType: value, page: 0));
  }

  Future<void> resetFilters() {
    return _loadQuery(const LogsQuery());
  }

  Future<void> updatePage(int page) {
    return _loadQuery(state.query.copyWith(page: page));
  }

  Future<void> updateRowsPerPage(int pageSize) {
    return _loadQuery(state.query.copyWith(pageSize: pageSize, page: 0));
  }

  Future<void> _loadQuery(LogsQuery query) async {
    emit(state.copyWith(status: LogsStatus.loading, message: null, query: query));
    try {
      final result = await _logsRepository.queryLogs(query);
      emit(
        state.copyWith(
          status: LogsStatus.loaded,
          logs: result.items,
          totalCount: result.totalCount,
          query: query,
          message: null,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(status: LogsStatus.failure, message: error.toString()),
      );
    }
  }
}
