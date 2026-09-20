import 'package:drift/drift.dart';
import 'package:qintrix/data/database/app_database.dart';
import 'package:qintrix/data/models/exports.dart';

import '../contracts/print_jobs_repository.dart';

class DriftPrintJobsRepository implements PrintJobsRepository {
  DriftPrintJobsRepository(this._printJobsDao);

  final PrintJobsDao _printJobsDao;

  @override
  Future<List<PrintJobModel>> getPrintJobs() async {
    final rows = await _printJobsDao.getPrintJobs();
    return rows.map(_mapJob).toList(growable: false);
  }

  @override
  Future<PagedResult<PrintJobModel>> queryPrintJobs(JobsQuery query) async {
    final results = await Future.wait([
      _printJobsDao.queryPrintJobs(query),
      _printJobsDao.countPrintJobs(query),
    ]);
    final rows = results[0] as List<PrintJobsTableData>;
    final totalCount = results[1] as int;

    return PagedResult<PrintJobModel>(
      items: rows.map(_mapJob).toList(growable: false),
      totalCount: totalCount,
      page: query.page,
      pageSize: query.pageSize,
    );
  }

  @override
  Future<PrintJobModel?> getPrintJobById(String id) async {
    final row = await _printJobsDao.getPrintJobById(id);
    return row == null ? null : _mapJob(row);
  }

  @override
  Future<PrintJobModel?> getPrintJobByIdempotencyKey(
    String appId,
    String idempotencyKey,
  ) async {
    final row = await _printJobsDao.getPrintJobByIdempotencyKey(
      appId,
      idempotencyKey,
    );
    return row == null ? null : _mapJob(row);
  }

  @override
  Future<List<PrintJobModel>> getPendingPrintJobs() async {
    final rows = await _printJobsDao.getPendingPrintJobs();
    return rows.map(_mapJob).toList(growable: false);
  }

  @override
  Future<void> savePrintJob(PrintJobModel printJob) {
    return _printJobsDao.upsertPrintJob(
      PrintJobsTableCompanion(
        id: Value(printJob.id),
        printerId: Value(printJob.printerId),
        appId: Value(printJob.appId),
        title: Value(printJob.title),
        status: Value(printJob.status.value),
        contentType: Value(printJob.contentType),
        copies: Value(printJob.copies),
        payloadSourceType: Value(printJob.payloadSourceType),
        payloadSummary: Value(printJob.payloadSummary),
        artifactPath: Value(printJob.artifactPath),
        artifactMimeType: Value(printJob.artifactMimeType),
        artifactSize: Value(printJob.artifactSize),
        artifactCreatedAt: Value(printJob.artifactCreatedAt),
        artifactChecksum: Value(printJob.artifactChecksum),
        optionsJson: Value(printJob.optionsJson),
        metaJson: Value(printJob.metaJson),
        referenceType: Value(printJob.referenceType),
        referenceId: Value(printJob.referenceId),
        source: Value(printJob.source),
        idempotencyKey: Value(printJob.idempotencyKey),
        failureCategory: Value(printJob.failureCategory?.value),
        failureMessage: Value(printJob.failureMessage),
        retryCount: Value(printJob.retryCount),
        lastRetryAt: Value(printJob.lastRetryAt),
        nextRetryAt: Value(printJob.nextRetryAt),
        queuedAt: Value(printJob.queuedAt),
        startedAt: Value(printJob.startedAt),
        completedAt: Value(printJob.completedAt),
        canceledAt: Value(printJob.canceledAt),
        createdAt: Value(printJob.createdAt),
        updatedAt: Value(printJob.updatedAt),
      ),
    );
  }

  @override
  Future<void> deletePrintJobs(List<String> ids) {
    return _printJobsDao.deletePrintJobs(ids);
  }

  PrintJobModel _mapJob(PrintJobsTableData row) {
    return PrintJobModel(
      id: row.id,
      printerId: row.printerId,
      appId: row.appId,
      title: row.title,
      status: PrintJobStatus.fromValue(row.status),
      contentType: row.contentType,
      copies: row.copies,
      payloadSourceType: row.payloadSourceType,
      payloadSummary: row.payloadSummary,
      artifactPath: row.artifactPath,
      artifactMimeType: row.artifactMimeType,
      artifactSize: row.artifactSize,
      artifactCreatedAt: row.artifactCreatedAt,
      artifactChecksum: row.artifactChecksum,
      optionsJson: row.optionsJson,
      metaJson: row.metaJson,
      referenceType: row.referenceType,
      referenceId: row.referenceId,
      source: row.source,
      idempotencyKey: row.idempotencyKey,
      failureCategory: PrintJobFailureCategory.fromValue(row.failureCategory),
      failureMessage: row.failureMessage,
      retryCount: row.retryCount,
      lastRetryAt: row.lastRetryAt,
      nextRetryAt: row.nextRetryAt,
      queuedAt: row.queuedAt,
      startedAt: row.startedAt,
      completedAt: row.completedAt,
      canceledAt: row.canceledAt,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
    );
  }
}
