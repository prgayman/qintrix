import 'package:flutter_test/flutter_test.dart';
import 'package:qintrix/app/app_destination.dart';

void main() {
  test('maps route names to destinations', () {
    expect(AppDestination.fromRouteName('/logs'), AppDestination.logs);
    expect(AppDestination.fromRouteName('/settings'), AppDestination.settings);
    expect(AppDestination.fromRouteName('/about'), AppDestination.about);
    expect(AppDestination.fromRouteName('/unknown'), AppDestination.dashboard);
  });
}
