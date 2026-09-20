enum PrintJobStatus {
  accepted('accepted'),
  rendering('rendering'),
  queued('queued'),
  processing('processing'),
  completed('completed'),
  failed('failed'),
  canceled('canceled'),
  retryScheduled('retry_scheduled');

  const PrintJobStatus(this.value);

  final String value;

  static PrintJobStatus fromValue(String value) {
    return PrintJobStatus.values.firstWhere(
      (status) => status.value == value,
      orElse: () => PrintJobStatus.failed,
    );
  }
}

enum PrintJobFailureCategory {
  validation('validation_failure'),
  render('render_failure'),
  execution('execution_failure'),
  queue('queue_failure'),
  auth('auth_failure');

  const PrintJobFailureCategory(this.value);

  final String value;

  static PrintJobFailureCategory? fromValue(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }

    for (final item in PrintJobFailureCategory.values) {
      if (item.value == value) {
        return item;
      }
    }

    return null;
  }
}

class PrintJobModel {
  const PrintJobModel({
    required this.id,
    required this.title,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.printerId,
    this.appId,
    this.contentType,
    this.copies = 1,
    this.payloadSourceType,
    this.payloadSummary,
    this.artifactPath,
    this.artifactMimeType,
    this.artifactSize,
    this.artifactCreatedAt,
    this.artifactChecksum,
    this.optionsJson,
    this.metaJson,
    this.referenceType,
    this.referenceId,
    this.source,
    this.idempotencyKey,
    this.failureCategory,
    this.failureMessage,
    this.retryCount = 0,
    this.lastRetryAt,
    this.nextRetryAt,
    this.queuedAt,
    this.startedAt,
    this.completedAt,
    this.canceledAt,
  });

  final String id;
  final String? printerId;
  final String? appId;
  final String title;
  final PrintJobStatus status;
  final String? contentType;
  final int copies;
  final String? payloadSourceType;
  final String? payloadSummary;
  final String? artifactPath;
  final String? artifactMimeType;
  final int? artifactSize;
  final DateTime? artifactCreatedAt;
  final String? artifactChecksum;
  final String? optionsJson;
  final String? metaJson;
  final String? referenceType;
  final String? referenceId;
  final String? source;
  final String? idempotencyKey;
  final PrintJobFailureCategory? failureCategory;
  final String? failureMessage;
  final int retryCount;
  final DateTime? lastRetryAt;
  final DateTime? nextRetryAt;
  final DateTime? queuedAt;
  final DateTime? startedAt;
  final DateTime? completedAt;
  final DateTime? canceledAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  bool get isRetryable =>
      status == PrintJobStatus.failed || status == PrintJobStatus.canceled;

  bool get isCancelable =>
      status == PrintJobStatus.queued || status == PrintJobStatus.retryScheduled;

  PrintJobModel copyWith({
    String? id,
    String? printerId,
    String? appId,
    String? title,
    PrintJobStatus? status,
    String? contentType,
    int? copies,
    String? payloadSourceType,
    String? payloadSummary,
    String? artifactPath,
    String? artifactMimeType,
    int? artifactSize,
    DateTime? artifactCreatedAt,
    String? artifactChecksum,
    String? optionsJson,
    String? metaJson,
    String? referenceType,
    String? referenceId,
    String? source,
    String? idempotencyKey,
    PrintJobFailureCategory? failureCategory,
    bool clearFailureCategory = false,
    String? failureMessage,
    bool clearFailureMessage = false,
    int? retryCount,
    DateTime? lastRetryAt,
    bool clearLastRetryAt = false,
    DateTime? nextRetryAt,
    bool clearNextRetryAt = false,
    DateTime? queuedAt,
    bool clearQueuedAt = false,
    DateTime? startedAt,
    bool clearStartedAt = false,
    DateTime? completedAt,
    bool clearCompletedAt = false,
    DateTime? canceledAt,
    bool clearCanceledAt = false,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return PrintJobModel(
      id: id ?? this.id,
      printerId: printerId ?? this.printerId,
      appId: appId ?? this.appId,
      title: title ?? this.title,
      status: status ?? this.status,
      contentType: contentType ?? this.contentType,
      copies: copies ?? this.copies,
      payloadSourceType: payloadSourceType ?? this.payloadSourceType,
      payloadSummary: payloadSummary ?? this.payloadSummary,
      artifactPath: artifactPath ?? this.artifactPath,
      artifactMimeType: artifactMimeType ?? this.artifactMimeType,
      artifactSize: artifactSize ?? this.artifactSize,
      artifactCreatedAt: artifactCreatedAt ?? this.artifactCreatedAt,
      artifactChecksum: artifactChecksum ?? this.artifactChecksum,
      optionsJson: optionsJson ?? this.optionsJson,
      metaJson: metaJson ?? this.metaJson,
      referenceType: referenceType ?? this.referenceType,
      referenceId: referenceId ?? this.referenceId,
      source: source ?? this.source,
      idempotencyKey: idempotencyKey ?? this.idempotencyKey,
      failureCategory: clearFailureCategory
          ? null
          : failureCategory ?? this.failureCategory,
      failureMessage: clearFailureMessage
          ? null
          : failureMessage ?? this.failureMessage,
      retryCount: retryCount ?? this.retryCount,
      lastRetryAt: clearLastRetryAt ? null : lastRetryAt ?? this.lastRetryAt,
      nextRetryAt: clearNextRetryAt ? null : nextRetryAt ?? this.nextRetryAt,
      queuedAt: clearQueuedAt ? null : queuedAt ?? this.queuedAt,
      startedAt: clearStartedAt ? null : startedAt ?? this.startedAt,
      completedAt: clearCompletedAt ? null : completedAt ?? this.completedAt,
      canceledAt: clearCanceledAt ? null : canceledAt ?? this.canceledAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
