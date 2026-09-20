import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qintrix/core/services/exports.dart';

class ThemeModeCubit extends Cubit<ThemeMode> {
  ThemeModeCubit({required AppPreferencesService preferencesService})
    : _preferencesService = preferencesService,
      super(preferencesService.loadThemeMode());

  final AppPreferencesService _preferencesService;

  Future<void> setThemeMode(ThemeMode themeMode) async {
    if (themeMode == state) {
      return;
    }

    emit(themeMode);
    await _preferencesService.saveThemeMode(themeMode);
  }
}
