# Introduction

Qintrix is a desktop print agent that helps your business applications print reliably through local printers. It runs on the same computer or network environment as your printers, receives print requests from approved applications, and sends those jobs to the correct printer in a controlled and trackable way.

Instead of connecting every website or internal system directly to a printer, Qintrix acts as the bridge between your software and your local printing hardware.

## What Is Qintrix Used For?

Qintrix is used when an application needs to print documents, tickets, receipts, labels, or order slips through printers that are connected to a local machine or local network.

Common use cases include:

- restaurant and cafe order printing
- POS receipt printing
- warehouse or shipping label printing
- office document printing from internal systems
- any web application that needs secure local printer access

## Why Use Qintrix?

Most web applications cannot talk to local printers directly in a secure and dependable way. Browsers have limited direct hardware access, and printer setups vary from one business to another.

Qintrix solves that problem by:

- running locally where printers are available
- exposing a lightweight local API for approved applications
- controlling which apps can print and which printers they can access
- managing print jobs through a queue instead of sending them blindly
- providing visibility through job history, status tracking, and logs

## How Qintrix Works

At a high level, Qintrix follows this flow:

1. You install and run Qintrix on a computer that has access to your printers.
2. You add and configure your printers inside Qintrix.
3. You create one or more client apps and generate API keys for them.
4. Your website or business system sends a print request to Qintrix.
5. Qintrix validates the request, prepares the print content, places it in the queue, and sends it to the target printer.
6. You can review the result from the Jobs, Logs, and Dashboard sections.

This design keeps printing stable, organized, and easier to support.

## Main Features

Qintrix includes the tools needed to manage printing from one place:

- **Printer management**: Add, edit, enable, disable, and test printers.
- **Multiple connection types**: Work with system printers, TCP network printers, and supported raw USB/ESC/POS setups.
- **Application access control**: Create app credentials and limit app access to selected printers.
- **Embedded local API**: Receive print requests from your own web or desktop systems.
- **Queue management**: Process jobs in order and control whether the queue is running or paused.
- **Job tracking**: View each print job and follow its status from accepted to completed, failed, or canceled.
- **Retry support**: Re-run failed jobs when needed.
- **Logs and diagnostics**: Review important events, server activity, and printing issues.
- **Background operation**: Keep Qintrix available in the background so it is ready when your applications need it.

## What Can Qintrix Print?

Qintrix supports common print content types used by business applications:

- plain text
- HTML content
- PDF files
- images

This allows different systems to send the format that best matches their workflow.

## Key Parts of the Application

When you open Qintrix, the most important areas are:

- **Dashboard**: A quick summary of server status, printers, applications, jobs, and recent activity.
- **Server**: Controls for starting, stopping, and monitoring the local API server.
- **Printers**: The place to configure printer definitions and test connectivity.
- **Jobs**: A full list of print jobs with status, details, retry, and cancel actions.
- **Apps**: Client app management, API keys, and printer access rules.
- **Logs**: A history of system activity and operational events.
- **Settings**: Application behavior, startup preferences, and server options.

## Who Is Qintrix For?

Qintrix is designed for:

- business owners who need stable day-to-day printing
- operations teams that manage shared printers
- developers integrating printing into a web application
- support teams who need visibility into print failures and server activity

## In Short

Qintrix exists to make local printing practical for modern applications. It gives you a secure, manageable, and observable way to connect software systems to printers without building printer communication directly into every application.

In the next sections, you will learn how to prepare your environment, install Qintrix, configure printers, and start sending print jobs.
