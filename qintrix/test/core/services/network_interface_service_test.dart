import 'package:flutter_test/flutter_test.dart';
import 'package:qintrix/core/services/exports.dart';

void main() {
  test('validates only local bindable ipv4 addresses', () {
    expect(NetworkInterfaceService.isValidBindableAddress('127.0.0.1'), isTrue);
    expect(
      NetworkInterfaceService.isValidBindableAddress('192.168.1.20'),
      isTrue,
    );
    expect(NetworkInterfaceService.isValidBindableAddress('10.0.0.5'), isTrue);
    expect(
      NetworkInterfaceService.isValidBindableAddress('172.16.1.10'),
      isTrue,
    );
    expect(
      NetworkInterfaceService.isValidBindableAddress('localhost'),
      isFalse,
    );
    expect(
      NetworkInterfaceService.isValidBindableAddress('1.2.232.12'),
      isFalse,
    );
    expect(
      NetworkInterfaceService.isValidBindableAddress('https://example.com'),
      isFalse,
    );
    expect(
      NetworkInterfaceService.isValidBindableAddress('printer.local'),
      isFalse,
    );
    expect(
      NetworkInterfaceService.isValidBindableAddress('192.168.1.999'),
      isFalse,
    );
  });

  test('prefers private lan ipv4 ranges deterministically', () {
    final addresses = ['10.0.0.5', '192.168.1.20', '172.16.1.10']
      ..sort(NetworkInterfaceService.compareLanIps);

    expect(addresses.first, '192.168.1.20');
  });
}
