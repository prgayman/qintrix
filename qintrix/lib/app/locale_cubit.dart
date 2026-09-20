import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qintrix/core/localization/app_locale_utils.dart';
import 'package:qintrix/core/services/exports.dart';

class LocaleCubit extends Cubit<Locale> {
  LocaleCubit({required AppPreferencesService preferencesService})
    : _preferencesService = preferencesService,
      super(AppLocaleUtils.normalize(preferencesService.loadLocale()));

  final AppPreferencesService _preferencesService;

  Future<void> setLocale(Locale locale) async {
    final normalized = AppLocaleUtils.normalize(locale);

    if (normalized == state) {
      return;
    }

    emit(normalized);
    await _preferencesService.saveLocale(normalized);
  }

  Future<void> toggleLocale() async {
    await setLocale(AppLocaleUtils.alternate(state));
  }
}
