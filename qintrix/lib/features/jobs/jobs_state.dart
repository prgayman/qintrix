import 'package:qintrix/data/models/exports.dart';
import 'package:qintrix/theme/tokens/color_tokens.dart';

enum JobsStatus { initial, loading, loaded, failure, processing }

class JobsFeedback {
  const JobsFeedback({
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

class JobsState {
  const JobsState({
    required this.status,
    required this.jobs,
    required this.query,
    required this.totalCount,
    required this.printerNamesById,
    this.activeJob,
    this.message,
    this.feedback,
  });

  const JobsState.initial()
    : this(
        status: JobsStatus.initial,
        jobs: const <PrintJobModel>[],
        query: const JobsQuery(),
        totalCount: 0,
        printerNamesById: const <String, String>{},
      );

  final JobsStatus status;
  final List<PrintJobModel> jobs;
  final JobsQuery query;
  final int totalCount;
  final Map<String, String> printerNamesById;
  final PrintJobModel? activeJob;
  final String? message;
  final JobsFeedback? feedback;

  JobsState copyWith({
    JobsStatus? status,
    List<PrintJobModel>? jobs,
    JobsQuery? query,
    int? totalCount,
    Map<String, String>? printerNamesById,
    PrintJobModel? activeJob,
    bool clearActiveJob = false,
    String? message,
    Object? feedback = _sentinel,
  }) {
    return JobsState(
      status: status ?? this.status,
      jobs: jobs ?? this.jobs,
      query: query ?? this.query,
      totalCount: totalCount ?? this.totalCount,
      printerNamesById: printerNamesById ?? this.printerNamesById,
      activeJob: clearActiveJob ? null : activeJob ?? this.activeJob,
      message: message,
      feedback: identical(feedback, _sentinel)
          ? this.feedback
          : feedback as JobsFeedback?,
    );
  }
}

const Object _sentinel = Object();
