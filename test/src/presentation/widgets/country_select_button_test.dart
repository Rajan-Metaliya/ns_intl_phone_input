import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ns_intl_phone_input/ns_intl_phone_input.dart';

void main() {
  const country = CountryModel(
    countryName: 'India',
    regions: {'Asia'},
    iso2Code: 'in',
    intlDialCode: '91',
    format: '.....-.....',
    currentAreaCode: '91',
  );
  testWidgets('CountryDropdownWidget country not selected',
      (WidgetTester tester) async {
    Completer completer = Completer<CountryModel>();

    await tester.pumpWidget(
      MaterialApp(
        home: CountrySelectButton(
          onPressed: () {
            completer.complete(country);
          },
          selectedCountry: null,
          options: const CountrySelectOption(
            defaultText: 'Select Country',
            defaultTextStyle: TextStyle(color: Colors.black),
            showCode: true,
            countryIsoCodeTextStyle: TextStyle(color: Colors.black),
            countryDialCodeTextStyle: TextStyle(color: Colors.black),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();
    expect(find.byType(Text), findsOneWidget);

    await tester.tap(find.byType(MaterialButton));

    await tester.pumpAndSettle();

    expect(completer.future, completes);
  });

  testWidgets('CountryDropdownWidget country selected',
      (WidgetTester tester) async {
    Completer completer = Completer<CountryModel>();

    await tester.pumpWidget(
      MaterialApp(
        home: CountrySelectButton(
          onPressed: () {
            completer.complete(country);
          },
          selectedCountry: country,
          options: const CountrySelectOption(
            defaultText: 'Select Country',
            defaultTextStyle: TextStyle(color: Colors.black),
            showCode: true,
            countryIsoCodeTextStyle: TextStyle(color: Colors.black),
            countryDialCodeTextStyle: TextStyle(color: Colors.black),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();
    expect(find.byType(Text), findsNWidgets(3));
  });
}
