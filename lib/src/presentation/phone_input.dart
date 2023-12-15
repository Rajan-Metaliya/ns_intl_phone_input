import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:ns_intl_phone_input/src/data/usecases/construct_lookup_map.dart';
import 'package:ns_intl_phone_input/src/domain/entities/country.dart';

import '../raw/raw_countries.dart';

// todo: fix selection: selection does not work
class PhoneInput extends StatefulWidget {
  const PhoneInput({super.key});

  @override
  State<PhoneInput> createState() => _PhoneInputState();
}

class _PhoneInputState extends State<PhoneInput> {
  late final _countriesLookupMap = ConstructLookupMapImpl()(rawCountries);

  var textEditingController = TextEditingController(text: "");

  late CountryEntity selectedCountry;

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

    final unmastedValue = maskFormatter.getUnmaskedText();

    for (final country in rawCountries) {
      if (selectedCountry.intlDialCode == country.intlDialCode) {
        if (country.areaCodes == null || country.areaCodes!.isEmpty) {
          continue;
        } else {
          for (final region in country.areaCodes!) {
            if (unmastedValue.startsWith(region)) {
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
      children: [
        Expanded(
          child: DropdownButtonFormField<String>(
            value: dropDownValue,
            items: _countriesLookupMap.keys.map(
              (e) {
                final country = _countriesLookupMap[e]!;
                return DropdownMenuItem<String>(
                  value: e,
                  child: Text('${country.flag} +$e ${country.countryName}'),
                );
              },
            ).toList(),
            onChanged: _onDropDownChange,
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.6,
          child: TextFormField(
            maxLength: selectedCountry.format?.length,
            controller: textEditingController,
            inputFormatters: [maskFormatter],
            decoration: const InputDecoration(
              hintText: 'Phone Number',
            ),
          ),
        ),
      ],
    );
  }
}
