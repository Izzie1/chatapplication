import 'package:flutter/material.dart';

InputDecoration textFieldInputDecoration(String hint) {
  return InputDecoration(
    hintText: hint,
    hintStyle: TextStyle(
      color: Colors.blueGrey,
    ),
  );
}

TextStyle customTextStyle(Color color) {
  return TextStyle(color: color, fontSize: 17);
}
