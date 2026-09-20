import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qintrix/data/models/exports.dart';
import 'package:qintrix/data/repositories/exports.dart';
import 'package:qintrix/features/apps/helpers/app_api_key_generator.dart';
import 'package:qintrix/features/apps/helpers/app_validation.dart';
import 'package:qintrix/l10n/app_localizations.dart';
import 'package:qintrix/theme/tokens/color_tokens.dart';

import 'apps_state.dart';

class AppsCubit extends Cubit<AppsState> {
  AppsCubit({
    required AppsRepository repository,
    required PrintersRepository printersRepository,
  }) : _repository = repository,
       _printersRepository = printersRepository,
       super(const AppsState.initial());

  final AppsRepository _repository;
  final PrintersRepository _printersRepository;

  Timer? _feedbackTimer;
  int _feedbackId = 0;

  Future<void> load({bool reset = false}) async {
    final query = reset ? const AppsQuery() : state.query;
    emit(
      state.copyWith(
        status: AppsStatus.loading,
        errorMessage: null,
        feedback: null,
        query: query,
        mode: reset ? AppsViewMode.listing : state.mode,
        activeApp: reset ? null : state.activeApp,
        selectedIds: reset ? const <String>{} : state.selectedIds,
      ),
    );

    try {
      final results = await Future.wait([
        _repository.queryApps(query),
        _printersRepository.getPrinters(),
      ]);
      final pagedApps = results[0] as PagedResult<AppModel>;
      final printers = results[1] as List<PrinterModel>;
      emit(
        state.copyWith(
          status: AppsStatus.loaded,
          apps: pagedApps.items,
          totalCount: pagedApps.totalCount,
          query: query,
          availablePrinters: printers,
          selectedIds: state.selectedIds
              .where((id) => pagedApps.items.any((app) => app.id == id))
              .toSet(),
          errorMessage: null,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: AppsStatus.failure,
          errorMessage: error.toString(),
        ),
      );
    }
  }

  Future<void> updateSearch(String value) {
    return _loadQuery(state.query.copyWith(search: value, page: 0));
  }

  Future<void> updateStatus(String value) {
    return _loadQuery(state.query.copyWith(status: value, page: 0));
  }

  Future<void> updateScope(String value) {
    return _loadQuery(state.query.copyWith(scope: value, page: 0));
  }

  Future<void> resetFilters() {
    return _loadQuery(const AppsQuery());
  }

  Future<void> updatePage(int page) {
    return _loadQuery(state.query.copyWith(page: page));
  }

  Future<void> updateRowsPerPage(int pageSize) {
    return _loadQuery(state.query.copyWith(pageSize: pageSize, page: 0));
  }

  void showCreate() {
    emit(state.copyWith(mode: AppsViewMode.create, activeApp: null, feedback: null));
  }

  void showApp(AppModel app) {
    emit(state.copyWith(mode: AppsViewMode.show, activeApp: app, feedback: null));
  }

  void editApp(AppModel app) {
    emit(state.copyWith(mode: AppsViewMode.edit, activeApp: app, feedback: null));
  }

  void backToIndex() {
    emit(state.copyWith(mode: AppsViewMode.listing, activeApp: null, feedback: null));
  }

  void backToShow() {
    emit(
      state.copyWith(
        mode: state.activeApp == null ? AppsViewMode.listing : AppsViewMode.show,
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

  Future<void> saveApp(AppModel app, AppLocalizations l10n) async {
    final isCreate = state.mode == AppsViewMode.create;
    final validation = await validateApp(app, l10n);
    if (validation != null) {
      _emitFeedback(validation, tone: AppStatusTone.error);
      return;
    }

    emit(state.copyWith(status: AppsStatus.saving, errorMessage: null));

    try {
      await _repository.saveApp(app);
      final refreshed = await _repository.getAppById(app.id);
      final result = await _repository.queryApps(state.query);

      emit(
        state.copyWith(
          status: AppsStatus.loaded,
          apps: result.items,
          totalCount: result.totalCount,
          selectedIds: state.selectedIds
              .where((id) => result.items.any((item) => item.id == id))
              .toSet(),
          activeApp: refreshed ?? app,
          mode: AppsViewMode.show,
          errorMessage: null,
        ),
      );

      _emitFeedback(
        isCreate ? l10n.appsCreatedSuccess : l10n.appsUpdatedSuccess,
        tone: AppStatusTone.success,
      );
    } catch (error) {
      emit(state.copyWith(status: AppsStatus.failure, errorMessage: error.toString()));
    }
  }

  Future<void> deleteApp(AppModel app, AppLocalizations l10n) async {
    await _repository.deleteApp(app.id);
    final result = await _repository.queryApps(state.query);
    emit(
      state.copyWith(
        status: AppsStatus.loaded,
        apps: result.items,
        totalCount: result.totalCount,
        selectedIds: Set<String>.of(state.selectedIds)..remove(app.id),
        activeApp: state.activeApp?.id == app.id ? null : state.activeApp,
        mode: state.activeApp?.id == app.id ? AppsViewMode.listing : state.mode,
        errorMessage: null,
      ),
    );
    _emitFeedback(l10n.appsDeletedSuccess, tone: AppStatusTone.success);
  }

  Future<void> deleteSelected(AppLocalizations l10n) async {
    await _repository.deleteApps(state.selectedIds.toList(growable: false));
    final result = await _repository.queryApps(state.query);
    emit(
      state.copyWith(
        status: AppsStatus.loaded,
        apps: result.items,
        totalCount: result.totalCount,
        selectedIds: const <String>{},
        activeApp: null,
        mode: AppsViewMode.listing,
        errorMessage: null,
      ),
    );
    _emitFeedback(l10n.appsBulkDeletedSuccess, tone: AppStatusTone.success);
  }

  Future<void> regenerateApiKey(AppModel app, AppLocalizations l10n) async {
    String apiKey;
    do {
      apiKey = AppApiKeyGenerator.generate();
    } while (await _repository.apiKeyExists(apiKey, excludingId: app.id));

    await _repository.saveApp(app.copyWith(apiKey: apiKey, updatedAt: DateTime.now()));
    final result = await _repository.queryApps(state.query);
    final activeApp = state.activeApp?.id == app.id
        ? await _repository.getAppById(app.id)
        : state.activeApp;

    emit(
      state.copyWith(
        apps: result.items,
        totalCount: result.totalCount,
        activeApp: activeApp,
      ),
    );
    _emitFeedback(l10n.appsRegeneratedApiKeySuccess, tone: AppStatusTone.success);
  }

  Future<String?> validateApp(AppModel app, AppLocalizations l10n) async {
    final nameError = AppValidation.validateName(app.name);
    if (nameError != null) {
      return _mapError(nameError, l10n);
    }

    if (app.apiKey.trim().isEmpty) {
      return l10n.appsValidationRequired;
    }

    final duplicateKey = await _repository.apiKeyExists(
      app.apiKey.trim(),
      excludingId: app.id,
    );
    if (duplicateKey) {
      return l10n.appsValidationDuplicateApiKey;
    }

    return null;
  }

  void notifyApiKeyCopied(AppLocalizations l10n) {
    _emitFeedback(l10n.appsApiKeyCopied, tone: AppStatusTone.success);
  }

  Future<void> _loadQuery(AppsQuery query) async {
    emit(
      state.copyWith(
        status: AppsStatus.loading,
        query: query,
        feedback: null,
      ),
    );

    try {
      final result = await _repository.queryApps(query);
      emit(
        state.copyWith(
          status: AppsStatus.loaded,
          apps: result.items,
          totalCount: result.totalCount,
          query: query,
          selectedIds: state.selectedIds
              .where((id) => result.items.any((app) => app.id == id))
              .toSet(),
          errorMessage: null,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: AppsStatus.failure,
          errorMessage: error.toString(),
        ),
      );
    }
  }

  void _emitFeedback(
    String message, {
    required AppStatusTone tone,
  }) {
    _feedbackTimer?.cancel();
    emit(
      state.copyWith(
        feedback: AppsFeedback(
          id: ++_feedbackId,
          title: null,
          message: message,
          tone: tone,
        ),
      ),
    );
    _feedbackTimer = Timer(const Duration(seconds: 3), () {
      emit(state.copyWith(feedback: null));
    });
  }

  String _mapError(String error, AppLocalizations l10n) {
    return switch (error) {
      'required' => l10n.appsValidationRequired,
      'max-length' => l10n.appsValidationMaxLength,
      _ => error,
    };
  }

  @override
  Future<void> close() {
    _feedbackTimer?.cancel();
    return super.close();
  }
}
