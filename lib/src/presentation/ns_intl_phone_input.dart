import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:ns_intl_phone_input/src/data/enum/country_selection_type_enum.dart';
import 'package:ns_intl_phone_input/src/data/models/country.dart';
import 'package:ns_intl_phone_input/src/data/models/country_select_button_options.dart';
import 'package:ns_intl_phone_input/src/data/usecases/construct_lookup_map_impl.dart';
import 'package:ns_intl_phone_input/src/presentation/country_select_screen.dart';

import '../data/models/country_selection.dart';
import '../raw/raw_countries.dart';
import 'country_select_dialog.dart';
import 'widgets/country_select_button.dart';

class NsIntlPhoneInput extends StatefulWidget {
  const NsIntlPhoneInput({
    Key? key,
    required this.onPhoneChange,
    required this.initialCountryCode,
    this.textEditingController,
    this.focusNode,
    this.phoneFieldDecoration,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.validationErrorText = 'Please enter a valid phone number',
    this.countrySelectOption = const CountrySelectOption(),
    this.countrySelectionType = CountrySelectionTypeEnum.dialog,
  }) : super(key: key);

  final TextEditingController? textEditingController;

  final FocusNode? focusNode;

  final String validationErrorText;

  final AutovalidateMode autovalidateMode;

  final InputDecoration? phoneFieldDecoration;

  final CountrySelectOption countrySelectOption;

  final CountrySelectionTypeEnum countrySelectionType;

  final Function(CountrySelection) onPhoneChange;

  final String initialCountryCode;

  @override
  State<NsIntlPhoneInput> createState() => _NsIntlPhoneInputState();
}

class _NsIntlPhoneInputState extends State<NsIntlPhoneInput> {
  final _countriesLookupMap = ConstructLookupMapImpl()(rawCountries);

  var textEditingController = TextEditingController(text: "");

  CountryModel? selectedCountry;

  String? dropDownValue;

  var maskFormatter = MaskTextInputFormatter(
    mask: '...-..-....',
    filter: {".": RegExp(r'[0-9]')},
  );

  @override
  void initState() {
    super.initState();
    _onDropDownChange(widget.initialCountryCode);
    textEditingController.addListener(() {
      _onTextChange(textEditingController.text);
      widget.textEditingController?.text = textEditingController.text;
    });
  }

  _onTextChange(String? value) {
    setState(() {});

    if (value == null || value.isEmpty || selectedCountry == null) {
      return;
    }

    final unMastedValue = maskFormatter.getUnmaskedText();
    widget.onPhoneChange(
      CountrySelection(
        formattedPhoneNumber: value,
        selectedCountry: selectedCountry!,
        unformattedPhoneNumber: unMastedValue,
      ),
    );
    for (final country in rawCountries) {
      if ((selectedCountry?.intlDialCode ?? '') == country.intlDialCode) {
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
    if (value == null || value.isEmpty) {
      return;
    }

    final values = value.split(" ");

    var initialText = '';
    if (values.length > 1) {
      initialText = values.last;
    }
    setState(() {});
    textEditingController.clear();
    if (_countriesLookupMap.containsKey(value)) {
      selectedCountry = _countriesLookupMap[value];

      dropDownValue = value;

      maskFormatter.updateMask(
        mask: selectedCountry?.format,
        filter: {".": RegExp(r'[0-9]')},
        newValue: TextEditingValue(text: initialText),
      );

      textEditingController.text = maskFormatter.getMaskedText();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      textBaseline: TextBaseline.alphabetic,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CountrySelectButton(
          selectedCountry: selectedCountry,
          onPressed: () {
            if (widget.countrySelectionType ==
                CountrySelectionTypeEnum.dialog) {
              countrySelectDialog(
                context,
                onCountrySelected: (country) {
                  _onDropDownChange(country.dialCode);
                },
              );
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CountrySelectScreen(
                    onCountrySelected: (country) {
                      _onDropDownChange(country.dialCode);
                    },
                  ),
                ),
              );
            }
          },
          options: widget.countrySelectOption,
        ),
        Expanded(
          flex: 6,
          child: TextFormField(
            maxLength: selectedCountry?.format?.length,
            controller: textEditingController,
            focusNode: widget.focusNode,
            inputFormatters: [maskFormatter],
            decoration: widget.phoneFieldDecoration ??
                const InputDecoration(
                  hintText: 'Phone Number',
                  counterText: '',
                ),
            style: const TextStyle(fontSize: 20),
            autovalidateMode: widget.autovalidateMode,
            validator: (value) {
              if (selectedCountry == null) {
                return widget.validationErrorText;
              } else if (value == null || value.isEmpty) {
                return widget.validationErrorText;
              } else if (value.length <
                  (selectedCountry?.format?.length ?? 15)) {
                return widget.validationErrorText;
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}
