import 'package:flutter/material.dart';

Widget appBarMain(BuildContext context) {
  return AppBar(
    title: Image.asset("assets/icons/logo.png"),
  );
}

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
