import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPreferencesService {
  AppPreferencesService._(this._preferences);

  static const localeKey = 'app.locale';
  static const themeModeKey = 'app.themeMode';

  final SharedPreferences _preferences;

  static Future<AppPreferencesService> create() async {
    final preferences = await SharedPreferences.getInstance();
    return AppPreferencesService._(preferences);
  }

  Locale? loadLocale() {
    final localeCode = _preferences.getString(localeKey);

    if (localeCode == null || localeCode.isEmpty) {
      return null;
    }

    return Locale(localeCode);
  }

  Future<void> saveLocale(Locale locale) async {
    await _preferences.setString(localeKey, locale.languageCode);
  }

  ThemeMode loadThemeMode() {
    return switch (_preferences.getString(themeModeKey)) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      _ => ThemeMode.system,
    };
  }

  Future<void> saveThemeMode(ThemeMode themeMode) async {
    final encoded = switch (themeMode) {
      ThemeMode.light => 'light',
      ThemeMode.dark => 'dark',
      ThemeMode.system => 'system',
    };

    await _preferences.setString(themeModeKey, encoded);
  }
}
