import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_flutter/lucide_flutter.dart';
import 'package:qintrix/core/widgets/exports.dart';
import 'package:qintrix/data/models/exports.dart';
import 'package:qintrix/features/printers/helpers/printer_form_options.dart';
import 'package:qintrix/features/printers/helpers/printer_form_validation.dart';
import 'package:qintrix/features/printers/helpers/printer_unique_key_generator.dart';
import 'package:qintrix/l10n/app_localizations.dart';
import 'package:uuid/uuid.dart';

class PrinterEditorView extends StatefulWidget {
  const PrinterEditorView({
    required this.modeLabel,
    required this.onCancel,
    required this.onSubmit,
    required this.onTestConnection,
    required this.onCopyIdentifier,
    this.initialPrinter,
    super.key,
  });

  final String modeLabel;
  final PrinterModel? initialPrinter;
  final ValueChanged<PrinterModel> onSubmit;
  final ValueChanged<PrinterModel> onTestConnection;
  final ValueChanged<String> onCopyIdentifier;
  final VoidCallback onCancel;

  @override
  State<PrinterEditorView> createState() => _PrinterEditorViewState();
}

class _PrinterEditorViewState extends State<PrinterEditorView> {
  static const Uuid _uuid = Uuid();

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _uniqueKeyController = TextEditingController();
  final _descriptionController = TextEditingController();

  final _tcpHostController = TextEditingController();
  final _tcpPortController = TextEditingController();
  final _tcpConnectTimeoutController = TextEditingController();
  final _tcpWriteTimeoutController = TextEditingController();
  final _tcpReadTimeoutController = TextEditingController();
  final _tcpReconnectDelayController = TextEditingController();
  final _tcpLingerController = TextEditingController();

  final _systemPrinterNameController = TextEditingController();
  final _systemDefaultCopiesController = TextEditingController();
  final _systemJobTimeoutController = TextEditingController();
  final _systemNotesController = TextEditingController();
  final _systemDriverNameController = TextEditingController();
  final _systemQueueNameController = TextEditingController();

  final _usbVendorIdController = TextEditingController();
  final _usbProductIdController = TextEditingController();
  final _usbSerialNumberController = TextEditingController();
  final _usbInterfaceNumberController = TextEditingController();
  final _usbOutEndpointController = TextEditingController();
  final _usbInEndpointController = TextEditingController();
  final _usbTimeoutController = TextEditingController();
  final _usbDrawerPinController = TextEditingController();
  final _usbManufacturerController = TextEditingController();
  final _usbProductNameController = TextEditingController();
  final _usbAlternateSettingController = TextEditingController();
  final _usbPacketDelayController = TextEditingController();

  PrinterConnectionType _connectionType = PrinterConnectionType.networkTcp;
  bool _isEnabled = true;
  bool _tcpAutoReconnect = false;
  bool _tcpKeepAlive = false;
  bool _tcpNoDelay = false;
  bool _systemColorEnabled = false;
  bool _systemUseRawSpool = false;
  bool _usbStatusMonitoringEnabled = false;
  bool _usbAutoCutEnabled = false;
  bool _usbCashDrawerEnabled = false;

  String _tcpEncoding = '';
  String _tcpCodePage = '';
  String _tcpLineEnding = '';
  String _systemPaperSize = '';
  String _systemDuplexMode = '';
  String _systemOrientation = '';
  String _systemSpoolFormat = '';
  String _usbEncoding = '';
  String _usbCodePage = '';
  String _usbCharacterTable = '';
  String _usbCutMode = '';
  String _rawGraphicsMode = 'modern';

  bool _showAdvanced = false;
  bool _saveAttempted = false;

  @override
  void initState() {
    super.initState();
    final printer = widget.initialPrinter;
    if (printer == null) {
      _uniqueKeyController.text = PrinterUniqueKeyGenerator.generate();
      _systemDefaultCopiesController.text = '1';
      return;
    }

    _nameController.text = printer.name;
    _uniqueKeyController.text = printer.uniqueKey;
    _descriptionController.text = printer.description ?? '';
    _connectionType = printer.connectionType;
    _isEnabled = printer.isEnabled;

    _tcpHostController.text = printer.tcpHost ?? '';
    _tcpPortController.text = _intLabel(printer.tcpPort);
    _tcpConnectTimeoutController.text = _intLabel(printer.tcpConnectTimeoutMs);
    _tcpWriteTimeoutController.text = _intLabel(printer.tcpWriteTimeoutMs);
    _tcpReadTimeoutController.text = _intLabel(printer.tcpReadTimeoutMs);
    _tcpAutoReconnect = printer.tcpAutoReconnect;
    _tcpReconnectDelayController.text = _intLabel(printer.tcpReconnectDelayMs);
    _tcpEncoding = printer.tcpEncoding ?? '';
    _tcpCodePage = printer.tcpCodePage ?? '';
    _tcpLineEnding = printer.tcpLineEnding ?? '';
    _tcpKeepAlive = printer.tcpKeepAlive;
    _tcpNoDelay = printer.tcpNoDelay;
    _tcpLingerController.text = _intLabel(printer.tcpLingerSeconds);

    _systemPrinterNameController.text = printer.systemPrinterName ?? '';
    _systemPaperSize = printer.systemPaperSize ?? '';
    _systemDefaultCopiesController.text = '${printer.systemDefaultCopies}';
    _systemColorEnabled = printer.systemColorEnabled;
    _systemDuplexMode = printer.systemDuplexMode ?? '';
    _systemOrientation = printer.systemOrientation ?? '';
    _systemJobTimeoutController.text = _intLabel(printer.systemJobTimeoutMs);
    _systemNotesController.text = printer.systemNotes ?? '';
    _systemDriverNameController.text = printer.systemDriverName ?? '';
    _systemQueueNameController.text = printer.systemQueueName ?? '';
    _systemSpoolFormat = printer.systemSpoolFormat ?? '';
    _systemUseRawSpool = printer.systemUseRawSpool;

    _usbVendorIdController.text = printer.usbVendorId ?? '';
    _usbProductIdController.text = printer.usbProductId ?? '';
    _usbSerialNumberController.text = printer.usbSerialNumber ?? '';
    _usbInterfaceNumberController.text = _intLabel(printer.usbInterfaceNumber);
    _usbOutEndpointController.text = _intLabel(printer.usbOutEndpoint);
    _usbInEndpointController.text = _intLabel(printer.usbInEndpoint);
    _usbTimeoutController.text = _intLabel(printer.usbTimeoutMs);
    _usbEncoding = printer.usbEncoding ?? '';
    _usbCodePage = printer.usbCodePage ?? '';
    _usbCharacterTable = printer.usbCharacterTable ?? '';
    _usbStatusMonitoringEnabled = printer.usbStatusMonitoringEnabled;
    _usbAutoCutEnabled = printer.usbAutoCutEnabled;
    _usbCutMode = printer.usbCutMode ?? '';
    _usbCashDrawerEnabled = printer.usbCashDrawerEnabled;
    _usbDrawerPinController.text = _intLabel(printer.usbDrawerPin);
    _usbManufacturerController.text = printer.usbManufacturer ?? '';
    _usbProductNameController.text = printer.usbProductName ?? '';
    _usbAlternateSettingController.text = _intLabel(
      printer.usbAlternateSetting,
    );
    _usbPacketDelayController.text = _intLabel(printer.usbPacketDelayMs);
    _rawGraphicsMode = printer.rawGraphicsMode ?? 'modern';
  }

  @override
  void dispose() {
    for (final controller in [
      _nameController,
      _uniqueKeyController,
      _descriptionController,
      _tcpHostController,
      _tcpPortController,
      _tcpConnectTimeoutController,
      _tcpWriteTimeoutController,
      _tcpReadTimeoutController,
      _tcpReconnectDelayController,
      _tcpLingerController,
      _systemPrinterNameController,
      _systemDefaultCopiesController,
      _systemJobTimeoutController,
      _systemNotesController,
      _systemDriverNameController,
      _systemQueueNameController,
      _usbVendorIdController,
      _usbProductIdController,
      _usbSerialNumberController,
      _usbInterfaceNumberController,
      _usbOutEndpointController,
      _usbInEndpointController,
      _usbTimeoutController,
      _usbDrawerPinController,
      _usbManufacturerController,
      _usbProductNameController,
      _usbAlternateSettingController,
      _usbPacketDelayController,
    ]) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Form(
      key: _formKey,
      autovalidateMode: _saveAttempted
          ? AutovalidateMode.always
          : AutovalidateMode.disabled,
      child: ListView(
        children: [
          Row(
            children: [
              AppButton(
                label: l10n.cancel,
                variant: AppButtonVariant.secondary,
                leading: LucideIcons.arrowLeft,
                onPressed: widget.onCancel,
              ),
              const Spacer(),
              AppButton(
                label: widget.modeLabel,
                leading: LucideIcons.save,
                onPressed: _handleSubmit,
              ),
              const SizedBox(width: 10),
              AppButton(
                label: l10n.printersTestConnectionAction,
                variant: AppButtonVariant.secondary,
                leading: LucideIcons.plugZap,
                onPressed: _handleTestConnection,
              ),
            ],
          ),
          const SizedBox(height: 18),
          AppSectionCard(
            title: l10n.printersFormOverviewTitle,
            child: FormGrid(
              children: [
                AppTextField(
                  label: l10n.printersFieldName,
                  required: true,
                  controller: _nameController,
                  validator: (value) => _mapError(_validateName(value), l10n),
                ),
                AppTextField(
                  label: l10n.printersFieldIdentifier,
                  required: true,
                  controller: _uniqueKeyController,
                  readOnly: true,
                  helperText: l10n.printersUniqueKeyHelper,
                  suffixIcon: _CopyFieldButton(
                    tooltip: l10n.printersCopyIdentifierAction,
                    onPressed: () =>
                        widget.onCopyIdentifier(_uniqueKeyController.text),
                  ),
                ),
                AppDropdownField<PrinterConnectionType>(
                  label: l10n.printersFieldConnectionType,
                  required: true,
                  value: _connectionType,
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    setState(() {
                      _connectionType = value;
                    });
                  },
                  items: [
                    DropdownMenuItem(
                      value: PrinterConnectionType.networkTcp,
                      child: Text(l10n.printersTypeTcp),
                    ),
                    DropdownMenuItem(
                      value: PrinterConnectionType.systemSpooler,
                      child: Text(l10n.printersTypeSystem),
                    ),
                    DropdownMenuItem(
                      value: PrinterConnectionType.usbRawEscPos,
                      child: Text(l10n.printersTypeUsbRaw),
                    ),
                  ],
                ),
                AppSwitchField(
                  label: l10n.printersFieldEnabled,
                  value: _isEnabled,
                  onChanged: (value) {
                    setState(() {
                      _isEnabled = value;
                    });
                  },
                ),
                AppMultilineField(
                  label: l10n.printersFieldDescription,
                  controller: _descriptionController,
                  hintText: l10n.printersDescriptionHint,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          AppSectionCard(
            title: _connectionTitle(l10n),
            subtitle: l10n.printersBasicSectionTitle,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FormGrid(children: _connectionBasicFields(context, l10n)),
                const SizedBox(height: 16),
                ExpansionTile(
                  key: const ValueKey('printer-advanced-tile'),
                  initiallyExpanded: _showAdvanced,
                  onExpansionChanged: (expanded) {
                    setState(() {
                      _showAdvanced = expanded;
                    });
                  },
                  title: Text(l10n.printersAdvancedSectionTitle),
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                      child: FormGrid(
                        children: _connectionAdvancedFields(context, l10n),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _connectionBasicFields(
    BuildContext context,
    AppLocalizations l10n,
  ) {
    return switch (_connectionType) {
      PrinterConnectionType.networkTcp => [
        _stringDropdown(
          context,
          l10n.printersFieldPaperSize,
          _systemPaperSize,
          PrinterFormOptions.receiptPaperSizes,
          (value) => setState(() => _systemPaperSize = value ?? ''),
        ),
        _textField(
          context,
          l10n.printersFieldHost,
          _tcpHostController,
          required: true,
          validator: (value) => _mapError(_validateApp(value), l10n),
        ),
        _integerField(
          context,
          l10n.printersFieldPort,
          _tcpPortController,
          required: true,
          validator: (value) => _mapError(_validatePort(value), l10n),
        ),
        _integerField(
          context,
          l10n.printersFieldConnectTimeout,
          _tcpConnectTimeoutController,
          validator: (value) =>
              _mapError(_validateTimeout(value, required: false), l10n),
        ),
        _integerField(
          context,
          l10n.printersFieldWriteTimeout,
          _tcpWriteTimeoutController,
          validator: (value) =>
              _mapError(_validateTimeout(value, required: false), l10n),
        ),
        _integerField(
          context,
          l10n.printersFieldReadTimeout,
          _tcpReadTimeoutController,
          validator: (value) =>
              _mapError(_validateTimeout(value, required: false), l10n),
        ),
        AppSwitchField(
          value: _tcpAutoReconnect,
          label: l10n.printersFieldAutoReconnect,
          onChanged: (value) {
            setState(() {
              _tcpAutoReconnect = value;
              if (!value) {
                _tcpReconnectDelayController.clear();
              }
            });
          },
        ),
        if (_tcpAutoReconnect)
          _integerField(
            context,
            l10n.printersFieldReconnectDelay,
            _tcpReconnectDelayController,
            required: true,
            validator: (value) =>
                _mapError(_validateReconnectDelay(value, required: true), l10n),
          ),
        _stringDropdown(
          context,
          l10n.printersFieldEncoding,
          _tcpEncoding,
          PrinterFormOptions.encodings,
          (value) => setState(() => _tcpEncoding = value ?? ''),
        ),
        _stringDropdown(
          context,
          l10n.printersFieldCodePage,
          _tcpCodePage,
          PrinterFormOptions.codePages,
          (value) => setState(() => _tcpCodePage = value ?? ''),
        ),
        _stringDropdown(
          context,
          l10n.printersFieldLineEnding,
          _tcpLineEnding,
          PrinterFormOptions.lineEndings,
          (value) => setState(() => _tcpLineEnding = value ?? ''),
        ),
        AppSwitchField(
          value: _usbAutoCutEnabled,
          label: l10n.printersFieldAutoCutEnabled,
          onChanged: (value) {
            setState(() {
              _usbAutoCutEnabled = value;
              if (!value) {
                _usbCutMode = '';
              }
            });
          },
        ),
        if (_usbAutoCutEnabled)
          _stringDropdown(
            context,
            l10n.printersFieldCutMode,
            _usbCutMode,
            PrinterFormOptions.cutModes,
            (value) => setState(() => _usbCutMode = value ?? ''),
          ),
        AppSwitchField(
          value: _usbCashDrawerEnabled,
          label: l10n.printersFieldCashDrawerEnabled,
          onChanged: (value) {
            setState(() {
              _usbCashDrawerEnabled = value;
              if (!value) {
                _usbDrawerPinController.clear();
              }
            });
          },
        ),
        if (_usbCashDrawerEnabled)
          _integerField(
            context,
            l10n.printersFieldDrawerPin,
            _usbDrawerPinController,
            required: true,
            validator: (value) => _mapError(_validateDrawerPin(value), l10n),
          ),
      ],
      PrinterConnectionType.systemSpooler => [
        _textField(
          context,
          l10n.printersFieldPrinterName,
          _systemPrinterNameController,
          required: true,
          validator: (value) => _mapError(_validatePrinterName(value), l10n),
        ),
        _stringDropdown(
          context,
          l10n.printersFieldPaperSize,
          _systemPaperSize,
          PrinterFormOptions.receiptPaperSizes,
          (value) => setState(() => _systemPaperSize = value ?? ''),
        ),
        _integerField(
          context,
          l10n.printersFieldDefaultCopies,
          _systemDefaultCopiesController,
          validator: (value) => _mapError(_validateCopies(value), l10n),
        ),
        AppSwitchField(
          value: _systemColorEnabled,
          label: l10n.printersFieldColorEnabled,
          onChanged: (value) {
            setState(() {
              _systemColorEnabled = value;
            });
          },
        ),
        _stringDropdown(
          context,
          l10n.printersFieldDuplexMode,
          _systemDuplexMode,
          PrinterFormOptions.duplexModes,
          (value) => setState(() => _systemDuplexMode = value ?? ''),
        ),
        _stringDropdown(
          context,
          l10n.printersFieldOrientation,
          _systemOrientation,
          PrinterFormOptions.orientations,
          (value) => setState(() => _systemOrientation = value ?? ''),
        ),
        _integerField(
          context,
          l10n.printersFieldJobTimeout,
          _systemJobTimeoutController,
          validator: (value) =>
              _mapError(_validateTimeout(value, required: false), l10n),
        ),
        SizedBox(
          width: 400,
          child: AppMultilineField(
            label: l10n.printersFieldNotes,
            controller: _systemNotesController,
          ),
        ),
      ],
      PrinterConnectionType.usbRawEscPos => [
        _stringDropdown(
          context,
          l10n.printersFieldPaperSize,
          _systemPaperSize,
          PrinterFormOptions.paperSizes,
          (value) => setState(() => _systemPaperSize = value ?? ''),
        ),
        _textField(
          context,
          l10n.printersFieldVendorId,
          _usbVendorIdController,
          required: true,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[0-9a-fA-FxX]')),
          ],
          validator: (value) => _mapError(_validateUsbId(value), l10n),
        ),
        _textField(
          context,
          l10n.printersFieldProductId,
          _usbProductIdController,
          required: true,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[0-9a-fA-FxX]')),
          ],
          validator: (value) => _mapError(_validateUsbId(value), l10n),
        ),
        _textField(
          context,
          l10n.printersFieldSerialNumber,
          _usbSerialNumberController,
          validator: (value) => _mapError(
            PrinterFormValidation.validateOptionalText(value, maxLength: 255),
            l10n,
          ),
        ),
        _integerField(
          context,
          l10n.printersFieldInterfaceNumber,
          _usbInterfaceNumberController,
          validator: (value) => _mapError(
            PrinterFormValidation.validateIntegerField(value, min: 0, max: 255),
            l10n,
          ),
        ),
        _textField(
          context,
          l10n.printersFieldOutEndpoint,
          _usbOutEndpointController,
          validator: (value) => _mapError(_validateEndpoint(value), l10n),
        ),
        if (_usbStatusMonitoringEnabled)
          _textField(
            context,
            l10n.printersFieldInEndpoint,
            _usbInEndpointController,
            validator: (value) => _mapError(_validateInEndpoint(value), l10n),
          ),
        _integerField(
          context,
          l10n.printersFieldTimeout,
          _usbTimeoutController,
          validator: (value) =>
              _mapError(_validateTimeout(value, required: false), l10n),
        ),
        _stringDropdown(
          context,
          l10n.printersFieldEncoding,
          _usbEncoding,
          PrinterFormOptions.encodings,
          (value) => setState(() => _usbEncoding = value ?? ''),
        ),
        _stringDropdown(
          context,
          l10n.printersFieldCodePage,
          _usbCodePage,
          PrinterFormOptions.codePages,
          (value) => setState(() => _usbCodePage = value ?? ''),
        ),
        _stringDropdown(
          context,
          l10n.printersFieldCharacterTable,
          _usbCharacterTable,
          PrinterFormOptions.characterTables,
          (value) => setState(() => _usbCharacterTable = value ?? ''),
        ),
        AppSwitchField(
          value: _usbStatusMonitoringEnabled,
          label: l10n.printersFieldStatusMonitoring,
          onChanged: (value) {
            setState(() {
              _usbStatusMonitoringEnabled = value;
              if (!value) {
                _usbInEndpointController.clear();
              }
            });
          },
        ),
        AppSwitchField(
          value: _usbAutoCutEnabled,
          label: l10n.printersFieldAutoCutEnabled,
          onChanged: (value) {
            setState(() {
              _usbAutoCutEnabled = value;
              if (!value) {
                _usbCutMode = '';
              }
            });
          },
        ),
        if (_usbAutoCutEnabled)
          _stringDropdown(
            context,
            l10n.printersFieldCutMode,
            _usbCutMode,
            PrinterFormOptions.cutModes,
            (value) => setState(() => _usbCutMode = value ?? ''),
          ),
        AppSwitchField(
          value: _usbCashDrawerEnabled,
          label: l10n.printersFieldCashDrawerEnabled,
          onChanged: (value) {
            setState(() {
              _usbCashDrawerEnabled = value;
              if (!value) {
                _usbDrawerPinController.clear();
              }
            });
          },
        ),
        if (_usbCashDrawerEnabled)
          _integerField(
            context,
            l10n.printersFieldDrawerPin,
            _usbDrawerPinController,
            required: true,
            validator: (value) => _mapError(_validateDrawerPin(value), l10n),
          ),
      ],
    };
  }

  List<Widget> _connectionAdvancedFields(
    BuildContext context,
    AppLocalizations l10n,
  ) {
    return switch (_connectionType) {
      PrinterConnectionType.networkTcp => [
        AppSwitchField(
          value: _tcpKeepAlive,
          label: l10n.printersFieldKeepAlive,
          onChanged: (value) => setState(() => _tcpKeepAlive = value),
        ),
        AppSwitchField(
          value: _tcpNoDelay,
          label: l10n.printersFieldNoDelay,
          onChanged: (value) => setState(() => _tcpNoDelay = value),
        ),
        _integerField(
          context,
          l10n.printersFieldLinger,
          _tcpLingerController,
          validator: (value) => _mapError(
            PrinterFormValidation.validateIntegerField(value, min: 0, max: 120),
            l10n,
          ),
        ),
        _stringDropdown(
          context,
          l10n.printersFieldRawGraphicsMode,
          _rawGraphicsMode,
          PrinterFormOptions.rawGraphicsModes,
          (value) => setState(() => _rawGraphicsMode = value ?? 'modern'),
          itemLabelBuilder: (value) => _rawGraphicsModeLabel(l10n, value),
        ),
      ],
      PrinterConnectionType.systemSpooler => [
        _textField(
          context,
          l10n.printersFieldDriverName,
          _systemDriverNameController,
          validator: (value) => _mapError(
            PrinterFormValidation.validateOptionalText(value, maxLength: 255),
            l10n,
          ),
        ),
        _textField(
          context,
          l10n.printersFieldQueueName,
          _systemQueueNameController,
          validator: (value) => _mapError(
            PrinterFormValidation.validateOptionalText(value, maxLength: 255),
            l10n,
          ),
        ),
        _stringDropdown(
          context,
          l10n.printersFieldSpoolFormat,
          _systemSpoolFormat,
          PrinterFormOptions.spoolFormats,
          (value) => setState(() => _systemSpoolFormat = value ?? ''),
        ),
        AppSwitchField(
          value: _systemUseRawSpool,
          label: l10n.printersFieldUseRawSpool,
          onChanged: (value) => setState(() => _systemUseRawSpool = value),
        ),
      ],
      PrinterConnectionType.usbRawEscPos => [
        _textField(
          context,
          l10n.printersFieldManufacturer,
          _usbManufacturerController,
          validator: (value) => _mapError(
            PrinterFormValidation.validateOptionalText(value, maxLength: 255),
            l10n,
          ),
        ),
        _textField(
          context,
          l10n.printersFieldProductName,
          _usbProductNameController,
          validator: (value) => _mapError(
            PrinterFormValidation.validateOptionalText(value, maxLength: 255),
            l10n,
          ),
        ),
        _integerField(
          context,
          l10n.printersFieldAlternateSetting,
          _usbAlternateSettingController,
          validator: (value) => _mapError(
            PrinterFormValidation.validateIntegerField(value, min: 0, max: 255),
            l10n,
          ),
        ),
        _integerField(
          context,
          l10n.printersFieldPacketDelay,
          _usbPacketDelayController,
          validator: (value) => _mapError(
            PrinterFormValidation.validateIntegerField(
              value,
              min: 0,
              max: 5000,
            ),
            l10n,
          ),
        ),
        _stringDropdown(
          context,
          l10n.printersFieldRawGraphicsMode,
          _rawGraphicsMode,
          PrinterFormOptions.rawGraphicsModes,
          (value) => setState(() => _rawGraphicsMode = value ?? 'modern'),
          itemLabelBuilder: (value) => _rawGraphicsModeLabel(l10n, value),
        ),
      ],
    };
  }

  void _handleSubmit() {
    final printer = _validateAndBuildPrinter();
    if (printer == null) {
      return;
    }

    widget.onSubmit(printer);
  }

  void _handleTestConnection() {
    final printer = _validateAndBuildPrinter();
    if (printer == null) {
      return;
    }

    widget.onTestConnection(printer);
  }

  PrinterModel? _validateAndBuildPrinter() {
    setState(() {
      _saveAttempted = true;
    });
    if (!_formKey.currentState!.validate()) {
      return null;
    }

    return PrinterModel(
      id: widget.initialPrinter?.id ?? _uuid.v4(),
      uniqueKey: _uniqueKeyController.text.trim(),
      name: _nameController.text.trim(),
      description: PrinterFormValidation.trimToNull(
        _descriptionController.text,
      ),
      connectionType: _connectionType,
      isEnabled: _isEnabled,
      lastStatus: widget.initialPrinter?.lastStatus,
      lastStatusKey: widget.initialPrinter?.lastStatusKey,
      lastStatusMessage: widget.initialPrinter?.lastStatusMessage,
      createdAt: widget.initialPrinter?.createdAt ?? DateTime.now(),
      updatedAt: DateTime.now(),
      tcpHost: _connectionType == PrinterConnectionType.networkTcp
          ? PrinterFormValidation.trimToNull(_tcpHostController.text)
          : null,
      tcpPort: _connectionType == PrinterConnectionType.networkTcp
          ? PrinterFormValidation.parseInteger(_tcpPortController.text)
          : null,
      tcpConnectTimeoutMs: _connectionType == PrinterConnectionType.networkTcp
          ? PrinterFormValidation.parseInteger(
              _tcpConnectTimeoutController.text,
            )
          : null,
      tcpWriteTimeoutMs: _connectionType == PrinterConnectionType.networkTcp
          ? PrinterFormValidation.parseInteger(_tcpWriteTimeoutController.text)
          : null,
      tcpReadTimeoutMs: _connectionType == PrinterConnectionType.networkTcp
          ? PrinterFormValidation.parseInteger(_tcpReadTimeoutController.text)
          : null,
      tcpAutoReconnect: _connectionType == PrinterConnectionType.networkTcp
          ? _tcpAutoReconnect
          : false,
      tcpReconnectDelayMs:
          _connectionType == PrinterConnectionType.networkTcp &&
              _tcpAutoReconnect
          ? PrinterFormValidation.parseInteger(
              _tcpReconnectDelayController.text,
            )
          : null,
      tcpEncoding: _connectionType == PrinterConnectionType.networkTcp
          ? PrinterFormValidation.trimToNull(_tcpEncoding)
          : null,
      tcpCodePage: _connectionType == PrinterConnectionType.networkTcp
          ? PrinterFormValidation.trimToNull(_tcpCodePage)
          : null,
      tcpLineEnding: _connectionType == PrinterConnectionType.networkTcp
          ? PrinterFormValidation.trimToNull(_tcpLineEnding)
          : null,
      tcpKeepAlive: _connectionType == PrinterConnectionType.networkTcp
          ? _tcpKeepAlive
          : false,
      tcpNoDelay: _connectionType == PrinterConnectionType.networkTcp
          ? _tcpNoDelay
          : false,
      tcpLingerSeconds: _connectionType == PrinterConnectionType.networkTcp
          ? PrinterFormValidation.parseInteger(_tcpLingerController.text)
          : null,
      systemPrinterName: _connectionType == PrinterConnectionType.systemSpooler
          ? PrinterFormValidation.trimToNull(_systemPrinterNameController.text)
          : null,
      systemPaperSize: PrinterFormValidation.trimToNull(_systemPaperSize),
      systemDefaultCopies:
          _connectionType == PrinterConnectionType.systemSpooler
          ? (PrinterFormValidation.parseInteger(
                  _systemDefaultCopiesController.text,
                ) ??
                1)
          : 1,
      systemColorEnabled: _connectionType == PrinterConnectionType.systemSpooler
          ? _systemColorEnabled
          : false,
      systemDuplexMode: _connectionType == PrinterConnectionType.systemSpooler
          ? PrinterFormValidation.trimToNull(_systemDuplexMode)
          : null,
      systemOrientation: _connectionType == PrinterConnectionType.systemSpooler
          ? PrinterFormValidation.trimToNull(_systemOrientation)
          : null,
      systemJobTimeoutMs: _connectionType == PrinterConnectionType.systemSpooler
          ? PrinterFormValidation.parseInteger(_systemJobTimeoutController.text)
          : null,
      systemNotes: _connectionType == PrinterConnectionType.systemSpooler
          ? PrinterFormValidation.trimToNull(_systemNotesController.text)
          : null,
      systemDriverName: _connectionType == PrinterConnectionType.systemSpooler
          ? PrinterFormValidation.trimToNull(_systemDriverNameController.text)
          : null,
      systemQueueName: _connectionType == PrinterConnectionType.systemSpooler
          ? PrinterFormValidation.trimToNull(_systemQueueNameController.text)
          : null,
      systemSpoolFormat: _connectionType == PrinterConnectionType.systemSpooler
          ? PrinterFormValidation.trimToNull(_systemSpoolFormat)
          : null,
      systemUseRawSpool: _connectionType == PrinterConnectionType.systemSpooler
          ? _systemUseRawSpool
          : false,
      usbVendorId: _connectionType == PrinterConnectionType.usbRawEscPos
          ? PrinterFormValidation.normalizeHexId(_usbVendorIdController.text)
          : null,
      usbProductId: _connectionType == PrinterConnectionType.usbRawEscPos
          ? PrinterFormValidation.normalizeHexId(_usbProductIdController.text)
          : null,
      usbSerialNumber: _connectionType == PrinterConnectionType.usbRawEscPos
          ? PrinterFormValidation.trimToNull(_usbSerialNumberController.text)
          : null,
      usbInterfaceNumber: _connectionType == PrinterConnectionType.usbRawEscPos
          ? PrinterFormValidation.parseInteger(
              _usbInterfaceNumberController.text,
            )
          : null,
      usbOutEndpoint: _connectionType == PrinterConnectionType.usbRawEscPos
          ? PrinterFormValidation.parseUsbEndpoint(
              _usbOutEndpointController.text,
            )
          : null,
      usbInEndpoint:
          _connectionType == PrinterConnectionType.usbRawEscPos &&
              _usbStatusMonitoringEnabled
          ? PrinterFormValidation.parseUsbEndpoint(
              _usbInEndpointController.text,
            )
          : null,
      usbTimeoutMs: _connectionType == PrinterConnectionType.usbRawEscPos
          ? PrinterFormValidation.parseInteger(_usbTimeoutController.text)
          : null,
      usbEncoding: _connectionType == PrinterConnectionType.usbRawEscPos
          ? PrinterFormValidation.trimToNull(_usbEncoding)
          : null,
      usbCodePage: _connectionType == PrinterConnectionType.usbRawEscPos
          ? PrinterFormValidation.trimToNull(_usbCodePage)
          : null,
      usbCharacterTable: _connectionType == PrinterConnectionType.usbRawEscPos
          ? PrinterFormValidation.trimToNull(_usbCharacterTable)
          : null,
      usbAutoCutEnabled:
          _connectionType == PrinterConnectionType.usbRawEscPos ||
              _connectionType == PrinterConnectionType.networkTcp
          ? _usbAutoCutEnabled
          : false,
      usbCutMode:
          (_connectionType == PrinterConnectionType.usbRawEscPos ||
                  _connectionType == PrinterConnectionType.networkTcp) &&
              _usbAutoCutEnabled
          ? PrinterFormValidation.trimToNull(_usbCutMode)
          : null,
      usbCashDrawerEnabled:
          _connectionType == PrinterConnectionType.usbRawEscPos ||
              _connectionType == PrinterConnectionType.networkTcp
          ? _usbCashDrawerEnabled
          : false,
      usbDrawerPin:
          (_connectionType == PrinterConnectionType.usbRawEscPos ||
                  _connectionType == PrinterConnectionType.networkTcp) &&
              _usbCashDrawerEnabled
          ? PrinterFormValidation.parseInteger(_usbDrawerPinController.text)
          : null,
      usbStatusMonitoringEnabled:
          _connectionType == PrinterConnectionType.usbRawEscPos
          ? _usbStatusMonitoringEnabled
          : false,
      usbManufacturer: _connectionType == PrinterConnectionType.usbRawEscPos
          ? PrinterFormValidation.trimToNull(_usbManufacturerController.text)
          : null,
      usbProductName: _connectionType == PrinterConnectionType.usbRawEscPos
          ? PrinterFormValidation.trimToNull(_usbProductNameController.text)
          : null,
      usbAlternateSetting: _connectionType == PrinterConnectionType.usbRawEscPos
          ? PrinterFormValidation.parseInteger(
              _usbAlternateSettingController.text,
            )
          : null,
      usbPacketDelayMs: _connectionType == PrinterConnectionType.usbRawEscPos
          ? PrinterFormValidation.parseInteger(_usbPacketDelayController.text)
          : null,
      rawGraphicsMode:
          _connectionType == PrinterConnectionType.usbRawEscPos ||
              _connectionType == PrinterConnectionType.networkTcp
          ? _rawGraphicsMode
          : null,
    );
  }

  String _intLabel(int? value) => value == null ? '' : '$value';

  Widget _textField(
    BuildContext _,
    String label,
    TextEditingController controller, {
    String? Function(String?)? validator,
    List<TextInputFormatter>? inputFormatters,
    bool required = false,
  }) {
    return AppTextField(
      label: label,
      required: required,
      controller: controller,
      validator: validator,
      inputFormatters: inputFormatters,
    );
  }

  Widget _integerField(
    BuildContext _,
    String label,
    TextEditingController controller, {
    String? Function(String?)? validator,
    bool required = false,
  }) {
    return AppNumberField(
      label: label,
      required: required,
      controller: controller,
      validator: validator,
    );
  }

  Widget _stringDropdown(
    BuildContext _,
    String label,
    String value,
    List<String> items,
    ValueChanged<String?> onChanged, {
    String Function(String value)? itemLabelBuilder,
  }) {
    return AppDropdownField<String>(
      label: label,
      value: value.isEmpty ? '' : value,
      onChanged: onChanged,
      items: [
        DropdownMenuItem(value: '', child: Text('-')),
        ...items.map(
          (item) => DropdownMenuItem(
            value: item,
            child: Text(itemLabelBuilder?.call(item) ?? item),
          ),
        ),
      ],
    );
  }

  String _rawGraphicsModeLabel(AppLocalizations l10n, String value) {
    return switch (value) {
      'legacy' => l10n.printersRawGraphicsModeLegacy,
      _ => l10n.printersRawGraphicsModeModern,
    };
  }

  String? _validateName(String? value) {
    return PrinterFormValidation.validateRequiredText(value, maxLength: 255);
  }

  String? _validateApp(String? value) {
    final required = PrinterFormValidation.validateRequiredText(value);
    if (required != null) {
      return required;
    }
    if (!PrinterFormValidation.isValidHost(value!.trim())) {
      return 'invalid-host';
    }
    return null;
  }

  String? _validatePort(String? value) {
    return PrinterFormValidation.validateIntegerField(
      value,
      required: true,
      min: 1,
      max: 65535,
    );
  }

  String? _validateTimeout(String? value, {required bool required}) {
    return PrinterFormValidation.validateIntegerField(
      value,
      required: required,
      min: 0,
      max: 120000,
    );
  }

  String? _validateReconnectDelay(String? value, {required bool required}) {
    return PrinterFormValidation.validateIntegerField(
      value,
      required: required,
      min: 0,
      max: 60000,
    );
  }

  String? _validatePrinterName(String? value) {
    return PrinterFormValidation.validateRequiredText(value, maxLength: 255);
  }

  String? _validateCopies(String? value) {
    return PrinterFormValidation.validateIntegerField(
      value,
      required: false,
      min: 1,
      max: 999,
    );
  }

  String? _validateUsbId(String? value) {
    final required = PrinterFormValidation.validateRequiredText(value);
    if (required != null) {
      return required;
    }
    if (!PrinterFormValidation.isValidUsbId(value!)) {
      return 'invalid-usb-id';
    }
    return null;
  }

  String? _validateEndpoint(String? value) {
    final trimmed = PrinterFormValidation.trimToNull(value);
    if (trimmed == null) {
      return null;
    }
    if (!PrinterFormValidation.isValidUsbEndpoint(trimmed)) {
      return 'invalid-endpoint';
    }
    return null;
  }

  String? _validateInEndpoint(String? value) {
    final endpointError = _validateEndpoint(value);
    if (endpointError != null) {
      return endpointError;
    }
    final outEndpoint = PrinterFormValidation.parseUsbEndpoint(
      _usbOutEndpointController.text,
    );
    final inEndpoint = PrinterFormValidation.parseUsbEndpoint(value);
    if (inEndpoint != null &&
        outEndpoint != null &&
        inEndpoint == outEndpoint) {
      return 'matching-endpoints';
    }
    return null;
  }

  String? _validateDrawerPin(String? value) {
    final result = PrinterFormValidation.validateIntegerField(
      value,
      required: true,
      min: 0,
      max: 5,
    );
    if (result != null) {
      return result;
    }
    final parsed = PrinterFormValidation.parseInteger(value);
    if (parsed != null && !PrinterFormOptions.drawerPins.contains(parsed)) {
      return 'invalid-drawer-pin';
    }
    return null;
  }

  String? _mapError(String? code, AppLocalizations l10n) {
    return switch (code) {
      null => null,
      'required' => l10n.printersValidationRequired,
      'max-length' => l10n.printersValidationTooLong,
      'invalid-host' => l10n.printersValidationInvalidHost,
      'invalid-integer' => l10n.printersValidationIntegerOnly,
      'min' => l10n.printersValidationTooSmall,
      'max' => l10n.printersValidationTooLarge,
      'invalid-usb-id' => l10n.printersValidationUsbId,
      'invalid-endpoint' => l10n.printersValidationUsbEndpoint,
      'matching-endpoints' => l10n.printersValidationDistinctEndpoints,
      'invalid-drawer-pin' => l10n.printersValidationDrawerPin,
      _ => l10n.errorDescription,
    };
  }

  String _connectionTitle(AppLocalizations l10n) {
    return switch (_connectionType) {
      PrinterConnectionType.networkTcp => l10n.printersTypeTcp,
      PrinterConnectionType.systemSpooler => l10n.printersTypeSystem,
      PrinterConnectionType.usbRawEscPos => l10n.printersTypeUsbRaw,
    };
  }
}

class _CopyFieldButton extends StatelessWidget {
  const _CopyFieldButton({required this.tooltip, required this.onPressed});

  final String tooltip;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: tooltip,
      onPressed: onPressed,
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints.tightFor(width: 36, height: 36),
      visualDensity: VisualDensity.compact,
      icon: const Icon(LucideIcons.copy, size: 16),
    );
  }
}
