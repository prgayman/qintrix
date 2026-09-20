# Qintrix Web SDK

Browser-first TypeScript SDK for connecting web applications to the Qintrix print agent API.

## What it covers

- Health checks
- Printer discovery and printer test actions
- Print job creation and monitoring
- Queue status, pause, and resume controls
- Typed API errors and request/response models

## Installation

For local development in this repository:

```bash
cd qintrix-web-sdk
npm install
npm run build
```

## Quick start

```ts
import { QintrixClient } from "qintrix-web-sdk";

const client = new QintrixClient({
  baseUrl: "http://127.0.0.1:4040",
  apiKey: "app_live_key",
});

const health = await client.health.get();
const printers = await client.printers.list();
```

## Client initialization

```ts
import { QintrixClient } from "qintrix-web-sdk";

const client = new QintrixClient({
  baseUrl: "http://127.0.0.1:4040",
  apiKey: "app_live_key",
  timeoutMs: 10_000,
});
```

### Config options

- `baseUrl`: required API base URL
- `apiKey`: optional default API key sent as `X-API-Key`
- `fetch`: optional custom fetch implementation
- `timeoutMs`: optional request timeout
- `headers`: optional default headers

## API key usage

All protected endpoints use `X-API-Key`. The SDK automatically injects it for:

- `printers.*`
- `jobs.*`
- `queue.*`

The health endpoint does not require authentication.

## Examples

### Health

```ts
const health = await client.health.get();
console.log(health.server.isRunning);
```

### Printers

```ts
const printers = await client.printers.list();
const printer = await client.printers.get(printers[0]!.id);
const testResult = await client.printers.test(printer.id);
```

### Create a text print job

```ts
const job = await client.jobs.create({
  printerId: "printer_1",
  contentType: "text",
  copies: 1,
  payload: {
    content: "Order #1025\n2 x Latte\n1 x Croissant",
  },
  meta: {
    referenceType: "order",
    referenceId: "1025",
    source: "website",
  },
});
```

### Create a PDF print job

```ts
const job = await client.jobs.create({
  printerId: "printer_1",
  contentType: "pdf",
  copies: 2,
  payload: {
    content: base64Pdf,
  },
  options: {
    paperSize: "A4",
    fitMode: "printer_default",
    autoRotate: true,
    allowRasterFallback: true,
    rasterDpi: 200,
    trimWhitespace: true,
    thermalDithering: true,
  },
  idempotencyKey: "order-1025-receipt",
});
```

Qintrix prints PDF jobs differently by printer type:

- `systemSpooler` printers prefer the original native PDF for best quality.
- `networkTcp` and `usbRawEscPos` printers rasterize PDF pages and print image pages for compatibility.
- If native PDF spooler printing fails and `allowRasterFallback` is enabled, Qintrix falls back to raster page printing and reports that in job details.

### Create an image print job

```ts
const job = await client.jobs.create({
  printerId: "printer_1",
  contentType: "image",
  copies: 1,
  payload: {
    content: base64Image,
    mimeType: "image/png",
  },
  options: {
    paperSize: "80mm",
    imagePreset: "mixed_receipt",
    trimWhitespace: true,
    thermalDithering: true,
  },
});
```

### List jobs

```ts
const result = await client.jobs.list({
  page: 0,
  perPage: 20,
  status: "queued",
  sortBy: "createdAt",
  sortDirection: "desc",
});
```

### Retry and cancel

```ts
await client.jobs.retry("job_123");
await client.jobs.cancel("job_124");
```

### Queue controls

```ts
const queue = await client.queue.getStatus();

if (queue.state === "paused") {
  await client.queue.resume();
}
```

## Error handling

```ts
import { QintrixApiError } from "qintrix-web-sdk";

try {
  await client.jobs.create({
    printerId: "",
    contentType: "text",
    payload: { content: "Hello" },
  });
} catch (error) {
  if (error instanceof QintrixApiError) {
    console.error(error.status, error.code, error.message);
  }
}
```

## Idempotency guidance

Use `idempotencyKey` when the client may retry the same request after a timeout or network error. Qintrix will return the existing job inside the configured deduplication window instead of creating a duplicate print.

## PDF options

PDF jobs accept additive options under `options`:

- `paperSize`
- `orientation`
- `duplexMode`
- `fitMode`
- `autoRotate`
- `allowRasterFallback`
- `rasterDpi`
- `trimWhitespace`
- `thermalDithering`

These fields are optional. Unsupported options are reported by the API in `ignoredOptions` when the job reaches execution metadata.

For receipt and raw ESC/POS printers, `trimWhitespace` and `thermalDithering` improve rasterized PDF and image output by removing large white margins before scaling and using error-diffusion instead of a simple fixed threshold.
Both options default to `true` when omitted.

For `image` jobs, `imagePreset` is image-only and supports `mixed_receipt`, `text_barcode`, `logo_graphics`, and `photo`. The default is `mixed_receipt`.
Invalid `imagePreset` values are rejected by the API with `validation_error`; they do not silently fall back to another preset.

## Job detail metadata

Job detail responses may include:

- `documentDeliveryMode`
- `usedFallback`
- `fallbackReason`
- `pdfDiagnostics`
- `imageDiagnostics`

These fields are optional and depend on the content type and execution stage.

## Endpoint mapping

| SDK method                  | HTTP endpoint                  |
| --------------------------- | ------------------------------ |
| `client.health.get()`       | `GET /health`                  |
| `client.printers.list()`    | `GET /printers`                |
| `client.printers.get(id)`   | `GET /printers/{id}`           |
| `client.printers.test(id)`  | `POST /printers/{id}/test`     |
| `client.jobs.create(input)` | `POST /print-jobs`             |
| `client.jobs.list(query)`   | `GET /print-jobs`              |
| `client.jobs.get(id)`       | `GET /print-jobs/{id}`         |
| `client.jobs.retry(id)`     | `POST /print-jobs/{id}/retry`  |
| `client.jobs.cancel(id)`    | `POST /print-jobs/{id}/cancel` |
| `client.queue.getStatus()`  | `GET /queue/status`            |
| `client.queue.pause()`      | `POST /queue/pause`            |
| `client.queue.resume()`     | `POST /queue/resume`           |

## Notes for frontend developers

- This SDK is browser-first and uses `fetch`.
- Successful browser usage depends on the Qintrix agent being reachable from the frontend and allowing the browser origin through deployment/network policy.
- Protected requests require a valid app API key from Qintrix.
- The SDK mirrors the current API; it does not add client-side retries, offline queues, or batching.
