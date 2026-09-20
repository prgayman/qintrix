import 'package:qintrix/features/dashboard/models/dashboard_analytics_snapshot.dart';

enum DashboardStatus { initial, loading, success, failure }

class DashboardState {
  const DashboardState({
    required this.status,
    this.snapshot,
    this.errorMessage,
  });

  const DashboardState.initial()
    : this(
        status: DashboardStatus.initial,
        snapshot: null,
        errorMessage: null,
      );

  final DashboardStatus status;
  final DashboardAnalyticsSnapshot? snapshot;
  final String? errorMessage;

  DashboardState copyWith({
    DashboardStatus? status,
    DashboardAnalyticsSnapshot? snapshot,
    String? errorMessage,
    bool clearErrorMessage = false,
  }) {
    return DashboardState(
      status: status ?? this.status,
      snapshot: snapshot ?? this.snapshot,
      errorMessage: clearErrorMessage
          ? null
          : errorMessage ?? this.errorMessage,
    );
  }
}
