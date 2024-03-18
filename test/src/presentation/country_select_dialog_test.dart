import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ns_intl_phone_input/ns_intl_phone_input.dart';

void main() {
  testWidgets('CountryDropdownWidget', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) {
            return MaterialButton(
              onPressed: () {
                countrySelectDialog(
                  context,
                  onCountrySelected: (p0) {},
                );
              },
            );
          },
        ),
      ),
    );

    await tester.pumpAndSettle();
    await tester.tap(find.byType(MaterialButton));

    await tester.pumpAndSettle();

    expect(find.byType(CountrySelectionDialogWidget), findsOneWidget);
  });
}
