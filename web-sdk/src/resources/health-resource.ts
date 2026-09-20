import type { HealthResponse } from '../types/health.js';
import { HttpClient } from '../http/http-client.js';

export class HealthResource {
  constructor(private readonly httpClient: HttpClient) {}

  get(): Promise<HealthResponse> {
    return this.httpClient.get<HealthResponse>('/health', { auth: false });
  }
}

