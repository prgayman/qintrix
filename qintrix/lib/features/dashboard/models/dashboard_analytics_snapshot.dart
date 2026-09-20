import 'package:qintrix/data/repositories/exports.dart';

class DashboardAnalyticsSnapshot {
  const DashboardAnalyticsSnapshot({
    required this.serverState,
    required this.totalJobs,
    required this.completedJobs,
    required this.failedJobs,
    required this.queuedJobs,
    required this.processingJobs,
    required this.totalPrinters,
    required this.enabledPrinters,
    required this.totalApps,
    required this.enabledApps,
    required this.restrictedApps,
    required this.recentErrorCount,
    required this.recentWarningCount,
    required this.completionRate,
    required this.dailyJobs,
    required this.statusBreakdown,
    required this.connectionBreakdown,
    required this.contentBreakdown,
  });

  final ServerStateModel serverState;
  final int totalJobs;
  final int completedJobs;
  final int failedJobs;
  final int queuedJobs;
  final int processingJobs;
  final int totalPrinters;
  final int enabledPrinters;
  final int totalApps;
  final int enabledApps;
  final int restrictedApps;
  final int recentErrorCount;
  final int recentWarningCount;
  final double completionRate;
  final List<DashboardTrendPoint> dailyJobs;
  final List<DashboardBreakdownValue> statusBreakdown;
  final List<DashboardBreakdownValue> connectionBreakdown;
  final List<DashboardBreakdownValue> contentBreakdown;

  int get totalAlerts => recentErrorCount + recentWarningCount;
}

class DashboardTrendPoint {
  const DashboardTrendPoint({required this.day, required this.value});

  final DateTime day;
  final int value;
}

class DashboardBreakdownValue {
  const DashboardBreakdownValue({
    required this.key,
    required this.value,
    required this.share,
  });

  final String key;
  final int value;
  final double share;
}
