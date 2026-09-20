import 'package:flutter_test/flutter_test.dart';
import 'package:qintrix/data/database/app_database.dart';
import 'package:qintrix/data/repositories/exports.dart';

void main() {
  test('creates default settings row and persists updates', () async {
    final database = AppDatabase.forTest();
    final repository = DriftSettingsRepository(database);

    final settings = await repository.loadSettings();
    expect(settings.appPort, 4880);
    expect(settings.bindHost, '127.0.0.1');
    expect(settings.enableBackgroundMode, isTrue);
    expect(settings.startWithOs, isTrue);
    expect(settings.autoStartServer, isTrue);

    final updated = settings.copyWith(appPort: 5001, allowLanAccess: true);
    final saved = await repository.saveSettings(updated);
    final reloaded = await repository.loadSettings();

    expect(saved.appPort, 5001);
    expect(reloaded.allowLanAccess, isTrue);
    expect(reloaded.bindHost, settings.bindHost);
  });
}
