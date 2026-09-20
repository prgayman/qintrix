import 'package:qintrix/data/models/exports.dart';
import 'package:qintrix/theme/tokens/color_tokens.dart';

enum AppsStatus { initial, loading, loaded, saving, failure }

enum AppsViewMode { listing, create, edit, show }

class AppsFeedback {
  const AppsFeedback({
    required this.id,
    required this.message,
    required this.tone,
    this.title,
  });

  final int id;
  final String? title;
  final String message;
  final AppStatusTone tone;
}

class AppsState {
  const AppsState({
    required this.status,
    required this.mode,
    this.errorMessage,
    this.apps = const [],
    this.query = const AppsQuery(),
    this.totalCount = 0,
    this.availablePrinters = const [],
    this.selectedIds = const <String>{},
    this.activeApp,
    this.feedback,
  });

  const AppsState.initial()
    : this(status: AppsStatus.initial, mode: AppsViewMode.listing);

  final AppsStatus status;
  final AppsViewMode mode;
  final String? errorMessage;
  final List<AppModel> apps;
  final AppsQuery query;
  final int totalCount;
  final List<PrinterModel> availablePrinters;
  final Set<String> selectedIds;
  final AppModel? activeApp;
  final AppsFeedback? feedback;

  AppsState copyWith({
    AppsStatus? status,
    AppsViewMode? mode,
    Object? errorMessage = _sentinel,
    List<AppModel>? apps,
    AppsQuery? query,
    int? totalCount,
    List<PrinterModel>? availablePrinters,
    Set<String>? selectedIds,
    Object? activeApp = _sentinel,
    Object? feedback = _sentinel,
  }) {
    return AppsState(
      status: status ?? this.status,
      mode: mode ?? this.mode,
      errorMessage: identical(errorMessage, _sentinel)
          ? this.errorMessage
          : errorMessage as String?,
      apps: apps ?? this.apps,
      query: query ?? this.query,
      totalCount: totalCount ?? this.totalCount,
      availablePrinters: availablePrinters ?? this.availablePrinters,
      selectedIds: selectedIds ?? this.selectedIds,
      activeApp: identical(activeApp, _sentinel)
          ? this.activeApp
          : activeApp as AppModel?,
      feedback: identical(feedback, _sentinel)
          ? this.feedback
          : feedback as AppsFeedback?,
    );
  }
}

const Object _sentinel = Object();
