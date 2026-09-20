import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qintrix/app/theme_mode_cubit.dart';
import 'package:qintrix/core/services/app_preferences_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('ThemeModeCubit', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    test('starts with system mode by default', () async {
      final preferencesService = await AppPreferencesService.create();
      final cubit = ThemeModeCubit(preferencesService: preferencesService);

      expect(cubit.state, ThemeMode.system);
    });

    test('emits dark when setThemeMode is called', () async {
      final preferencesService = await AppPreferencesService.create();
      final cubit = ThemeModeCubit(preferencesService: preferencesService);

      final expectation = expectLater(
        cubit.stream,
        emitsInOrder([ThemeMode.dark]),
      );

      await cubit.setThemeMode(ThemeMode.dark);
      await expectation;
    });
  });
}
