import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:qintrix/core/services/printer_connection_test_service.dart';
import 'package:qintrix/data/models/exports.dart';

void main() {
  test('tcp connection test succeeds when a server is available', () async {
    const service = PrinterConnectionTestService();
    final server = await ServerSocket.bind(InternetAddress.loopbackIPv4, 0);
    addTearDown(server.close);

    final printer = PrinterModel(
      id: '1',
      uniqueKey: 'PRN-A1B2C3',
      name: 'TCP Printer',
      connectionType: PrinterConnectionType.networkTcp,
      isEnabled: true,
      createdAt: DateTime(2026, 3, 18),
      updatedAt: DateTime(2026, 3, 18),
      tcpHost: InternetAddress.loopbackIPv4.address,
      tcpPort: server.port,
    );

    final result = await service.testConnection(printer);

    expect(result.status, PrinterConnectionTestStatus.success);
    expect(result.code, PrinterConnectionTestCode.tcpSuccess);
  });

  test('tcp connection test fails when no server is available', () async {
    const service = PrinterConnectionTestService();
    final printer = PrinterModel(
      id: '1',
      uniqueKey: 'PRN-A1B2C3',
      name: 'TCP Printer',
      connectionType: PrinterConnectionType.networkTcp,
      isEnabled: true,
      createdAt: DateTime(2026, 3, 18),
      updatedAt: DateTime(2026, 3, 18),
      tcpHost: InternetAddress.loopbackIPv4.address,
      tcpPort: 6553,
      tcpConnectTimeoutMs: 50,
    );

    final result = await service.testConnection(printer);

    expect(result.status, PrinterConnectionTestStatus.failure);
    expect(
      {PrinterConnectionTestCode.tcpTimeout, PrinterConnectionTestCode.tcpFailure},
      contains(result.code),
    );
  });

  test('system printer test succeeds when the spooler queue exists', () async {
    final service = PrinterConnectionTestService(
      processRunner: (
        String executable,
        List<String> arguments, {
        Duration? timeout,
      }) async => ProcessResult(
        1,
        0,
        Platform.isWindows ? 'Office Printer' : 'printer Office Printer is idle.',
        '',
      ),
    );

    final printer = PrinterModel(
      id: '1',
      uniqueKey: 'PRN-A1B2C3',
      name: 'System Printer',
      connectionType: PrinterConnectionType.systemSpooler,
      isEnabled: true,
      createdAt: DateTime(2026, 3, 18),
      updatedAt: DateTime(2026, 3, 18),
      systemPrinterName: 'Office Printer',
    );

    final result = await service.testConnection(printer);

    expect(result.status, PrinterConnectionTestStatus.success);
    expect(result.code, PrinterConnectionTestCode.systemSuccess);
  });

  test('system printer test fails when the queue does not exist', () async {
    final service = PrinterConnectionTestService(
      processRunner: (
        String executable,
        List<String> arguments, {
        Duration? timeout,
      }) async => ProcessResult(1, 1, '', 'not found'),
    );

    final printer = PrinterModel(
      id: '1',
      uniqueKey: 'PRN-A1B2C3',
      name: 'System Printer',
      connectionType: PrinterConnectionType.systemSpooler,
      isEnabled: true,
      createdAt: DateTime(2026, 3, 18),
      updatedAt: DateTime(2026, 3, 18),
      systemPrinterName: 'Missing Printer',
    );

    final result = await service.testConnection(printer);

    expect(result.status, PrinterConnectionTestStatus.failure);
    expect(result.code, PrinterConnectionTestCode.systemFailure);
  });

  test('usb raw test succeeds when the device is available', () async {
    final service = PrinterConnectionTestService(
      processRunner: (
        String executable,
        List<String> arguments, {
        Duration? timeout,
      }) async => ProcessResult(
        1,
        0,
        Platform.isWindows
            ? 'USB\\VID_04B8&PID_0202\\ABC123'
            : Platform.isMacOS
            ? '| |   idVendor = 0x04b8\n| |   idProduct = 0x0202'
            : 'Bus 001 Device 002: ID 04b8:0202 Epson Printer',
        '',
      ),
    );

    final printer = PrinterModel(
      id: '1',
      uniqueKey: 'PRN-A1B2C3',
      name: 'USB Printer',
      connectionType: PrinterConnectionType.usbRawEscPos,
      isEnabled: true,
      createdAt: DateTime(2026, 3, 18),
      updatedAt: DateTime(2026, 3, 18),
      usbVendorId: '04B8',
      usbProductId: '0202',
    );

    final result = await service.testConnection(printer);

    expect(result.status, PrinterConnectionTestStatus.success);
    expect(result.code, PrinterConnectionTestCode.usbSuccess);
  });

  test('usb raw test fails when the device is missing', () async {
    final service = PrinterConnectionTestService(
      processRunner: (
        String executable,
        List<String> arguments, {
        Duration? timeout,
      }) async => ProcessResult(1, 1, '', 'missing'),
    );

    final printer = PrinterModel(
      id: '1',
      uniqueKey: 'PRN-A1B2C3',
      name: 'USB Printer',
      connectionType: PrinterConnectionType.usbRawEscPos,
      isEnabled: true,
      createdAt: DateTime(2026, 3, 18),
      updatedAt: DateTime(2026, 3, 18),
      usbVendorId: '04B8',
      usbProductId: '0202',
    );

    final result = await service.testConnection(printer);

    expect(result.status, PrinterConnectionTestStatus.failure);
    expect(result.code, PrinterConnectionTestCode.usbFailure);
  });

  test('usb raw test fails when identifiers are missing', () async {
    const service = PrinterConnectionTestService();
    final printer = PrinterModel(
      id: '1',
      uniqueKey: 'PRN-A1B2C3',
      name: 'USB Printer',
      connectionType: PrinterConnectionType.usbRawEscPos,
      isEnabled: true,
      createdAt: DateTime(2026, 3, 18),
      updatedAt: DateTime(2026, 3, 18),
    );

    final result = await service.testConnection(printer);

    expect(result.status, PrinterConnectionTestStatus.failure);
    expect(result.code, PrinterConnectionTestCode.usbMissingConfig);
  });
}
