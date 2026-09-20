import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qintrix/core/services/exports.dart';
import 'package:qintrix/data/models/exports.dart';
import 'package:qintrix/data/repositories/exports.dart';
import 'package:qintrix/features/printers/helpers/printer_form_validation.dart';
import 'package:qintrix/l10n/app_localizations.dart';
import 'package:qintrix/theme/tokens/color_tokens.dart';

import 'printers_state.dart';

class PrintersCubit extends Cubit<PrintersState> {
  PrintersCubit({
    required PrintersRepository repository,
    required PrinterConnectionTestService connectionTestService,
    required LoggerService logger,
  }) : _repository = repository,
       _connectionTestService = connectionTestService,
       _logger = logger,
       super(const PrintersState.initial());

  final PrintersRepository _repository;
  final PrinterConnectionTestService _connectionTestService;
  final LoggerService _logger;

  Timer? _feedbackTimer;
  int _feedbackId = 0;

  Future<void> load({bool reset = false}) async {
    final query = reset ? const PrintersQuery() : state.query;
    emit(
      state.copyWith(
        status: PrintersStatus.loading,
        errorMessage: null,
        feedback: null,
        query: query,
        mode: reset ? PrintersViewMode.listing : state.mode,
        activePrinter: reset ? null : state.activePrinter,
        selectedIds: reset ? const <String>{} : state.selectedIds,
      ),
    );

    try {
      final result = await _repository.queryPrinters(query);
      final printers = result.items;
      emit(
        state.copyWith(
          status: PrintersStatus.loaded,
          printers: printers,
          totalCount: result.totalCount,
          query: query,
          selectedIds: state.selectedIds
              .where((id) => printers.any((printer) => printer.id == id))
              .toSet(),
          errorMessage: null,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: PrintersStatus.failure,
          errorMessage: error.toString(),
        ),
      );
    }
  }

  Future<void> updateSearch(String value) {
    return _loadQuery(state.query.copyWith(search: value, page: 0));
  }

  Future<void> updateConnectionType(String value) {
    return _loadQuery(state.query.copyWith(connectionType: value, page: 0));
  }

  Future<void> updateStatus(String value) {
    return _loadQuery(state.query.copyWith(status: value, page: 0));
  }

  Future<void> resetFilters() {
    return _loadQuery(const PrintersQuery());
  }

  Future<void> updatePage(int page) {
    return _loadQuery(state.query.copyWith(page: page));
  }

  Future<void> updateRowsPerPage(int pageSize) {
    return _loadQuery(state.query.copyWith(pageSize: pageSize, page: 0));
  }

  void showCreate() {
    emit(
      state.copyWith(
        mode: PrintersViewMode.create,
        activePrinter: null,
        feedback: null,
      ),
    );
  }

  void showPrinter(PrinterModel printer) {
    emit(
      state.copyWith(
        mode: PrintersViewMode.show,
        activePrinter: printer,
        feedback: null,
      ),
    );
  }

  void editPrinter(PrinterModel printer) {
    emit(
      state.copyWith(
        mode: PrintersViewMode.edit,
        activePrinter: printer,
        feedback: null,
      ),
    );
  }

  void backToIndex() {
    emit(
      state.copyWith(
        mode: PrintersViewMode.listing,
        activePrinter: null,
        feedback: null,
      ),
    );
  }

  void backToShow() {
    emit(
      state.copyWith(
        mode: state.activePrinter == null
            ? PrintersViewMode.listing
            : PrintersViewMode.show,
        feedback: null,
      ),
    );
  }

  void toggleSelection(String id) {
    final next = Set<String>.of(state.selectedIds);
    if (!next.add(id)) {
      next.remove(id);
    }
    emit(state.copyWith(selectedIds: next));
  }

  Future<void> savePrinter(PrinterModel printer, AppLocalizations l10n) async {
    final isCreate = state.mode == PrintersViewMode.create;
    final validationMessage = await validatePrinter(printer, l10n);
    if (validationMessage != null) {
      _emitFeedback(validationMessage, tone: AppStatusTone.error);
      return;
    }

    emit(state.copyWith(status: PrintersStatus.saving, errorMessage: null));

    try {
      await _repository.savePrinter(printer);
      final refreshed = await _repository.getPrinterById(printer.id);
      final result = await _repository.queryPrinters(state.query);
      final printers = result.items;

      emit(
        state.copyWith(
          status: PrintersStatus.loaded,
          printers: printers,
          totalCount: result.totalCount,
          selectedIds: state.selectedIds
              .where((id) => printers.any((item) => item.id == id))
              .toSet(),
          activePrinter: refreshed ?? printer,
          mode: PrintersViewMode.show,
          errorMessage: null,
        ),
      );

      _emitFeedback(
        isCreate ? l10n.printersCreatedSuccess : l10n.printersUpdatedSuccess,
        tone: AppStatusTone.success,
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: PrintersStatus.failure,
          errorMessage: error.toString(),
        ),
      );
    }
  }

  Future<void> testConnection(
    PrinterModel printer,
    AppLocalizations l10n,
  ) async {
    final validationMessage = await validatePrinter(printer, l10n);
    if (validationMessage != null) {
      _emitFeedback(validationMessage, tone: AppStatusTone.error);
      return;
    }

    final result = await _connectionTestService.testConnection(printer);
    await _logger.logPrinterTestResult(result.message);
    await _persistPrinterStatus(
      printer,
      statusKey: switch (result.status) {
        PrinterConnectionTestStatus.success => 'test_success',
        PrinterConnectionTestStatus.failure => 'test_failure',
        PrinterConnectionTestStatus.notSupported => 'test_not_supported',
      },
      statusMessage: _buildStoredConnectionStatus(result),
    );

    _emitFeedback(
      _mapConnectionTestMessage(result, l10n),
      tone: switch (result.status) {
        PrinterConnectionTestStatus.success => AppStatusTone.success,
        PrinterConnectionTestStatus.failure => AppStatusTone.error,
        PrinterConnectionTestStatus.notSupported => AppStatusTone.info,
      },
    );
  }

  void notifyIdentifierCopied(AppLocalizations l10n) {
    _emitFeedback(
      l10n.printersIdentifierCopied,
      tone: AppStatusTone.info,
      duration: const Duration(milliseconds: 1400),
    );
  }

  Future<void> deletePrinter(
    PrinterModel printer,
    AppLocalizations l10n,
  ) async {
    await _repository.deletePrinter(printer.id);
    final result = await _repository.queryPrinters(state.query);
    final printers = result.items;

    emit(
      state.copyWith(
        status: PrintersStatus.loaded,
        printers: printers,
        totalCount: result.totalCount,
        selectedIds: Set<String>.of(state.selectedIds)..remove(printer.id),
        activePrinter: state.activePrinter?.id == printer.id
            ? null
            : state.activePrinter,
        mode: state.activePrinter?.id == printer.id
            ? PrintersViewMode.listing
            : state.mode,
        errorMessage: null,
      ),
    );

    _emitFeedback(l10n.printersDeletedSuccess, tone: AppStatusTone.success);
  }

  Future<void> deleteSelected(AppLocalizations l10n) async {
    await _repository.deletePrinters(state.selectedIds.toList(growable: false));
    final result = await _repository.queryPrinters(state.query);
    final printers = result.items;

    emit(
      state.copyWith(
        status: PrintersStatus.loaded,
        printers: printers,
        totalCount: result.totalCount,
        selectedIds: const <String>{},
        activePrinter: null,
        mode: PrintersViewMode.listing,
        errorMessage: null,
      ),
    );

    _emitFeedback(l10n.printersBulkDeletedSuccess, tone: AppStatusTone.success);
  }

  Future<String?> validatePrinter(
    PrinterModel printer,
    AppLocalizations l10n,
  ) async {
    if (printer.uniqueKey.trim().isEmpty) {
      return l10n.printersValidationRequired;
    }

    final duplicate = await _repository.uniqueKeyExists(
      printer.uniqueKey,
      excludingId: printer.id,
    );
    if (duplicate) {
      return l10n.printersValidationUniqueKey;
    }

    final crossFieldError =
        PrinterFormValidation.validateConnectionSpecificRules(printer);
    if (crossFieldError == null) {
      return null;
    }

    return switch (crossFieldError) {
      'usb-endpoints-match' => l10n.printersValidationDistinctEndpoints,
      'invalid-spool-format' => l10n.printersValidationSpoolFormat,
      _ => l10n.errorDescription,
    };
  }

  String _mapConnectionTestMessage(
    PrinterConnectionTestResult result,
    AppLocalizations l10n,
  ) {
    final details = switch (result.code) {
      PrinterConnectionTestCode.tcpMissingConfig =>
        l10n.printersTestTcpMissingConfig,
      PrinterConnectionTestCode.tcpSuccess => l10n.printersTestTcpSuccess(
        result.metadata['host'] ?? '-',
        result.metadata['port'] ?? '-',
      ),
      PrinterConnectionTestCode.tcpTimeout => l10n.printersTestTcpTimeout(
        result.metadata['host'] ?? '-',
        result.metadata['port'] ?? '-',
      ),
      PrinterConnectionTestCode.tcpFailure => l10n.printersTestTcpFailure(
        result.metadata['host'] ?? '-',
        result.metadata['port'] ?? '-',
        result.metadata['error'] ?? '-',
      ),
      PrinterConnectionTestCode.systemMissingConfig =>
        l10n.printersTestSystemMissingConfig,
      PrinterConnectionTestCode.systemSuccess => l10n.printersTestSystemSuccess(
        result.metadata['name'] ?? '-',
      ),
      PrinterConnectionTestCode.systemFailure => l10n.printersTestSystemFailure(
        result.metadata['name'] ?? '-',
      ),
      PrinterConnectionTestCode.usbMissingConfig =>
        l10n.printersTestUsbMissingConfig,
      PrinterConnectionTestCode.usbSuccess => l10n.printersTestUsbSuccess(
        result.metadata['vendorId'] ?? '-',
        result.metadata['productId'] ?? '-',
      ),
      PrinterConnectionTestCode.usbFailure => l10n.printersTestUsbFailure(
        result.metadata['vendorId'] ?? '-',
        result.metadata['productId'] ?? '-',
      ),
      PrinterConnectionTestCode.commandUnavailable =>
        l10n.printersTestCommandUnavailable(result.metadata['command'] ?? '-'),
      PrinterConnectionTestCode.unsupportedPlatform =>
        l10n.printersTestUnsupportedPlatform,
      null => result.message,
    };

    return switch (result.status) {
      PrinterConnectionTestStatus.success => l10n.printersTestConnectionSuccess(
        details,
      ),
      PrinterConnectionTestStatus.failure => l10n.printersTestConnectionFailure(
        details,
      ),
      PrinterConnectionTestStatus.notSupported =>
        l10n.printersTestConnectionNotSupported(details),
    };
  }

  String _buildStoredConnectionStatus(PrinterConnectionTestResult result) {
    return switch (result.code) {
      PrinterConnectionTestCode.tcpMissingConfig =>
        'Test failed: TCP host/port is missing.',
      PrinterConnectionTestCode.tcpSuccess =>
        'Test succeeded: TCP ${result.metadata['host'] ?? '-'}:${result.metadata['port'] ?? '-'} is reachable.',
      PrinterConnectionTestCode.tcpTimeout =>
        'Test failed: TCP ${result.metadata['host'] ?? '-'}:${result.metadata['port'] ?? '-'} timed out.',
      PrinterConnectionTestCode.tcpFailure =>
        'Test failed: TCP ${result.metadata['host'] ?? '-'}:${result.metadata['port'] ?? '-'} returned ${result.metadata['error'] ?? 'an unknown error'}.',
      PrinterConnectionTestCode.systemMissingConfig =>
        'Test failed: spooler printer name is missing.',
      PrinterConnectionTestCode.systemSuccess =>
        'Test succeeded: spooler queue ${result.metadata['name'] ?? '-'} is available.',
      PrinterConnectionTestCode.systemFailure =>
        'Test failed: spooler queue ${result.metadata['name'] ?? '-'} is unavailable.',
      PrinterConnectionTestCode.usbMissingConfig =>
        'Test failed: USB vendor/product ID is missing.',
      PrinterConnectionTestCode.usbSuccess =>
        'Test succeeded: USB ${result.metadata['vendorId'] ?? '-'}:${result.metadata['productId'] ?? '-'} is available.',
      PrinterConnectionTestCode.usbFailure =>
        'Test failed: USB ${result.metadata['vendorId'] ?? '-'}:${result.metadata['productId'] ?? '-'} is unavailable.',
      PrinterConnectionTestCode.commandUnavailable =>
        'Test failed: required command ${result.metadata['command'] ?? '-'} is unavailable.',
      PrinterConnectionTestCode.unsupportedPlatform =>
        'Test not supported on this platform.',
      null => result.message,
    };
  }

  Future<void> _persistPrinterStatus(
    PrinterModel printer,
    {
    required String statusKey,
    required String statusMessage,
  }
  ) async {
    final updatedPrinter = printer.copyWith(
      lastStatus: statusMessage,
      lastStatusKey: statusKey,
      lastStatusMessage: statusMessage,
      updatedAt: DateTime.now(),
    );
    await _repository.savePrinter(updatedPrinter);

    emit(
      state.copyWith(
        printers: state.printers
            .map((item) => item.id == updatedPrinter.id ? updatedPrinter : item)
            .toList(growable: false),
        activePrinter: state.activePrinter?.id == updatedPrinter.id
            ? updatedPrinter
            : state.activePrinter,
      ),
    );
  }

  void _emitFeedback(
    String message, {
    required AppStatusTone tone,
    String? title,
    Duration duration = const Duration(seconds: 3),
  }) {
    _feedbackTimer?.cancel();
    final feedback = PrintersFeedback(
      id: ++_feedbackId,
      title: title,
      message: message,
      tone: tone,
    );
    emit(state.copyWith(feedback: feedback));

    _feedbackTimer = Timer(duration, () {
      if (state.feedback?.id == feedback.id) {
        emit(state.copyWith(feedback: null));
      }
    });
  }

  @override
  Future<void> close() {
    _feedbackTimer?.cancel();
    return super.close();
  }

  Future<void> _loadQuery(PrintersQuery query) async {
    emit(
      state.copyWith(
        status: PrintersStatus.loading,
        errorMessage: null,
        feedback: null,
        query: query,
      ),
    );

    try {
      final result = await _repository.queryPrinters(query);
      final printers = result.items;
      emit(
        state.copyWith(
          status: PrintersStatus.loaded,
          printers: printers,
          totalCount: result.totalCount,
          query: query,
          selectedIds: state.selectedIds
              .where((id) => printers.any((printer) => printer.id == id))
              .toSet(),
          errorMessage: null,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: PrintersStatus.failure,
          errorMessage: error.toString(),
        ),
      );
    }
  }
}
