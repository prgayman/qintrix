import 'package:qintrix/data/models/exports.dart';

abstract class PrintJobsRepository {
  Future<List<PrintJobModel>> getPrintJobs();

  Future<PagedResult<PrintJobModel>> queryPrintJobs(JobsQuery query);

  Future<PrintJobModel?> getPrintJobById(String id);

  Future<PrintJobModel?> getPrintJobByIdempotencyKey(
    String appId,
    String idempotencyKey,
  );

  Future<List<PrintJobModel>> getPendingPrintJobs();

  Future<void> savePrintJob(PrintJobModel printJob);

  Future<void> deletePrintJobs(List<String> ids);
}
