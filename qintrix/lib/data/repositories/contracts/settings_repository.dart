import 'package:qintrix/data/models/exports.dart';

abstract class SettingsRepository {
  Future<AppSettingsModel> loadSettings();

  Future<AppSettingsModel> saveSettings(AppSettingsModel settings);
}
