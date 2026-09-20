export interface QintrixApiErrorOptions {
  status: number;
  code?: string | undefined;
  message: string;
  body?: unknown;
}

export class QintrixApiError extends Error {
  readonly status: number;
  readonly code: string | undefined;
  readonly body: unknown;

  constructor(options: QintrixApiErrorOptions) {
    super(options.message);
    this.name = 'QintrixApiError';
    this.status = options.status;
    this.code = options.code;
    this.body = options.body;
  }
}
