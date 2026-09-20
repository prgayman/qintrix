import { QintrixApiError } from './api-error.js';
import type { QintrixClientConfig } from '../types/client.js';
import type { QueryValue } from '../utils/query.js';
import { buildQueryString, joinUrl } from '../utils/query.js';

interface RequestOptions {
  query?: Record<string, QueryValue>;
  body?: unknown;
  headers?: HeadersInit;
  auth?: boolean;
}

export class HttpClient {
  private readonly baseUrl: string;
  private readonly apiKey: string | undefined;
  private readonly fetchImpl: typeof fetch;
  private readonly timeoutMs: number | undefined;
  private readonly defaultHeaders: HeadersInit | undefined;

  constructor(config: QintrixClientConfig) {
    this.baseUrl = config.baseUrl.replace(/\/+$/, '');
    this.apiKey = config.apiKey;
    this.fetchImpl = config.fetch ?? this.resolveFetch();
    this.timeoutMs = config.timeoutMs;
    this.defaultHeaders = config.headers;
  }

  async get<T>(path: string, options?: RequestOptions): Promise<T> {
    return this.request<T>('GET', path, options);
  }

  async post<T>(path: string, options?: RequestOptions): Promise<T> {
    return this.request<T>('POST', path, options);
  }

  private resolveFetch(): typeof fetch {
    if (typeof globalThis.fetch !== 'function') {
      throw new Error(
        'No fetch implementation was found. Pass a custom fetch in QintrixClientConfig.',
      );
    }

    return globalThis.fetch.bind(globalThis);
  }

  private async request<T>(
    method: string,
    path: string,
    options: RequestOptions = {},
  ): Promise<T> {
    const url = this.buildUrl(path, options.query);
    const headers = new Headers(this.defaultHeaders);

    if (options.auth !== false && this.apiKey) {
      headers.set('X-API-Key', this.apiKey);
    }

    if (options.headers) {
      new Headers(options.headers).forEach((value, key) => {
        headers.set(key, value);
      });
    }

    const controller = typeof AbortController === 'function'
      ? new AbortController()
      : undefined;
    const timeoutHandle = this.timeoutMs != null && controller != null
      ? globalThis.setTimeout(() => controller.abort(), this.timeoutMs)
      : undefined;

    try {
      const hasJsonBody = options.body !== undefined;
      if (hasJsonBody && !headers.has('Content-Type')) {
        headers.set('Content-Type', 'application/json');
      }

      const requestInit: RequestInit = {
        method,
        headers,
      };

      if (hasJsonBody) {
        requestInit.body = JSON.stringify(options.body);
      }

      if (controller != null) {
        requestInit.signal = controller.signal;
      }

      const response = await this.fetchImpl(url, requestInit);

      if (timeoutHandle != null) {
        globalThis.clearTimeout(timeoutHandle);
      }

      if (response.status === 204) {
        return undefined as T;
      }

      const rawText = await response.text();
      const parsedBody = rawText.length > 0 ? this.safeParseJson(rawText) : undefined;

      if (!response.ok) {
        const errorBody = this.toErrorBody(parsedBody);
        throw new QintrixApiError({
          status: response.status,
          code: typeof errorBody.error === 'string' ? errorBody.error : undefined,
          message:
              typeof errorBody.message === 'string'
                  ? errorBody.message
                  : `${response.status} ${response.statusText}`.trim(),
          body: parsedBody,
        });
      }

      return parsedBody as T;
    } catch (error) {
      if (timeoutHandle != null) {
        globalThis.clearTimeout(timeoutHandle);
      }

      if (error instanceof QintrixApiError) {
        throw error;
      }

      if (error instanceof Error && error.name === 'AbortError') {
        throw new QintrixApiError({
          status: 408,
          code: 'request_timeout',
          message: 'Request timed out.',
        });
      }

      throw error;
    }
  }

  private buildUrl(path: string, query?: Record<string, QueryValue>): string {
    const queryString = query == null ? '' : buildQueryString(query);
    const base = joinUrl(this.baseUrl, path);
    return queryString.length > 0 ? `${base}?${queryString}` : base;
  }

  private safeParseJson(text: string): unknown {
    try {
      return JSON.parse(text) as unknown;
    } catch {
      return text;
    }
  }

  private toErrorBody(
    body: unknown,
  ): { error?: unknown; message?: unknown } {
    if (body != null && typeof body === 'object') {
      return body as { error?: unknown; message?: unknown };
    }

    return {};
  }
}
