import 'dart:io';

class NetworkInterfaceService {
  const NetworkInterfaceService();

  Future<List<String>> getAvailableLanIpv4Addresses() async {
    final interfaces = await NetworkInterface.list(
      includeLoopback: false,
      type: InternetAddressType.IPv4,
    );

    final addresses =
        interfaces
            .expand((interface) => interface.addresses)
            .map((address) => address.address)
            .where(isPrivateLanIpv4)
            .toSet()
            .toList()
          ..sort(compareLanIps);

    return addresses;
  }

  Future<String?> getPreferredLanIpv4Address() async {
    final addresses = await getAvailableLanIpv4Addresses();
    if (addresses.isEmpty) {
      return null;
    }

    return addresses.first;
  }

  static bool isValidBindableAddress(String value) {
    return isLoopbackIpv4(value) || isPrivateLanIpv4(value);
  }

  static bool isValidIpv4(String value) {
    final ipv4Pattern = RegExp(
      r'^((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)\.){3}(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)$',
    );
    return ipv4Pattern.hasMatch(value);
  }

  static bool isPrivateLanIpv4(String value) {
    if (!isValidIpv4(value)) {
      return false;
    }

    final octets = value.split('.').map(int.parse).toList(growable: false);
    final first = octets[0];
    final second = octets[1];

    if (first == 10) {
      return true;
    }

    if (first == 172 && second >= 16 && second <= 31) {
      return true;
    }

    if (first == 192 && second == 168) {
      return true;
    }

    return false;
  }

  static bool isLoopbackIpv4(String value) {
    return value == '127.0.0.1';
  }

  static int compareLanIps(String left, String right) {
    final leftPriority = _privateRangePriority(left);
    final rightPriority = _privateRangePriority(right);

    if (leftPriority != rightPriority) {
      return leftPriority.compareTo(rightPriority);
    }

    final leftOctets = left.split('.').map(int.parse).toList(growable: false);
    final rightOctets = right.split('.').map(int.parse).toList(growable: false);

    for (var index = 0; index < 4; index++) {
      final comparison = leftOctets[index].compareTo(rightOctets[index]);
      if (comparison != 0) {
        return comparison;
      }
    }

    return 0;
  }

  static int _privateRangePriority(String value) {
    if (value.startsWith('192.168.')) {
      return 0;
    }

    if (value.startsWith('10.')) {
      return 1;
    }

    return 2;
  }
}
