import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:ns_intl_phone_input/ns_intl_phone_input.dart';

class IntlTextEditingController extends TextEditingController {
  IntlTextEditingController({String? text}) : super(text: text);

  CountryModel? selectedCountry;

  MaskTextInputFormatter maskFormatter = MaskTextInputFormatter(
    mask: '...-..-....',
    filter: {".": RegExp(r'[0-9]')},
  );

  @override
  set text(String newText) {
    super.text = newText;
    notifyListeners();
  }

  @override
  void notifyListeners() {
    final unMastedValue = NSIntlPhoneHelper.getUnMaskedPhoneNumber(
      phoneNumber: text,
    );

    final newCountry = NSIntlPhoneHelper.selectedCountryCode(
          countryCode: selectedCountry?.intlDialCode ?? '',
          phoneNumber: unMastedValue,
        ) ??
        selectedCountry;
    if (newCountry != null) {
      if (newCountry.countryName != selectedCountry?.countryName) {
        print('IntlTextEditingController notifyListeners Changed Country');
        selectedCountry = newCountry;
      } else {
        print('IntlTextEditingController notifyListeners Not Changed Country');
      }
    }

    super.notifyListeners();
  }

  void initialPhone({
    required String phoneNumber,
    required String intlDialCode,
  }) {
    selectedCountry = NSIntlPhoneHelper.selectedCountryCode(
          countryCode: intlDialCode,
          phoneNumber: NSIntlPhoneHelper.getUnMaskedPhoneNumber(
              phoneNumber: phoneNumber),
        ) ??
        selectedCountry;

    maskFormatter.updateMask(
      mask: selectedCountry?.format,
      filter: {".": RegExp(r'[0-9]')},
      newValue: TextEditingValue(text: selectedCountry?.currentAreaCode ?? ""),
    );

    text = maskFormatter.maskText(phoneNumber);
    notifyListeners();
  }

  void setCountry(CountryModel? newCountry) {
    clear();
    selectedCountry = newCountry;
    maskFormatter.updateMask(
      mask: selectedCountry?.format,
      filter: {".": RegExp(r'[0-9]')},
      newValue: TextEditingValue(text: selectedCountry?.currentAreaCode ?? ""),
    );

    text = maskFormatter.maskText(newCountry?.currentAreaCode ?? '');

    notifyListeners();
  }

  @override
  void clear() {
    print('IntlTextEditingController clear');
    super.clear();
    selectedCountry = null;
    text = '';
    notifyListeners();
  }
}
