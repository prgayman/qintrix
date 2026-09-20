import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qintrix/core/services/app_preferences_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('AppPreferencesService', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    test('loads default values when preferences are empty', () async {
      final service = await AppPreferencesService.create();

      expect(service.loadLocale(), isNull);
      expect(service.loadThemeMode(), ThemeMode.system);
    });

    test('saves and loads locale and theme mode', () async {
      final service = await AppPreferencesService.create();

      await service.saveLocale(const Locale('ar'));
      await service.saveThemeMode(ThemeMode.dark);

      expect(service.loadLocale(), const Locale('ar'));
      expect(service.loadThemeMode(), ThemeMode.dark);
    });
  });
}
