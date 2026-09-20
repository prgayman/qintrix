abstract final class PrinterFormOptions {
  static const encodings = <String>[
    'UTF-8',
    'ASCII',
    'CP437',
    'CP850',
    'CP852',
    'CP866',
    'WINDOWS-1252',
  ];

  static const codePages = <String>[
    'CP437',
    'CP850',
    'CP852',
    'CP857',
    'CP858',
    'CP860',
    'CP863',
    'CP865',
    'CP866',
    'CP1252',
  ];

  static const paperSizes = <String>[
    'A4',
    'A5',
    'Letter',
    'Legal',
    '80mm',
    '58mm',
  ];

  static const receiptPaperSizes = <String>['80mm', '58mm'];

  static const spoolFormats = <String>['RAW', 'TEXT', 'EMF', 'PDF'];

  static const lineEndings = <String>['LF', 'CR', 'CRLF', 'NONE'];

  static const duplexModes = <String>['NONE', 'LONG_EDGE', 'SHORT_EDGE'];

  static const orientations = <String>['PORTRAIT', 'LANDSCAPE'];

  static const characterTables = <String>[
    'DEFAULT',
    'PC437',
    'PC850',
    'PC860',
    'PC863',
    'PC865',
    'PC866',
  ];

  static const cutModes = <String>['FULL', 'PARTIAL', 'NONE'];

  static const drawerPins = <int>[2, 5];

  static const rawGraphicsModes = <String>['modern', 'legacy'];
}
