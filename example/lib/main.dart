import 'package:flutter/material.dart';
import 'package:ns_intl_phone_input/ns_intl_phone_input.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Center(
            child: PhoneInput(),
          ),
        ),
      ),
    ),
  );
}
