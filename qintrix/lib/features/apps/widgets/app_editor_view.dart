import 'package:flutter/material.dart';
import 'package:lucide_flutter/lucide_flutter.dart';
import 'package:qintrix/core/widgets/exports.dart';
import 'package:qintrix/data/models/exports.dart';
import 'package:qintrix/features/apps/helpers/app_api_key_generator.dart';
import 'package:qintrix/features/apps/helpers/app_validation.dart';
import 'package:qintrix/l10n/app_localizations.dart';
import 'package:uuid/uuid.dart';

class AppEditorView extends StatefulWidget {
  const AppEditorView({
    required this.modeLabel,
    required this.availablePrinters,
    required this.onCancel,
    required this.onSubmit,
    required this.onCopyApiKey,
    this.initialApp,
    super.key,
  });

  final String modeLabel;
  final AppModel? initialApp;
  final List<PrinterModel> availablePrinters;
  final ValueChanged<AppModel> onSubmit;
  final ValueChanged<String> onCopyApiKey;
  final VoidCallback onCancel;

  @override
  State<AppEditorView> createState() => _AppEditorViewState();
}

class _AppEditorViewState extends State<AppEditorView> {
  static const Uuid _uuid = Uuid();

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _apiKeyController = TextEditingController();
  bool _isEnabled = true;
  bool _saveAttempted = false;
  Set<String> _selectedPrinterIds = <String>{};

  @override
  void initState() {
    super.initState();
    final app = widget.initialApp;
    if (app == null) {
      _apiKeyController.text = AppApiKeyGenerator.generate();
      return;
    }

    _nameController.text = app.name;
    _descriptionController.text = app.description ?? '';
    _apiKeyController.text = app.apiKey;
    _isEnabled = app.isEnabled;
    _selectedPrinterIds = app.allowedPrinterIds.toSet();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _apiKeyController.dispose();
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
            ],
          ),
          const SizedBox(height: 18),
          AppSectionCard(
            title: l10n.appsOverviewTitle,
            child: FormGrid(
              children: [
                AppTextField(
                  label: l10n.appsFieldName,
                  required: true,
                  controller: _nameController,
                  validator: (value) => _mapError(
                    AppValidation.validateName(value),
                    l10n,
                  ),
                ),
                AppSwitchField(
                  label: l10n.appsFieldEnabled,
                  value: _isEnabled,
                  onChanged: (value) {
                    setState(() {
                      _isEnabled = value;
                    });
                  },
                ),
                AppTextField(
                  label: l10n.appsFieldApiKey,
                  required: true,
                  controller: _apiKeyController,
                  readOnly: true,
                  helperText: l10n.appsApiKeyHelper,
                  suffixIcon: Padding(
                    padding: const EdgeInsetsDirectional.only(end: 6),
                    child: AppCopyButton(
                      tooltip: l10n.appsCopyApiKeyAction,
                      onPressed: () => widget.onCopyApiKey(_apiKeyController.text),
                    ),
                  ),
                ),
                AppMultilineField(
                  label: l10n.appsFieldDescription,
                  controller: _descriptionController,
                  hintText: l10n.appsDescriptionHint,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          AppSectionCard(
            title: l10n.appsAccessTitle,
            subtitle: l10n.appsAllPrintersNote,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.availablePrinters.isEmpty)
                  Text(
                    l10n.appsNoPrintersAvailable,
                    style: Theme.of(context).textTheme.bodySmall,
                  )
                else
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: widget.availablePrinters
                        .map(
                          (printer) => FilterChip(
                            label: Text(printer.name),
                            selected: _selectedPrinterIds.contains(printer.id),
                            onSelected: (selected) {
                              setState(() {
                                if (selected) {
                                  _selectedPrinterIds.add(printer.id);
                                } else {
                                  _selectedPrinterIds.remove(printer.id);
                                }
                              });
                            },
                          ),
                        )
                        .toList(growable: false),
                  ),
                const SizedBox(height: 12),
                Text(
                  l10n.appsAllPrintersNote,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _handleSubmit() {
    setState(() {
      _saveAttempted = true;
    });

    if (!_formKey.currentState!.validate()) {
      return;
    }

    final initial = widget.initialApp;
    final now = DateTime.now();
    widget.onSubmit(
      AppModel(
        id: initial?.id ?? _uuid.v4(),
        name: _nameController.text.trim(),
        isEnabled: _isEnabled,
        description: _descriptionController.text.trim().isEmpty
            ? null
            : _descriptionController.text.trim(),
        apiKey: _apiKeyController.text.trim(),
        allowedPrinterIds: _selectedPrinterIds.toList(growable: false),
        allowedPrinterNames: widget.availablePrinters
            .where((printer) => _selectedPrinterIds.contains(printer.id))
            .map((printer) => printer.name)
            .toList(growable: false),
        createdAt: initial?.createdAt ?? now,
        updatedAt: now,
      ),
    );
  }

  String? _mapError(String? error, AppLocalizations l10n) {
    return switch (error) {
      'required' => l10n.appsValidationRequired,
      'max-length' => l10n.appsValidationMaxLength,
      _ => null,
    };
  }
}
