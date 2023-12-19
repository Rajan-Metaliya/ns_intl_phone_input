import 'package:flutter/material.dart';
import 'package:ns_intl_phone_input/ns_intl_phone_input.dart';
import 'package:ns_intl_phone_input/src/data/models/country.dart';
import 'package:ns_intl_phone_input/src/data/models/country_selection.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CountrySelection countrySelection = CountrySelection(
    selectedCountry: CountryModel(
      countryName: 'India',
      regions: {'Asia'},
      iso2Code: 'IN',
      flag: '🇮🇳',
      intlDialCode: '+91',
      format: '...-..-....',
      orderPriority: 0,
      areaCodes: {'91'},
      currentAreaCode: '',
    ),
    formattedPhoneNumber: '',
    unformattedPhoneNumber: '',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NsIntlPhoneInput Example',
            style: Theme.of(context).textTheme.titleLarge),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Column(
            children: [
              NsIntlPhoneInput(
                onPhoneChange: (countrySelection) {
                  setState(() {
                    this.countrySelection = countrySelection;
                  });
                },
              ),
              const SizedBox(height: 20),
              Text(
                'Selected Country: $countrySelection',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
