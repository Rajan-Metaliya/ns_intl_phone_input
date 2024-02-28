import 'package:flutter/material.dart';
import 'package:ns_intl_phone_input/ns_intl_phone_input.dart';

typedef BuildCountry = CountrySelection? Function();

class NsIntlPhoneInput extends StatefulWidget {
  const NsIntlPhoneInput({
    Key? key,
    required this.onPhoneChange,
    required this.textEditingController,
    this.focusNode,
    this.phoneInputFontSize = 16,
    this.phoneFieldDecoration,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.validationErrorText = 'Please enter a valid phone number',
    this.countrySelectOption = const CountrySelectOption(),
    this.countrySelectionType = CountrySelectionTypeEnum.dialog,
    this.enableValidation = true,
  }) : super(key: key);

  final FocusNode? focusNode;

  final bool enableValidation;

  final String validationErrorText;

  final AutovalidateMode autovalidateMode;

  final InputDecoration? phoneFieldDecoration;

  final CountrySelectOption countrySelectOption;

  final CountrySelectionTypeEnum countrySelectionType;

  final Function(CountrySelection) onPhoneChange;

  final IntlTextEditingController textEditingController;

  final double phoneInputFontSize;

  @override
  State<NsIntlPhoneInput> createState() => _NsIntlPhoneInputState();
}

class _NsIntlPhoneInputState extends State<NsIntlPhoneInput> {
  @override
  void initState() {
    super.initState();
    widget.textEditingController.addListener(() {
      _notifyListeners(widget.textEditingController.text);
    });
  }

  void _notifyListeners(text) {
    final unMastedValue = NSIntlPhoneHelper.getUnMaskedPhoneNumber(
      phoneNumber: text,
    );

    final newCountry = NSIntlPhoneHelper.selectedCountryCode(
          countryCode:
              widget.textEditingController.selectedCountry?.intlDialCode ?? '',
          phoneNumber: unMastedValue,
        ) ??
        widget.textEditingController.selectedCountry;
    if (newCountry != null) {
      if (newCountry.countryName !=
          widget.textEditingController.selectedCountry?.countryName) {
        widget.textEditingController.selectedCountry = newCountry;
      }
      widget.onPhoneChange(CountrySelection(
        selectedCountry: newCountry,
        formattedPhoneNumber: text,
        unformattedPhoneNumber: unMastedValue,
      ));
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      textBaseline: TextBaseline.alphabetic,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CountrySelectButton(
          selectedCountry: widget.textEditingController.selectedCountry,
          onPressed: () {
            if (widget.countrySelectionType ==
                CountrySelectionTypeEnum.dialog) {
              countrySelectDialog(
                context,
                onCountrySelected: (country) {
                  setState(() {
                    widget.textEditingController.setCountry(country);
                  });
                },
              );
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CountrySelectScreen(
                    onCountrySelected: (country) {
                      setState(() {
                        widget.textEditingController.setCountry(country);
                      });
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
            maxLength:
                widget.textEditingController.selectedCountry?.format?.length,
            controller: widget.textEditingController,
            focusNode: widget.focusNode,
            inputFormatters: [widget.textEditingController.maskFormatter],
            decoration: widget.phoneFieldDecoration ??
                const InputDecoration(
                  hintText: 'Phone Number',
                  counterText: '',
                ),
            style: TextStyle(fontSize: widget.phoneInputFontSize),
            autovalidateMode: widget.autovalidateMode,
            validator: (value) {
              if(!widget.enableValidation) {
                if (value != null ) {
                  if (value.isNotEmpty && value.length <
                      (widget.textEditingController.selectedCountry?.format
                          ?.length ??
                          15)) {
                    return widget.validationErrorText;
                  }
                }
                  return null;
              }
              if (widget.textEditingController.selectedCountry == null) {
                return widget.validationErrorText;
              } else if (value == null || value.isEmpty) {
                return widget.validationErrorText;
              } else if (value.length <
                  (widget.textEditingController.selectedCountry?.format
                          ?.length ??
                      15)) {
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
