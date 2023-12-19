import 'package:flutter/material.dart';
import 'package:ns_intl_phone_input/src/data/models/country.dart';
import 'package:ns_intl_phone_input/src/presentation/widgets/font_text_widget.dart';

class CountrySelectButton extends StatelessWidget {
  const CountrySelectButton({
    super.key,
    required this.onPressed,
    required this.selectedCountry,
    this.showCode = false,
    this.countryIsoCodeTextStyle,
    this.countryDialCodeTextStyle,
  });

  final void Function()? onPressed;
  final CountryModel selectedCountry;
  final bool showCode;
  final TextStyle? countryIsoCodeTextStyle;
  final TextStyle? countryDialCodeTextStyle;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
      onPressed: onPressed,
      child: Row(
        children: [
          FontTextWidget(text: selectedCountry.flag),
          const SizedBox(width: 10),
          if (showCode) ...[
            Text(
              selectedCountry.iso2Code.toUpperCase(),
              style: countryIsoCodeTextStyle ??
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(width: 10),
          ],
          Text(
            '+${selectedCountry.intlDialCode}',
            style: countryDialCodeTextStyle ??
                const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
