export type PrinterConnectionType =
  | 'network_tcp'
  | 'system_spooler'
  | 'usb_raw_esc_pos';

export interface PrinterSummary {
  id: string;
  identifier: string;
  name: string;
  connectionType: PrinterConnectionType;
  isEnabled: boolean;
  lastStatus?: string;
  updatedAt: string;
}

export interface PrinterConnectionDetails {
  tcpHost?: string | null;
  tcpPort?: number | null;
  tcpConnectTimeoutMs?: number | null;
  tcpWriteTimeoutMs?: number | null;
  tcpReadTimeoutMs?: number | null;
  tcpAutoReconnect?: boolean | null;
  tcpReconnectDelayMs?: number | null;
  tcpEncoding?: string | null;
  tcpCodePage?: string | null;
  tcpLineEnding?: string | null;
  systemPrinterName?: string | null;
  systemPaperSize?: string | null;
  systemDefaultCopies?: number | null;
  systemColorEnabled?: boolean | null;
  systemDuplexMode?: string | null;
  systemOrientation?: string | null;
  usbVendorId?: string | null;
  usbProductId?: string | null;
  usbSerialNumber?: string | null;
  rawGraphicsMode?: 'modern' | 'legacy' | null;
}

export interface PrinterDetails extends PrinterSummary {
  description?: string;
  createdAt: string;
  connection: PrinterConnectionDetails;
}

export interface PrinterTestResult {
  printerId: string;
  status: string;
  message: string;
}
