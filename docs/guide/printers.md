# Printers

The Printers page is where you create, manage, test, and review your printer definitions.

It is one of the most important pages in Qintrix, because printing cannot work correctly until your printers are set up here.

## Printers List

The index page shows all saved printers.

![Printers index](/images/screenshots/printers-index.png)

### What You Can Do Here

From the printers list, you can:

- view all configured printers
- search for a printer
- filter by connection type
- filter by status
- create a new printer
- open a printer details page
- edit a printer
- test a printer connection
- delete one or more printers

## Create Printer

The create page is used to add a new printer definition.

![Create printer](/images/screenshots/printers-create.png)

### What You Set Here

Depending on the connection type, you can enter:

- printer name
- identifier
- optional description
- connection type
- printer-specific connection details
- whether the printer is enabled

Qintrix supports printer setups such as:

- system spooler printers
- TCP network printers
- supported raw USB or ESC/POS setups

## Edit Printer

The edit page is used when an existing printer needs to be updated.

![Edit printer](/images/screenshots/printers-edit.png)

Use this page when:

- the printer name should change
- the connection details changed
- the printer should be enabled or disabled
- you want to update device-specific settings

## Printer Details

The show page gives a read-only view of one printer and its important information.

![Printer details](/images/screenshots/printers-show.png)

### Why This Page Is Useful

Use the details page to:

- review the current setup
- confirm the identifier
- test the connection
- move to edit mode
- delete the printer if it is no longer needed

## Best Practice

After creating or editing a printer:

- save it
- run the printer test
- confirm the printer is enabled
- send a real test print job later from your integration

This helps you catch setup issues before real traffic starts.
