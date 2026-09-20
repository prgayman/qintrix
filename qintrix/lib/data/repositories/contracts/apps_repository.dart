import 'package:qintrix/data/models/exports.dart';

abstract class AppsRepository {
  Future<List<AppModel>> getApps();

  Future<PagedResult<AppModel>> queryApps(AppsQuery query);

  Future<AppModel?> getAppById(String id);

  Future<AppModel?> getAppByApiKey(String apiKey);

  Future<void> saveApp(AppModel app);

  Future<void> deleteApp(String id);

  Future<void> deleteApps(List<String> ids);

  Future<bool> apiKeyExists(String apiKey, {String? excludingId});
}
