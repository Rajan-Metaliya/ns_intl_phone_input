import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:ns_intl_phone_input/src/data/enum/country_selection_type_enum.dart';
import 'package:ns_intl_phone_input/src/data/models/country.dart';
import 'package:ns_intl_phone_input/src/data/models/country_select_button_options.dart';
import 'package:ns_intl_phone_input/src/presentation/country_select_screen.dart';
import 'package:ns_intl_phone_input/src/presentation/helper/ns_intl_helper.dart';

import '../data/models/country_selection.dart';
import 'country_select_dialog.dart';
import 'widgets/country_select_button.dart';

typedef BuildCountry = CountrySelection? Function();

class NsIntlPhoneInput extends StatefulWidget {
  const NsIntlPhoneInput({
    Key? key,
    required this.onPhoneChange,
    this.focusNode,
    this.phoneInputFontSize = 16,
    this.phoneFieldDecoration,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.validationErrorText = 'Please enter a valid phone number',
    this.countrySelectOption = const CountrySelectOption(),
    this.countrySelectionType = CountrySelectionTypeEnum.dialog,
    this.builder,
  }) : super(key: key);

  final FocusNode? focusNode;

  final String validationErrorText;

  final AutovalidateMode autovalidateMode;

  final InputDecoration? phoneFieldDecoration;

  final CountrySelectOption countrySelectOption;

  final CountrySelectionTypeEnum countrySelectionType;

  final Function(CountrySelection) onPhoneChange;

  final double phoneInputFontSize;

  final BuildCountry? builder;

  @override
  State<NsIntlPhoneInput> createState() => _NsIntlPhoneInputState();
}

class _NsIntlPhoneInputState extends State<NsIntlPhoneInput> {
  var textEditingController = TextEditingController(text: "");

  CountryModel? selectedCountry;

  String? dropDownValue;

  var maskFormatter = MaskTextInputFormatter(
    mask: '...-..-....',
    filter: {".": RegExp(r'[0-9]')},
  );

  CountrySelection? _previousCountrySelection;

  @override
  void initState() {
    super.initState();

    textEditingController.addListener(() {
      _onTextChange(textEditingController.text);
    });
  }

  _onTextChange(String? value) {
    setState(() {});

    if (value == null || value.isEmpty || selectedCountry == null) {
      return;
    }

    final unMastedValue = NSIntlPhoneHelper.getUnMaskedPhoneNumber(
      phoneNumber: value,
    );
    widget.onPhoneChange(
      CountrySelection(
        formattedPhoneNumber: value,
        selectedCountry: selectedCountry!,
        unformattedPhoneNumber: unMastedValue,
      ),
    );
    selectedCountry = NSIntlPhoneHelper.selectedCountryCode(
          countryCode: selectedCountry?.intlDialCode ?? '',
          phoneNumber: unMastedValue,
        ) ??
        selectedCountry;

    return;
  }

  _onDropDownChange(CountryModel country, {bool? isAutoChange = false}) {
    if (isAutoChange != true) {
      selectedCountry = country.copyWith(currentAreaCode: '');
    } else {
      selectedCountry = country;
    }

    dropDownValue = country.intlDialCode;

    maskFormatter.updateMask(
      mask: selectedCountry?.format,
      filter: {".": RegExp(r'[0-9]')},
      newValue: TextEditingValue(text: country.currentAreaCode),
    );

    textEditingController.text = maskFormatter.getMaskedText();
  }

  _onValueChange(dialCode, phoneNumber) {
    selectedCountry = NSIntlPhoneHelper.selectedCountryCode(
      countryCode: dialCode,
      phoneNumber: phoneNumber,
    );

    if (selectedCountry != null) {
      maskFormatter.updateMask(
        mask: selectedCountry?.format,
        filter: {".": RegExp(r'[0-9]')},
        newValue: TextEditingValue(text: phoneNumber),
      );
      _onDropDownChange(selectedCountry!, isAutoChange: true);
    }
    textEditingController.text = NSIntlPhoneHelper.getMaskedPhoneNumber(
      countryCode: dialCode,
      phoneNumber: phoneNumber,
    );
  }

  @override
  Widget build(BuildContext context) {
    final countrySelection = widget.builder?.call();
    if (countrySelection != null) {
      if (!countrySelection.isEqual(_previousCountrySelection)) {
        _previousCountrySelection = countrySelection;
        _onValueChange(
          countrySelection.selectedCountry.intlDialCode,
          countrySelection.unformattedPhoneNumber,
        );
      }
      }
    if(_previousCountrySelection != null && countrySelection == null)
    {
      textEditingController.clear();
      selectedCountry = null;
      dropDownValue = null;
      setState(() {
      });
    }

    return Row(
      textBaseline: TextBaseline.alphabetic,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CountrySelectButton(
          selectedCountry: selectedCountry,
          onPressed: () {
            if (widget.countrySelectionType ==
                CountrySelectionTypeEnum.dialog) {
              countrySelectDialog(
                context,
                onCountrySelected: (country) {
                  _onDropDownChange(country);
                },
              );
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CountrySelectScreen(
                    onCountrySelected: (country) {
                      _onDropDownChange(country);
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
            style: TextStyle(fontSize: widget.phoneInputFontSize),
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
