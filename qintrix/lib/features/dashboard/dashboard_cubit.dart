import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qintrix/data/models/exports.dart';
import 'package:qintrix/data/repositories/exports.dart';
import 'package:qintrix/features/dashboard/dashboard_state.dart';
import 'package:qintrix/features/dashboard/models/dashboard_analytics_snapshot.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit({
    required ServerRepository serverRepository,
    required PrintersRepository printersRepository,
    required AppsRepository appsRepository,
    required PrintJobsRepository printJobsRepository,
    required LogsRepository logsRepository,
  }) : _serverRepository = serverRepository,
       _printersRepository = printersRepository,
       _appsRepository = appsRepository,
       _printJobsRepository = printJobsRepository,
       _logsRepository = logsRepository,
       super(const DashboardState.initial());

  final ServerRepository _serverRepository;
  final PrintersRepository _printersRepository;
  final AppsRepository _appsRepository;
  final PrintJobsRepository _printJobsRepository;
  final LogsRepository _logsRepository;

  Future<void> load() async {
    emit(
      state.copyWith(
        status: DashboardStatus.loading,
        clearErrorMessage: true,
      ),
    );

    try {
      final results = await Future.wait([
        _serverRepository.getState(),
        _printersRepository.getPrinters(),
        _appsRepository.getApps(),
        _printJobsRepository.getPrintJobs(),
        _logsRepository.getLogs(limit: 120),
      ]);

      final snapshot = _buildSnapshot(
        serverState: results[0] as ServerStateModel,
        printers: results[1] as List<PrinterModel>,
        apps: results[2] as List<AppModel>,
        jobs: results[3] as List<PrintJobModel>,
        logs: results[4] as List<AppLogModel>,
      );

      emit(
        state.copyWith(
          status: DashboardStatus.success,
          snapshot: snapshot,
          clearErrorMessage: true,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: DashboardStatus.failure,
          errorMessage: error.toString(),
        ),
      );
    }
  }

  DashboardAnalyticsSnapshot _buildSnapshot({
    required ServerStateModel serverState,
    required List<PrinterModel> printers,
    required List<AppModel> apps,
    required List<PrintJobModel> jobs,
    required List<AppLogModel> logs,
  }) {
    final now = DateTime.now();
    final enabledPrinters = printers.where((printer) => printer.isEnabled).length;
    final enabledApps = apps.where((app) => app.isEnabled).length;
    final restrictedApps = apps.where((app) => !app.allowsAllPrinters).length;

    final completedJobs = jobs
        .where((job) => job.status == PrintJobStatus.completed)
        .length;
    final failedJobs = jobs
        .where(
          (job) =>
              job.status == PrintJobStatus.failed ||
              job.status == PrintJobStatus.canceled,
        )
        .length;
    final queuedJobs = jobs
        .where(
          (job) =>
              job.status == PrintJobStatus.accepted ||
              job.status == PrintJobStatus.rendering ||
              job.status == PrintJobStatus.queued ||
              job.status == PrintJobStatus.retryScheduled,
        )
        .length;
    final processingJobs = jobs
        .where((job) => job.status == PrintJobStatus.processing)
        .length;

    final finalizedJobs = completedJobs + failedJobs;
    final completionRate = finalizedJobs == 0
        ? 0.0
        : completedJobs / finalizedJobs;

    final recentErrorCount = logs
        .where((log) => log.level.toLowerCase().contains('error'))
        .length;
    final recentWarningCount = logs
        .where((log) => log.level.toLowerCase().contains('warn'))
        .length;

    return DashboardAnalyticsSnapshot(
      serverState: serverState,
      totalJobs: jobs.length,
      completedJobs: completedJobs,
      failedJobs: failedJobs,
      queuedJobs: queuedJobs,
      processingJobs: processingJobs,
      totalPrinters: printers.length,
      enabledPrinters: enabledPrinters,
      totalApps: apps.length,
      enabledApps: enabledApps,
      restrictedApps: restrictedApps,
      recentErrorCount: recentErrorCount,
      recentWarningCount: recentWarningCount,
      completionRate: completionRate,
      dailyJobs: _buildDailyJobs(jobs, now),
      statusBreakdown: _buildStatusBreakdown(jobs),
      connectionBreakdown: _buildConnectionBreakdown(printers),
      contentBreakdown: _buildContentBreakdown(jobs),
    );
  }

  List<DashboardTrendPoint> _buildDailyJobs(
    List<PrintJobModel> jobs,
    DateTime now,
  ) {
    final points = <DashboardTrendPoint>[];

    for (var index = 6; index >= 0; index--) {
      final day = DateTime(
        now.year,
        now.month,
        now.day,
      ).subtract(Duration(days: index));
      final count = jobs.where((job) {
        final created = job.createdAt;
        return created.year == day.year &&
            created.month == day.month &&
            created.day == day.day;
      }).length;
      points.add(DashboardTrendPoint(day: day, value: count));
    }

    return points;
  }

  List<DashboardBreakdownValue> _buildStatusBreakdown(List<PrintJobModel> jobs) {
    final counts = <String, int>{
      PrintJobStatus.completed.value: 0,
      PrintJobStatus.processing.value: 0,
      PrintJobStatus.queued.value: 0,
      PrintJobStatus.failed.value: 0,
    };

    for (final job in jobs) {
      final key = switch (job.status) {
        PrintJobStatus.completed => PrintJobStatus.completed.value,
        PrintJobStatus.processing => PrintJobStatus.processing.value,
        PrintJobStatus.failed || PrintJobStatus.canceled =>
          PrintJobStatus.failed.value,
        _ => PrintJobStatus.queued.value,
      };
      counts.update(key, (value) => value + 1);
    }

    return _mapBreakdown(counts);
  }

  List<DashboardBreakdownValue> _buildConnectionBreakdown(
    List<PrinterModel> printers,
  ) {
    final counts = <String, int>{
      PrinterConnectionType.networkTcp.value: 0,
      PrinterConnectionType.systemSpooler.value: 0,
      PrinterConnectionType.usbRawEscPos.value: 0,
    };

    for (final printer in printers) {
      counts.update(printer.connectionType.value, (value) => value + 1);
    }

    return _mapBreakdown(counts);
  }

  List<DashboardBreakdownValue> _buildContentBreakdown(
    List<PrintJobModel> jobs,
  ) {
    final counts = <String, int>{
      'text': 0,
      'pdf': 0,
      'image': 0,
    };

    for (final job in jobs) {
      final key = (job.contentType ?? '').toLowerCase();
      if (counts.containsKey(key)) {
        counts.update(key, (value) => value + 1);
      }
    }

    return _mapBreakdown(counts);
  }

  List<DashboardBreakdownValue> _mapBreakdown(Map<String, int> counts) {
    final total = counts.values.fold<int>(0, (sum, value) => sum + value);

    return counts.entries
        .map(
          (entry) => DashboardBreakdownValue(
            key: entry.key,
            value: entry.value,
            share: total == 0 ? 0 : entry.value / total,
          ),
        )
        .toList(growable: false);
  }
}
