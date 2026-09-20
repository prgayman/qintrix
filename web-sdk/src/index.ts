export { QintrixClient } from './client/qintrix-client.js';
export { QintrixApiError } from './http/api-error.js';

export type { QintrixClientConfig } from './types/client.js';
export type { HealthResponse, HealthServerState } from './types/health.js';
export type {
  PrinterConnectionType,
  PrinterSummary,
  PrinterDetails,
  PrinterConnectionDetails,
  PrinterTestResult,
} from './types/printers.js';
export type {
  PrintJobStatus,
  PrintJobFailureCategory,
  PrintJobSummary,
  PrintJobDetails,
  JobsListQuery,
  JobsListResult,
  CreatePrintJobInput,
  CreateTextPrintJobInput,
  CreatePdfPrintJobInput,
  CreateImagePrintJobInput,
  PrintJobPayloadMeta,
  PrintJobOptions,
} from './types/jobs.js';
export type {
  QueueRunState,
  QueueWorkerState,
  QueueWorkerStatus,
  QueueStatus,
} from './types/queue.js';
