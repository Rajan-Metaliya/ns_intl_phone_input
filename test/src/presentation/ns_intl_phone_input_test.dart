import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ns_intl_phone_input/ns_intl_phone_input.dart';

void main() {
  testWidgets('NS Intl Phone field Screen test', (WidgetTester tester) async {
    final IntlTextEditingController textEditingController =
        IntlTextEditingController();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: NsIntlPhoneInput(
            onPhoneChange: (value) {},
            textEditingController: textEditingController,
          ),
        ),
      ),
    );

    await tester.pumpAndSettle(Durations.long1);

    expect(find.byType(MaterialButton), findsOneWidget);

    await tester.tap(find.byType(MaterialButton, skipOffstage: true));

    await tester.pumpAndSettle(Durations.long1);

    expect(find.byType(CountrySelectionDialogWidget), findsOneWidget);

    expect(find.byKey(const Key('ns_country_search_field')), findsOneWidget);

    await tester.enterText(
      find.byKey(const Key('ns_country_search_field')),
      'india',
    );

    await tester.pumpAndSettle();

    expect(find.text('India'), findsOneWidget);

    await tester.tap(find.byType(ListTile).first);

    await tester.pumpAndSettle();

    expect(find.byKey(const Key('ns_phone_input_field')), findsOneWidget);
    await tester.enterText(
      find.byKey(const Key('ns_phone_input_field')),
      '98765432',
    );
    await tester.pumpAndSettle();

    await tester.enterText(
      find.byKey(const Key('ns_phone_input_field')),
      '987654321012',
    );

    await tester.pumpAndSettle();

    expect(textEditingController.text, '987 654 321 012');
  });
}
