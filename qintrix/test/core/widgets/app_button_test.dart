import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qintrix/core/widgets/app_button.dart';

Future<void> _pumpButton(WidgetTester tester, Widget child) async {
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(body: Center(child: child)),
    ),
  );
}

void main() {
  group('AppButton', () {
    testWidgets('shows loading spinner when isLoading is true', (tester) async {
      await _pumpButton(
        tester,
        const AppButton(label: 'Save', isLoading: true),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Save'), findsNothing);
    });

    testWidgets('renders secondary variant label', (tester) async {
      await _pumpButton(
        tester,
        AppButton(
          label: 'Cancel',
          variant: AppButtonVariant.secondary,
          onPressed: () {},
        ),
      );

      expect(find.byType(OutlinedButton), findsOneWidget);
      expect(find.text('Cancel'), findsOneWidget);
    });
  });
}
