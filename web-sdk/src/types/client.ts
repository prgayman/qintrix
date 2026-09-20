export interface QintrixClientConfig {
  baseUrl: string;
  apiKey?: string;
  fetch?: typeof fetch;
  timeoutMs?: number;
  headers?: HeadersInit;
}

