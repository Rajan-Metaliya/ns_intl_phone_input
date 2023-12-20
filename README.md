<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

# Flutter Phone Validation Package by Nonstop IO

The Flutter Phone Validation Package by Nonstop IO is a versatile and easy-to-use Flutter package designed to validate phone numbers from more than 200 countries. With this package, users can seamlessly integrate phone number validation into their Flutter applications, enhancing user experience and ensuring data integrity.

## Screenshots



## Features

- **Country Selection Dropdown:** Users can choose the desired country code from a dropdown menu, making it easy to validate phone numbers for different regions.

- **Comprehensive Validation:** The package supports validation for phone numbers from over 200 countries, ensuring accuracy and inclusivity.

- **Various Number Formats:** Users can input phone numbers in different formats, and the package adapts to validate them accordingly. This includes support for various masks and formats.

## Getting Started

To use the Flutter Phone Validation Package in your project, follow these simple steps:

1. Add the package to your `pubspec.yaml` file:

   ```yaml
   dependencies:
     ns_intl_phone_input: ^1.0.0
   ```

2. Install the package by running:

   ```bash
   flutter pub get
   ```

3. Import the package in your Dart file:

   ```dart
   import 'package:ns_intl_phone_input/ns_intl_phone_input.dart';
   ```

4. Implement the `NsIntlPhoneInput` widget in your UI, providing the necessary callbacks and customization options.

   ```dart
   NsIntlPhoneInput(
     onPhoneChange: (CountrySelection countrySelection) {
       // Handle phone number change
       // eg:
       setState(() {
         this.countrySelection = countrySelection;
       });
     },
     initialCountryCode: '1',
     // Other customization options...
   ),
   ```

## Usage

### Country Selection

The package provides a user-friendly country selection dropdown, allowing users to choose the relevant country code for phone number validation.

```dart
NsIntlPhoneInput(
  onPhoneChange: (CountrySelection countrySelection) {
    // Handle phone number change, e.g., update the state
    setState(() {
      this.countrySelection = countrySelection;
    });
  },
  initialCountryCode: '1',
  // Other customization options...
),

```

### Phone Number Validation

Validate phone numbers easily with the `onPhoneChange` callback. The package supports various phone number formats.

```dart
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
```

### Customization

Customize the package to suit your application's needs with various options like initial country code, formatting, and more.

```dart
NsIntlPhoneInput(
  onPhoneChange: (CountrySelection countrySelection) {
    // Handle phone number change, e.g., update the state
    setState(() {
      this.countrySelection = countrySelection;
    });
  },
  initialCountryCode: '1',
  textEditingController: TextEditingController(text: ""),
  focusNode: primaryFocus,
  phoneInputFontSize: 20,
  autovalidateMode: AutovalidateMode.always,
  validationErrorText: 'Please enter a valid phone number',
  countrySelectOption: const CountrySelectOption(
    showCode: true,
    countryIsoCodeTextStyle: TextStyle(fontSize: 20),
  ),
  countrySelectionType: CountrySelectionTypeEnum.screen,
),
```

## Example

For a quick start, check out the provided example in the `lib/home` folder with `home_screen.dart` file. It demonstrates the integration of the Flutter Phone Validation Package into a sample Flutter application.

## Support and Contributions

If you encounter any issues or have suggestions for improvement, feel free to open an issue on the [GitHub repository](https://link-to-github-repo). Contributions are welcome!

Thank you for choosing the Flutter Phone Validation Package by Nonstop IO. Happy coding!
