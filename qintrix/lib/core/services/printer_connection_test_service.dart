import 'dart:async';
import 'dart:io';

import 'package:qintrix/data/models/exports.dart';

typedef ProcessRunner =
    Future<ProcessResult> Function(
      String executable,
      List<String> arguments, {
      Duration? timeout,
    });

enum PrinterConnectionTestStatus { success, failure, notSupported }

enum PrinterConnectionTestCode {
  tcpMissingConfig,
  tcpSuccess,
  tcpTimeout,
  tcpFailure,
  systemMissingConfig,
  systemSuccess,
  systemFailure,
  usbMissingConfig,
  usbSuccess,
  usbFailure,
  commandUnavailable,
  unsupportedPlatform,
}

class PrinterConnectionTestResult {
  const PrinterConnectionTestResult({
    required this.status,
    required this.message,
    this.code,
    this.metadata = const <String, String>{},
  });

  final PrinterConnectionTestStatus status;
  final String message;
  final PrinterConnectionTestCode? code;
  final Map<String, String> metadata;
}

class PrinterConnectionTestService {
  const PrinterConnectionTestService({ProcessRunner? processRunner})
    : _processRunner = processRunner ?? _defaultProcessRunner;

  final ProcessRunner _processRunner;

  Future<PrinterConnectionTestResult> testConnection(
    PrinterModel printer,
  ) async {
    return switch (printer.connectionType) {
      PrinterConnectionType.networkTcp => _testTcp(printer),
      PrinterConnectionType.systemSpooler => _testSystemSpooler(printer),
      PrinterConnectionType.usbRawEscPos => _testUsb(printer),
    };
  }

  Future<PrinterConnectionTestResult> _testTcp(PrinterModel printer) async {
    final host = printer.tcpHost?.trim();
    final port = printer.tcpPort;
    if (host == null || host.isEmpty || port == null) {
      return const PrinterConnectionTestResult(
        status: PrinterConnectionTestStatus.failure,
        code: PrinterConnectionTestCode.tcpMissingConfig,
        message: 'tcp_missing_config',
      );
    }

    final timeout = Duration(milliseconds: printer.tcpConnectTimeoutMs ?? 5000);

    Socket? socket;
    try {
      socket = await Socket.connect(host, port, timeout: timeout);
      await socket.close();
      return PrinterConnectionTestResult(
        status: PrinterConnectionTestStatus.success,
        code: PrinterConnectionTestCode.tcpSuccess,
        message: 'tcp_success',
        metadata: {'host': host, 'port': '$port'},
      );
    } on TimeoutException {
      return PrinterConnectionTestResult(
        status: PrinterConnectionTestStatus.failure,
        code: PrinterConnectionTestCode.tcpTimeout,
        message: 'tcp_timeout',
        metadata: {'host': host, 'port': '$port'},
      );
    } catch (error) {
      return PrinterConnectionTestResult(
        status: PrinterConnectionTestStatus.failure,
        code: PrinterConnectionTestCode.tcpFailure,
        message: 'tcp_failure',
        metadata: {'host': host, 'port': '$port', 'error': '$error'},
      );
    } finally {
      socket?.destroy();
    }
  }

  Future<PrinterConnectionTestResult> _testSystemSpooler(
    PrinterModel printer,
  ) async {
    final queueName =
        printer.systemQueueName?.trim().isNotEmpty == true
            ? printer.systemQueueName!.trim()
            : printer.systemPrinterName?.trim();

    if (queueName == null || queueName.isEmpty) {
      return const PrinterConnectionTestResult(
        status: PrinterConnectionTestStatus.failure,
        code: PrinterConnectionTestCode.systemMissingConfig,
        message: 'system_missing_config',
      );
    }

    if (Platform.isWindows) {
      return _testSystemSpoolerWindows(queueName);
    }

    if (Platform.isMacOS || Platform.isLinux) {
      return _testSystemSpoolerPosix(queueName);
    }

    return const PrinterConnectionTestResult(
      status: PrinterConnectionTestStatus.notSupported,
      code: PrinterConnectionTestCode.unsupportedPlatform,
      message: 'unsupported_platform',
    );
  }

  Future<PrinterConnectionTestResult> _testSystemSpoolerWindows(
    String queueName,
  ) async {
    try {
      final result = await _processRunner('powershell', [
        '-NoProfile',
        '-Command',
        "Get-Printer -Name '$queueName' | Select-Object -ExpandProperty Name",
      ]);
      final output = '${result.stdout}'.trim();
      if (result.exitCode == 0 && output.isNotEmpty) {
        return PrinterConnectionTestResult(
          status: PrinterConnectionTestStatus.success,
          code: PrinterConnectionTestCode.systemSuccess,
          message: 'system_success',
          metadata: {'name': queueName},
        );
      }
      return PrinterConnectionTestResult(
        status: PrinterConnectionTestStatus.failure,
        code: PrinterConnectionTestCode.systemFailure,
        message: 'system_failure',
        metadata: {'name': queueName},
      );
    } on ProcessException {
      return const PrinterConnectionTestResult(
        status: PrinterConnectionTestStatus.failure,
        code: PrinterConnectionTestCode.commandUnavailable,
        message: 'command_unavailable',
        metadata: {'command': 'powershell'},
      );
    }
  }

  Future<PrinterConnectionTestResult> _testSystemSpoolerPosix(
    String queueName,
  ) async {
    try {
      final result = await _processRunner('lpstat', ['-p', queueName]);
      if (result.exitCode == 0) {
        return PrinterConnectionTestResult(
          status: PrinterConnectionTestStatus.success,
          code: PrinterConnectionTestCode.systemSuccess,
          message: 'system_success',
          metadata: {'name': queueName},
        );
      }
      return PrinterConnectionTestResult(
        status: PrinterConnectionTestStatus.failure,
        code: PrinterConnectionTestCode.systemFailure,
        message: 'system_failure',
        metadata: {'name': queueName},
      );
    } on ProcessException {
      return const PrinterConnectionTestResult(
        status: PrinterConnectionTestStatus.failure,
        code: PrinterConnectionTestCode.commandUnavailable,
        message: 'command_unavailable',
        metadata: {'command': 'lpstat'},
      );
    }
  }

  Future<PrinterConnectionTestResult> _testUsb(PrinterModel printer) async {
    final vendorId = _normalizeUsbId(printer.usbVendorId);
    final productId = _normalizeUsbId(printer.usbProductId);

    if (vendorId == null || productId == null) {
      return const PrinterConnectionTestResult(
        status: PrinterConnectionTestStatus.failure,
        code: PrinterConnectionTestCode.usbMissingConfig,
        message: 'usb_missing_config',
      );
    }

    if (Platform.isWindows) {
      return _testUsbWindows(vendorId, productId);
    }

    if (Platform.isMacOS) {
      return _testUsbMacOs(vendorId, productId);
    }

    if (Platform.isLinux) {
      return _testUsbLinux(vendorId, productId);
    }

    return const PrinterConnectionTestResult(
      status: PrinterConnectionTestStatus.notSupported,
      code: PrinterConnectionTestCode.unsupportedPlatform,
      message: 'unsupported_platform',
    );
  }

  Future<PrinterConnectionTestResult> _testUsbWindows(
    String vendorId,
    String productId,
  ) async {
    try {
      final result = await _processRunner('powershell', [
        '-NoProfile',
        '-Command',
        'Get-PnpDevice -PresentOnly | Select-Object -ExpandProperty InstanceId',
      ]);
      final pattern = 'VID_${vendorId.toUpperCase()}&PID_${productId.toUpperCase()}';
      if (result.exitCode == 0 &&
          '${result.stdout}'.toUpperCase().contains(pattern)) {
        return PrinterConnectionTestResult(
          status: PrinterConnectionTestStatus.success,
          code: PrinterConnectionTestCode.usbSuccess,
          message: 'usb_success',
          metadata: {'vendorId': vendorId, 'productId': productId},
        );
      }
      return PrinterConnectionTestResult(
        status: PrinterConnectionTestStatus.failure,
        code: PrinterConnectionTestCode.usbFailure,
        message: 'usb_failure',
        metadata: {'vendorId': vendorId, 'productId': productId},
      );
    } on ProcessException {
      return const PrinterConnectionTestResult(
        status: PrinterConnectionTestStatus.failure,
        code: PrinterConnectionTestCode.commandUnavailable,
        message: 'command_unavailable',
        metadata: {'command': 'powershell'},
      );
    }
  }

  Future<PrinterConnectionTestResult> _testUsbMacOs(
    String vendorId,
    String productId,
  ) async {
    try {
      final result = await _processRunner('ioreg', ['-p', 'IOUSB', '-l', '-w', '0']);
      final stdout = '${result.stdout}'.toLowerCase();
      final vendorPattern = 'idvendor = 0x${vendorId.toLowerCase()}';
      final productPattern = 'idproduct = 0x${productId.toLowerCase()}';
      if (result.exitCode == 0 &&
          stdout.contains(vendorPattern) &&
          stdout.contains(productPattern)) {
        return PrinterConnectionTestResult(
          status: PrinterConnectionTestStatus.success,
          code: PrinterConnectionTestCode.usbSuccess,
          message: 'usb_success',
          metadata: {'vendorId': vendorId, 'productId': productId},
        );
      }
      return PrinterConnectionTestResult(
        status: PrinterConnectionTestStatus.failure,
        code: PrinterConnectionTestCode.usbFailure,
        message: 'usb_failure',
        metadata: {'vendorId': vendorId, 'productId': productId},
      );
    } on ProcessException {
      return const PrinterConnectionTestResult(
        status: PrinterConnectionTestStatus.failure,
        code: PrinterConnectionTestCode.commandUnavailable,
        message: 'command_unavailable',
        metadata: {'command': 'ioreg'},
      );
    }
  }

  Future<PrinterConnectionTestResult> _testUsbLinux(
    String vendorId,
    String productId,
  ) async {
    try {
      final result = await _processRunner('lsusb', [
        '-d',
        '${vendorId.toLowerCase()}:${productId.toLowerCase()}',
      ]);
      if (result.exitCode == 0) {
        return PrinterConnectionTestResult(
          status: PrinterConnectionTestStatus.success,
          code: PrinterConnectionTestCode.usbSuccess,
          message: 'usb_success',
          metadata: {'vendorId': vendorId, 'productId': productId},
        );
      }
      return PrinterConnectionTestResult(
        status: PrinterConnectionTestStatus.failure,
        code: PrinterConnectionTestCode.usbFailure,
        message: 'usb_failure',
        metadata: {'vendorId': vendorId, 'productId': productId},
      );
    } on ProcessException {
      return const PrinterConnectionTestResult(
        status: PrinterConnectionTestStatus.failure,
        code: PrinterConnectionTestCode.commandUnavailable,
        message: 'command_unavailable',
        metadata: {'command': 'lsusb'},
      );
    }
  }

  static Future<ProcessResult> _defaultProcessRunner(
    String executable,
    List<String> arguments, {
    Duration? timeout,
  }) {
    return Process.run(executable, arguments).timeout(
      timeout ?? const Duration(seconds: 5),
    );
  }

  String? _normalizeUsbId(String? value) {
    if (value == null) {
      return null;
    }
    final normalized = value.trim().replaceFirst(RegExp(r'^0x', caseSensitive: false), '');
    if (normalized.length != 4 || !RegExp(r'^[0-9a-fA-F]{4}$').hasMatch(normalized)) {
      return null;
    }
    return normalized.toUpperCase();
  }
}
