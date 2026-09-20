import 'package:qintrix/data/models/exports.dart';
import 'package:qintrix/theme/tokens/color_tokens.dart';

enum PrintersStatus { initial, loading, loaded, saving, failure }

enum PrintersViewMode { listing, create, edit, show }

class PrintersFeedback {
  const PrintersFeedback({
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

class PrintersState {
  const PrintersState({
    required this.status,
    required this.mode,
    this.errorMessage,
    this.printers = const [],
    this.query = const PrintersQuery(),
    this.totalCount = 0,
    this.selectedIds = const <String>{},
    this.activePrinter,
    this.feedback,
  });

  const PrintersState.initial()
    : this(status: PrintersStatus.initial, mode: PrintersViewMode.listing);

  final PrintersStatus status;
  final PrintersViewMode mode;
  final String? errorMessage;
  final List<PrinterModel> printers;
  final PrintersQuery query;
  final int totalCount;
  final Set<String> selectedIds;
  final PrinterModel? activePrinter;
  final PrintersFeedback? feedback;

  bool get isBusy =>
      status == PrintersStatus.loading || status == PrintersStatus.saving;

  PrintersState copyWith({
    PrintersStatus? status,
    PrintersViewMode? mode,
    Object? errorMessage = _sentinel,
    List<PrinterModel>? printers,
    PrintersQuery? query,
    int? totalCount,
    Set<String>? selectedIds,
    Object? activePrinter = _sentinel,
    Object? feedback = _sentinel,
  }) {
    return PrintersState(
      status: status ?? this.status,
      mode: mode ?? this.mode,
      errorMessage: identical(errorMessage, _sentinel)
          ? this.errorMessage
          : errorMessage as String?,
      printers: printers ?? this.printers,
      query: query ?? this.query,
      totalCount: totalCount ?? this.totalCount,
      selectedIds: selectedIds ?? this.selectedIds,
      activePrinter: identical(activePrinter, _sentinel)
          ? this.activePrinter
          : activePrinter as PrinterModel?,
      feedback: identical(feedback, _sentinel)
          ? this.feedback
          : feedback as PrintersFeedback?,
    );
  }
}

const Object _sentinel = Object();
