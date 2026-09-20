# Web SDK

The Qintrix Web SDK helps your website or web application connect to the Qintrix desktop agent.

It gives you a simple way to:

- check whether the Qintrix agent is available
- load printers
- test printers
- create print jobs
- list and inspect jobs
- retry or cancel jobs
- manage queue state

## What The SDK Does

The SDK is a client for the local Qintrix API.

Your application sends requests to the Qintrix desktop agent, and the agent handles the real printer communication.

This means your web application does not need to manage printers directly.

## Before You Use The SDK

Before using the Web SDK, make sure:

- Qintrix is installed and running
- the Qintrix server is running
- at least one printer is configured inside Qintrix
- you created an app and copied its API key from the **Apps** page
- your website can reach the Qintrix server URL

Typical local server URL:

```txt
http://127.0.0.1:4880
```

## Installation Options

You can use the SDK in one of two ways.

### Use The Package In A JavaScript Or TypeScript Project

Example:

```ts
import { QintrixClient } from "[SDK-PATH]";

const client = new QintrixClient({
  baseUrl: "http://127.0.0.1:4880",
  apiKey: "your_app_api_key",
});
```

## Create The Client

To use the SDK, create a `QintrixClient`.

```ts
import { QintrixClient } from "[SDK-PATH]";

const client = new QintrixClient({
  baseUrl: "http://127.0.0.1:4880",
  apiKey: "your_app_api_key",
  timeoutMs: 10000,
});
```

### Client Options

- `baseUrl`: the Qintrix server URL
- `apiKey`: the API key created in Qintrix
- `timeoutMs`: optional request timeout
- `headers`: optional extra request headers
- `fetch`: optional custom fetch implementation

## Basic Example

This example checks the Qintrix agent and loads the available printers.

```ts
import { QintrixClient } from "[SDK-PATH]";

const client = new QintrixClient({
  baseUrl: "http://127.0.0.1:4880",
  apiKey: "your_app_api_key",
});

async function loadQintrix() {
  const health = await client.health.get();
  const printers = await client.printers.list();

  console.log("Server status:", health.server.isRunning);
  console.log("Available printers:", printers);
}

loadQintrix();
```

## Full Example

The example below shows a simple real-world flow:

1. connect to Qintrix
2. load printers
3. select one printer
4. send a text print job
5. load jobs

```ts
import { QintrixClient, QintrixApiError } from "[SDK-PATH]";

const client = new QintrixClient({
  baseUrl: "http://127.0.0.1:4880",
  apiKey: "your_app_api_key",
  timeoutMs: 10000,
});

async function sendReceipt() {
  try {
    const health = await client.health.get();

    if (!health.server.isRunning) {
      console.error("Qintrix server is not running.");
      return;
    }

    const printers = await client.printers.list();

    if (printers.length === 0) {
      console.error("No printers are available in Qintrix.");
      return;
    }

    const printer = printers[0];

    const job = await client.jobs.create({
      printerId: printer.id,
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
      idempotencyKey: "order-1025-receipt",
    });

    console.log("Created job:", job.id);

    const jobs = await client.jobs.list({
      page: 0,
      perPage: 10,
      sortBy: "createdAt",
      sortDirection: "desc",
    });

    console.log("Recent jobs:", jobs.items);
  } catch (error) {
    if (error instanceof QintrixApiError) {
      console.error(
        "Qintrix API error:",
        error.status,
        error.code,
        error.message,
      );
      return;
    }

    console.error("Unexpected error:", error);
  }
}

sendReceipt();
```

## Health

Use the health resource to check whether the Qintrix agent is reachable.

```ts
const health = await client.health.get();

console.log(health.status);
console.log(health.server.host);
console.log(health.server.port);
console.log(health.server.isRunning);
```

## Printers

### List Printers

```ts
const printers = await client.printers.list();
```

### Get One Printer

```ts
const printer = await client.printers.get("printer_id");
```

### Test A Printer

```ts
const result = await client.printers.test("printer_id");
console.log(result.status, result.message);
```

## Print Jobs

### Create A Text Job

```ts
const job = await client.jobs.create({
  printerId: "printer_id",
  contentType: "text",
  copies: 1,
  payload: {
    content: "Hello from Qintrix",
  },
});
```

### Create A PDF Job

```ts
const job = await client.jobs.create({
  printerId: "printer_id",
  contentType: "pdf",
  copies: 1,
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
  idempotencyKey: "pdf-order-1025",
});
```

### How PDF Jobs Print

Qintrix handles PDF jobs based on the printer connection type:

- `systemSpooler`: print the original native PDF when possible
- `networkTcp`: rasterize the PDF into page images and print those pages
- `usbRawEscPos`: rasterize the PDF into page images and print those pages

If native PDF spooler printing fails and `allowRasterFallback` is enabled, Qintrix falls back to raster page printing.

### PDF Options

You can optionally include these PDF job options:

- `paperSize`
- `orientation`
- `duplexMode`
- `fitMode`
- `autoRotate`
- `allowRasterFallback`
- `rasterDpi`
- `trimWhitespace`
- `thermalDithering`

These options are additive. The API keeps the same request shape and ignores unsupported options for printer paths that cannot use them.

For receipt and raw ESC/POS printers, `trimWhitespace` removes large blank margins before scaling raster pages to receipt width, and `thermalDithering` improves black-and-white conversion for grayscale logos, icons, and mixed-content PDFs.
Both options default to `true` when omitted.

### Create An Image Job

```ts
const job = await client.jobs.create({
  printerId: "printer_id",
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

For `image` jobs, `imagePreset` is image-only and supports `mixed_receipt`, `text_barcode`, `logo_graphics`, and `photo`. The default is `mixed_receipt`.
Invalid `imagePreset` values are rejected with `validation_error` instead of silently falling back to another preset.

### List Jobs

```ts
const jobs = await client.jobs.list({
  page: 0,
  perPage: 20,
  status: "queued",
  sortBy: "createdAt",
  sortDirection: "desc",
});
```

### Get One Job

```ts
const job = await client.jobs.get("job_id");
```

### Retry A Job

```ts
await client.jobs.retry("job_id");
```

### Cancel A Job

```ts
await client.jobs.cancel("job_id");
```

## Queue Controls

### Get Queue Status

```ts
const queue = await client.queue.getStatus();
console.log(queue.state);
```

### Pause The Queue

```ts
await client.queue.pause();
```

### Resume The Queue

```ts
await client.queue.resume();
```

## Error Handling

The SDK returns `QintrixApiError` for API failures.

```ts
import { QintrixApiError } from "[SDK-PATH]";

try {
  await client.printers.list();
} catch (error) {
  if (error instanceof QintrixApiError) {
    console.error("Status:", error.status);
    console.error("Code:", error.code);
    console.error("Message:", error.message);
  }
}
```

## Important Notes

- The health endpoint does not require authentication.
- Protected endpoints use the `X-API-Key` header automatically when you provide `apiKey`.
- The SDK is browser-first and uses `fetch`.
- The SDK does not add its own offline queue, retry system, or batching logic.
- Use `idempotencyKey` when you want to protect against duplicate print creation during retries.
- Job details may include `documentDeliveryMode`, `usedFallback`, `fallbackReason`, `pdfDiagnostics`, and `imageDiagnostics` depending on content type.
- Invalid, truncated, or protected PDFs return validation errors instead of being accepted into the queue.

## Endpoint Mapping

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

## Simple Workflow Summary

For most websites, the flow is:

1. create a Qintrix app and API key
2. create a `QintrixClient`
3. load printers
4. choose a printer
5. create a print job
6. track the job in Qintrix

This keeps the frontend simple while Qintrix handles the real printer work locally.
