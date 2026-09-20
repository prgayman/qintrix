export type QueueRunState = 'running' | 'paused';
export type QueueWorkerState = 'idle' | 'processing' | 'paused' | 'error';

export interface QueueWorkerStatus {
  printerId: string;
  state: QueueWorkerState;
  activeJobId?: string | null;
  errorMessage?: string | null;
}

export interface QueueStatus {
  state: QueueRunState;
  workers: QueueWorkerStatus[];
}

