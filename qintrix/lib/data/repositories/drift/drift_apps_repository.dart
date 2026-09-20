import 'package:drift/drift.dart';
import 'package:qintrix/data/database/app_database.dart';
import 'package:qintrix/data/models/exports.dart';

import '../contracts/apps_repository.dart';

class DriftAppsRepository implements AppsRepository {
  DriftAppsRepository(this._appsDao, this._printersDao);

  final AppsDao _appsDao;
  final PrintersDao _printersDao;

  @override
  Future<List<AppModel>> getApps() async {
    final apps = await _appsDao.getApps();
    return _mapApps(apps);
  }

  @override
  Future<PagedResult<AppModel>> queryApps(AppsQuery query) async {
    final results = await Future.wait([
      _appsDao.queryApps(query),
      _appsDao.countApps(query),
    ]);
    final rows = results[0] as List<AppsTableData>;
    final totalCount = results[1] as int;
    final apps = await _mapApps(rows);

    return PagedResult<AppModel>(
      items: apps,
      totalCount: totalCount,
      page: query.page,
      pageSize: query.pageSize,
    );
  }

  @override
  Future<AppModel?> getAppById(String id) async {
    final row = await _appsDao.getAppById(id);
    if (row == null) {
      return null;
    }

    final apps = await _mapApps([row]);
    return apps.isEmpty ? null : apps.first;
  }

  @override
  Future<AppModel?> getAppByApiKey(String apiKey) async {
    final row = await _appsDao.getAppByApiKey(apiKey);
    if (row == null) {
      return null;
    }

    final apps = await _mapApps([row]);
    return apps.isEmpty ? null : apps.first;
  }

  @override
  Future<void> saveApp(AppModel app) {
    return _appsDao.upsertApp(
      AppsTableCompanion(
        id: Value(app.id),
        name: Value(app.name),
        isEnabled: Value(app.isEnabled),
        description: Value(app.description),
        apiKey: Value(app.apiKey),
        createdAt: Value(app.createdAt),
        updatedAt: Value(app.updatedAt),
      ),
      app.allowedPrinterIds,
    );
  }

  @override
  Future<void> deleteApp(String id) => _appsDao.deleteApp(id);

  @override
  Future<void> deleteApps(List<String> ids) => _appsDao.deleteApps(ids);

  @override
  Future<bool> apiKeyExists(String apiKey, {String? excludingId}) {
    return _appsDao.apiKeyExists(apiKey, excludingId: excludingId);
  }

  Future<List<AppModel>> _mapApps(
    List<AppsTableData> rows,
  ) async {
    if (rows.isEmpty) {
      return const <AppModel>[];
    }

    final links = await _appsDao.getPrinterAssignmentsForApps(
      rows.map((row) => row.id),
    );
    final printers = await _printersDao.getPrinters();
    final printerNamesById = {
      for (final printer in printers) printer.id: printer.name,
    };
    final printerIdsByApp = <String, List<String>>{};

    for (final link in links) {
      printerIdsByApp.putIfAbsent(link.appId, () => <String>[]).add(
        link.printerId,
      );
    }

    return rows.map((row) {
      final allowedPrinterIds =
          List<String>.unmodifiable(printerIdsByApp[row.id] ?? const <String>[]);
      final allowedPrinterNames = List<String>.unmodifiable(
        allowedPrinterIds
            .map((id) => printerNamesById[id])
            .whereType<String>()
            .toList(growable: false),
      );

      return AppModel(
        id: row.id,
        name: row.name,
        isEnabled: row.isEnabled,
        description: row.description,
        apiKey: row.apiKey,
        allowedPrinterIds: allowedPrinterIds,
        allowedPrinterNames: allowedPrinterNames,
        createdAt: row.createdAt,
        updatedAt: row.updatedAt,
      );
    }).toList(growable: false);
  }
}
