import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:ns_intl_phone_input/src/data/models/country.dart';
import 'package:ns_intl_phone_input/src/data/models/country_select_button_options.dart';
import 'package:ns_intl_phone_input/src/data/usecases/construct_lookup_map_impl.dart';
import 'package:ns_intl_phone_input/src/presentation/country_select_screen.dart';

import '../raw/raw_countries.dart';
import 'widgets/country_select_button.dart';

class NsIntlPhoneInput extends StatefulWidget {
  const NsIntlPhoneInput({
    Key? key,
    this.phoneFieldDecoration,
    this.countrySelectOption = const CountrySelectOption(),
  }) : super(key: key);

  final InputDecoration? phoneFieldDecoration;

  final CountrySelectOption countrySelectOption;

  @override
  State<NsIntlPhoneInput> createState() => _NsIntlPhoneInputState();
}

class _NsIntlPhoneInputState extends State<NsIntlPhoneInput> {
  final _countriesLookupMap = ConstructLookupMapImpl()(rawCountries);

  var textEditingController = TextEditingController(text: "");

  late CountryModel selectedCountry;

  String? dropDownValue;

  var maskFormatter = MaskTextInputFormatter(
    mask: '...-..-....',
    filter: {".": RegExp(r'[0-9]')},
  );

  @override
  void initState() {
    super.initState();
    _onDropDownChange('91');
    textEditingController.addListener(() {
      _onTextChange(textEditingController.text);
    });
  }

  _onTextChange(String? value) {
    setState(() {});

    if (value == null || value.isEmpty) {
      return;
    }

    final unMastedValue = maskFormatter.getUnmaskedText();

    for (final country in rawCountries) {
      if (selectedCountry.intlDialCode == country.intlDialCode) {
        if (country.areaCodes == null || country.areaCodes!.isEmpty) {
          continue;
        } else {
          for (final region in country.areaCodes!) {
            if (unMastedValue.startsWith(region)) {
              selectedCountry = country;
              dropDownValue = '${country.intlDialCode} $region';
              return;
            }
          }
        }
      }
    }
  }

  _onDropDownChange(String? value) {
    final values = value!.split(" ");

    var initialText = '';
    if (values.length > 1) {
      initialText = values.last;
    }
    setState(() {});
    textEditingController.clear();
    selectedCountry = _countriesLookupMap[value]!;
    dropDownValue = value;

    maskFormatter.updateMask(
      mask: selectedCountry.format,
      filter: {".": RegExp(r'[0-9]')},
      newValue: TextEditingValue(text: initialText),
    );

    textEditingController.text = maskFormatter.getMaskedText();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      textBaseline: TextBaseline.alphabetic,
      children: [
        CountrySelectButton(
          selectedCountry: selectedCountry,
          onPressed: () => {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CountrySelectScreen(
                  onCountrySelected: (country) {
                    _onDropDownChange(country.dialCode);
                  },
                ),
              ),
            )
          },
          options: widget.countrySelectOption,
        ),
        Expanded(
          flex: 6,
          child: TextFormField(
            maxLength: selectedCountry.format?.length,
            controller: textEditingController,
            inputFormatters: [maskFormatter],
            decoration: widget.phoneFieldDecoration ??
                const InputDecoration(
                  hintText: 'Phone Number',
                  counterText: '',
                ),
            style: const TextStyle(fontSize: 20),
          ),
        ),
      ],
    );
  }
}
