# Jobs

The Jobs page is where you monitor print jobs after they are accepted by Qintrix.

This page helps you understand what happened to each job and whether it completed successfully.

## Jobs List

The main jobs screen shows the print job list.

![Jobs index](/images/screenshots/jobs-index.png)

### What You Can Do Here

From the list page, you can:

- view recent jobs
- search jobs
- filter by status
- filter by printer
- filter by content type
- open a job to see full details

### Typical Job States

Jobs may move through states such as:

- accepted
- rendering
- queued
- processing
- completed
- failed
- canceled
- retry scheduled

## Job Details

When you open one job, Qintrix shows a full detail view.

![Job details](/images/screenshots/jobs-show.png)

### What You Can See

The details page can show:

- job ID
- printer ID
- current status
- content type
- copies
- timestamps
- retry information
- failure information
- metadata and options
- delivery mode and fallback details for supported job types
- PDF diagnostics such as page count and raster fallback metadata
- image diagnostics such as original size, normalized size, and target thermal width

## Main Actions

Depending on the job state, you may be able to:

- retry a failed or canceled job
- cancel a queued job

These actions are useful when:

- a temporary printer problem caused failure
- you need to stop a job before it starts printing

## When To Use This Page

Use the Jobs page when:

- a customer reports that something did not print
- you want to confirm that a job reached the queue
- you need to see whether a job failed or completed
- you want to retry a failed job

## PDF Jobs

PDF jobs are handled differently depending on the printer path:

- office and system spooler printers prefer native PDF printing
- receipt and raw ESC/POS printers use rasterized PDF pages
- if native PDF spooler printing fails, Qintrix can fall back to raster pages when the job allows it

The job details help you confirm which path was used by showing:

- `documentDeliveryMode`
- whether fallback was used
- the fallback reason when one occurred
- PDF diagnostics recorded during rendering

For receipt and raw ESC/POS printers, PDF and image jobs can also use thermal raster improvements such as whitespace trimming and dithering before the final ESC/POS bytes are generated.

## PDF Troubleshooting

When a PDF job fails, check for these common cases:

- invalid or non-PDF payload content
- truncated or corrupt PDF data
- encrypted or password-protected PDF files
- spooler failure followed by raster fallback
- reduced quality on receipt printers because PDF pages are rasterized before printing
- large PDF margins wasting receipt width when whitespace trimming is disabled
- logos or grayscale artwork appearing too harsh when thermal dithering is disabled

## Image Jobs

Image jobs remain separate from PDF, HTML, and text jobs.

- system spooler printers prefer the original uploaded image source
- raw TCP and USB ESC/POS printers use the image-specific thermal path
- image-only options such as `imagePreset` tune thermal image preprocessing without changing the PDF, HTML, or text pipelines
- supported `imagePreset` values are `mixed_receipt`, `text_barcode`, `logo_graphics`, and `photo`
- invalid `imagePreset` values are rejected instead of silently falling back

## HTML Jobs

HTML jobs remain separate from PDF, image, and text jobs.

- HTML now renders as `HTML -> browser-rendered PDF -> raster pages`
- system spooler printers prefer the rendered native PDF for the best design fidelity
- raw TCP and USB ESC/POS printers use raster page fallbacks derived from the rendered PDF
- if native PDF spooler printing fails and `allowRasterFallback` is enabled, Qintrix falls back to raster page printing
- `payload.url` remains unsupported; use inline `payload.content`
- self-contained HTML with inline CSS, embedded fonts, and data-URL images is the recommended production path for reliable fidelity
- desktop HTML rendering uses a compatible Chromium-based browser in headless mode for the high-fidelity HTML render step
