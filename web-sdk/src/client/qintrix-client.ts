import { HttpClient } from '../http/http-client.js';
import { HealthResource } from '../resources/health-resource.js';
import { JobsResource } from '../resources/jobs-resource.js';
import { PrintersResource } from '../resources/printers-resource.js';
import { QueueResource } from '../resources/queue-resource.js';
import type { QintrixClientConfig } from '../types/client.js';

export class QintrixClient {
  readonly health: HealthResource;
  readonly printers: PrintersResource;
  readonly jobs: JobsResource;
  readonly queue: QueueResource;

  constructor(config: QintrixClientConfig) {
    const httpClient = new HttpClient(config);

    this.health = new HealthResource(httpClient);
    this.printers = new PrintersResource(httpClient);
    this.jobs = new JobsResource(httpClient);
    this.queue = new QueueResource(httpClient);
  }
}

