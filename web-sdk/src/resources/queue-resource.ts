import { HttpClient } from '../http/http-client.js';
import type { QueueStatus } from '../types/queue.js';

export class QueueResource {
  constructor(private readonly httpClient: HttpClient) {}

  getStatus(): Promise<QueueStatus> {
    return this.httpClient.get<QueueStatus>('/queue/status');
  }

  pause(): Promise<QueueStatus> {
    return this.httpClient.post<QueueStatus>('/queue/pause');
  }

  resume(): Promise<QueueStatus> {
    return this.httpClient.post<QueueStatus>('/queue/resume');
  }
}

