import { HttpClient } from '../http/http-client.js';
import type {
  PrinterDetails,
  PrinterSummary,
  PrinterTestResult,
} from '../types/printers.js';

interface PrintersListEnvelope {
  items: PrinterSummary[];
}

interface PrinterDetailsEnvelope {
  id: string;
  identifier: string;
  name: string;
  connectionType: PrinterDetails['connectionType'];
  isEnabled: boolean;
  lastStatus?: string;
  updatedAt: string;
  description?: string;
  createdAt: string;
  connection: PrinterDetails['connection'];
}

export class PrintersResource {
  constructor(private readonly httpClient: HttpClient) {}

  async list(): Promise<PrinterSummary[]> {
    const response = await this.httpClient.get<PrintersListEnvelope>('/printers');
    return response.items;
  }

  get(printerId: string): Promise<PrinterDetails> {
    return this.httpClient.get<PrinterDetails>(`/printers/${encodeURIComponent(printerId)}`);
  }

  test(printerId: string): Promise<PrinterTestResult> {
    return this.httpClient.post<PrinterTestResult>(
      `/printers/${encodeURIComponent(printerId)}/test`,
    );
  }
}

