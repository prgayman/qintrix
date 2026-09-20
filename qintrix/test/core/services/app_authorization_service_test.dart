import 'package:flutter_test/flutter_test.dart';
import 'package:qintrix/core/services/exports.dart';
import 'package:qintrix/data/models/exports.dart';
import 'package:qintrix/data/repositories/exports.dart';

class _FakeAppsRepository implements AppsRepository {
  _FakeAppsRepository(this._apps);

  final List<AppModel> _apps;

  @override
  Future<bool> apiKeyExists(String apiKey, {String? excludingId}) async => false;

  @override
  Future<void> deleteApp(String id) async {}

  @override
  Future<void> deleteApps(List<String> ids) async {}

  @override
  Future<AppModel?> getAppByApiKey(String apiKey) async {
    for (final app in _apps) {
      if (app.apiKey == apiKey) {
        return app;
      }
    }
    return null;
  }

  @override
  Future<AppModel?> getAppById(String id) async => null;

  @override
  Future<List<AppModel>> getApps() async => _apps;

  @override
  Future<PagedResult<AppModel>> queryApps(AppsQuery query) async {
    return PagedResult<AppModel>(
      items: _apps,
      totalCount: _apps.length,
      page: query.page,
      pageSize: query.pageSize,
    );
  }

  @override
  Future<void> saveApp(AppModel app) async {}
}

void main() {
  test('authorizes enabled app with matching api key', () async {
    final app = AppModel(
      id: '1',
      name: 'Client A',
      isEnabled: true,
      apiKey: 'abc123',
      allowedPrinterIds: const ['p1'],
      allowedPrinterNames: const ['Printer 1'],
      createdAt: DateTime(2026),
      updatedAt: DateTime(2026),
    );
    final service = AppAuthorizationService(
      repository: _FakeAppsRepository([app]),
    );

    final result = await service.authorize(apiKey: 'abc123');

    expect(result.isAllowed, isTrue);
    expect(result.app?.id, '1');
    expect(result.allowedPrinterIds, {'p1'});
  });

  test('rejects disabled app or mismatched api key', () async {
    final app = AppModel(
      id: '1',
      name: 'Client A',
      isEnabled: false,
      apiKey: 'abc123',
      allowedPrinterIds: const [],
      allowedPrinterNames: const [],
      createdAt: DateTime(2026),
      updatedAt: DateTime(2026),
    );
    final service = AppAuthorizationService(
      repository: _FakeAppsRepository([app]),
    );

    final disabledResult = await service.authorize(apiKey: 'abc123');
    final wrongKeyResult = await service.authorize(apiKey: 'wrong');

    expect(disabledResult.isAllowed, isFalse);
    expect(wrongKeyResult.isAllowed, isFalse);
  });
}
