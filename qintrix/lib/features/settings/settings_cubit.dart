import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qintrix/data/models/exports.dart';
import 'package:qintrix/data/repositories/exports.dart';

import 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit({required SettingsRepository settingsRepository})
    : _settingsRepository = settingsRepository,
      super(const SettingsState.initial());

  final SettingsRepository _settingsRepository;

  Future<void> load() async {
    emit(state.copyWith(status: SettingsStatus.loading, message: null));

    try {
      final settings = await _settingsRepository.loadSettings();
      emit(
        state.copyWith(
          status: SettingsStatus.loaded,
          settings: settings,
          message: null,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: SettingsStatus.failure,
          message: error.toString(),
        ),
      );
    }
  }

  Future<AppSettingsModel> save(AppSettingsModel settings) async {
    emit(
      state.copyWith(
        status: SettingsStatus.saving,
        settings: settings,
        message: null,
      ),
    );

    try {
      final saved = await _settingsRepository.saveSettings(settings);
      emit(
        state.copyWith(
          status: SettingsStatus.loaded,
          settings: saved,
          message: null,
        ),
      );
      return saved;
    } catch (error) {
      emit(
        state.copyWith(
          status: SettingsStatus.failure,
          settings: settings,
          message: error.toString(),
        ),
      );
      rethrow;
    }
  }
}
