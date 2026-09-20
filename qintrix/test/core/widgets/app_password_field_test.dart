import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qintrix/core/widgets/app_password_field.dart';

void main() {
  testWidgets('toggles obscure text state', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: AppPasswordField(label: 'Token')),
      ),
    );

    final textField = tester.widget<EditableText>(find.byType(EditableText));
    expect(textField.obscureText, isTrue);

    await tester.tap(find.byType(IconButton));
    await tester.pumpAndSettle();

    final updatedTextField = tester.widget<EditableText>(
      find.byType(EditableText),
    );
    expect(updatedTextField.obscureText, isFalse);
  });
}
