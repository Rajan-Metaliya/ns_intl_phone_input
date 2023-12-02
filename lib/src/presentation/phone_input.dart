import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ns_intl_phone_input/src/data/usecases/change_country.dart';
import 'package:ns_intl_phone_input/src/data/usecases/construct_lookup_map.dart';
import 'package:ns_intl_phone_input/src/data/usecases/format.dart';
import 'package:ns_intl_phone_input/src/data/utils/extensions.dart';
import 'package:ns_intl_phone_input/src/domain/entities/country.dart';
import 'package:ns_intl_phone_input/src/domain/usecases/change_country.dart';
import 'package:ns_intl_phone_input/src/domain/usecases/format.dart';

import '../data/models/country.dart';
import '../data/usecases/query_format.dart';
import '../domain/usecases/query_format.dart';
import '../raw/raw_countries.dart';

// todo: fix selection: selection does not work
class PhoneInput extends StatelessWidget {
  late final Format _format;
  late final ChangeCountry _changeCountry;
  late final Iterable<CountryEntity> _countries;
  late final _countriesLookupMap = ConstructLookupMapImpl()(_countries);
  late final QueryFormat _queryFormat = QueryFormatImpl();
  late final TextEditingController _textController;

  PhoneInput({super.key}) {
    _format = FormatImpl();
    _changeCountry = ChangeCountryImpl();
    _countries = rawCountries
        .map(
          (e) => CountryModel.fromRawData(e),
        )
        .cast<CountryEntity>();

    _textController = TextEditingController();

    _textController.addListener(() {
      final mFormat = _queryFormat(
        countriesLookupMap: _countriesLookupMap,
        number: _textController.text,
      );

      final String formattedNumber = _format(
        number: _textController.text,
        format: mFormat,
      );

      _textController.value = _textController.value.copyWith(
        text: formattedNumber,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: DropdownButtonFormField<String>(
            value: '91',
            items: _countriesLookupMap.entries
                .map(
                  (e) => DropdownMenuItem(
                    value: e.key,
                    child: Text('+${e.key} (${e.value.iso2Code})'),
                  ),
                )
                .toList(),
            onChanged: (value) {
              final changed = _changeCountry(
                countriesLookupMap: _countriesLookupMap,
                number: _textController.text.fetchDigits,
                newCountry: value,
              );

              final formatted = _format(
                number: changed,
                format: _queryFormat(
                  countriesLookupMap: _countriesLookupMap,
                  number: changed,
                ),
              );

              _textController.text = formatted;
            },
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.6,
          child: TextField(
            selectionControls: CustomMaterialTextSelectionHandleControls(),
            maxLength: 15,
            controller: _textController,
            decoration: const InputDecoration(
              hintText: 'Phone Number',
            ),
          ),
        ),
      ],
    );
  }
}

class CustomMaterialTextSelectionHandleControls
    extends MaterialTextSelectionControls with TextSelectionHandleControls {
  @override
  void handleCopy(TextSelectionDelegate delegate,
      [ClipboardStatusNotifier? clipboardStatus]) {
    final digits = delegate.textEditingValue.text.fetchDigits;
    Clipboard.setData(ClipboardData(text: digits));
  }
}
