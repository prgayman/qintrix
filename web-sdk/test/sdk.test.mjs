import test from 'node:test';
import assert from 'node:assert/strict';

const modulePath = new URL('../dist/index.js', import.meta.url);

function createJsonResponse(body, init = {}) {
  return new Response(JSON.stringify(body), {
    status: init.status ?? 200,
    headers: { 'Content-Type': 'application/json' },
  });
}

test('injects X-API-Key on protected requests', async () => {
  const calls = [];
  const { QintrixClient } = await import(modulePath);

  const client = new QintrixClient({
    baseUrl: 'http://agent.local',
    apiKey: 'secret_key',
    fetch: async (input, init) => {
      calls.push([input, init]);
      return createJsonResponse({ items: [] });
    },
  });

  await client.printers.list();

  const [, init] = calls[0];
  assert.equal(init.headers.get('X-API-Key'), 'secret_key');
});

test('does not require auth on health requests', async () => {
  const calls = [];
  const { QintrixClient } = await import(modulePath);

  const client = new QintrixClient({
    baseUrl: 'http://agent.local',
    apiKey: 'secret_key',
    fetch: async (input, init) => {
      calls.push([input, init]);
      return createJsonResponse({
        status: 'ok',
        server: { isRunning: true, host: '127.0.0.1', port: 4040 },
        timestamp: '2026-03-21T00:00:00.000Z',
        app: 'Qintrix Print Agent',
      });
    },
  });

  await client.health.get();

  const [, init] = calls[0];
  assert.equal(init.headers.get('X-API-Key'), null);
});

test('serializes jobs list query parameters', async () => {
  const calls = [];
  const { QintrixClient } = await import(modulePath);

  const client = new QintrixClient({
    baseUrl: 'http://agent.local',
    fetch: async (input) => {
      calls.push(String(input));
      return createJsonResponse({
        items: [],
        totalCount: 0,
        page: 0,
        pageSize: 20,
      });
    },
  });

  await client.jobs.list({
    page: 0,
    perPage: 20,
    status: 'queued',
    contentType: 'pdf',
    search: 'receipt',
  });

  assert.equal(
    calls[0],
    'http://agent.local/print-jobs?page=0&perPage=20&status=queued&contentType=pdf&search=receipt',
  );
});

test('shapes print job create bodies correctly', async () => {
  const payloads = [];
  const { QintrixClient } = await import(modulePath);

  const client = new QintrixClient({
    baseUrl: 'http://agent.local',
    fetch: async (_input, init) => {
      payloads.push(JSON.parse(init.body));
      return createJsonResponse({
        job: {
          id: 'job_1',
          status: 'accepted',
          title: 'Test',
          retryCount: 0,
          createdAt: '2026-03-21T00:00:00.000Z',
          updatedAt: '2026-03-21T00:00:00.000Z',
          copies: 1,
        },
      }, { status: 202 });
    },
  });

  await client.jobs.create({
    printerId: 'printer_1',
    contentType: 'text',
    payload: { content: 'Hello' },
  });

  await client.jobs.create({
    printerId: 'printer_1',
    contentType: 'pdf',
    copies: 2,
    payload: { content: 'base64_pdf' },
    options: {
      paperSize: 'A4',
      fitMode: 'printer_default',
      autoRotate: true,
      allowRasterFallback: true,
      rasterDpi: 200,
      trimWhitespace: true,
      thermalDithering: true,
    },
    idempotencyKey: 'order-1',
  });

  await client.jobs.create({
    printerId: 'printer_1',
    contentType: 'image',
    payload: { content: 'base64_image', mimeType: 'image/png' },
    options: {
      paperSize: '80mm',
      imagePreset: 'mixed_receipt',
      trimWhitespace: true,
      thermalDithering: true,
    },
  });

  assert.deepEqual(payloads[0], {
    printerId: 'printer_1',
    contentType: 'text',
    copies: 1,
    payload: { content: 'Hello' },
  });

  assert.deepEqual(payloads[1], {
    printerId: 'printer_1',
    contentType: 'pdf',
    copies: 2,
    payload: { content: 'base64_pdf' },
    options: {
      paperSize: 'A4',
      fitMode: 'printer_default',
      autoRotate: true,
      allowRasterFallback: true,
      rasterDpi: 200,
      trimWhitespace: true,
      thermalDithering: true,
    },
    idempotencyKey: 'order-1',
  });

  assert.deepEqual(payloads[2], {
    printerId: 'printer_1',
    contentType: 'image',
    copies: 1,
    payload: { content: 'base64_image', mimeType: 'image/png' },
    options: {
      paperSize: '80mm',
      imagePreset: 'mixed_receipt',
      trimWhitespace: true,
      thermalDithering: true,
    },
  });

});

test('preserves optional PDF execution metadata on job details', async () => {
  const { QintrixClient } = await import(modulePath);

  const client = new QintrixClient({
    baseUrl: 'http://agent.local',
    fetch: async () =>
      createJsonResponse({
        job: {
          id: 'job_pdf_1',
          status: 'completed',
          title: 'Invoice',
          retryCount: 0,
          createdAt: '2026-03-21T00:00:00.000Z',
          updatedAt: '2026-03-21T00:00:00.000Z',
          copies: 1,
          documentDeliveryMode: 'native_pdf',
          usedFallback: false,
          pdfDiagnostics: {
            pageCount: 3,
            isEncrypted: false,
            rasterDpi: 144,
          },
          imageDiagnostics: {
            originalWidth: 640,
            originalHeight: 120,
            normalizedWidth: 640,
            normalizedHeight: 120,
            targetWidthPx: 576,
          },
        },
      }),
  });

  const job = await client.jobs.get('job_pdf_1');

  assert.equal(job.documentDeliveryMode, 'native_pdf');
  assert.equal(job.usedFallback, false);
  assert.equal(job.pdfDiagnostics.pageCount, 3);
  assert.equal(job.imageDiagnostics.targetWidthPx, 576);
});

test('maps API error payloads into QintrixApiError', async () => {
  const { QintrixApiError, QintrixClient } = await import(modulePath);

  const client = new QintrixClient({
    baseUrl: 'http://agent.local',
    fetch: async () =>
      createJsonResponse(
        {
          error: 'unauthorized',
          message: 'A valid X-API-Key for an enabled app is required.',
        },
        { status: 401 },
      ),
  });

  await assert.rejects(
    () => client.printers.list(),
    (error) => {
      assert.ok(error instanceof QintrixApiError);
      assert.equal(error.status, 401);
      assert.equal(error.code, 'unauthorized');
      return true;
    },
  );
});

test('exposes queue controls and printer details', async () => {
  const { QintrixClient } = await import(modulePath);

  const client = new QintrixClient({
    baseUrl: 'http://agent.local',
    fetch: async (input) => {
      const url = String(input);
      if (url.endsWith('/queue/status')) {
        return createJsonResponse({
          state: 'running',
          workers: [],
        });
      }

      if (url.endsWith('/printers/printer_1')) {
        return createJsonResponse({
          id: 'printer_1',
          identifier: 'front-desk',
          name: 'Front Desk',
          connectionType: 'network_tcp',
          isEnabled: true,
          updatedAt: '2026-03-21T00:00:00.000Z',
          createdAt: '2026-03-21T00:00:00.000Z',
          connection: {
            tcpHost: '192.168.1.10',
            tcpPort: 9100,
            rawGraphicsMode: 'modern',
          },
        });
      }

      if (url.endsWith('/printers/printer_1/test')) {
        return createJsonResponse({
          printerId: 'printer_1',
          status: 'success',
          message: 'Connected.',
        });
      }

      return createJsonResponse({ state: 'paused', workers: [] });
    },
  });

  const queue = await client.queue.getStatus();
  const printer = await client.printers.get('printer_1');
  const testResult = await client.printers.test('printer_1');

  assert.equal(queue.state, 'running');
  assert.equal(printer.connection.tcpPort, 9100);
  assert.equal(printer.connection.rawGraphicsMode, 'modern');
  assert.equal(testResult.printerId, 'printer_1');
});
