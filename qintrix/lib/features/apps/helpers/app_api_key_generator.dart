import 'package:uuid/uuid.dart';

abstract final class AppApiKeyGenerator {
  static const Uuid _uuid = Uuid();

  static String generate() {
    return _uuid.v4().replaceAll('-', '');
  }
}
