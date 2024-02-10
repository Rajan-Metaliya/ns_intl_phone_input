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

- Widget with Country Code and Phone Number Field:
  <br><img width="417" alt="Screenshot 2023-12-20 at 4 47 30 PM" src="https://github.com/rajan-nonstopio/ns_intl_phone_input/assets/132648639/b3b827c1-c9b9-4773-980d-8e4a3618372c">


- Drop Down Menu Options for Country code list:
  <br><img width="901" alt="Screenshot 2023-12-20 at 3 04 24 PM" src="https://github.com/rajan-nonstopio/ns_intl_phone_input/assets/132648639/8fb0f20c-e815-4c8d-9b6d-3d182222884a">

- Widget with Country Code, Phone Number Field and area code format:
  <br><img width="425" alt="Screenshot 2023-12-20 at 3 05 32 PM" src="https://github.com/rajan-nonstopio/ns_intl_phone_input/assets/132648639/e9032139-4bad-4428-a589-61090aa7db52">

## Features

- **Country Selection Dropdown:** Users can choose the desired country code from a dropdown menu, making it easy to validate phone numbers for different regions.

- **Comprehensive Validation:** The package supports validation for phone numbers from over 200 countries, ensuring accuracy and inclusivity.

- **Various Number Formats:** Users can input phone numbers in different formats, and the package adapts to validate them accordingly. This includes support for various masks and formats.
- **Support for area codes of the country:** The package provides support for area codes within countries. Users can input phone numbers with area codes, and the package considers this during validation. This feature enhances the package's flexibility and applicability to regions where area codes are an integral part of phone numbers.

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

For a quick start, check out the provided example in the `lib/home` folder with the `home_screen.dart` file. It demonstrates the integration of the Flutter Phone Validation Package into a sample Flutter application.

## Support and Contributions

If you encounter any issues or have suggestions for improvement, feel free to open an issue on the [GitHub repository](https://github.com/Rajan-Metaliya/ns_intl_phone_input/). Contributions are welcome!
There are a couple of ways in which you can contribute.

- Propose any feature, enhancement
- Report a bug
- Fix a bug
- Participate in a discussion and help in decision-making
- Write and improve some documentation. Documentation is supercritical and its importance cannot be overstated!
- Send in a Pull Request :-)

Thank you for choosing the Flutter Phone Validation Package by Nonstop IO. Happy coding!

<br>
<div align="center" >
  <p>Thanks to all contributors to this package</p>
  <a href="https://github.com/Rajan-Metaliya/ns_intl_phone_input/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=Rajan-Metaliya/ns_intl_phone_input" />
</a>
</div>
<br>
