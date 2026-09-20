enum QueueRunState { running, paused }

enum PrinterWorkerState { idle, processing, paused, error }

class PrinterWorkerStatus {
  const PrinterWorkerStatus({
    required this.printerId,
    required this.state,
    this.activeJobId,
    this.errorMessage,
  });

  final String printerId;
  final PrinterWorkerState state;
  final String? activeJobId;
  final String? errorMessage;
}

class QueueStatusModel {
  const QueueStatusModel({
    required this.state,
    required this.workers,
  });

  final QueueRunState state;
  final List<PrinterWorkerStatus> workers;
}
