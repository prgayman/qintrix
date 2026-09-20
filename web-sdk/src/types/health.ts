export interface HealthServerState {
  isRunning: boolean;
  host: string;
  port: number;
  startedAt?: string | null;
  lastChangedAt?: string | null;
  lastError?: string | null;
}

export interface HealthResponse {
  status: 'ok';
  server: HealthServerState;
  timestamp: string;
  app: string;
}

