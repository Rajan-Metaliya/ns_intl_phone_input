import 'package:flutter/material.dart';

class CountrySelectOption {
  final bool showCode;
  final TextStyle countryIsoCodeTextStyle;
  final TextStyle countryDialCodeTextStyle;

  const CountrySelectOption({
    this.showCode = false,
    this.countryIsoCodeTextStyle = const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
    this.countryDialCodeTextStyle = const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
  });
}
