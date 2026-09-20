import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qintrix/core/services/exports.dart';
import 'package:qintrix/data/models/exports.dart';
import 'package:qintrix/data/repositories/exports.dart';
import 'package:qintrix/l10n/app_localizations.dart';
import 'package:qintrix/theme/tokens/color_tokens.dart';

import 'jobs_state.dart';

class JobsCubit extends Cubit<JobsState> {
  JobsCubit({
    required PrintJobsRepository repository,
    required PrintersRepository printersRepository,
    required PrintQueueService printQueueService,
  }) : _repository = repository,
       _printersRepository = printersRepository,
       _printQueueService = printQueueService,
       super(const JobsState.initial());

  final PrintJobsRepository _repository;
  final PrintersRepository _printersRepository;
  final PrintQueueService _printQueueService;
  Timer? _feedbackTimer;
  int _feedbackId = 0;

  Future<void> load({bool reset = false}) async {
    final query = reset ? const JobsQuery() : state.query;
    emit(
      state.copyWith(
        status: JobsStatus.loading,
        query: query,
        clearActiveJob: reset,
        message: null,
        feedback: null,
      ),
    );
    try {
      final result = await _repository.queryPrintJobs(query);
      final printerNamesById = await _loadPrinterNames();
      emit(
        state.copyWith(
          status: JobsStatus.loaded,
          jobs: result.items,
          totalCount: result.totalCount,
          query: query,
          printerNamesById: printerNamesById,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: JobsStatus.failure, message: error.toString()));
    }
  }

  Future<void> openJob(String id) async {
    final job = await _repository.getPrintJobById(id);
    emit(state.copyWith(activeJob: job, feedback: null));
  }

  void closeJob() => emit(state.copyWith(clearActiveJob: true, feedback: null));

  Future<void> retryJob(String id, AppLocalizations l10n) async {
    emit(state.copyWith(status: JobsStatus.processing, message: null, feedback: null));
    try {
      final job = await _printQueueService.retryJob(id);
      final result = await _repository.queryPrintJobs(state.query);
      emit(
        state.copyWith(
          status: JobsStatus.loaded,
          jobs: result.items,
          totalCount: result.totalCount,
          query: state.query,
          activeJob: state.activeJob != null ? job : null,
        ),
      );
      _emitFeedback(
        l10n.retry,
        l10n.jobsRetrySuccess,
        tone: AppStatusTone.success,
      );
    } catch (error) {
      emit(state.copyWith(status: JobsStatus.failure, message: error.toString()));
      _emitFeedback(
        l10n.retry,
        error.toString(),
        tone: AppStatusTone.error,
      );
    }
  }

  Future<void> cancelJob(String id, AppLocalizations l10n) async {
    emit(state.copyWith(status: JobsStatus.processing, message: null, feedback: null));
    try {
      final job = await _printQueueService.cancelJob(id);
      final result = await _repository.queryPrintJobs(state.query);
      emit(
        state.copyWith(
          status: JobsStatus.loaded,
          jobs: result.items,
          totalCount: result.totalCount,
          query: state.query,
          activeJob: state.activeJob != null ? job : null,
        ),
      );
      _emitFeedback(
        l10n.cancel,
        l10n.jobsCancelSuccess,
        tone: AppStatusTone.success,
      );
    } catch (error) {
      emit(state.copyWith(status: JobsStatus.failure, message: error.toString()));
      _emitFeedback(
        l10n.cancel,
        error.toString(),
        tone: AppStatusTone.error,
      );
    }
  }

  Future<void> updateSearch(String value) =>
      _reloadWith(state.query.copyWith(search: value, page: 0));
  Future<void> updateStatus(String value) =>
      _reloadWith(state.query.copyWith(status: value, page: 0));
  Future<void> updatePrinter(String value) =>
      _reloadWith(state.query.copyWith(printerId: value, page: 0));
  Future<void> updateContentType(String value) =>
      _reloadWith(state.query.copyWith(contentType: value, page: 0));
  Future<void> updatePage(int page) =>
      _reloadWith(state.query.copyWith(page: page));
  Future<void> updateRowsPerPage(int pageSize) =>
      _reloadWith(state.query.copyWith(pageSize: pageSize, page: 0));
  Future<void> resetFilters() => _reloadWith(const JobsQuery());

  Future<void> _reloadWith(JobsQuery query) async {
    emit(
      state.copyWith(
        status: JobsStatus.loading,
        query: query,
        message: null,
        feedback: null,
      ),
    );
    try {
      final result = await _repository.queryPrintJobs(query);
      final printerNamesById = await _loadPrinterNames();
      emit(
        state.copyWith(
          status: JobsStatus.loaded,
          jobs: result.items,
          totalCount: result.totalCount,
          query: query,
          printerNamesById: printerNamesById,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: JobsStatus.failure, message: error.toString()));
    }
  }

  Future<Map<String, String>> _loadPrinterNames() async {
    final printers = await _printersRepository.getPrinters();
    return {
      for (final printer in printers)
        if (printer.id.trim().isNotEmpty) printer.id: printer.name,
    };
  }

  void _emitFeedback(
    String title,
    String message, {
    required AppStatusTone tone,
  }) {
    _feedbackTimer?.cancel();
    final feedback = JobsFeedback(
      id: ++_feedbackId,
      title: title,
      message: message,
      tone: tone,
    );
    emit(state.copyWith(feedback: feedback));
    _feedbackTimer = Timer(const Duration(seconds: 3), () {
      if (state.feedback?.id == feedback.id) {
        emit(state.copyWith(feedback: null));
      }
    });
  }

  @override
  Future<void> close() {
    _feedbackTimer?.cancel();
    return super.close();
  }
}
