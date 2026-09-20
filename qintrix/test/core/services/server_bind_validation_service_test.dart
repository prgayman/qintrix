import 'package:flutter_test/flutter_test.dart';
import 'package:qintrix/core/services/exports.dart';

void main() {
  const service = ServerBindValidationService();

  test('validates a bindable loopback host and free port', () async {
    final result = await service.validate(
      host: '127.0.0.1',
      port: 0,
    );

    expect(result.isValid, isTrue);
  });
}
