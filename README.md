<div align="center">
  <img src="qintrix/assets/logo.png" alt="Qintrix logo" width="120">

# Qintrix

**A lightweight desktop print agent for secure, reliable printing from web and business applications.**

</div>

Qintrix bridges modern applications and local printers. It runs beside the printers, exposes a local authenticated API, queues print jobs, and provides the visibility needed to manage printing without giving a browser direct access to hardware.

## Features

- Print plain text, HTML, PDF, and images
- Connect to system, TCP network, and supported USB/ESC/POS printers
- Authenticate applications with API keys and printer-level access rules
- Queue, retry, cancel, and monitor print jobs
- Inspect job history, diagnostics, and application logs
- Run in the background with system-tray support
- Use the interface in English or Arabic
- Integrate browser applications through the typed TypeScript SDK

## Repository structure

| Directory              | Description                                               |
| ---------------------- | --------------------------------------------------------- |
| [`qintrix/`](qintrix/) | Flutter desktop application for macOS, Windows, and Linux |
| [`web-sdk/`](web-sdk/) | Browser-first TypeScript client for the local Qintrix API |
| [`docs/`](docs/)       | VitePress documentation site                              |

## Requirements

- Flutter with a Dart SDK compatible with `^3.11.1`
- The desktop build tools required by your operating system
- Node.js and npm for the SDK
- Node.js and Yarn for the documentation site
- A local or network printer for end-to-end printing tests

Run `flutter doctor` before starting to verify your desktop toolchain. See the [requirements guide](docs/guide/requirements.md) and [installation guide](docs/guide/installing-qintrix.md) for platform-specific setup.

## Run the desktop agent

```bash
cd qintrix
flutter pub get
flutter run -d macos   # or windows / linux
```

On first launch:

1. Add and test a printer.
2. Create an app and copy its API key.
3. Start the local API server.
4. Send a print job from your application or the SDK.

The default server address is `http://127.0.0.1:4880`; it can be changed in Qintrix settings.

## Use the web SDK

Build and test the SDK locally:

```bash
cd web-sdk
npm install
npm run build
npm test
```

Create a client with the URL shown in the Qintrix Server page and an API key created in the Apps page:

```ts
import { QintrixClient } from "qintrix-web-sdk";

const qintrix = new QintrixClient({
  baseUrl: "http://127.0.0.1:4880",
  apiKey: "your-api-key",
});

const printers = await qintrix.printers.list();

await qintrix.jobs.create({
  printerId: printers[0].id,
  contentType: "text",
  copies: 1,
  payload: { content: "Hello from Qintrix" },
});
```

Protected endpoints send the API key in the `X-API-Key` header. For the complete client API, job formats, and error handling, see the [SDK guide](docs/guide/web-sdk.md) and [SDK README](web-sdk/README.md).

## Documentation

Run the documentation site locally:

```bash
cd docs
npm install
npm run docs:dev
```

The documentation covers printer setup, app credentials, server configuration, jobs, logs, settings, and SDK integration. Start with the [introduction](docs/guide/introduction.md).

## Development checks

```bash
# Flutter application
cd qintrix
flutter analyze
flutter test

# TypeScript SDK
cd ../web-sdk
npm run typecheck
npm test

# Documentation
cd ../docs
npm run docs:build
```

## Security notes

- Keep API keys private and rotate them if exposed.
- Grant each application access only to the printers it needs.
- Keep the server bound to localhost unless network access is intentionally configured and protected.
- Do not commit production credentials or customer print data.

## License

Qintrix is released under the [MIT License](LICENSE). Copyright © 2026 Tenvoro.

Third-party components remain subject to their respective licenses; the bundled Cairo font is covered by the [SIL Open Font License](qintrix/assets/fonts/Cairo-OFL.txt).
