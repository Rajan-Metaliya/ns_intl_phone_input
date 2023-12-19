import 'package:flutter/material.dart';
import 'package:ns_intl_phone_input/ns_intl_phone_input.dart';

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

  final _formKey = GlobalKey<FormState>();

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
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  NsIntlPhoneInput(
                    onPhoneChange: (countrySelection) {
                      setState(() {
                        this.countrySelection = countrySelection;
                      });
                    },
                    initialCountryCode: '1',
                  ),
                  const SizedBox(height: 20),
                  MaterialButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Validated')),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Not Validated')),
                        );
                      }
                    },
                    child: const Text('Submit'),
                  ),
                  Text(
                    'Selected Country: $countrySelection',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
