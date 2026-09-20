import 'package:qintrix/data/models/exports.dart';
import 'package:qintrix/data/repositories/exports.dart';

class AppAuthorizationResult {
  const AppAuthorizationResult({
    required this.isAllowed,
    this.app,
    this.allowedPrinterIds = const <String>{},
  });

  final bool isAllowed;
  final AppModel? app;
  final Set<String> allowedPrinterIds;

  bool get allowsAllPrinters => app != null && app!.allowedPrinterIds.isEmpty;
}

class AppAuthorizationService {
  const AppAuthorizationService({required AppsRepository repository})
    : _repository = repository;

  final AppsRepository _repository;

  Future<AppAuthorizationResult> authorize({
    required String apiKey,
  }) async {
    final normalizedKey = apiKey.trim();
    if (normalizedKey.isEmpty) {
      return const AppAuthorizationResult(isAllowed: false);
    }

    final app = await _repository.getAppByApiKey(normalizedKey);
    if (app == null || !app.isEnabled) {
      return const AppAuthorizationResult(isAllowed: false);
    }

    return AppAuthorizationResult(
      isAllowed: true,
      app: app,
      allowedPrinterIds: app.allowedPrinterIds.toSet(),
    );
  }
}
