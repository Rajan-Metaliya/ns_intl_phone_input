## 0.0.1

* Initial release.


## 0.0.2 [Breaking changes]

* Create `NSIntlPhoneHelper` for helper functions regarding packages
* Replace `TextEditingController` with  `IntlTextEditingController` to initialize, clear and notify values as textfield controller.
* `initialCountryCode` is removed now we can directly pass initial country code and number to `IntlTextEditingController`. 
* Move the most of the country selection logic part into IntlTextEditingController. 
* Update ReadMe file
* Update package `mask_text_input_formatter` to ^2.9.0