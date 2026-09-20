import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lucide_flutter/lucide_flutter.dart';
import 'package:qintrix/core/widgets/exports.dart';

void main() {
  testWidgets('centers loading view inside available space', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SizedBox(
            width: 800,
            height: 600,
            child: AppLoadingView(label: 'Loading'),
          ),
        ),
      ),
    );

    final parentCenter = tester.getCenter(find.byType(SizedBox).first);
    final progressCenter = tester.getCenter(
      find.byType(CircularProgressIndicator),
    );

    expect((parentCenter.dx - progressCenter.dx).abs(), lessThan(2));
    expect((parentCenter.dy - progressCenter.dy).abs(), lessThan(2));
  });

  testWidgets('data table paginates rows client side', (
    WidgetTester tester,
  ) async {
    final rows = List.generate(12, (index) => 'Row $index');

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AppDataTable<String>(
            rows: rows,
            initialRowsPerPage: 10,
            columns: [
              AppDataTableColumn<String>(
                label: 'Name',
                cellBuilder: (context, row) => Text(row),
              ),
            ],
          ),
        ),
      ),
    );

    expect(find.text('Row 0'), findsOneWidget);
    expect(find.text('Row 9'), findsOneWidget);
    expect(find.text('Row 10'), findsNothing);

    await tester.tap(find.text('2'));
    await tester.pumpAndSettle();

    expect(find.text('Row 10'), findsOneWidget);
    expect(find.text('Row 11'), findsOneWidget);
  });

  testWidgets('data table shows a 5-page pagination window', (
    WidgetTester tester,
  ) async {
    final rows = List.generate(100, (index) => 'Row $index');

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AppDataTable<String>(
            rows: rows,
            initialRowsPerPage: 10,
            columns: [
              AppDataTableColumn<String>(
                label: 'Name',
                cellBuilder: (context, row) => Text(row),
              ),
            ],
          ),
        ),
      ),
    );

    expect(find.text('1'), findsOneWidget);
    expect(find.text('5'), findsOneWidget);
    expect(find.text('6'), findsNothing);

    await tester.tap(find.text('5'));
    await tester.pumpAndSettle();

    expect(find.text('6'), findsOneWidget);
    expect(find.text('8'), findsNothing);

    await tester.tap(find.byIcon(LucideIcons.chevronRight));
    await tester.pumpAndSettle();

    expect(find.text('8'), findsOneWidget);
    expect(find.text('10'), findsNothing);
  });

  testWidgets(
    'data table reset button clears active filters through callback',
    (WidgetTester tester) async {
      var resetCount = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppDataTable<String>(
              rows: const ['Row 1'],
              searchValue: 'queue',
              onSearchChanged: (_) {},
              hasActiveFilters: true,
              onResetFilters: () {
                resetCount += 1;
              },
              resetFiltersLabel: 'Reset filters',
              filters: [
                const SizedBox(
                  width: 140,
                  child: AppDropdownField<String>(
                    label: 'Level',
                    value: null,
                    isDense: true,
                    items: [
                      DropdownMenuItem<String>(value: null, child: Text('All')),
                    ],
                  ),
                ),
              ],
              columns: [
                AppDataTableColumn<String>(
                  label: 'Name',
                  cellBuilder: (context, row) => Text(row),
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Reset filters'), findsOneWidget);

      await tester.tap(find.text('Reset filters'));
      await tester.pumpAndSettle();

      expect(resetCount, 1);
    },
  );

  testWidgets('custom dropdown opens and selects a value', (tester) async {
    String? selectedValue;

    await tester.pumpWidget(
      MaterialApp(
        home: StatefulBuilder(
          builder: (context, setState) {
            return Scaffold(
              body: AppDropdownField<String>(
                label: 'Level',
                value: selectedValue,
                items: const [
                  DropdownMenuItem<String>(value: 'info', child: Text('Info')),
                  DropdownMenuItem<String>(
                    value: 'error',
                    child: Text('Error'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    selectedValue = value;
                  });
                },
              ),
            );
          },
        ),
      ),
    );

    await tester.tap(find.text('Level').last);
    await tester.pumpAndSettle();

    expect(find.text('Info'), findsOneWidget);
    expect(find.text('Error'), findsOneWidget);

    await tester.tap(find.text('Error').last);
    await tester.pumpAndSettle();

    expect(selectedValue, 'error');
  });

  testWidgets('custom dropdown opens upward when near the bottom edge', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: SizedBox(
                width: 188,
                child: AppDropdownField<String>(
                  label: 'Level',
                  value: null,
                  isDense: true,
                  items: const [
                    DropdownMenuItem<String>(value: 'all', child: Text('All')),
                    DropdownMenuItem<String>(
                      value: 'info',
                      child: Text('Info'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'error',
                      child: Text('Error'),
                    ),
                  ],
                  onChanged: (_) {},
                ),
              ),
            ),
          ),
        ),
      ),
    );

    final triggerTop = tester.getTopLeft(find.text('Level')).dy;

    await tester.tap(find.text('Level'));
    await tester.pumpAndSettle();

    final menuTop = tester.getTopLeft(find.text('All')).dy;
    expect(menuTop, lessThan(triggerTop));
  });
}
