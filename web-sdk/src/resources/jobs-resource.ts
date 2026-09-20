import { HttpClient } from '../http/http-client.js';
import type {
  CreatePrintJobInput,
  JobsListQuery,
  JobsListResult,
  PrintJobDetails,
} from '../types/jobs.js';

interface JobEnvelope {
  job: PrintJobDetails;
}

export class JobsResource {
  constructor(private readonly httpClient: HttpClient) {}

  async create(input: CreatePrintJobInput): Promise<PrintJobDetails> {
    const response = await this.httpClient.post<JobEnvelope>('/print-jobs', {
      body: {
        printerId: input.printerId,
        contentType: input.contentType,
        copies: input.copies ?? 1,
        payload: input.payload,
        options: input.options,
        meta: input.meta,
        idempotencyKey: input.idempotencyKey,
      },
    });

    return response.job;
  }

  list(query: JobsListQuery = {}): Promise<JobsListResult> {
    return this.httpClient.get<JobsListResult>('/print-jobs', {
      query: { ...query },
    });
  }

  async get(jobId: string): Promise<PrintJobDetails> {
    const response = await this.httpClient.get<JobEnvelope>(
      `/print-jobs/${encodeURIComponent(jobId)}`,
    );
    return response.job;
  }

  async retry(jobId: string): Promise<PrintJobDetails> {
    const response = await this.httpClient.post<JobEnvelope>(
      `/print-jobs/${encodeURIComponent(jobId)}/retry`,
    );
    return response.job;
  }

  async cancel(jobId: string): Promise<PrintJobDetails> {
    const response = await this.httpClient.post<JobEnvelope>(
      `/print-jobs/${encodeURIComponent(jobId)}/cancel`,
    );
    return response.job;
  }
}
