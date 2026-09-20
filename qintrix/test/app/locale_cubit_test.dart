import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:qintrix/app/locale_cubit.dart';
import 'package:qintrix/core/services/app_preferences_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('LocaleCubit', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    test('starts with english by default', () async {
      final preferencesService = await AppPreferencesService.create();
      final cubit = LocaleCubit(preferencesService: preferencesService);

      expect(cubit.state, const Locale('en'));
    });

    test('emits arabic when setLocale is called', () async {
      final preferencesService = await AppPreferencesService.create();
      final cubit = LocaleCubit(preferencesService: preferencesService);

      final expectation = expectLater(
        cubit.stream,
        emitsInOrder([const Locale('ar')]),
      );

      await cubit.setLocale(const Locale('ar'));
      await expectation;
    });

    test('toggles between english and arabic', () async {
      SharedPreferences.setMockInitialValues({
        AppPreferencesService.localeKey: 'ar',
      });
      final preferencesService = await AppPreferencesService.create();
      final cubit = LocaleCubit(preferencesService: preferencesService);

      final expectation = expectLater(
        cubit.stream,
        emitsInOrder([const Locale('en')]),
      );

      await cubit.toggleLocale();
      await expectation;
    });
  });
}
